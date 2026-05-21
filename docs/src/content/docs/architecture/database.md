---
title: Database schema
description: PostgreSQL 17 tables grouped by domain, with notes on LANG-ADAPT migrations from MySQL.
---

PostgreSQL 17 holds all persistent state. The schema is loaded from **65 SQL
dumps** (PM verbatim, MySQL→Postgres-converted via `tools/sql_mysql_to_postgres.py`)
plus three post-load migrations.

## Loading order

Files in `data/sql/` load alphabetically. The `zz_*` files run last:

| File | Purpose |
|------|---------|
| `*.sql` (62 files) | Per-table dumps from PM (`gamedata_*`, `server_*`, `characters_*`) |
| `zz_lowercase_cols.sql` | LANG-ADAPT: ALTER all camelCase columns to lowercase (MySQL was case-insensitive, Postgres isn't) |
| `zz_tinyint1_to_bool.sql` | LANG-ADAPT: convert MySQL `tinyint(1)` columns to native `boolean` so Npgsql can read them |
| `zz_privateareas_music_compat.sql` | Compat: alt-PM collapsed `daymusic`/`nightmusic`/`battlemusic` into one `music` column; this re-adds the three for PM C# code |

## Table groups

### Account / auth (`MeteorReborn.Login`)

| Table | Rows | Purpose |
|-------|------|---------|
| `users` | dynamic | Registered accounts. PBKDF2-HMAC-SHA256 password hash + salt. |
| `sessions` | dynamic | 56-char hex session tokens, 1h TTL, 1 active per user (`ON CONFLICT (userid)`). |

### Character (`MeteorReborn.Lobby` + `MeteorReborn.Map`)

| Table | Description |
|-------|-------------|
| `characters` | Core character row: name, position, zone, GC rank, achievements, playTime |
| `characters_appearance` | 28 appearance fields (face, hair, body, equipment slots) |
| `characters_class_levels` | XP per class — DoW/DoM/DoH/DoL |
| `characters_inventory` | Item bag, key items, currency |
| `characters_inventory_equipment` | What's equipped per class |
| `characters_hotbar` | Action bar layout |
| `characters_quest_*` | Quest progress (scenario/local/regional guildleve) |
| `characters_friendlist` / `characters_blacklist` / `characters_linkshells` | Social |
| `characters_retainers` / `characters_chocobo` / `characters_npclinkshell` | Pets / vendors |

### World / gameplay

| Table | Rows | Description |
|-------|------|-------------|
| `server_zones` | 111 | All zones + their server assignment (`serverip`, `serverport`) |
| `server_zones_privateareas` | 25 | Instanced sub-zones (housing, raids, story scenes) |
| `server_zones_spawnlocations` | many | Aetheryte / return points |
| `server_spawn_locations` | 999 | Populace NPC positions |
| `server_eventnpc_spawn_locations` | 1294 | Event NPC positions (vendors, quest givers) |
| `server_eventnpc_mapobj` | 79 | Interactive map objects |
| `server_battlenpc_groups` | 4 | Monster spawn groups (zone + behavior) |
| `server_battlenpc_pools` | 4 | Pools — which actor class to use |
| `server_battlenpc_genus` | 65 | Monster family templates (stats, kindred, scaling) |
| `server_battlenpc_spawn_locations` | **7** | Hardcoded coordinates — *only 7 enemy spawns ship with PM* |
| `server_battlenpc_skill_list` | 155 | Skills monsters can use |
| `server_battlenpc_spell_list` | 7 | Spells monsters can cast |
| `server_battle_commands` | **969** | All player + monster combat abilities |
| `server_battle_traits` | 77 | Job traits |
| `server_statuseffects` | 294 | Buff/debuff definitions |
| `server_linkshells` | dynamic | Player-created linkshells |
| `server_retainers` | dynamic | Player retainers |
| `server_items` / `server_items_dealing` / `server_items_modifiers` | dynamic | Player-owned items, market transactions |

### Reference (`gamedata_*`)

| Table | Rows | Description |
|-------|------|-------------|
| `gamedata_actor_class` | 7984 | All actor models the client knows (classpath, displayName, eventConditions) |
| `gamedata_actor_appearance` | many | Appearance templates (body, face, equipment) |
| `gamedata_actor_pushcommand` | 145 | NPC interact-trigger commands |
| `gamedata_items` | 8403 | All item definitions |
| `gamedata_items_equipment` / `_weapon` / `_armor` / `_accessory` / `_graphics` | many | Item subclass details |
| `gamedata_guildleves` | 624 | Leve definitions |
| `gamedata_quests` | **524** | Quest definitions (new — from alt PM import) |
| `gamedata_achievements` | many | Achievement definitions |

### Misc

- `servers` — known world servers (id, name, address, port, isActive)
- `reserved_names` — name reservation list
- `supportdesk_tickets` / `supportdesk_faqs` / `supportdesk_issues` — GM ticket system

## Common MySQL → Postgres adaptations

| MySQL | Postgres | Notes |
|-------|----------|-------|
| `` ` `` (backticks) | `"` (double quotes) | Case-preserving identifier quoting |
| `int(N) unsigned` | `bigint` | No uint in Postgres |
| `tinyint(1)` | `boolean` | Via `zz_tinyint1_to_bool.sql` post-migration |
| `tinyint(4)` | `smallint` | Signed wrap (-1 = 0xFF) preserved via `unchecked` cast in `DataReaderExtensions` |
| `INSERT ... ON DUPLICATE KEY UPDATE` | `INSERT ... ON CONFLICT (pk) DO UPDATE SET col = EXCLUDED.col` | |
| `REPLACE INTO` | `INSERT INTO` after DROP TABLE | |
| `GROUP BY col` with non-grouped columns | `SELECT DISTINCT ON (col)` | PM relied on MySQL's permissive group-by |
| `\'` escape in JSON | `''` Postgres escape | |
| MySQL date `'0000-00-00'` | `NULL` | |

See `tools/sql_mysql_to_postgres.py` for the full converter.

## Direct access

```bash
docker exec -it meteorreborn-postgres psql -U meteor -d meteor
```

Some useful queries:

```sql
-- Char count per user
SELECT userid, COUNT(*) FROM characters GROUP BY userid;

-- Active sessions
SELECT * FROM sessions WHERE expiration > NOW();

-- Monster spawn coordinates per zone
SELECT bsl.bnpcid, sz.zonename, bsl.positionx, bsl.positiony, bsl.positionz
FROM server_battlenpc_spawn_locations bsl
JOIN server_battlenpc_groups bgr ON bsl.groupid = bgr.groupid
JOIN server_zones sz ON bgr.zoneid = sz.id;
```
