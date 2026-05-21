---
title: ZIPATCH file structure
description: Wire format of FFXIV 1.x .patch files as implemented by MR's launcher.
---

The official FFXIV 1.x `.patch` files use the **ZIPATCH** binary format. MR's
launcher parses and applies them natively in `PatchFile.cs`.

## File header

Every patch starts with a 16-byte header:

| Offset | Size | Value | Meaning |
|--------|------|-------|---------|
| 0x00 | 8 | `0x91 'Z' 'I' 'P' 'A' 'T' 'C' 'H'` | Magic |
| 0x08 | 8 | various | Build metadata (ignored by the parser) |

Anything else is rejected with `Invalid patch header (expected ZIPATCH magic)`.

## Command stream

After the header, the file is a stream of 4-byte ASCII command tags followed
by tag-specific payloads, in big-endian byte order.

| Command | Payload | What it does |
|---------|---------|--------------|
| `FHDR` | 4 bytes | Format version. Skipped. |
| `DIFF` | 20 bytes (5 × u32) | Skip. |
| `HIST` | 20 bytes | Skip. |
| `APLY` | 20 bytes | Skip. |
| `ADIR` | pathSize(u32 BE) + path + 16 bytes | Create directory under game root |
| `DELD` | pathSize(u32 BE) + path + 16 bytes | Delete directory under game root |
| `ETRY` | pathSize(u32 BE) + path + itemCount(u32 BE) + items + 8 bytes | Replace file with new content |

End-of-file is detected when a 4-byte read returns less than 4 bytes.

## ETRY item format

`ETRY` carries one file's worth of updates. After the path comes
`itemCount` items. Each item:

| Field | Size | Notes |
|-------|------|-------|
| `hashMode` | u32 LE | `0x41` = last-hash, `0x44` = first-hash, `0x4D` = both |
| `srcFileHash` | 20 bytes | SHA-1 of the source file |
| `dstFileHash` | 20 bytes | SHA-1 of the destination file |
| `compressionMode` | u32 LE | `0x4E` ('N') = none, `0x5A` ('Z') = zlib |
| `compressedFileSize` | u32 BE | Bytes that follow this header (0 if not last item) |
| `previousFileSize` | u32 BE | Pre-patch file size (reference only) |
| `newFileSize` | u32 BE | Post-patch file size (reference only) |
| `data` | `compressedFileSize` bytes | Only present on the **last** item; earlier items have `compressedFileSize=0` |

The first N-1 items describe intermediate states of the patch chain (incremental
deltas). Only the **final item** carries actual data — that's what MR writes
to disk.

## Decompression

- `0x4E` mode: stream the bytes 1:1 to the output file
- `0x5A` mode: pipe through a `System.IO.Compression.ZLibStream` (`.NET 6+`'s
  native zlib decompressor) capped at `compressedFileSize` via a
  `LimitedStream` wrapper so the decompressor doesn't read beyond the item

## How MR applies a chain

For a chain of patches (e.g. 49 patches to go from launch to 1.23b), the
launcher:

1. Sorts the patch files by filename — names like `D2010.09.18.0000.patch` are
   chronological by ASCII sort
2. For each patch:
   - Opens the file as a `FileStream`
   - Calls `PatchFile.Execute(stream, gamePath)`
   - The parser walks the command stream, creating/deleting directories and
     replacing files in the game folder
   - On success, moves to the next patch
3. After the last patch, writes `<gamePath>/game.ver` = `"2012.09.19.0001"` and
   `<gamePath>/boot.ver` = `"2010.09.18.0000"`

## Edge cases handled

| Case | Resolution |
|------|------------|
| `ETRY` for a file that doesn't exist | Created (warning logged) |
| `ETRY` for a parent directory that doesn't exist | Auto-created |
| `ADIR` for a directory that already exists | Warning, skipped |
| `DELD` for a directory that doesn't exist | Warning, skipped |
| File locked by Explorer (icon cache) | Retried up to 5 times with 1s sleep |
| Unknown command tag | Hard error with offset for debugging |

## Implementation file

`tools/MeteorReborn.Launcher/PatchFile.cs` — 250 LOC, no external dependencies
beyond `System.IO.Compression`. Reference port of the C++ implementation in
the historical Seventh Umbral Launcher.

## Future work

- Hash verification: currently `srcFileHash` / `dstFileHash` are read but not
  checked. Adding SHA-1 verification would catch corrupted patches before
  writing bad data.
- Resumable downloads: if the launcher is killed mid-patch-apply, the partial
  output file is left behind. A `.tmp` + rename pattern would make application
  atomic.
- Parallel apply: independent patches that touch disjoint files could apply in
  parallel. Not implemented; chain order matters for files patched multiple
  times.
