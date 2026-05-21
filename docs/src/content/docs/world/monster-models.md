---
title: Monster models
description: All monster actor classes shipped in Meteor Reborn's gamedata_actor_class table.
---

The FFXIV 1.0 client has **134 monster actor classes** across 29 families,
all enumerated in the `gamedata_actor_class` table (rows where
`classpath LIKE '%/Monster/%'`). These define the *available models*, not
where they spawn — see [regions](/MeteorReborn/world/regions/) for spawn
location data.

## Monster families

| Family | Count | Examples |
|--------|-------|----------|
| Lemming | 28 | Wharf rat variants |
| Flower | 24 | Morpho variants |
| Yak | 14 | Buffalo / yak |
| Cactus | 13 | Sabotenders |
| Bug | 10 | Spiders, beetles |
| Lizardman | 7 | Tribal NPCs |
| Fighter | 6 | Generic combat models |
| Ogre | 5 | Cyclopes |
| Wolf | 3 | Bloodthirsty wolf, etc. |
| Ifrit | 3 | Primal Ifrit & adds |
| Sprite | 2 | Aether sprites |
| Mole | 2 | Tunnel diggers |
| Bat / Bomb / Chigoe / Crab / Dodo / Firefly / Funguar / Goblin / Goobbue / Jellyfish / Monkey / Orebeetle / Petitghost / Piranha / Serow / Slug / Spider | 1 each | One model each |

29 families total, 134 distinct `actorClassId`s.

## Spawning monsters

You don't pick a model directly. The hierarchy is:

```
server_battlenpc_genus     ← 65 templates (stats per family)
        ↑
server_battlenpc_pools     ← 4 pools (genus + actor class to instantiate)
        ↑
server_battlenpc_groups    ← 4 groups (pool + zone + behavior)
        ↑
server_battlenpc_spawn_locations  ← 7 rows (group + xyz coords)
```

PM only populated **7 spawn locations** total:

| BnpcId | Zone | Script | Spawn type | Allegiance |
|--------|------|--------|------------|------------|
| 1 | 170 (Central Thanalan) | wharf_rat | Normal | 0 |
| 2 | 170 (Central Thanalan) | wharf_rat | Normal | 0 |
| 3 | 166 (Central Shroud) | bloodthirsty_wolf | Scripted | 0 |
| 4 | 166 | bloodthirsty_wolf | Scripted | 0 |
| 5 | 166 | bloodthirsty_wolf | Scripted | 0 |
| 6 | 166 | yda | Scripted | 1 (ally) |
| 7 | 166 | papalymo | Scripted | 1 (ally) |

Only Normal-spawn rows show in `Loaded N monsters` (so map reports `Loaded 2 monsters`).

## Spawning manually via `!spawn`

The `!spawn` GM command bypasses the spawn-locations table and lets you
instantiate any actor class at your position. Examples:

```
!spawn 2104001        # wharf rat (Lemming family)
!spawn 2201407        # bloodthirsty wolf
!spawn 2103902        # bug
!spawn 2101608        # bomb (boom)
!spawn 2105000        # cactus (sabotender)
```

To find the actorClassId of any monster:

```bash
docker exec meteorreborn-postgres psql -U meteor -d meteor -c \
  "SELECT id, classpath FROM gamedata_actor_class WHERE classpath LIKE '%/Monster/Wolf/%';"
```

## Populating more spawns

If you want monsters in the world without typing `!spawn`, you'd insert into
`server_battlenpc_groups` + `_pools` + `_spawn_locations`. PM never finished
this content — most spawn locations would need to be hand-tuned (zone choice,
xyz coords, level range, allegiance).

A future MR project: auto-generate sane spawns by parsing the FFXIV client's
`mob.dat` / world data files. Not implemented yet.
