// PM-MISSING (MR-original infrastructure).
// HttpClient downloader con report de progreso para los .patch FFXIV.
// Equivalente al CDownloaderService de SeventhUmbral pero usando HttpClient nativo.

using System.IO;
using System.Net.Http;

namespace MeteorReborn.Launcher;

internal static class PatchDownloader
{
    private static readonly HttpClient Http = CreateClient();

    private static HttpClient CreateClient()
    {
        var c = new HttpClient(new HttpClientHandler
        {
            // Las patches están en S3 público — sin auth, pero permitir redirects.
            AllowAutoRedirect = true,
        });
        c.Timeout = TimeSpan.FromMinutes(30); // grandes patches (700 MB) pueden tardar
        c.DefaultRequestHeaders.UserAgent.ParseAdd("MeteorReborn-Launcher/1.0");
        return c;
    }

    /// <summary>
    /// Descarga `urlBase + entry.RelativePath` a `localRoot / entry.RelativePath`.
    /// Reporta progreso vía bytesDownloaded callback (acumulado de este file).
    /// </summary>
    public static async Task DownloadAsync(
        PatchManifestEntry entry,
        string urlBase,
        string localRoot,
        IProgress<long> bytesDownloaded,
        CancellationToken cancel)
    {
        var localPath = Path.Combine(localRoot, entry.RelativePath.Replace('/', Path.DirectorySeparatorChar));
        var localDir = Path.GetDirectoryName(localPath)!;
        Directory.CreateDirectory(localDir);

        // Build URL (asegura `/` separator y trailing slash en base).
        var baseUri = urlBase.EndsWith('/') ? urlBase : urlBase + "/";
        var url = baseUri + entry.RelativePath;

        using var resp = await Http.GetAsync(url, HttpCompletionOption.ResponseHeadersRead, cancel);
        resp.EnsureSuccessStatusCode();

        using var src = await resp.Content.ReadAsStreamAsync(cancel);
        using var dst = new FileStream(localPath, FileMode.Create, FileAccess.Write, FileShare.None);

        var buf = new byte[0x10000]; // 64 KB
        long totalRead = 0;
        while (true)
        {
            int n = await src.ReadAsync(buf.AsMemory(0, buf.Length), cancel);
            if (n == 0) break;
            await dst.WriteAsync(buf.AsMemory(0, n), cancel);
            totalRead += n;
            bytesDownloaded.Report(totalRead);
        }

        // Verificación de size: si server devolvió Content-Length lo comparamos a entry.Size.
        if (totalRead != entry.Size)
        {
            // No es fatal — algunos espejos pueden tener tamaños ligeramente distintos. Loggear.
            // Pero si difiere mucho (>1%), el patch probablemente está corrupto.
            var pct = Math.Abs(totalRead - entry.Size) / (double)entry.Size;
            if (pct > 0.01)
                throw new InvalidDataException(
                    $"Downloaded size {totalRead} doesn't match expected {entry.Size} (entry={entry.RelativePath}).");
        }
    }

    /// <summary>True si el file local existe Y su tamaño matchea entry.Size dentro del 1%.</summary>
    public static bool IsLocallyComplete(PatchManifestEntry entry, string localRoot)
    {
        var localPath = Path.Combine(localRoot, entry.RelativePath.Replace('/', Path.DirectorySeparatorChar));
        var fi = new FileInfo(localPath);
        if (!fi.Exists) return false;
        var pct = Math.Abs(fi.Length - entry.Size) / (double)entry.Size;
        return pct <= 0.01;
    }
}
