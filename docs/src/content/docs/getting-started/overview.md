---
title: Overview
description: What Meteor Reborn is, what you need to run it, what already works and what doesn't.
---

Meteor Reborn is a server emulator for **FINAL FANTASY XIV 1.0 (version 1.23b)**.
It's a port of [Project Meteor](https://bitbucket.org/Ioncannon/project-meteor-server)
— a community project that reverse-engineered the original 1.x protocol and was
abandoned in 2019 — to a modern stack:

- **.NET 10** + **PostgreSQL 17** + **Docker** for the server side
- **WPF** launcher (.NET 10) for client auth + auto-patching to 1.23b
- **MoonSharp** for the Lua scripting engine (PM used NLua)

## Architecture

Four services + a database:

| Service    | Port   | Role                                                        |
|------------|--------|-------------------------------------------------------------|
| `postgres` | 5432   | PostgreSQL 17 database                                      |
| `login`    | 17743  | HTTP server for account creation and sessions (MR-original) |
| `lobby`    | 54994  | Character selection, Blowfish handshake                     |
| `world`    | 54992  | Zone router, parties, linkshells                            |
| `map`      | 1989   | Game logic, NPCs, combat, Lua scripting                     |

Client flow:

```
Launcher  →  Login HTTP (account + sessionId)
          →  ffxivgame.exe  →  Lobby (TCP+Blowfish)
                            →  World  ↔  Map
```

## Requirements

- **PostgreSQL 17** — bundled by Docker; if going [native](/MeteorReborn/getting-started/native/), install it separately.
- **Docker Desktop** (Windows or Linux) — *recommended* path.
- **.NET 10 SDK** — always required for the launcher, plus the 4 servers if not using Docker.
- **FFXIV 1.x client installed** — any version between 2010-09 and 2012-09; the launcher patches it to 1.23b.

:::caution
The project does not distribute the base client. You need your own copy
installed. The launcher only applies the official `.patch` files on top.
:::

## What works

- Stable Docker stack (`postgres` + `login` + `lobby` + `world` + `map`)
- Native mode (no Docker) — documented
- Launcher: account creation, login HTTP, version check, ZIPATCH patcher with
  HTTP downloader for the 49 official FFXIV patches up to 1.23b
- Lobby flow: character creation + selection, Blowfish handshake
- World ↔ Map cluster via Docker service DNS
- Map loads 2414 actors, 8403 items, 624 guildleves, 82 zones, 976 spawns,
  969 battle commands, 77 traits

## Known limitations

- **Zone-in incomplete**: client times out ~12s after the map session is
  created (`SetMap` / `SetMusic` / `SetWeather` + player spawn chain not fully
  wired yet).
- **Few monsters out of the box**: PM's SQL dumps ship only 7 spawn locations
  (5 scripted in Central Shroud + 2 normal wharf rats in Central Thanalan).
  The client contains ~134 monster models but spawn locations are server-side
  content PM never finished.
- **Some PM Lua scripts had silent NLua errors** — MoonSharp surfaces them. We
  patch the worst ones (`spawn.lua`, `sacred_prism.lua`) as we hit them.

## Next steps

1. [Set it up with Docker](/MeteorReborn/getting-started/docker/) (5 minutes)
2. [Or run it natively](/MeteorReborn/getting-started/native/) (no containers)
3. [Set up the launcher and patch your client](/MeteorReborn/getting-started/launcher/)
