---
title: Unfinished content
description: What Meteor Reborn still doesn't do, listed by service. Living document.
---

Meteor Reborn is **alpha software**. It boots and serves a 1.23b-patched client
through to character selection, but full in-world play has gaps. This page
tracks them so contributors know where to look.

## Critical (blocks gameplay)

### Zone-in chain incomplete

After lobby hands the client to world, world hands to map, and map creates the
session (`Loaded session list` log fires). The client expects a sequence of
packets to render the world (`SetActorIsZoning false`, `SetDalamud`,
`SetMusic`, `SetWeather`, `SetMap`, player spawn, inventory, `SetCurrentJob`,
existing actors, `WorldMaster`/`DebugActor` spawn).

`Player.SendZoneInPackets` in `src/MeteorReborn.Map/Actors/Chara/Player/Player.cs`
generates the chain, but several packet builders enqueue without flushing —
the data queues fill, the client times out around 12 seconds and disconnects.

Tracked in [GitHub issues](https://github.com/Yokimitsuro/MeteorReborn/issues).

## Content gaps (data ships sparse)

### Only 7 enemy spawn locations

`server_battlenpc_spawn_locations` has 7 rows from upstream — 5 scripted
opening-tutorial wolves in Central Shroud + 2 wharf rats in Central Thanalan.

The 1.0 client has 134 monster models available
([monster models](/MeteorReborn/world/monster-models/)); spawn locations are
server-side content that PM never produced. Hand-tuning or programmatic
generation would unlock more enemies.

### Quests load but don't run end-to-end

`gamedata_quests` ships 524 quest definitions (alt-PM import) and we have 73
quest scripts in `data/scripts/quests/` covering the main scenario (`man0*`),
side quests (`etc*`), Grand Company missions (`gcu*`/`gcl*`/`gcg*`) and a few
others.

Triggering them from in-world dialogue currently fails because:

- Quest givers need to be NPCs at specific positions — that's
  `server_eventnpc_spawn_locations` (1294 rows, *not yet wired to map's loader*)
- The PM event dispatch path through `EventStartHandler` is incomplete

### Crafting / DoH

`gamedata_recipes.sql` is schema-only (no rows). DoH classes load but no
recipes exist, so synthesis can't be tested. Hand-tuning recipes is content
work.

## Code gaps

### Lua scripts call non-existent C# members

PM's NLua silently ignored missing-method calls. MoonSharp surfaces them. We
patch the worst ones as we hit them:

- `spawn.lua`: `actor.SetAppearance(1001149)` → commented out, MR notes
- `sacred_prism.lua`: invalid `[...]` array literal → fixed to Lua hash

There are likely more dormant cases. A `tools/lua_lint.py` static analyzer
(see [utilities](/MeteorReborn/project/utilities/)) would surface them all.

### Event NPC loader missing

The map server reads `server_spawn_locations` (populace NPCs) but **doesn't
read `server_eventnpc_spawn_locations`**. We imported 1294 event NPCs from
alt PM but they sit in the DB unused. Adding the loader would fill many
empty rooms with vendors and quest givers.

### Permissions on GM commands

Lua scripts declare `permissions = 0` in their `properties` block, but the
command processor doesn't check it — any `!`-prefixed message fires. A GM
rank column on `users` table + check in `CommandProcessor.DoCommand` would
gate the commands.

## Network / infrastructure

### World cluster handshake doesn't fully close

`World ↔ Map` opens a TCP socket on startup that drops immediately. World
keeps listening anyway. The cluster protocol (used for cross-zone messaging,
party sync) isn't completing the handshake — works for single-zone testing,
breaks for multi-zone parties.

### No release builds shipped

No GitHub Releases artifact contains the built launcher binary. Users have to
clone + `dotnet build`. Adding a release workflow that compiles + zips the
launcher would make it `Download .zip`-grade for non-developers.

## Tooling we'd like

- Static Lua checker (`tools/lua_lint.py`)
- Auto-generated `server_battlenpc_*` rows (`tools/gen_battlenpc_spawns.py`)
- Opcode coverage diff (`tools/opcode_diff.py`)
- End-to-end test harness that drives a mock FFXIV client against the stack
