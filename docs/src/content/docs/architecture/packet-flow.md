---
title: Packet flow
description: End-to-end walkthrough of every packet a client exchanges from launcher click to in-world.
---

This page traces what happens between the moment the player clicks **PLAY** in
the launcher and the moment `ffxivgame.exe` is rendering the in-world view.

## 1. Launcher → Login HTTP

The launcher sends:

```http
POST /api/auth/login
Content-Type: application/json

{"username":"test","password":"abc123"}
```

`MeteorReborn.Login` validates the password (PBKDF2), inserts/updates the
`sessions` row, and returns:

```json
{"sessionId":"<56 hex chars>", "userId":1}
```

## 2. Launcher patches + spawns ffxivgame.exe

Before the client process starts, the launcher (`GameLauncher.cs`):

- Reads PE32 image base from `ffxivgame.exe` header
- Creates the process **suspended**
- Writes 5 bytes at `imageBase + 0x9A15E3` (`EncryptionTimePatchRva`) to disable the time-encryption check
- Writes up to 20 bytes at `imageBase + 0xB90110` (`LobbyHostNameRva`) with your lobby host
- Resumes the thread

Command line passed (encrypted with Blowfish, base64url):

```
sqex0002<encrypted>!////
```

Where `<encrypted>` decrypts to:

```
 T ={tickCount} /LANG =en-us /REGION =2 /SERVER_UTC =1356916742 /SESSION_ID ={sessionId}
```

## 3. ffxivgame.exe → Lobby (TCP :54994)

The 1.x client opens a TCP connection to the patched lobby host and starts the
Blowfish handshake. The full sequence is documented in the
[lobby session opcodes](/MeteorReborn/reference/game-opcodes/), but the
high-level beats:

1. **Hardcoded handshake packets** — securecnum, session ack, client version
2. **`SessionPacket` (0x???)** — client sends sessionId; lobby checks it against the
   `sessions` table
3. **`GetCharacters` / `ImportList`** — lobby reads `characters WHERE userid = ?`
4. **`CharacterModify` / `Reserve` / `MakeCharacter`** — if creating new
5. **`SelectCharacter`** — lobby tells the client which world to connect to
   (from the `servers` table) and hands off

See `MeteorReborn.Lobby/PacketProcessor.cs` for the full switch.

## 4. ffxivgame.exe → World (TCP :54992)

After lobby handoff, the client opens a fresh TCP connection to **world**.
World holds this connection for the rest of the gameplay session.

World receives the `SessionBegin` packet (opcode `0x1000`), looks up which map
server owns the character's current zone (`server_zones.serverip` /
`serverport`), and opens its own TCP connection to that **map** server.

## 5. World ↔ Map (TCP :1989, internal)

World forwards client→map packets transparently after wrapping them in an outer
header. Map sees a stream of opcodes like a real client.

Map's `PacketProcessor.cs:60` handles `case 0x1000` (Session Begin):

```csharp
session = mServer.AddSession(subpacket.header.sourceId);
if (!beginSessionPacket.isLogin)
    Server.GetWorldManager().DoZoneIn(session.GetActor(), false, ...);
Log.Information("{0} has been added to the session list.", session.GetActor().customDisplayName);
client.FlushQueuedSendPackets();
```

The full **zone-in chain** then fires (`Player.SendZoneInPackets`):

```
SetActorIsZoningPacket  (false)
SetDalamudPacket        (0)
SetMusicPacket          (zone.bgmDay)
SetWeatherPacket        (current weather)
SetMapPacket            (zone.regionId, zone.actorId)
SpawnPackets            (player AddActor + SetPosition + SetAppearance...)
InventoryBegin/End + items
SetCurrentJob + stats
WorldMaster/DebugActor spawn
Other actors in zone spawn
```

## 6. In-world

Once zone-in completes, the client sends:

- `Ping (0x0001)` every ~1s → server replies `Pong`
- `UpdatePlayerPosition (0x?)` as you move
- `EventStart (0x012D)` when interacting with NPCs
- `ChatMessage (0x0003)` for `/say`, `/shout`, etc.

Map broadcasts AOE updates (other players moving, NPCs spawning, etc.) to all
sessions in the same zone.

## Current status

Steps 1-4 work end-to-end. Step 5 connects, but the zone-in chain is missing
some packets — the client times out ~12s after `Session has been added`.
Tracking via [issue list](https://github.com/Yokimitsuro/MeteorReborn/issues).
