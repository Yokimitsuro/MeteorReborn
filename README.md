<sup>**English** · [Español](README.es.md)</sup>

# Meteor Reborn

Server emulator for **FINAL FANTASY XIV 1.0 (version 1.23b)** — a port of
[Project Meteor](https://bitbucket.org/Ioncannon/project-meteor-server) to a
modern stack: .NET 10, PostgreSQL and Docker.

PM was abandoned in 2025. Meteor Reborn revives it in a reproducible
environment: one `docker compose up` and you connect with a patched 1.23b
client.

## Architecture

Four services + database, all in Docker:

| Service    | Port   | Role                                                       |
|------------|--------|------------------------------------------------------------|
| `postgres` | 5432   | PostgreSQL 17 database                                     |
| `login`    | 17743  | HTTP server for account creation and sessions (MR-original)|
| `lobby`    | 54994  | Character selection, Blowfish handshake                    |
| `world`    | 54992  | Zone router, parties, linkshells                           |
| `map`      | 1989   | Game logic, NPCs, combat, Lua scripting                    |

Client flow:

```
Launcher  →  Login HTTP (account + sessionId)
          →  ffxivgame.exe  →  Lobby (TCP+Blowfish)
                            →  World  ↔  Map
```

## Requirements

- **PostgreSQL 17** (bundled by Docker; if going "no-Docker", install it
  separately and create a `meteor` database with user `meteor` / pass `meteor`).
- **Docker Desktop** (Windows or Linux) — *recommended*. Alternative: run the
  services directly with `dotnet run` (see "Without Docker" section).
- **.NET 10 SDK** — always needed to build the launcher; also required in
  "no-Docker" mode for the 4 servers.
- **FFXIV 1.x client installed** on your PC (any version between 2010-09 and
  2012-09 — the launcher will patch it up to 1.23b if outdated).

> The project does NOT distribute the base client. You need your own copy
> installed. The launcher only applies the official `.patch` files on top of
> your install.

## Quick start (with Docker — recommended)

### 1. Bring the server up

```bash
git clone <repo>
cd "Meteor Reborn"
docker compose up -d
```

This creates:
- Volume `meteorreborn_postgres-data` with the database initialized (~65 SQL
  dumps + automatic migrations for boolean types and lowercase columns).
- 4 `.NET 10` containers running lobby/world/map/login.

Verify everything is up:

```bash
docker compose ps
```

## Without Docker (native mode)

If you prefer not to use Docker, install Postgres separately and start each
service with `dotnet run`.

### 1. Postgres + schema load

Install PostgreSQL 17 from
[postgresql.org/download](https://www.postgresql.org/download/) and create the
database:

```bash
psql -U postgres -c "CREATE USER meteor WITH PASSWORD 'meteor';"
psql -U postgres -c "CREATE DATABASE meteor OWNER meteor;"
```

Load the 65 dumps + migrations (alphabetical order matters: the `zz_*` files
must run last):

```bash
cd "Meteor Reborn/data/sql"
for f in $(ls *.sql | sort); do
  psql -U meteor -d meteor -f "$f"
done
```

### 2. Configure the `.ini` files to point at local Postgres

Edit `data/config/*.ini` (4 files: `login_config.ini`, `lobby_config.ini`,
`map_config.ini`, `world_config.ini`) and change `host=postgres` to
`host=127.0.0.1`. For `map_config.ini` also change `server_ip=map` to
`server_ip=127.0.0.1` (and do the same in the DB:
`UPDATE server_zones SET serverip='127.0.0.1';`
`UPDATE servers SET address='127.0.0.1';`).

Copy the `.ini` to the cwd you'll use to launch each service (each one looks
for its `*_config.ini` in the current directory).

### 3. Start the 4 services

In 4 separate terminals:

```bash
# Terminal 1 — Login (:17743)
cd src/MeteorReborn.Login
cp ../../data/config/login_config.ini .
dotnet run -c Release

# Terminal 2 — Lobby (:54994)
cd src/MeteorReborn.Lobby
cp ../../data/config/lobby_config.ini .
dotnet run -c Release

# Terminal 3 — World (:54992)
cd src/MeteorReborn.World
cp ../../data/config/world_config.ini .
dotnet run -c Release

# Terminal 4 — Map (:1989)
cd src/MeteorReborn.Map
cp ../../data/config/map_config.ini .
cp ../../data/staticactors.bin .
cp -r ../../data/scripts .
dotnet run -c Release
```

From here the launcher works the same as in Docker mode.

### 2. Build and open the launcher

(Same step in Docker or native mode.)

```bash
cd tools/MeteorReborn.Launcher
dotnet build -c Release
.\bin\Release\net10.0-windows\MeteorReborn.Launcher.exe
```

In the launcher:

- **Game path**: path to your FFXIV folder (where `ffxivgame.exe` lives).
- **Login server**: `http://127.0.0.1:17743` (default).
- **Lobby server**: `127.0.0.1:54994` (default).
- **Patch source**: local folder for `.patch` files (default
  `.\Meteor Reborn\data\clientPatch`). If a patch is missing, the launcher
  downloads it from **Patch URL base** (default
  `http://ffxivpatches.s3.amazonaws.com/`).

Steps:

1. **Create account** — use the form to register (POST `/api/account`
   against the Login server).
2. **PLAY** — the launcher reads your `game.ver`. If it isn't 1.23b you'll be
   asked whether to update; if you accept it downloads and applies the 49
   patches (~5 GB). When done, it spawns `ffxivgame.exe` patched in memory
   (`LobbyHostNameRva` + `EncryptionTimePatchRva`) and connects to the lobby.

## Configuration

All config files live in **`./Meteor Reborn/data/config/`**:

```
data/config/
├── login_config.ini   # Login HTTP (:17743) + DB credentials
├── lobby_config.ini   # Lobby TCP (:54994) + DB credentials
├── map_config.ini     # Map TCP (:1989) + DB credentials
└── world_config.ini   # World TCP (:54992) + DB credentials
```

### DB credentials

By default the 4 services use `meteor:meteor@<host>:5432/meteor` (host=
`postgres` on Docker, `127.0.0.1` on native mode). Change the credentials in
the 4 `*.ini` before bringing the server up.

### Hostnames

- **Docker mode**: services see each other by name (`map`, `world`,
  `postgres`). The FFXIV client connects via `127.0.0.1` (host port-forward).
  `server_zones.serverip = 'map'` lets **world** find the game server via the
  docker network's internal DNS.
- **Native mode**: everything is `127.0.0.1`. Make sure you run
  `UPDATE server_zones SET serverip='127.0.0.1'` after loading the dumps.

### Direct DB access

```bash
docker exec -it meteorreborn-postgres psql -U meteor -d meteor
```

Relevant tables:
- `users` / `sessions` — login server
- `characters` / `characters_appearance` — characters
- `server_zones` / `server_spawn_locations` — world
- `gamedata_*` — reference (items, NPCs, equipment, achievements)

## Folder structure

```
Meteor Reborn/
├── docker-compose.yml        # postgres + login + lobby + world + map
├── Dockerfile                # multi-stage build, parametrized by PROJECT
├── README.md                 # this file (English) / README.es.md (Spanish)
├── MeteorReborn.sln
├── src/
│   ├── MeteorReborn.Common/  # Wire format, Blowfish, ZLib, utils
│   ├── MeteorReborn.Login/   # HTTP server (FINISH-PM, MR-original)
│   ├── MeteorReborn.Lobby/   # TCP server :54994
│   ├── MeteorReborn.World/   # TCP server :54992 (router)
│   └── MeteorReborn.Map/     # TCP server :1989 (gameplay)
├── tests/
│   └── MeteorReborn.Common.Tests/
├── tools/
│   └── MeteorReborn.Launcher/   # WPF .NET 10 — auth + patcher + game launch
└── data/
    ├── sql/                  # 65 PM dumps + 2 migrations (zz_*)
    ├── scripts/              # Map server Lua (commands, quests, NPCs)
    ├── config/               # *.ini for each service
    └── clientPatch/          # cache of downloaded .patch files (auto-created)
```

## Current status

What works end-to-end:

- Stable docker stack (postgres healthy + 4 servers listening).
- Launcher: create account, login HTTP, version check, download + apply of the
  49 FFXIV patches up to 1.23b, spawn of in-memory patched `ffxivgame.exe`.
- Lobby: character creation + selection, handshake with world.
- World ↔ Map: TCP cluster cross-container via docker service DNS.
- Map: loads 2414 actors, 8403 items, 624 guildleves, 82 zones, 976 spawns,
  151 battle commands, 77 traits.

Known limitations:

- **Incomplete zone-in**: the client reaches the world but map doesn't send
  the full zone-in packet chain (SetMap/SetMusic/SetWeather + player spawn).
  Client disconnects after ~12s.
- **Few monsters out of the box**: PM's SQL dumps only ship 7 spawn locations
  (5 scripted + 2 normal in Central Thanalan). To get more enemies you need
  to insert entries into `server_battlenpc_*` manually.
- **Incomplete Lua scripts**: PM had some half-finished scripts. The patch
  for the `!spawn` GM command disables a dead call to `actor.SetAppearance`
  that NLua silently ignored but MoonSharp rejects.

## How the port was done

PM originally runs on .NET Framework + MySQL + NLua + Mono. Meteor Reborn
moves it to .NET 10 + PostgreSQL + Npgsql + MoonSharp + Serilog, keeping the
wire-level bytes identical to PM (the packets the 1.23b client receives are
byte-exact).

Every change against PM falls into one of these categories (look for the
`// PM-...` and `// FINISH-PM` comments in the code to find them):

- **PM-COMPLETE** — verbatim port, with `// PM file:line` citation.
- **PM-INCOMPLETE** — PM had the logic started; MR finishes it.
- **PM-MISSING** — PM didn't implement it but the 1.23b client requires it;
  MR adds it tagged `FINISH-PM` (example: the HTTP login server).
- **LANG-ADAPT** — stack adaptation (MySQL → Postgres, NLua → MoonSharp,
  nullable C#), applied only when observable behavior is identical.

If you want to contribute or read code, those prefixes tell you quickly
whether what you're looking at is original PM, a language adaptation, or
something added by MR.

## Credits

- **[Project Meteor](https://bitbucket.org/Ioncannon/project-meteor-server)**
  by Ioncannon and contributors — the server codebase (AGPL-3.0).
- **[Seventh Umbral Launcher](https://github.com/jpd002/SeventhUmbral)** by
  jpd002 — reference for the FFXIV patch format (ZIPATCH) and the S3 URLs of
  the official patches.
- **Square Enix** — FINAL FANTASY XIV 1.x. This is an educational server
  emulator; no client content is redistributed.

## License

AGPL-3.0 (inherited from Project Meteor). See [LICENSE](LICENSE) if present
or the original PM repo for full text.
