---
title: Regions & zones
description: All zones served by Meteor Reborn — IDs, region groups, instanced sub-areas.
---

Meteor Reborn loads **111 zones** at boot (`map_config.ini` →
`WorldManager.LoadZoneList`). Each zone belongs to a region. The mapping is
stored in `server_zones`.

## Region breakdown

| Region ID | Zones | Approximate scope |
|-----------|-------|-------------------|
| 0 | 1 | Internal / debug |
| 101 | 22 | La Noscea (Limsa Lominsa) |
| 102 | 13 | Black Shroud (Gridania) |
| 103 | 19 | Thanalan (Ul'dah) |
| 104 | 25 | Coerthas + connectors |
| 105 | 4 | Mor Dhona |
| 106 | 5 | Battle zones |
| 107 | 2 | Public dungeons |
| 109 | 3 | Special / event |
| 111 | 1 | Tutorial |
| 112 | 6 | Tactics zones |
| 202 | 2 | Inn rooms |
| 204 | 2 | Story scenes |
| 205 | 2 | Story scenes |
| 207-209 | 3 | Other private |
| 805 | 1 | Maintenance |

Full list:

```bash
docker exec meteorreborn-postgres psql -U meteor -d meteor -c \
  "SELECT id, zonename, placename, regionid FROM server_zones ORDER BY regionid, id;"
```

## Zone schema

`server_zones` columns (lowercase post-`zz_lowercase_cols.sql`):

| Column | Type | Notes |
|--------|------|-------|
| `id` | bigint | Zone ID — clients reference these |
| `zonename` | varchar | Internal name (`wil0Field01`, `fst0Town01`) |
| `placename` | varchar | Display name (`Central Thanalan`) |
| `regionid` | integer | See breakdown above |
| `serverip` | varchar | Which map server owns this zone — defaults to `map` (docker DNS) |
| `serverport` | bigint | 1989 by default |
| `daymusic` / `nightmusic` / `battlemusic` | integer | BGM IDs |
| `isisolated` | boolean | Cut off from world map? |
| `isinn` | boolean | Inn rest available? |
| `canridechocobo` | boolean | Chocobo allowed? |
| `canstealth` | boolean | Hide command works? |
| `isinstanceraid` | boolean | Raid instance? |
| `loadnavmesh` | boolean | Has a `.snb` navmesh file |

## Private areas (instances)

25 private areas in `server_zones_privateareas` — instanced sub-zones nested
inside a parent zone:

| Type | Count | Examples |
|------|-------|----------|
| Inn rooms | ~8 | Per starter city |
| Story scenes | ~10 | `PrivateAreaMasterPast` and similar |
| Market wards | ~3 | `PrivateAreaMasterMarket` |
| Special raids | ~4 | Endgame content |

Schema notes:

- `parentzoneid` — the open-world zone it sits inside
- `privateareaname` — internal identifier
- `privateareatype` — 0=instance, 1=raid (rough mapping from observed data)
- `canexitarea` — whether `/return` exits to parent
- `music` — alt-PM collapsed daymusic/nightmusic/battlemusic into one column;
  `zz_privateareas_music_compat.sql` re-adds the three legacy columns so PM
  C# code keeps working

## How map server loads zones

On startup, `WorldManager.LoadZoneList` queries:

```sql
SELECT id, zonename, regionid, classpath, daymusic, nightmusic, battlemusic,
       isisolated, isinn, canridechocobo, canstealth, isinstanceraid, loadnavmesh
FROM server_zones
WHERE zonename IS NOT NULL AND serverip = @ip AND serverport = @port
```

Only zones whose `serverip:serverport` matches *this* map server's bind get
loaded. With Docker DNS that's `map:1989`; in [native mode](/MeteorReborn/getting-started/native/)
you `UPDATE` the rows to `127.0.0.1`.

## Spawn locations per zone

| Table | Rows | Used for |
|-------|------|----------|
| `server_zones_spawnlocations` | many | Aetheryte teleport points, return points |
| `server_spawn_locations` | 999 | Populace NPCs (vendors, quest givers) |
| `server_eventnpc_spawn_locations` | 1294 | Event NPCs |
| `server_battlenpc_spawn_locations` | **7** | Enemy spawns — PM never populated more |

The first three are loaded by `WorldManager` and tied to actors in
`gamedata_actor_class`. The fourth is the source of `Loaded N monsters` in
the map server log; see [monster models](/MeteorReborn/world/monster-models/)
for what's actually spawnable.
