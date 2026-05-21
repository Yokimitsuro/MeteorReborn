// PM-MISSING (MR-original infrastructure).
// Orquesta descarga + aplicación del set completo de 49 .patch FFXIV 1.0→1.23b.
//
// Pipeline:
//   1. Por cada entrada en PatchManifest.Entries:
//      - Si el .patch falta en `patchSourcePath` (o size != expected) → descarga
//        desde `patchUrlBase + relPath` via HttpClient.
//      - Reporta progreso de bytes descargados.
//   2. Aplica cada .patch en orden cronológico vía PatchFile.Execute().
//   3. Al terminar escribe game.ver + boot.ver.
//
// Diseño:
//   - PatchSource = carpeta LOCAL (descargas + lectura).
//   - PatchUrlBase = URL HTTP raíz; default = PatchManifest.DefaultUrlBase
//     (http://ffxivpatches.s3.amazonaws.com/ — AWS de SeventhUmbral aún público).

using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace MeteorReborn.Launcher;

internal sealed record PatcherProgress(
    int CurrentIndex,
    int TotalCount,
    string CurrentFileName,
    string Status,
    long DownloadedBytes = 0,
    long DownloadTotalBytes = 0,
    bool IsComplete = false,
    bool HasError = false,
    string? ErrorMessage = null);

internal static class Patcher
{
    public static async Task ApplyAsync(
        string gamePath,
        string patchSourcePath,
        string patchUrlBase,
        IProgress<PatcherProgress> progress,
        CancellationToken cancel = default)
    {
        Directory.CreateDirectory(patchSourcePath);

        // Total acumulado para barras de progreso de descarga.
        long totalBytes = 0;
        foreach (var e in PatchManifest.Entries) totalBytes += e.Size;

        // === FASE 1: descarga ===
        long downloadedBytes = 0;
        for (int i = 0; i < PatchManifest.Entries.Length; i++)
        {
            if (cancel.IsCancellationRequested) { ReportCancelled(progress, i); return; }
            var entry = PatchManifest.Entries[i];

            if (PatchDownloader.IsLocallyComplete(entry, patchSourcePath))
            {
                downloadedBytes += entry.Size;
                progress.Report(new(i + 1, PatchManifest.Entries.Length,
                    Path.GetFileName(entry.RelativePath),
                    $"Already downloaded: {Path.GetFileName(entry.RelativePath)} ({i + 1}/{PatchManifest.Entries.Length})",
                    DownloadedBytes: downloadedBytes,
                    DownloadTotalBytes: totalBytes));
                continue;
            }

            long fileStart = downloadedBytes;
            var inFileProgress = new Progress<long>(b =>
            {
                progress.Report(new(i, PatchManifest.Entries.Length,
                    Path.GetFileName(entry.RelativePath),
                    $"Downloading {Path.GetFileName(entry.RelativePath)} ({i + 1}/{PatchManifest.Entries.Length})... {b / 1024 / 1024} / {entry.Size / 1024 / 1024} MB",
                    DownloadedBytes: fileStart + b,
                    DownloadTotalBytes: totalBytes));
            });

            try
            {
                await PatchDownloader.DownloadAsync(entry, patchUrlBase, patchSourcePath, inFileProgress, cancel);
            }
            catch (Exception ex)
            {
                progress.Report(new(i, PatchManifest.Entries.Length,
                    Path.GetFileName(entry.RelativePath),
                    "Download failed.",
                    IsComplete: true, HasError: true,
                    ErrorMessage: $"Failed to download {entry.RelativePath} from {patchUrlBase}:\n{ex.Message}"));
                return;
            }

            downloadedBytes = fileStart + entry.Size;
        }

        // === FASE 2: aplicación ===
        for (int i = 0; i < PatchManifest.Entries.Length; i++)
        {
            if (cancel.IsCancellationRequested) { ReportCancelled(progress, i); return; }
            var entry = PatchManifest.Entries[i];
            var localPath = Path.Combine(patchSourcePath,
                entry.RelativePath.Replace('/', Path.DirectorySeparatorChar));
            var name = Path.GetFileName(localPath);

            progress.Report(new(i, PatchManifest.Entries.Length, name,
                $"Applying {name} ({i + 1}/{PatchManifest.Entries.Length})...",
                DownloadedBytes: totalBytes, DownloadTotalBytes: totalBytes));

            try
            {
                await Task.Run(() =>
                {
                    using var input = new FileStream(localPath, FileMode.Open, FileAccess.Read, FileShare.Read);
                    var result = PatchFile.Execute(input, gamePath);
                    if (!result.Succeeded)
                        throw new Exception($"Patch '{name}' failed:\n" + string.Join("\n", result.Messages));
                }, cancel);
            }
            catch (Exception ex)
            {
                progress.Report(new(i, PatchManifest.Entries.Length, name,
                    "Patch apply failed.",
                    IsComplete: true, HasError: true,
                    ErrorMessage: ex.Message));
                return;
            }
        }

        VersionChecker.WriteVersionFiles(gamePath);
        progress.Report(new(PatchManifest.Entries.Length, PatchManifest.Entries.Length, "",
            "All patches applied. Game is now at 1.23b.",
            DownloadedBytes: totalBytes, DownloadTotalBytes: totalBytes,
            IsComplete: true));
    }

    private static void ReportCancelled(IProgress<PatcherProgress> progress, int idx)
    {
        progress.Report(new(idx, PatchManifest.Entries.Length, "", "Cancelled.",
            IsComplete: true, HasError: true,
            ErrorMessage: "Patching cancelled by user."));
    }
}
