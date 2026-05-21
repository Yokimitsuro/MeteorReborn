---
title: Architecture overview
description: High-level picture of how the four MR services fit together.
---

```
                    ┌──────────────┐
                    │  Launcher    │  ← WPF .NET 10
                    │  (Windows)   │
                    └──────┬───────┘
              HTTP /api/auth/login + /api/account
                           │
                ┌──────────▼──────────┐
                │   login  :17743     │  ← ASP.NET HTTP (FINISH-PM, MR-original)
                │   Account+session   │
                └──────────┬──────────┘
                           │ writes session
                           ▼
                  ┌──────────────────┐
                  │  postgres :5432  │
                  └──────────────────┘
                           ▲
                           │
ffxivgame.exe ─TCP Blowfish─┼─→ ┌────────────────┐
                           │   │ lobby  :54994  │  ← Character select
                           │   └────────┬───────┘
                           │            │ Session handoff (0x1000)
                           │            ▼
                           │   ┌────────────────┐
                           └───│ world  :54992  │  ← Zone router, parties
                               └────────┬───────┘
                                        │ Inter-server TCP
                                        ▼
                               ┌────────────────┐
                               │  map  :1989    │  ← Gameplay, Lua
                               └────────────────┘
```

## Service responsibilities

### login (`MeteorReborn.Login`)

ASP.NET minimal API, the only **MR-original** service (PM had a PHP/WAMP login).

- `POST /api/account` — register a user (PBKDF2-HMAC-SHA256, 100k iter)
- `POST /api/auth/login` — verify credentials, return a 56-char hex sessionId
- Writes sessions to `sessions` table with 1h TTL; lobby consumes them on connect

### lobby (`MeteorReborn.Lobby`)

TCP server on :54994. Handles the FFXIV 1.x classic Blowfish handshake, lists
characters per user, persists new-character data into the `characters` +
`characters_appearance` tables.

When the client picks a character, lobby tells the client to connect to **world**.

### world (`MeteorReborn.World`)

TCP server on :54992. The "social" router:

- Holds the long-lived TCP connection from `ffxivgame.exe` after lobby handoff
- Manages parties, linkshells, retainer groups, friend lists
- Routes player traffic to the appropriate **map** server based on
  `server_zones.serverIp:serverPort`
- Multiple `world` instances can exist per shard (single-world today)

### map (`MeteorReborn.Map`)

TCP server on :1989. The actual gameplay node:

- Loads all 82 zones + private areas at boot, spawns NPCs and battle NPCs
- Drives the per-zone tick loop (movement, combat, spawning)
- Runs the [Lua engine](/MeteorReborn/architecture/lua/) (MoonSharp) for
  NPC behavior, quest scripts, GM commands
- Sends per-zone packets to clients via world

### postgres (`postgres:17-alpine`)

PostgreSQL 17 holds all persistent state:

- Account + character data
- World definitions: zones, regions, spawn locations, NPCs
- Reference data: items, achievements, battle commands, status effects

Schema is loaded from the 65 SQL dumps + automatic post-load migrations on
first boot (`zz_lowercase_cols.sql`, `zz_tinyint1_to_bool.sql`,
`zz_privateareas_music_compat.sql`).

See [database schema](/MeteorReborn/architecture/database/) for the full layout.

## Wire protocol

Wire-level bytes are **PM-faithful exact**. Every packet the 1.23b client
receives looks identical to what Project Meteor would have sent. See:

- [Packet headers](/MeteorReborn/reference/packet-headers/)
- [Game opcodes](/MeteorReborn/reference/game-opcodes/)
- [Packet flow walkthrough](/MeteorReborn/architecture/packet-flow/)
