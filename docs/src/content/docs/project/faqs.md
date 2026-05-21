---
title: FAQs
description: Frequently asked questions about running and developing Meteor Reborn.
---

## General

### What is Meteor Reborn?

A revival of [Project Meteor](https://bitbucket.org/Ioncannon/project-meteor-server)
— the FFXIV 1.0 server emulator abandoned in 2019 — ported to a modern stack
(.NET 10, PostgreSQL 17, Docker). Includes a WPF launcher that patches the
client to 1.23b before connecting.

### Is this legal?

The server code is original or PM-derived (AGPL-3.0, see [credits](/)). The
project does **not** distribute the FFXIV client binaries, the official `.patch`
files, or any SQUARE ENIX-owned assets. Players supply their own legally-acquired
copy of the 1.0/1.23b client. The launcher just patches an install you already
have.

### Which version of FFXIV?

Patch 1.23b (game version `2012.09.19.0001`, boot version `2010.09.18.0000`).
That's the last public 1.0 build before the world reset, and the version the
PM protocol implementation targets.

### Can I play 2.x / Endwalker / Dawntrail with this?

No. Meteor Reborn is exclusively for FFXIV 1.0. The 2.x+ protocol is entirely
different and there are mature server emulator projects for those eras.

## Setup

### Why Docker?

It removes the "five services + a Postgres" setup pain. One `docker compose up`
brings up the whole stack with a known-good schema and config. Without Docker,
[native mode](/MeteorReborn/getting-started/native/) requires manually
installing Postgres 17, loading 65 SQL dumps, and starting four .NET processes.

### Why PostgreSQL instead of MySQL?

PM ran on MySQL 5.7. We picked Postgres 17 for the port because:

- Free, modern, single-image Docker container
- Better type system (booleans, jsonb, generated columns)
- Strict SQL is easier to write code against than MySQL's permissive defaults
- Npgsql is a first-class .NET driver

Some MySQL→Postgres adaptations were needed (`ON CONFLICT` instead of
`ON DUPLICATE KEY`, `DISTINCT ON` instead of permissive `GROUP BY`, etc).
See [port notes](/MeteorReborn/architecture/port-notes/).

### What about the client install?

You need a 1.0 / 1.x client install. Any version from 2010-09 to 2012-09
works as a starting point — the launcher will detect via `game.ver` and apply
the chain of official `.patch` files to bring it up to 1.23b.

## Connection issues

### Launcher won't connect to login server

Check `docker compose ps` — make sure the `login` container is healthy.
Curl-test:

```bash
curl http://127.0.0.1:17743/
# Expect: {"service":"MeteorReborn Login","status":"ok"}
```

If you changed `data/config/login_config.ini`, restart the login container.

### Client crashes immediately after PLAY

Most likely the in-memory patch didn't apply correctly. Check launcher logs
(should print `ffxivgame.exe lanzado (PID ...)`). If `WriteProcessMemory failed`
appears, the FFXIV exe RVAs probably don't match a 1.23b binary — verify your
client install with the launcher's version check.

### Client connects to lobby but disconnects after character select

This is the known [zone-in incomplete](/MeteorReborn/project/unfinished-content/)
issue. Map server creates the session but the zone-in packet chain doesn't
complete, client times out around 12 seconds.

Workaround for testing: lobby + world + character creation flow works,
in-world play does not yet.

### `Loaded 2 monsters` only

Expected — PM's SQL dumps only ship 7 monster spawn locations. The 1.0 client
has 134 monster models, but populating spawn coordinates is content work PM
never finished. Use `!spawn <actorClassId>` in chat to spawn any of the 134
models at your position.

## Development

### How is the C# code organized?

```
src/MeteorReborn.Common/   — Wire format helpers (BasePacket, SubPacket, Blowfish, ZLib)
src/MeteorReborn.Login/    — ASP.NET HTTP (FINISH-PM, MR-original)
src/MeteorReborn.Lobby/    — TCP server :54994
src/MeteorReborn.World/    — TCP server :54992 (router)
src/MeteorReborn.Map/      — TCP server :1989 (gameplay engine + Lua)
tools/MeteorReborn.Launcher — WPF .NET 10 launcher
```

Every file has a `// PM-COMPLETE` / `// PM-INCOMPLETE` / `// PM-MISSING` /
`// LANG-ADAPT` marker at the top. See [port notes](/MeteorReborn/architecture/port-notes/)
for what each means.

### How do I add a Lua script?

Drop the file in the appropriate `data/scripts/` subfolder. NPCs go under
`data/scripts/base/chara/npc/<family>/<class>.lua`, GM commands under
`data/scripts/commands/gm/`, quests under `data/scripts/quests/`. Restart map
to pick up new files; edits to existing files are re-read on each invocation.

### How do I run the test suite?

```bash
cd src
dotnet test
```

Currently tests cover `MeteorReborn.Common` only. The TCP servers don't have
end-to-end coverage yet — that's tracked in
[unfinished content](/MeteorReborn/project/unfinished-content/).

### Can I contribute?

Yes — PR against `develop`. Follow gitflow: feature branches off `develop`,
release branches when stable, `master` only for tagged releases. See the
[GitHub repo](https://github.com/Yokimitsuro/MeteorReborn).

## Performance

### How much RAM/CPU does it use?

Idle (no players): all five containers together use ~150 MB RAM and < 1% CPU.
Map server is the heaviest (~80 MB) because it loads 8403 items + 2414 static
actors + 1655 actor classes into memory at boot.

Per active player, expect another ~5 MB of RAM and minimal CPU until in-world
gameplay drives actor updates.

### How many concurrent players can it handle?

Untested at scale. PM originally targeted dozens-of-players community servers,
not thousands. The Lua scripting engine (MoonSharp) is single-threaded per
script context, which is a likely scalability ceiling.
