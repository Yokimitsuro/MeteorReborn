// PM-MISSING (MR-original infrastructure, port de SeventhUmbral/launcher/PatchFile.cpp).
// Parser + aplicador de un único .patch FFXIV 1.x format ZIPATCH.
//
// Wire format (big-endian para tamaños/contadores, little-endian para flags):
//   Header (0x10 bytes): 0x91 'Z' 'I' 'P' 'A' 'T' 'C' 'H' + 8 bytes adicionales (skip).
//   Commands sequence (cada uno 4-byte ASCII tag):
//     FHDR  → versión: uint32 BE                                       (skip)
//     DIFF  → 5×uint32                                                  (skip)
//     HIST  → 5×uint32                                                  (skip)
//     APLY  → 5×uint32                                                  (skip)
//     ADIR  → pathSize(BE) + path + 16 bytes; crea directorio
//     DELD  → pathSize(BE) + path + 16 bytes; borra directorio
//     ETRY  → pathSize(BE) + path + itemCount(BE) + items + 8 trailing
//             Cada item: hashMode(LE) + srcHash[20] + dstHash[20] +
//                        compressionMode(LE) + compressedSize(BE) +
//                        previousFileSize(BE) + newFileSize(BE) + data
//             Solo el ÚLTIMO item tiene data; los anteriores compressedSize=0.
//             compressionMode: 0x4E='N' (none), 0x5A='Z' (zlib).

using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Text;
using System.Threading;

namespace MeteorReborn.Launcher;

internal sealed class PatchFile
{
    private readonly string _gameLocationPath;
    public List<string> Messages { get; } = new();
    public bool Succeeded { get; private set; }

    private PatchFile(string gameLocationPath) => _gameLocationPath = gameLocationPath;

    public static PatchFile Execute(Stream input, string gameLocationPath)
    {
        var patch = new PatchFile(gameLocationPath);
        try
        {
            patch.DoExecute(input);
            patch.Succeeded = true;
        }
        catch (Exception ex)
        {
            patch.Messages.Add($"FAILED: {ex.Message}");
            patch.Succeeded = false;
        }
        return patch;
    }

    private void DoExecute(Stream s)
    {
        var header = new byte[0x10];
        ReadExact(s, header, 0, header.Length);
        if (header[0] != 0x91 || header[1] != 'Z' || header[2] != 'I' || header[3] != 'P' ||
            header[4] != 'A' || header[5] != 'T' || header[6] != 'C' || header[7] != 'H')
            throw new InvalidDataException("Invalid patch header (expected ZIPATCH magic).");

        while (true)
        {
            var cmd = new byte[4];
            int read = s.Read(cmd, 0, 4);
            if (read < 4) break;
            var tag = Encoding.ASCII.GetString(cmd);
            switch (tag)
            {
                case "FHDR": SkipBytes(s, 4); break;
                case "DIFF": SkipBytes(s, 20); break;
                case "HIST": SkipBytes(s, 20); break;
                case "APLY": SkipBytes(s, 20); break;
                case "ADIR": ExecuteADIR(s); break;
                case "DELD": ExecuteDELD(s); break;
                case "ETRY": ExecuteETRY(s); break;
                default: throw new InvalidDataException($"Unhandled command '{tag}' at offset {s.Position}.");
            }
        }
    }

    private void ExecuteADIR(Stream s)
    {
        var path = ReadPath(s);
        SkipBytes(s, 16);
        var full = Path.Combine(_gameLocationPath, path);
        if (Directory.Exists(full))
            Messages.Add($"Warning: directory '{full}' already exists.");
        else
            Directory.CreateDirectory(full);
    }

    private void ExecuteDELD(Stream s)
    {
        var path = ReadPath(s);
        SkipBytes(s, 16);
        var full = Path.Combine(_gameLocationPath, path);
        if (!Directory.Exists(full))
            Messages.Add($"Warning: directory '{full}' deletion requested but doesn't exist.");
        else
            Directory.Delete(full, recursive: true);
    }

    private void ExecuteETRY(Stream s)
    {
        var path = ReadPath(s);
        var fullPath = Path.Combine(_gameLocationPath, path);
        var fullDir = Path.GetDirectoryName(fullPath)!;
        if (!Directory.Exists(fullDir))
        {
            Messages.Add($"Warning: directory '{fullDir}' doesn't exist. Creating.");
            Directory.CreateDirectory(fullDir);
        }
        if (!File.Exists(fullPath))
            Messages.Add($"Warning: file '{fullPath}' doesn't exist. Creating.");

        uint itemCount = ReadUInt32BE(s);
        for (uint i = 0; i < itemCount; i++)
        {
            uint hashMode = ReadUInt32LE(s);
            if (hashMode != 0x41 && hashMode != 0x44 && hashMode != 0x4D)
                throw new InvalidDataException($"Unexpected hashMode 0x{hashMode:X}.");
            SkipBytes(s, 0x14 + 0x14); // srcFileHash + dstFileHash

            uint compressionMode = ReadUInt32LE(s);
            if (compressionMode != 0x4E && compressionMode != 0x5A)
                throw new InvalidDataException($"Unknown compressionMode 0x{compressionMode:X}.");

            uint compressedFileSize = ReadUInt32BE(s);
            uint previousFileSize = ReadUInt32BE(s);
            uint newFileSize = ReadUInt32BE(s);
            _ = previousFileSize;
            _ = newFileSize;

            if (i != itemCount - 1 && compressedFileSize != 0)
                throw new InvalidDataException("Non-final ETRY item has data; expected only final item carries payload.");

            if (compressedFileSize == 0) continue;

            using var outStream = CreateOutputStreamWithRetry(fullPath);
            if (compressionMode == 0x4E)
                ExtractUncompressed(outStream, s, compressedFileSize);
            else
                ExtractCompressed(outStream, s, compressedFileSize);
        }

        SkipBytes(s, 8);
    }

    private static FileStream CreateOutputStreamWithRetry(string path)
    {
        // explorer.exe a veces tiene los .exe abiertos para extraer iconos → retry.
        for (int retry = 0; ; retry++)
        {
            try { return new FileStream(path, FileMode.Create, FileAccess.Write, FileShare.None); }
            catch (IOException) when (retry < 5) { Thread.Sleep(1000); }
        }
    }

    private static void ExtractUncompressed(Stream output, Stream input, uint size)
    {
        var buffer = new byte[0x4000];
        while (size > 0)
        {
            int toRead = (int)Math.Min(buffer.Length, size);
            ReadExact(input, buffer, 0, toRead);
            output.Write(buffer, 0, toRead);
            size -= (uint)toRead;
        }
    }

    private static void ExtractCompressed(Stream output, Stream input, uint size)
    {
        // El patch lleva un sub-stream zlib de `size` bytes. Lo envolvemos en un LimitedStream
        // para que ZLibStream no consuma más del compressedSize declarado.
        var limited = new LimitedStream(input, size);
        using var z = new ZLibStream(limited, CompressionMode.Decompress, leaveOpen: true);
        z.CopyTo(output);
    }

    // Helpers de lectura big-endian (formato wire) y little-endian (flags).
    private static uint ReadUInt32BE(Stream s)
    {
        var b = new byte[4];
        ReadExact(s, b, 0, 4);
        return ((uint)b[0] << 24) | ((uint)b[1] << 16) | ((uint)b[2] << 8) | b[3];
    }

    private static uint ReadUInt32LE(Stream s)
    {
        var b = new byte[4];
        ReadExact(s, b, 0, 4);
        return ((uint)b[3] << 24) | ((uint)b[2] << 16) | ((uint)b[1] << 8) | b[0];
    }

    private static string ReadPath(Stream s)
    {
        uint sz = ReadUInt32BE(s);
        var buf = new byte[sz];
        ReadExact(s, buf, 0, (int)sz);
        return Encoding.UTF8.GetString(buf).TrimEnd('\0');
    }

    private static void SkipBytes(Stream s, int n)
    {
        var buf = new byte[n];
        ReadExact(s, buf, 0, n);
    }

    private static void ReadExact(Stream s, byte[] buf, int offset, int count)
    {
        while (count > 0)
        {
            int n = s.Read(buf, offset, count);
            if (n <= 0) throw new EndOfStreamException();
            offset += n; count -= n;
        }
    }

    private sealed class LimitedStream : Stream
    {
        private readonly Stream _inner;
        private long _remaining;
        public LimitedStream(Stream inner, long max) { _inner = inner; _remaining = max; }
        public override bool CanRead => true;
        public override bool CanSeek => false;
        public override bool CanWrite => false;
        public override long Length => throw new NotSupportedException();
        public override long Position { get => throw new NotSupportedException(); set => throw new NotSupportedException(); }
        public override void Flush() { }
        public override int Read(byte[] buffer, int offset, int count)
        {
            if (_remaining <= 0) return 0;
            int toRead = (int)Math.Min(count, _remaining);
            int n = _inner.Read(buffer, offset, toRead);
            _remaining -= n;
            return n;
        }
        public override long Seek(long offset, SeekOrigin origin) => throw new NotSupportedException();
        public override void SetLength(long value) => throw new NotSupportedException();
        public override void Write(byte[] buffer, int offset, int count) => throw new NotSupportedException();
    }
}
