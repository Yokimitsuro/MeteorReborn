---
title: Codebase tour
description: Where everything lives in src/ — guided walk through every project, folder by folder.
---

A guided walk through the source tree. Use this as a map when you're trying
to find where a piece of behavior lives.

## Top-level layout

```
MeteorReborn/
├── src/                      # .NET 10 servers
│   ├── MeteorReborn.Common/
│   ├── MeteorReborn.Login/
│   ├── MeteorReborn.Lobby/
│   ├── MeteorReborn.World/
│   └── MeteorReborn.Map/
├── tests/MeteorReborn.Common.Tests/
├── tools/
│   ├── MeteorReborn.Launcher/        # WPF .NET 10 launcher
│   └── sql_mysql_to_postgres.py      # MySQL→Postgres dump converter
├── data/
│   ├── sql/                  # 65+ Postgres dumps + zz_* migrations
│   ├── scripts/              # 1254 Lua scripts (NPCs, quests, commands, effects)
│   ├── config/               # *.ini per service
│   ├── clientPatch/          # Cached .patch files (auto-populated by launcher)
│   ├── staticactors.bin      # Binary list consumed by map server
│   └── www/                  # Legacy PHP web assets (mostly unused)
├── docs/                     # This Astro Starlight site
├── .github/workflows/        # CI/CD
├── docker-compose.yml
├── Dockerfile
└── MeteorReborn.sln
```

## `src/MeteorReborn.Common/`

Wire-format helpers shared by all services. **Most stable codebase** —
changes here ripple everywhere.

| File | Role |
|------|------|
| `BasePacket.cs` | Outer packet header (16 bytes) — PM-COMPLETE |
| `SubPacket.cs` | Inner subpacket (0x20 header + payload) — PM-COMPLETE |
| `Blowfish.cs` | Blowfish-ECB cipher with PM's key schedule — PM-COMPLETE |
| `Utils.cs` | Endian swap, padding, hex helpers — PM-COMPLETE |
| `Vector3.cs` | 3-float position struct — PM-COMPLETE |
| `STA_INIFile.cs` | Simple INI parser — PM-COMPLETE |
| `Bitfield.cs` | Bitfield helpers for packed flags — PM-COMPLETE |
| `EfficientHashTables.cs` | PM-specific hash tables — PM-COMPLETE |
| `CircularBuffer.cs` | Cyotek.Collections.Generic.CircularBuffer — replicated locally (not on nuget) |
| `DataReaderExtensions.cs` | `GetByte` / `GetUInt32` etc. with PM-faithful unchecked wrap — FINISH-PM (MR-original) |
| `NpgsqlParameterExtensions.cs` | `AddParam` method that handles uint→bigint mapping — FINISH-PM |

## `src/MeteorReborn.Login/`

The smallest project — minimal ASP.NET HTTP API. PM-MISSING throughout
(PM had PHP/WAMP login).

| File | Role |
|------|------|
| `Program.cs` | Entire server: 2 endpoints, ~150 lines |
| `login_config.ini` | DB connection settings |

`/api/account` and `/api/auth/login` are the only routes. Sessions are
56-char hex strings, written to the `sessions` Postgres table with 1h TTL,
unique per user (`ON CONFLICT (userid) DO UPDATE`).

## `src/MeteorReborn.Lobby/`

Character selection and creation. ~30 files.

| Folder | Role |
|--------|------|
| `Server.cs` + `ClientConnection.cs` | TCP accept loop, per-client state |
| `PacketProcessor.cs` | Opcode-keyed dispatcher for the lobby protocol |
| `Database.cs` | All SQL — `GetSession`, `GetCharacters`, `ReserveCharacter`, `MakeCharacter` |
| `Packets/HardCoded_Packets.cs` | The pre-Blowfish handshake bytes |
| `Packets/Receive/` | `SessionPacket`, `CharacterModifyPacket`, `SelectCharacterPacket` |
| `Packets/Send/` | `AccountListPacket`, `CharacterListPacket`, `WorldListPacket`, etc. |
| `DataObjects/` | DTOs — `Account`, `Character`, `Appearance`, `CharaInfo`, `Retainer` |

## `src/MeteorReborn.World/`

Per-world router. Manages parties, linkshells, retainer groups. Holds the
client's long-lived TCP connection after lobby handoff.

| Folder | Role |
|--------|------|
| `Server.cs` | TCP accept |
| `WorldMaster.cs` | Top-level world coordinator |
| `PacketProcessor.cs` | World-side opcode dispatch (mostly 0x1xxx range) |
| `PartyManager.cs` / `LinkshellManager.cs` / `RelationGroupManager.cs` / `RetainerGroupManager.cs` | Group management |
| `Database.cs` | World-server SQL queries |
| `DataObjects/Session.cs` | Per-player session state |
| `DataObjects/ZoneServer.cs` | World ↔ Map TCP connection |
| `DataObjects/Group/*.cs` | DTOs for groups, parties, linkshells |
| `Packets/Receive/` + `Packets/Send/` + `Packets/WorldPackets/` | Send/Receive split |

## `src/MeteorReborn.Map/`

The big one — ~22,000 lines. The actual gameplay engine.

### Top level

| File | Role |
|------|------|
| `Program.cs` | Entry point — Serilog init, DB test, server start |
| `Server.cs` | TCP accept + load orchestration (`StartServer` calls `LoadXxx` in order) |
| `PacketProcessor.cs` | Big opcode switch (~400 lines) — entry point for client packets |
| `WorldManager.cs` | Loads all reference data; manages zone/spawn registry |
| `CommandProcessor.cs` | Parses `!commands` and routes to Lua |
| `ConfigConstants.cs` | Parses `map_config.ini` |
| `Database.cs` | All persistence — player save/load, item operations, dozens of queries |

### `Actors/`

The class hierarchy:

```
Actor (base)
├── Character
│   ├── Player
│   ├── Npc
│   │   ├── Ally
│   │   ├── BattleNpc
│   │   ├── Pet
│   │   └── Retainer
│   └── (other living things)
├── Area (zone container, has actors inside)
│   ├── Zone
│   ├── PrivateArea
│   └── PrivateAreaContent
├── Director (event coordinator)
│   └── GuildleveDirector
├── Quest (static actor with quest metadata)
├── Command (static actor for action triggers)
├── Judge (static actor for arbitration)
├── StaticActors (loader for `staticactors.bin`)
└── World/WorldMaster (root actor with ID 0x5FF80001)
```

### `Actors/Chara/`

Stats, equipment, AI:

- `Character.cs` — base for everything with HP/stats
- `BattleSave.cs` / `BattleTemp.cs` / `ParameterSave.cs` / `ParameterTemp.cs` — persistence schemas
- `Modifier.cs` / `ModifierList.cs` — buff/debuff math
- `ItemPackage.cs` / `ReferencedItemPackage.cs` — inventory containers
- `EventSave.cs` / `EventTemp.cs` — quest/event state

#### `Actors/Chara/Ai/`

The AI engine:

- `AIContainer.cs` — per-actor AI scheduler
- `Controllers/` — `BattleNpcController`, `PlayerController`, `PetController`, `AllyController`
- `State/` — `IdleState`, `AttackState`, `MagicState`, `AbilityState`, `ItemState`, `DeathState`, etc.
- `Helpers/PathFind.cs` / `TargetFind.cs` / `ActionQueue.cs` — utilities
- `StatusEffectContainer.cs` / `StatusEffect.cs` — buff/debuff stack
- `HateContainer.cs` — threat list
- `BattleCommand.cs` / `BattleTrait.cs` — action definitions
- `Utils/AttackUtils.cs` / `BattleUtils.cs` — combat math

### `Lua/`

The MoonSharp scripting engine integration:

- `LuaEngine.cs` — registers globals, exposes C# accessors to scripts (~870 lines)
- `LuaScript.cs` — per-script wrapper
- `LuaParam.cs` — typed parameter struct for Lua calls
- `LuaUtils.cs` — helpers for Lua ↔ C# marshalling
- `CaseInsensitiveScriptLoader.cs` — case-insensitive `require()` for Linux containers (FINISH-PM)

### `Packets/`

`Send/` and `Receive/` mirror PM's structure exactly:

- `Receive/<X>Packet.cs` — deserializer for client → server
- `Send/Actor/`, `Send/Events/`, `Send/Groups/`, `Send/Inventory/`, etc. — serializers for server → client
- `WorldPackets/Receive/` + `WorldPackets/Send/` — map ↔ world inter-server messages

Each packet file is tiny (~50 LOC) and PM-COMPLETE.

### `DataObjects/`

DTOs not in the actor tree:

- `Session.cs` — per-player connection state
- `ZoneConnection.cs` — TCP socket wrapper with `QueuePacket` + `FlushQueuedSendPackets`
- `InventoryItem.cs`, `ItemData.cs`, `GuildleveData.cs` — runtime item data
- `SearchEntry.cs`, `RecruitmentDetails.cs` — search/recruitment system

## `tests/MeteorReborn.Common.Tests/`

xUnit tests for the Common project. Covers Blowfish round-trip, packet
header encoding, etc. Run with `dotnet test`.

## `tools/MeteorReborn.Launcher/`

The WPF launcher. ~12 files:

- `MainWindow.xaml(.cs)` — login form + settings panel
- `PatcherWindow.xaml(.cs)` — patch progress modal
- `GameLauncher.cs` — process spawn + memory patching (P/Invoke heavy)
- `BlowfishCipher.cs` — duplicate of Common/Blowfish.cs (no project ref to Common to keep launcher standalone)
- `PatchFile.cs` — ZIPATCH parser
- `PatchManifest.cs` — list of 49 patches + sizes
- `PatchDownloader.cs` — HttpClient with progress
- `Patcher.cs` — download + apply pipeline
- `VersionChecker.cs` — game.ver lookup

## Quick code-search recipes

```bash
# Find every opcode handler in map
grep -n "case 0x" src/MeteorReborn.Map/PacketProcessor.cs

# Find every Lua-exposed C# function
grep -n 'script.Globals\[' src/MeteorReborn.Map/Lua/LuaEngine.cs

# All FINISH-PM annotations (= MR-original additions)
grep -rn "FINISH-PM" src/ tools/

# All LANG-ADAPT annotations (= stack adaptations from PM)
grep -rn "LANG-ADAPT" src/ tools/

# Where a packet type is sent
grep -rn "BuildPacket" src/MeteorReborn.Map/Packets/Send/<Type>Packet.cs

# Where actor IDs are constructed
grep -n "ActorIdGenerator\|<< 28" src/MeteorReborn.Map/Actors/
```
