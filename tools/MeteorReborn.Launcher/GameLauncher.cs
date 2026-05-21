using System.IO;
using System.Runtime.InteropServices;
using System.Text;

namespace MeteorReborn.Launcher;

internal static class GameLauncher
{
    private const uint EncryptionTimePatchRva = 0x9A15E3;
    private static readonly byte[] EncryptionTimePatchBytes = [0xB8, 0x12, 0xE8, 0xE0, 0x50];
    private const uint LobbyHostNameRva = 0xB90110;
    private const int LobbyHostNameMaxSize = 0x14;

    private const uint CREATE_SUSPENDED = 0x00000004;
    private const uint NORMAL_PRIORITY_CLASS = 0x00000020;
    private const uint PAGE_EXECUTE_READWRITE = 0x40;

    [StructLayout(LayoutKind.Sequential)]
    private struct STARTUPINFOA
    {
        public int cb;
        public nint lpReserved;
        public nint lpDesktop;
        public nint lpTitle;
        public int dwX, dwY, dwXSize, dwYSize;
        public int dwXCountChars, dwYCountChars;
        public int dwFillAttribute;
        public int dwFlags;
        public short wShowWindow;
        public short cbReserved2;
        public nint lpReserved2;
        public nint hStdInput, hStdOutput, hStdError;
    }

    [StructLayout(LayoutKind.Sequential)]
    private struct PROCESS_INFORMATION
    {
        public nint hProcess;
        public nint hThread;
        public int dwProcessId;
        public int dwThreadId;
    }

    [DllImport("kernel32.dll", SetLastError = true, CharSet = CharSet.Ansi)]
    private static extern bool CreateProcessA(
        string? lpApplicationName,
        StringBuilder lpCommandLine,
        nint lpProcessAttributes,
        nint lpThreadAttributes,
        bool bInheritHandles,
        uint dwCreationFlags,
        nint lpEnvironment,
        string? lpCurrentDirectory,
        ref STARTUPINFOA lpStartupInfo,
        out PROCESS_INFORMATION lpProcessInformation);

    [DllImport("kernel32.dll", SetLastError = true)]
    private static extern bool WriteProcessMemory(
        nint hProcess, nint lpBaseAddress, byte[] lpBuffer, int nSize, out nint lpNumberOfBytesWritten);

    [DllImport("kernel32.dll", SetLastError = true)]
    private static extern bool VirtualProtectEx(
        nint hProcess, nint lpAddress, int dwSize, uint flNewProtect, out uint lpflOldProtect);

    [DllImport("kernel32.dll", SetLastError = true)]
    private static extern uint ResumeThread(nint hThread);

    [DllImport("kernel32.dll", SetLastError = true)]
    private static extern bool CloseHandle(nint hObject);

    [DllImport("kernel32.dll")]
    private static extern uint GetTickCount();

    [DllImport("kernel32.dll", SetLastError = true)]
    private static extern bool SetProcessAffinityMask(nint hProcess, nuint dwProcessAffinityMask);

    private const int MaxCpuThreads = 15;

    public static (bool ok, int pid, string detail) Launch(string gamePath, string lobbyHost, string sessionId)
    {
        if (sessionId.Length != 56)
            return (false, 0, $"Session ID debe ser 56 chars, recibido {sessionId.Length}.");

        var gameExe = Path.Combine(gamePath, "ffxivgame.exe");
        if (!File.Exists(gameExe))
            return (false, 0, $"No se encuentra ffxivgame.exe en:\n{gamePath}");

        if (lobbyHost.Length >= LobbyHostNameMaxSize)
            return (false, 0, $"Lobby hostname demasiado largo (max {LobbyHostNameMaxSize - 1} chars).");

        var tickCount = GetTickCount();
        var encryptedArgs = BuildEncryptedCommandLine(tickCount, sessionId);
        var cmdLine = new StringBuilder($"\"{gameExe}\" sqex0002{encryptedArgs}!////");

        var si = new STARTUPINFOA { cb = Marshal.SizeOf<STARTUPINFOA>() };

        if (!CreateProcessA(null, cmdLine, 0, 0, false,
                CREATE_SUSPENDED | NORMAL_PRIORITY_CLASS,
                0, gamePath, ref si, out var pi))
        {
            var err = Marshal.GetLastWin32Error();
            return (false, 0, $"CreateProcessA fallo (error {err}).");
        }

        try
        {
            var imageBase = ReadImageBase(gameExe);

            PatchMemory(pi.hProcess, imageBase + EncryptionTimePatchRva,
                EncryptionTimePatchBytes);

            var lobbyBytes = new byte[LobbyHostNameMaxSize];
            Encoding.ASCII.GetBytes(lobbyHost, 0, lobbyHost.Length, lobbyBytes, 0);
            PatchMemory(pi.hProcess, imageBase + LobbyHostNameRva, lobbyBytes);

            if (Environment.ProcessorCount > MaxCpuThreads)
            {
                var mask = (nuint)((1UL << MaxCpuThreads) - 1);
                SetProcessAffinityMask(pi.hProcess, mask);
            }

            ResumeThread(pi.hThread);
            return (true, pi.dwProcessId,
                $"ffxivgame.exe lanzado (PID {pi.dwProcessId}).");
        }
        catch (Exception ex)
        {
            return (false, 0, $"Error al parchear memoria: {ex.Message}");
        }
        finally
        {
            CloseHandle(pi.hThread);
            CloseHandle(pi.hProcess);
        }
    }

    private static string BuildEncryptedCommandLine(uint tickCount, string sessionId)
    {
        var plaintext = $" T ={tickCount} /LANG =en-us /REGION =2 /SERVER_UTC =1356916742 /SESSION_ID ={sessionId}";
        var data = new byte[plaintext.Length + 1];
        Encoding.ASCII.GetBytes(plaintext, 0, plaintext.Length, data, 0);

        var keyStr = (tickCount & ~0xFFFFu).ToString("x8");
        var keyBytes = Encoding.ASCII.GetBytes(keyStr);

        var bf = new BlowfishCipher();
        bf.Initialize(keyBytes, keyBytes.Length);
        bf.EncryptInPlace(data, data.Length);

        var b64 = Convert.ToBase64String(data);
        return b64.Replace('+', '-').Replace('/', '_');
    }

    private static uint ReadImageBase(string exePath)
    {
        using var fs = File.OpenRead(exePath);
        using var br = new BinaryReader(fs);
        fs.Seek(0x3C, SeekOrigin.Begin);
        var peOffset = br.ReadInt32();
        fs.Seek(peOffset + 0x34, SeekOrigin.Begin);
        return br.ReadUInt32();
    }

    private static void PatchMemory(nint hProcess, uint address, byte[] data)
    {
        var addr = (nint)(long)address;
        VirtualProtectEx(hProcess, addr, data.Length, PAGE_EXECUTE_READWRITE, out _);
        if (!WriteProcessMemory(hProcess, addr, data, data.Length, out _))
        {
            var err = Marshal.GetLastWin32Error();
            throw new InvalidOperationException(
                $"WriteProcessMemory fallo en 0x{address:X8} (error {err}).");
        }
    }
}
