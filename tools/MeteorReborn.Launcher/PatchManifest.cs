// PM-MISSING (MR-original infrastructure).
// Manifest hardcoded de los 49 .patch FFXIV 1.0→1.23b, copiado verbatim de
// SeventhUmbral/launcher/PatcherWindow.cpp:12-88 (CPatcherWindow::m_downloads).
// Path relativo al PatchUrlBase / PatchSource. Size en bytes (verificado contra archivo
// local antes de aplicar). CRC32 se ignora — chequear size es suficiente.

namespace MeteorReborn.Launcher;

internal sealed record PatchManifestEntry(string RelativePath, long Size);

internal static class PatchManifest
{
    public static readonly PatchManifestEntry[] Entries = new[]
    {
        new PatchManifestEntry("2d2a390f/patch/D2010.09.18.0000.patch", 0x00550467L),

        new PatchManifestEntry("48eca647/patch/D2010.09.19.0000.patch", 444398866L),
        new PatchManifestEntry("48eca647/patch/D2010.09.23.0000.patch", 6907277L),
        new PatchManifestEntry("48eca647/patch/D2010.09.28.0000.patch", 18803280L),

        new PatchManifestEntry("48eca647/patch/D2010.10.07.0001.patch", 19226330L),
        new PatchManifestEntry("48eca647/patch/D2010.10.14.0000.patch", 19464329L),
        new PatchManifestEntry("48eca647/patch/D2010.10.22.0000.patch", 19778252L),
        new PatchManifestEntry("48eca647/patch/D2010.10.26.0000.patch", 19778391L),

        new PatchManifestEntry("48eca647/patch/D2010.11.25.0002.patch", 250718651L),
        new PatchManifestEntry("48eca647/patch/D2010.11.30.0000.patch", 6921623L),

        new PatchManifestEntry("48eca647/patch/D2010.12.06.0000.patch", 7158904L),
        new PatchManifestEntry("48eca647/patch/D2010.12.13.0000.patch", 263311481L),
        new PatchManifestEntry("48eca647/patch/D2010.12.21.0000.patch", 7521358L),

        new PatchManifestEntry("48eca647/patch/D2011.01.18.0000.patch", 9954265L),

        new PatchManifestEntry("48eca647/patch/D2011.02.01.0000.patch", 11632816L),
        new PatchManifestEntry("48eca647/patch/D2011.02.10.0000.patch", 11714096L),

        new PatchManifestEntry("48eca647/patch/D2011.03.01.0000.patch", 77464101L),
        new PatchManifestEntry("48eca647/patch/D2011.03.24.0000.patch", 108923937L),
        new PatchManifestEntry("48eca647/patch/D2011.03.30.0000.patch", 109010880L),

        new PatchManifestEntry("48eca647/patch/D2011.04.13.0000.patch", 341603850L),
        new PatchManifestEntry("48eca647/patch/D2011.04.21.0000.patch", 343579198L),

        new PatchManifestEntry("48eca647/patch/D2011.05.19.0000.patch", 344239925L),

        new PatchManifestEntry("48eca647/patch/D2011.06.10.0000.patch", 344334860L),

        new PatchManifestEntry("48eca647/patch/D2011.07.20.0000.patch", 584926805L),
        new PatchManifestEntry("48eca647/patch/D2011.07.26.0000.patch", 7649141L),

        new PatchManifestEntry("48eca647/patch/D2011.08.05.0000.patch", 152064532L),
        new PatchManifestEntry("48eca647/patch/D2011.08.09.0000.patch", 8573687L),
        new PatchManifestEntry("48eca647/patch/D2011.08.16.0000.patch", 6118907L),

        new PatchManifestEntry("48eca647/patch/D2011.10.04.0000.patch", 677633296L),
        new PatchManifestEntry("48eca647/patch/D2011.10.12.0001.patch", 28941655L),
        new PatchManifestEntry("48eca647/patch/D2011.10.27.0000.patch", 29179764L),

        new PatchManifestEntry("48eca647/patch/D2011.12.14.0000.patch", 374617428L),
        new PatchManifestEntry("48eca647/patch/D2011.12.23.0000.patch", 22363713L),

        new PatchManifestEntry("48eca647/patch/D2012.01.18.0000.patch", 48998794L),
        new PatchManifestEntry("48eca647/patch/D2012.01.24.0000.patch", 49126606L),
        new PatchManifestEntry("48eca647/patch/D2012.01.31.0000.patch", 49536396L),

        new PatchManifestEntry("48eca647/patch/D2012.03.07.0000.patch", 320630782L),
        new PatchManifestEntry("48eca647/patch/D2012.03.09.0000.patch", 8312819L),
        new PatchManifestEntry("48eca647/patch/D2012.03.22.0000.patch", 22027738L),
        new PatchManifestEntry("48eca647/patch/D2012.03.29.0000.patch", 8322920L),

        new PatchManifestEntry("48eca647/patch/D2012.04.04.0000.patch", 8678570L),
        new PatchManifestEntry("48eca647/patch/D2012.04.23.0001.patch", 289511791L),

        new PatchManifestEntry("48eca647/patch/D2012.05.08.0000.patch", 27266546L),
        new PatchManifestEntry("48eca647/patch/D2012.05.15.0000.patch", 27416023L),
        new PatchManifestEntry("48eca647/patch/D2012.05.22.0000.patch", 27742726L),

        new PatchManifestEntry("48eca647/patch/D2012.06.06.0000.patch", 129984024L),
        new PatchManifestEntry("48eca647/patch/D2012.06.19.0000.patch", 133434217L),
        new PatchManifestEntry("48eca647/patch/D2012.06.26.0000.patch", 133581048L),

        new PatchManifestEntry("48eca647/patch/D2012.07.21.0000.patch", 253224781L),

        new PatchManifestEntry("48eca647/patch/D2012.08.10.0000.patch", 42851112L),

        new PatchManifestEntry("48eca647/patch/D2012.09.06.0000.patch", 20566711L),
        new PatchManifestEntry("48eca647/patch/D2012.09.19.0001.patch", 20874726L),
    };

    public const string DefaultUrlBase = "http://ffxivpatches.s3.amazonaws.com/";
}
