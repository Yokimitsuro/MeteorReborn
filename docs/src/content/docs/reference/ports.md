---
title: Ports & services
description: Port mappings, what listens where, and how containers talk to each other.
---

## TCP ports exposed on the host

| Service | Host port | Container port | Protocol |
|---------|-----------|----------------|----------|
| postgres | 5432 | 5432 | PostgreSQL wire |
| login | 17743 | 17743 | HTTP (ASP.NET) |
| lobby | 54994 | 54994 | TCP + Blowfish |
| world | 54992 | 54992 | TCP |
| map | 1989 | 1989 | TCP |

All exposed on `0.0.0.0` of the host so the FFXIV client (running on Windows
outside Docker) reaches them via `127.0.0.1:<port>`.

## Inter-container DNS

Inside the `meteorreborn_default` bridge network, services resolve each other
by **service name** (defined in `docker-compose.yml`):

| Source | Target | Used for |
|--------|--------|----------|
| login | `postgres:5432` | DB access |
| lobby | `postgres:5432` | DB access |
| world | `postgres:5432`, `map:1989` | DB + zone server connect |
| map | `postgres:5432` | DB access |

That's why `data/config/*.ini` ships with `host=postgres` and `map_config.ini`
has `server_ip=map`. The DB also stores `server_zones.serverip = 'map'` so
**world** knows where to reach the game server.

## Client → server routing

The client never talks to `map` directly. Flow:

```
ffxivgame.exe ──TCP──► 127.0.0.1:54994 (lobby)
                                          ▼ tells client which world
ffxivgame.exe ──TCP──► 127.0.0.1:54992 (world)
                                          ▼ internal TCP
                                          map:1989 (inside docker)
```

World holds the client's long-lived TCP socket for the entire gameplay session
and forwards packets to/from map transparently.

## What gets patched into ffxivgame.exe

The launcher (`GameLauncher.cs`) writes two patches at process creation:

| RVA | Bytes | Purpose |
|-----|-------|---------|
| `0x9A15E3` | 5 | Disable encryption time check (`mov eax, 0x50E0E812`) |
| `0xB90110` | up to 20 | Lobby hostname string — your `127.0.0.1` |

The lobby port is **hardcoded in the client** (54994) and not patched.

## Without Docker

In native mode, everything uses `127.0.0.1` and the DB needs:

```sql
UPDATE server_zones SET serverip = '127.0.0.1';
UPDATE servers SET address = '127.0.0.1';
```

See [native setup](/MeteorReborn/getting-started/native/).
