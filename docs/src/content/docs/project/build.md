---
title: Setting up the build
description: Build everything from source — solution, projects, NuGet dependencies, output binaries.
---

The MR repository is a single .NET solution plus a docs site. This page walks
through building each piece from source.

## Solution layout

```
MeteorReborn.sln
├── src/MeteorReborn.Common/        # netstandard2.1 library (wire format, utils)
├── src/MeteorReborn.Login/         # ASP.NET HTTP minimal API
├── src/MeteorReborn.Lobby/         # Console TCP server
├── src/MeteorReborn.World/         # Console TCP server
├── src/MeteorReborn.Map/           # Console TCP server with Lua engine
└── tests/MeteorReborn.Common.Tests/
```

Plus, outside the solution:

```
tools/MeteorReborn.Launcher/   # Standalone WPF .NET 10 project
docs/                          # Astro Starlight docs site (npm)
```

## Prerequisites

| Tool | Version | Where to get it |
|------|---------|-----------------|
| .NET SDK | 10.0 | https://dotnet.microsoft.com/download |
| Node.js | 20+ | https://nodejs.org (only for `docs/`) |
| Python | 3.11+ | https://python.org (only for `tools/sql_mysql_to_postgres.py`) |
| Docker Desktop | latest | Optional but recommended for the stack |
| PostgreSQL | 17 | Optional — only needed for native mode (no Docker) |

## Build the servers

```bash
dotnet restore
dotnet build -c Release MeteorReborn.sln
```

This produces:

- `src/MeteorReborn.Login/bin/Release/net10.0/MeteorReborn.Login.dll`
- `src/MeteorReborn.Lobby/bin/Release/net10.0/MeteorReborn.Lobby.dll`
- `src/MeteorReborn.World/bin/Release/net10.0/MeteorReborn.World.dll`
- `src/MeteorReborn.Map/bin/Release/net10.0/MeteorReborn.Map.dll`

Run them in native mode:

```bash
dotnet run -c Release --project src/MeteorReborn.Map
```

…or use the Docker images which encapsulate the build (see [Quick start](/MeteorReborn/getting-started/docker/)).

## Build the launcher

```bash
cd tools/MeteorReborn.Launcher
dotnet build -c Release
```

Output: `bin/Release/net10.0-windows/MeteorReborn.Launcher.exe`.

The launcher is Windows-only (WPF). It won't build on Linux/macOS — the
`<EnableWindowsTargeting>true</EnableWindowsTargeting>` flag in the `.csproj`
gates cross-platform builds explicitly.

## Build the docs site

```bash
cd docs
npm install
npm run build      # produces docs/dist/
npm run dev        # local dev server at http://localhost:4321/MeteorReborn/
```

Deployed via GitHub Actions on push to `master` — see
`.github/workflows/deploy-docs.yml`.

## NuGet dependencies

| Project | Package | Why |
|---------|---------|-----|
| `Common` | none | Pure standard library |
| `Login` | `Npgsql`, `Serilog`, `Serilog.AspNetCore` | DB + logging |
| `Lobby` / `World` / `Map` | `Npgsql`, `Serilog`, `Serilog.Sinks.Console` | DB + logging |
| `Map` | `MoonSharp.Interpreter`, `Newtonsoft.Json` | Lua engine + JSON serializer |
| `Launcher` | none | Built-in `System.IO.Compression.ZLibStream` for ZIPATCH |

`packages.config` is gone — everything uses SDK-style `<PackageReference>` in
the `.csproj`. NuGet restore happens automatically on `dotnet build`.

## Configuration files

Each server reads its `<name>_config.ini` from the working directory:

- `data/config/login_config.ini`
- `data/config/lobby_config.ini`
- `data/config/world_config.ini`
- `data/config/map_config.ini`

Docker copies these into `/app/` at image build time (see `Dockerfile`). In
native mode you `cp` the relevant `.ini` into the project folder before
`dotnet run` — see [native setup](/MeteorReborn/getting-started/native/).

## Data files

The map server additionally needs:

- `staticactors.bin` — binary list of static actor IDs (commands, quests,
  judges); copied from `data/staticactors.bin`
- `scripts/` — the entire `data/scripts/` Lua tree

Both must be in the map server's working directory at startup.

## Tests

```bash
dotnet test
```

Currently covers `MeteorReborn.Common` only. Wire format round-trip tests
(BasePacket / SubPacket / Blowfish) live in `tests/MeteorReborn.Common.Tests/`.
TCP-level integration tests are not yet present — tracked in
[unfinished content](/MeteorReborn/project/unfinished-content/).

## Common build issues

### `error MSB4018: NuGet.Packaging.Core.PackagingException`

A stale NuGet config is leaking a Windows-style fallback path. Reset:

```bash
dotnet nuget locals all --clear
```

Then retry `dotnet restore`.

### `EnableWindowsTargeting` warning

Building the launcher on Linux will produce a "WindowsDesktop SDK is not
supported" warning. Expected — the launcher only runs on Windows. The CI build
builds everything except the launcher on Linux runners.

### Map server crashes with `Could not find staticactors.bin`

Working directory issue. Either run the map server from `src/MeteorReborn.Map/`
after copying the data files there, or use Docker which sets `WORKDIR /app`
with all files in place.
