---
title: Client setup & launcher
description: Build the WPF launcher, point it at your FFXIV install, let it patch the client to 1.23b, and connect.
---

The launcher is a WPF .NET 10 app (Windows-only) that handles three things:

1. **Account / login HTTP** against the `login` server
2. **ZIPATCH version check + patcher** — detects your `game.ver`, downloads
   and applies the 49 official FFXIV patches up to 1.23b
3. **Game launch** — spawns `ffxivgame.exe` with the right command line, patches
   it in memory (`LobbyHostNameRva` + `EncryptionTimePatchRva`) and lets it
   connect to the lobby

## 1. Build it

```bash
cd tools/MeteorReborn.Launcher
dotnet build -c Release
.\bin\Release\net10.0-windows\MeteorReborn.Launcher.exe
```

## 2. Configure (Settings panel)

| Field | Default | What it is |
|-------|---------|------------|
| **Game path** | `E:\Program Files (x86)\SquareEnix\FINAL FANTASY XIV` | Folder where `ffxivgame.exe` lives |
| **Login server** | `http://127.0.0.1:17743` | Your `login` service URL |
| **Lobby server** | `127.0.0.1:54994` | What gets patched into the client memory |
| **Patch source** | `.\Meteor Reborn\data\clientPatch` | Local folder where downloaded patches are cached |
| **Patch URL base** | `http://ffxivpatches.s3.amazonaws.com/` | S3 mirror from SeventhUmbral — still online |

Settings persist in `%APPDATA%\MeteorReborn\launcher.json`.

## 3. Use it

1. **Create account** — fills in `POST /api/account` against the Login server.
2. **PLAY** — the launcher:
   - Reads `<gamePath>/game.ver`
   - If it isn't `2012.09.19.0001` (=1.23b), prompts you to update
   - Downloads any missing patches from `Patch URL base` to `Patch source`
   - Applies all 49 patches in chronological order
   - Writes `game.ver` + `boot.ver`
   - Spawns `ffxivgame.exe` patched in memory, connecting to your `Lobby server`

The launcher does **not** distribute the FFXIV base install — you need a copy
of the 1.x client (any version between 2010-09 and 2012-09 works as a starting
point; the patcher brings it up to 1.23b).

## Patches in detail

The 49 patches total ~5 GB. They follow the [ZIPATCH file format](/MeteorReborn/reference/zipatch/),
which the launcher parses natively (see `tools/MeteorReborn.Launcher/PatchFile.cs`).

If you already have a folder full of `.patch` files, drop them at:

```
data/clientPatch/
├── 2d2a390f/patch/D2010.09.18.0000.patch
└── 48eca647/patch/
    ├── D2010.09.19.0000.patch
    └── ... (48 more)
```

The launcher detects existing files by size (within 1%) and skips re-downloading them.
