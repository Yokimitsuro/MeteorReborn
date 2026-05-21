---
title: Lua engine
description: MoonSharp setup, script paths, common PM bugs and how MR works around them.
---

The map server embeds a Lua engine via [MoonSharp](https://www.moonsharp.org)
(PM used [NLua](https://github.com/NLua/NLua), but MoonSharp is the maintained
.NET-native alternative). Lua drives:

- NPC behavior (`onSpawn`, `onTalk`, `onInteract`)
- Quest scripts (`Man0l0.lua`, `Gcu101.lua`, ...)
- GM commands (`!spawn`, `!warp`, ...)
- Effect scripts (`sacred_prism.lua`, ...)
- Director scripts (event sequencing)

## Script paths

All loaded from `./scripts/` relative to the map server's working directory
(`./scripts/?.lua` is the `require` path). The repository layout:

```
data/scripts/
├── ability.lua                     # Top-level player/ability helpers
├── battlenpc.lua
├── battleutils.lua
├── global.lua                      # Globals exposed to all scripts
├── player.lua
├── statuseffectids.lua
├── base/chara/npc/                 # NPC AI templates by family
│   ├── monster/Wolf/WolfStandard.lua
│   ├── monster/Lemming/LemmingStandard.lua
│   ├── populace/PopulaceStandard.lua
│   └── ...
├── commands/                       # Player commands + GM tools
│   ├── Ability.lua
│   ├── AttackCommand.lua
│   ├── gm/spawn.lua                # `!spawn <actorClassId>`
│   ├── gm/warp.lua
│   └── ...
├── content/                        # Cutscenes / scripted scenes
├── directors/                      # Quest / event directors
├── effects/                        # Status effect logic
│   └── sacred_prism.lua
├── quests/                         # 524 quest definitions
│   ├── man/                        # Main scenario
│   ├── etc/                        # Side quests
│   ├── gcu/, gcl/, gcw/            # Grand Company quests
│   └── ...
└── unique/                         # Zone-specific scripts
```

## How map invokes Lua

`LuaEngine.cs:RegisterFunctions` injects C#-side accessors into every script:

```lua
GetWorldManager()        -- returns WorldManager
GetStaticActor(name)     -- look up a static actor
GetWorldMaster()         -- root actor
GetItemGamedata(id)      -- read gamedata_items row
GetGuildleveGamedata(id) -- read gamedata_guildleves row
```

Per-NPC scripts implement well-known entrypoints:

```lua
function init(player, npc)              -- called once at spawn
    -- return  classPath, isStatic, ...
end

function onSpawn(player, npc)            -- after spawn packets sent
end

function onEventStart(player, npc, ev)   -- player interacted
end
```

## Case-insensitive `require`

PM was developed on Windows where the filesystem is case-insensitive, so
scripts have inconsistent casing (`require("battleUtils")` resolves to
`battleutils.lua`). On Linux containers this fails.

MR ships a `CaseInsensitiveScriptLoader` that wraps MoonSharp's
`FileSystemScriptLoader` and lowercases the `modname` before resolving:

```csharp
public class CaseInsensitiveScriptLoader : FileSystemScriptLoader
{
    public override string ResolveModuleName(string modname, Table globalContext)
        => base.ResolveModuleName(modname.ToLowerInvariant(), globalContext);
}
```

## Common PM Lua bugs

NLua silently swallowed many script-side errors (calls to non-existent methods,
typos). MoonSharp is stricter and surfaces them. Catalog of fixes applied:

### `actor.SetAppearance(1001149)` (spawn.lua)

PM scripts call `actor.SetAppearance(1001149)` — that method **does not exist**
in either PM or MR C# code (verified: 0 hits). NLua silently ignored it.
MoonSharp throws and abandons the rest of the script, leaving the spawned
actor with appearance=0 — the client crashes trying to render it.

**Fix**: the line is commented out in `data/scripts/commands/gm/spawn.lua`,
with a `// FINISH-PM` note. The spawned actor uses its natural appearance
from `Npc.LoadNpcAppearance(actorClassId)` which the constructor already calls.

### `supportedSpells = [27346, 27347, ...]` (sacred_prism.lua)

PM's old version used JavaScript-style `[]` array literals — invalid Lua.
MoonSharp fails to parse, the whole script aborts.

**Fix**: replaced with proper Lua hash table syntax:

```lua
supportedSpells = {}
supportedSpells[27346] = true  -- Cure
supportedSpells[27347] = true  -- Cura
...
```

The lookup `supportedSpells[skill.id]` now works as the original code intended.

## Adding a GM command

GM commands live in `data/scripts/commands/gm/<name>.lua`. Example:

```lua
require("global");

properties = {
    permissions = 0,
    parameters = "s",
    description = "Demo command — echoes input.",
}

function onTrigger(player, argc, message)
    player:SendMessage(0x20, "", "You said: " .. message);
end;
```

In-game: `!demo hello` → "You said: hello".

`permissions` field is currently unused (PM TODO — all commands fire if `!` is typed).

## Reloading scripts

The Lua engine reads files fresh on each call (no caching). Edit a script and
the next invocation picks up the change — no map restart needed.

The exception is `init()` / module-level code, which only runs once when the
script is `require`d. Restart map for those changes.
