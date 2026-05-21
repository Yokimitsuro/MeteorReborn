// PM-MISSING (MR-original infrastructure).
// Lee `<gamePath>/game.ver` y compara con la versión target FFXIV 1.23b.
// Versiones tomadas de SeventhUmbral/launcher/AppDef.h.

using System.IO;

namespace MeteorReborn.Launcher;

internal static class VersionChecker
{
    public const string TargetGameVersion = "2012.09.19.0001"; // FFXIV 1.23b
    public const string TargetBootVersion = "2010.09.18.0000";

    public static string? ReadGameVersion(string gamePath)
    {
        var verFile = Path.Combine(gamePath, "game.ver");
        if (!File.Exists(verFile)) return null;
        try { return File.ReadAllText(verFile).Trim(); }
        catch { return null; }
    }

    public static bool IsUpToDate(string gamePath)
        => ReadGameVersion(gamePath) == TargetGameVersion;

    public static void WriteVersionFiles(string gamePath)
    {
        File.WriteAllText(Path.Combine(gamePath, "game.ver"), TargetGameVersion);
        File.WriteAllText(Path.Combine(gamePath, "boot.ver"), TargetBootVersion);
    }
}
