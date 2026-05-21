---
title: Game opcodes
description: Packet opcode catalog as handled by Meteor Reborn's map/lobby/world PacketProcessors.
---

Every TCP packet exchanged between the client and the MR servers carries a
**16-bit opcode** in its subpacket header. This page catalogs the opcodes MR
currently handles, where they're processed, and what they do.

The authoritative source is `src/MeteorReborn.Map/PacketProcessor.cs` (and the
matching files in Lobby/World). When this page diverges from code, code wins.

## Server boundaries

| Server | Opcode range used | Where to read |
|--------|-------------------|----------------|
| Lobby (:54994) | `0x????` (Blowfish handshake + character select) | `MeteorReborn.Lobby/PacketProcessor.cs` |
| World (:54992) | `0x100A`, `0x1020`, `0x1025` (internal server-to-server) | `MeteorReborn.World/PacketProcessor.cs` |
| Map (:1989) | `0x0001`-`0x0007`, `0x00CA`-`0x01D6`, `0x10xx` | `MeteorReborn.Map/PacketProcessor.cs` |

## Map server opcodes (the big one)

### Connection lifecycle

| Opcode | Direction | Handler | Description |
|--------|-----------|---------|-------------|
| `0x1000` | World → Map | `case 0x1000` | Session Begin — world hands off the client; map creates a session and triggers `DoZoneIn` |
| `0x1001` | World → Map | `case 0x1001` | Session End — clean up, save player state, notify world |
| `0x100A` | World → Map | `case 0x100A` | Error from world (e.g. failed handoff) |
| `0x1020` | World → Map | `case 0x1020` | Party sync — refresh party member list |
| `0x1025` | World → Map | `case 0x1025` | Linkshell creation result |
| `0x0001` | Client → Map | `case 0x0001` | Ping — server replies with Pong + bumps idle timer |
| `0x0002` | Client → Map | `case 0x0002` | Unknown protocol-level packet, sent at handshake |
| `0x0006` | Client → Map | `case 0x0006` | Language code — first "real" client packet; triggers `onBeginLogin`/`onLogin` Lua hooks + zone-in |
| `0x0007` | Client → Map | `case 0x0007` | Zone-In Complete — client confirms it received all spawn packets |

### Chat & social

| Opcode | Description |
|--------|-------------|
| `0x0003` | Chat message (`/say`, `/shout`, `/tell`, party, GM commands prefixed `!`) |
| `0x01CC` | Add to friend list |
| `0x01CD` | Remove from friend list |
| `0x01CE` | Refresh friend list display |
| `0x01CF` | Friend status update |

### Events & interaction

| Opcode | Description |
|--------|-------------|
| `0x00CA` | Some interact / open thing handler |
| `0x00CC` | Lock/unlock UI affinity |
| `0x00CD` | Update player position (movement broadcast) |
| `0x00CE` | Happens at NPC spawn / cutscene play (unknown specifics) |
| `0x00CF` | Countdown requested (`/countdown`) |
| `0x012D` | **Event Start** — client interacts with an NPC / map object. Looks up `ownerActorID` in static actors → retainer → zone actors → director → fires Lua `onEventStart` |
| `0x012E` | Event Update — multi-step event flow |
| `0x012F` | Data Request — client asks for extra info during an event |
| `0x0131` | Update Item Package — inventory action |
| `0x0132` | Generic actor-related action |

### Support / GM tickets

| Opcode | Description |
|--------|-------------|
| `0x01D0` | Request FAQ/info list |
| `0x01D1` | Request body of a FAQ entry |
| `0x01D2` | Request issue list |
| `0x01D3` | Query whether a GM ticket exists |
| `0x01D4` | Request GM response text |
| `0x01D5` | Submit GM ticket |
| `0x01D6` | End GM ticket |

### Lock target / search / recruitment

Several opcodes drive the player-search, retainer-search, and recruitment
panels. Stub implementations exist in the PacketProcessor but most don't
yet produce useful responses — see [unfinished content](/MeteorReborn/project/unfinished-content/).

## Lobby opcodes

Lobby's handshake uses **hardcoded packets** rather than opcode-keyed
handlers. The flow:

1. Securecnum exchange (Blowfish key seed)
2. Secure session ack
3. Client version (`2012.09.19.0001`)
4. SessionPacket — client sends sessionId, lobby verifies against `sessions` table
5. GetCharacters / ImportList / CharacterModify / Reserve / MakeCharacter
6. SelectCharacter — lobby tells client which world to connect to

See `MeteorReborn.Lobby/PacketProcessor.cs` for the full state machine.

## Wire encoding

All multi-byte integers are **little-endian** within the packet body. The
outer header is documented separately on the [packet headers](/MeteorReborn/reference/packet-headers/)
page.

## Adding a new opcode handler

In `MeteorReborn.Map/PacketProcessor.cs`, add a `case` to the `switch
(subpacket.gameMessage.opcode)`:

```csharp
case 0xABCD:
    var myPacket = new MyReceivePacket(subpacket.data);
    // ... handle
    session.QueuePacket(MyReceivePacket.BuildResponse(...));
    client.FlushQueuedSendPackets();  // important — see port-notes
    break;
```

Reminder from [port notes](/MeteorReborn/architecture/port-notes/): PM relied
on manual `FlushQueuedSendPackets()` per case. Forgetting to flush causes the
client to time out waiting for data.
