---
title: Without Docker (native mode)
description: Run the 4 services with dotnet run + a local Postgres install.
---

If you prefer not to use Docker, install Postgres directly and run each service
with `dotnet run`.

## 1. Postgres + schema load

Install [PostgreSQL 17](https://www.postgresql.org/download/), then create the DB:

```bash
psql -U postgres -c "CREATE USER meteor WITH PASSWORD 'meteor';"
psql -U postgres -c "CREATE DATABASE meteor OWNER meteor;"
```

Load the 65 dumps + migrations (alphabetical order — `zz_*` files run last):

```bash
cd "MeteorReborn/data/sql"
for f in $(ls *.sql | sort); do
  psql -U meteor -d meteor -f "$f"
done
```

## 2. Configure the `.ini` files for local Postgres

Edit the 4 files in `data/config/`:

- `login_config.ini`
- `lobby_config.ini`
- `map_config.ini`
- `world_config.ini`

Change `host=postgres` to `host=127.0.0.1`.

For `map_config.ini`, also change `server_ip=map` to `server_ip=127.0.0.1`, and
do the same in the DB:

```sql
UPDATE server_zones SET serverip = '127.0.0.1';
UPDATE servers SET address = '127.0.0.1';
```

## 3. Start the 4 services

In four separate terminals:

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

From here the [launcher](/MeteorReborn/getting-started/launcher/) works the same as in Docker mode.

:::tip
Map server expects `staticactors.bin` and the `scripts/` folder in its working
directory. The Docker build copies these automatically; native mode requires
the manual copy step above.
:::
