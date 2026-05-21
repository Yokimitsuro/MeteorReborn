---
title: GM commands
description: All GM/debug commands shipped in data/scripts/commands/gm/ and how to use them.
---

GM commands are Lua scripts in `data/scripts/commands/gm/`. Typing `!<name>`
in the in-game chat (or via the map server's stdin in native mode) routes to
the matching `<name>.lua`.

The `CommandProcessor` (in `src/MeteorReborn.Map/CommandProcessor.cs`) strips
the leading `!`, looks up the file, parses parameters according to the script's
`parameters` field (`"d"` = decimal, `"s"` = string, `"ds"` = int + string, ...)
and calls its `onTrigger(player, argc, ...)` entry point.

## Commands shipped with Meteor Reborn

### World & teleport

| Command | Args | What it does |
|---------|------|--------------|
| `!warp` | `<zoneId> <x> <y> <z>` | Teleport to coords in another zone |
| `!warpid` | `<zoneId>` | Warp to a zone's default spawn |
| `!warpplayer` | `<playerName> <zoneId>` | Warp another player |
| `!mypos` | — | Echo current x/y/z/rotation/zoneId |
| `!nudge` | `<distance>` | Move yourself forward N yalms |
| `!nudgenpc` | `<actorId> <distance>` | Move an NPC forward |
| `!setpopulacepos` | `<populaceUniqueId> <x> <y> <z>` | Move a populace NPC |
| `!reloadzone` | — | Re-spawn all NPCs in your current zone |
| `!zonecount` | — | Total zones loaded |
| `!speed` | `<stop> <walk> <run> <active>` | Override movement speeds |

### Spawning

| Command | Args | What it does |
|---------|------|--------------|
| `!spawn` | `<actorClassId> [w] [h]` | Spawn a battle NPC at your position; w/h create a grid |
| `!spawnnpc` | `<actorClassId>` | Spawn a populace NPC |
| `!despawn` | `<actorId>` | Despawn the given actor |
| `!changetonpc` | `<actorClassId>` | Disguise yourself as the given NPC class |
| `!setappearance` | `<modelId>` | Change your model |
| `!setsize` | `<scale>` | Resize self (1.0 = normal) |
| `!setstate` | `<mainState>` | Change actor state (e.g. crouched, dead) |
| `!setnpcls` | `<value>` | Set NPC linkshell visibility |

### Combat & stats

| Command | Args | What it does |
|---------|------|--------------|
| `!setmaxhp` | `<hp>` | Set your max HP |
| `!setmaxmp` | `<mp>` | Set your max MP |
| `!settp` | `<tp>` | Set your current TP |
| `!setmod` | `<modifierId> <value>` | Set a Modifier (Attack, Defense, ...) |
| `!setjob` | `<jobId>` | Change current job/class |
| `!giveexp` | `<amount>` | Award EXP to current job |
| `!ba` | — | Toggle a test battle scenario |
| `!testbnpckill` | — | Spawn + auto-kill a battle NPC for testing |
| `!vdragon` | — | Spawn a test wyrm encounter |

### Inventory & currency

| Command | Args | What it does |
|---------|------|--------------|
| `!giveitem` | `<itemId> [qty] [quality]` | Add item to your bag |
| `!delitem` | `<itemId>` | Remove an item |
| `!givekeyitem` | `<keyItemId>` | Add a key item |
| `!delkeyitem` | `<keyItemId>` | Remove a key item |
| `!givegil` | `<amount>` | Add gil |
| `!givecurrency` | `<currencyId> <amount>` | Add currency (GC seals, ...) |
| `!delcurrency` | `<currencyId> <amount>` | Remove currency |
| `!equipactions` | — | Auto-equip default actions for current job |

### Quests & content

| Command | Args | What it does |
|---------|------|--------------|
| `!quest` | `<questId>` | Start a quest |
| `!addquest` | `<questId>` | Add to active list |
| `!completedQuest` | `<questId>` | Mark a quest as completed |
| `!addguildleve` | `<leveId>` | Add a leve |
| `!removeguildleve` | `<leveId>` | Remove a leve |
| `!eaction` | `<id>` | Trigger an event action |
| `!effect` | `<id>` | Apply a status effect |
| `!endevent` | — | Force-end current event scene |
| `!playanimation` | `<animId>` | Play an animation on yourself |
| `!anim` | `<animId>` | Same as `playanimation` |
| `!animhex` | `<hexAnimId>` | Play an animation by hex code |
| `!graphic` | `<slot> <modelId>` | Force a graphic slot to a model |

### Environment

| Command | Args | What it does |
|---------|------|--------------|
| `!weather` | `<weatherId>` | Force weather in current zone |
| `!music` | `<musicId> [mode]` | Force background music |
| `!menuman` | — | Toggle the populace menu management dialog |

### Debug / internals

| Command | Args | What it does |
|---------|------|--------------|
| `!getinfo` | `<actorId>` | Dump everything we know about an actor |
| `!sendpacket` | `<opcode> <hexbytes>` | Manually craft and send a packet |
| `!setproc` | `<procName> <value>` | Set a `proc` flag |
| `!workvalue` | `<idx> <value>` | Set a `playerWork` slot |
| `!test` | — | Reserved for ad-hoc testing |
| `!testmapobj` | — | Spawn a test map object |
| `!testpopulace` | — | Spawn a test populace NPC |
| `!yolo` | — | Apply a stack of buffs/debuffs for chaos testing |
| `!addtoparty` | `<playerName>` | Force-add player to your party |

## Lua script structure

Each command is a self-contained script. Minimal template:

```lua
require("global");

properties = {
    permissions = 0,
    parameters = "d",            -- "d"=decimal, "s"=string, "ds"=int+string
    description = "What this command does.",
}

function onTrigger(player, argc, firstArg)
    if (firstArg == nil) then
        player:SendMessage(0x20, "", "Usage: !mycmd <arg>");
        return;
    end
    -- ... do work
    player:SendMessage(0x20, "", "Done.");
end;
```

`permissions` is read but **not currently enforced** — any `!`-prefixed message
fires the matching command if it exists. A future change should compare to a
GM rank stored in the `users` table.

## Adding a new command

1. Drop `mycmd.lua` in `data/scripts/commands/gm/`
2. Restart map (`docker compose restart map`) — file index is built at startup
3. Type `!mycmd` in chat — output goes to the chat window via `SendMessage`

If you only edit an existing command, **no restart** is needed — the script is
re-read on each invocation.
