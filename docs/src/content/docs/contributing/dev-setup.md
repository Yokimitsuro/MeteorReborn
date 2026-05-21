---
title: Dev environment
description: IDE, SDK, debug tooling — what to install to work on Meteor Reborn productively.
---

This page focuses on the **developer** setup beyond what end users need. If
you just want to play, see [Docker setup](/MeteorReborn/getting-started/docker/).

## Recommended stack

| Tool | Why |
|------|-----|
| **Visual Studio 2022** or **Rider** or **VS Code** with C# extension | All four servers + the launcher are .NET 10 projects |
| **.NET 10 SDK** | Build + run + test |
| **Docker Desktop** | Local stack (postgres + 4 servers) |
| **DBeaver** or **pgAdmin 4** or **TablePlus** | Browse/query the Postgres DB |
| **Wireshark** | Capture TCP packets between client and server for protocol debugging |
| **Python 3.11+** | Run the helper scripts in `tools/` |
| **Node 20+** | Build the docs site if you change it |
| **Git** with gitflow knowledge | Branch hygiene |

## Cloning

```bash
git clone https://github.com/Yokimitsuro/MeteorReborn.git
cd MeteorReborn
git checkout develop
```

The default branch is `master` (releases only). All work happens on `develop`
and feature branches off it.

## Recommended IDE setup

### Visual Studio 2022 / Rider

Open `MeteorReborn.sln` — the four server projects + the test project load
together. The launcher is **outside the solution** at
`tools/MeteorReborn.Launcher/MeteorReborn.Launcher.csproj` — open it as a
separate solution or add it to a `.sln` of your own.

Set the startup project to whichever server you're working on
(`MeteorReborn.Map` is usually most interesting). Configure the working
directory to the project folder so it finds its `*_config.ini`,
`staticactors.bin` and `scripts/`:

- Project → Properties → Debug → Working directory → `$(ProjectDir)`

Copy these files into each server project folder one-time:

```bash
cp data/config/login_config.ini src/MeteorReborn.Login/
cp data/config/lobby_config.ini src/MeteorReborn.Lobby/
cp data/config/world_config.ini src/MeteorReborn.World/
cp data/config/map_config.ini   src/MeteorReborn.Map/
cp data/staticactors.bin        src/MeteorReborn.Map/
cp -r data/scripts              src/MeteorReborn.Map/
```

Don't commit them back — they're in `.gitignore` paths.

### VS Code

Install:

- C# Dev Kit (Microsoft)
- C# (OmniSharp)
- Docker
- PostgreSQL (Chris Kolkman) for `psql` inside VS Code

Optional: `astro` extension if you'll edit `docs/`.

## Running the stack for development

### Option A — Docker for everything

```bash
docker compose up -d
```

…then attach a debugger to a container via VS Code "Attach to .NET Process in
Container" or simply tail logs:

```bash
docker compose logs -f map
```

Edit-rebuild-restart cycle (per service):

```bash
docker compose build map
docker compose up -d map
```

### Option B — Postgres in Docker, servers via `dotnet run`

Best for iterative C# work — full debugger support and hot edits.

1. Start just the DB:

   ```bash
   docker compose up -d postgres
   ```

2. Update `data/config/*.ini` so `host=127.0.0.1` instead of `host=postgres`.
3. `UPDATE server_zones SET serverip='127.0.0.1'` so map binds where you can reach it.
4. `dotnet run -c Debug` from each project (4 terminals).

Server logs go to stdout; the Visual Studio debugger attaches by default.

## Database GUI

Connection settings:

| Field | Value |
|-------|-------|
| Host | `localhost` (or `127.0.0.1`) |
| Port | `5432` |
| Database | `meteor` |
| User | `meteor` |
| Password | `meteor` |

DBeaver / TablePlus give you a quick way to query, edit rows, and inspect
schema. The [database schema page](/MeteorReborn/architecture/database/)
lists the relevant tables grouped by domain.

## Wireshark for protocol work

The client never uses TLS — all FFXIV 1.0 traffic is plain TCP (or
Blowfish-encrypted plain TCP, but the headers are still visible).

Filter expressions:

```
tcp.port == 1989                # map server traffic
tcp.port == 54994               # lobby
tcp.port == 54992               # world
tcp.port == 17743               # login HTTP
```

To decode the wire format use the [packet headers](/MeteorReborn/reference/packet-headers/)
reference. Blowfish-encrypted bodies require the session key, which you can
log from `MeteorReborn.Common/Blowfish.cs` if you add a temporary
`Log.Debug("Session key: {Key}", ...)` line.

## Tests

```bash
dotnet test
```

Covers `MeteorReborn.Common` (wire format, Blowfish, zlib helpers).
End-to-end TCP tests against the running stack are a TODO — contributions
welcome.

## Code formatting

The repo doesn't enforce a specific formatter. PM's original code style is
varied (some files use 4-space, some 8-space, some tabs). We don't normalize
existing code (it makes diffs against PM unreadable) — keep the convention
of the file you're editing.

For **new files**, use:

- 4 spaces, no tabs
- Allman-style braces (opening brace on new line) — matches PM
- `// PascalCase` for type names, `camelCase` for fields/locals — matches PM
- Lead with the PM-COMPLETE / FINISH-PM / LANG-ADAPT comment block (see
  [code conventions](/MeteorReborn/contributing/conventions/))

## Skipping the launcher when iterating

The launcher is great for end users but slow for dev iteration (~5 GB of
patches to apply on first run). If you have a 1.23b client already patched,
you can launch `ffxivgame.exe` directly with the right command line — the
launcher source is your reference (`GameLauncher.Launch`).

Test accounts can be created in bulk against the login HTTP endpoint:

```bash
for i in {1..10}; do
  curl -s -X POST http://127.0.0.1:17743/api/account \
    -H "Content-Type: application/json" \
    -d "{\"username\":\"test$i\",\"password\":\"test\"}"
done
```

## When things break

See [debugging](/MeteorReborn/contributing/debugging/) for common patterns:
zone-in failures, Lua errors, Postgres type mismatches, packet flush issues,
Docker DNS surprises.
