---
title: Quick start (Docker)
description: Bring up all four MR services and the database with one docker compose up.
---

The recommended path. Five minutes if you have Docker Desktop already running.

## 1. Clone the repo

```bash
git clone https://github.com/Yokimitsuro/MeteorReborn.git
cd MeteorReborn
```

## 2. Bring the server up

```bash
docker compose up -d
```

This creates:

- A volume `meteorreborn_postgres-data` with the database initialized from the
  65 SQL dumps + automatic migrations (`zz_lowercase_cols.sql`,
  `zz_tinyint1_to_bool.sql`, `zz_privateareas_music_compat.sql`).
- Four `.NET 10` containers running lobby, world, map, login.

## 3. Verify

```bash
docker compose ps
```

You should see:

```
SERVICE    STATUS                   PORTS
lobby      Up 5 seconds             0.0.0.0:54994->54994/tcp
login      Up 5 seconds             0.0.0.0:17743->17743/tcp
map        Up 5 seconds             0.0.0.0:1989->1989/tcp
postgres   Up 6 seconds (healthy)   0.0.0.0:5432->5432/tcp
world      Up 5 seconds             0.0.0.0:54992->54992/tcp
```

## 4. Test the login HTTP endpoint

```bash
curl -X POST http://127.0.0.1:17743/api/account \
  -H "Content-Type: application/json" \
  -d '{"username":"test","password":"abc123"}'
# → {"userId":1}

curl -X POST http://127.0.0.1:17743/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"test","password":"abc123"}'
# → {"sessionId":"<56-char hex>","userId":1}
```

## 5. Open the launcher

See the [client setup guide](/MeteorReborn/getting-started/launcher/).

## Stop the stack

```bash
docker compose down            # stop + remove containers (keeps DB volume)
docker compose down -v         # also wipe the database volume (reset to dumps)
```

## Direct DB access

```bash
docker exec -it meteorreborn-postgres psql -U meteor -d meteor
```

Relevant tables:

- `users` / `sessions` — login server
- `characters` / `characters_appearance` — characters
- `server_zones` / `server_spawn_locations` — world
- `gamedata_*` — reference data (items, NPCs, equipment, achievements)

See the [database schema reference](/MeteorReborn/architecture/database/) for the full layout.
