---
title: Packet headers
description: BasePacket and SubPacket binary layouts as implemented in MeteorReborn.Common.
---

Every TCP packet exchanged with the FFXIV 1.0 client is wrapped in two
nested headers: an outer **BasePacket** carrying one or more inner **SubPackets**.
Both layouts are PM-faithful (byte-exact to what the 1.23b client expects)
and live in `src/MeteorReborn.Common/BasePacket.cs` and `SubPacket.cs`.

## BasePacket (outer)

The outer frame is 16 bytes:

| Offset | Size | Field | Description |
|--------|------|-------|-------------|
| 0x00 | 2 | `isAuthenticated` | 1 if Blowfish-encrypted, 0 if plain |
| 0x02 | 2 | `connectionType` | Marker for which service (lobby/world/map) the packet is destined for |
| 0x04 | 2 | `packetSize` | Total size including header |
| 0x06 | 2 | reserved | Always 0 |
| 0x08 | 4 | `sourceId` | Actor ID of the sender (server → client) or 0 (client → server) |
| 0x0C | 4 | `timestamp` | Unix time in seconds (server-stamped) |

All multi-byte fields are **little-endian**. After the header, the body
contains one or more subpackets back-to-back until `packetSize` is exhausted.

### Encryption

If `isAuthenticated = 1`, the payload bytes (everything after offset 0x10)
are encrypted with **Blowfish-ECB** using the session key established during
the lobby handshake. Implementation is in `MeteorReborn.Common/Blowfish.cs`
— a verbatim port of PM's Blowfish (same constant tables, same key schedule).

The launcher patches the client's `EncryptionTimePatchRva` (5 bytes at
`imageBase + 0x9A15E3`) so the client doesn't reject our timestamps — see
[launcher](/MeteorReborn/getting-started/launcher/) for the patch details.

## SubPacket (inner)

Each subpacket is `subpacketSize` bytes:

| Offset | Size | Field | Description |
|--------|------|-------|-------------|
| 0x00 | 2 | `subpacketSize` | Total size including subpacket header |
| 0x02 | 2 | `type` | 0x03 = game message, others reserved |
| 0x04 | 4 | `sourceId` | Actor ID emitting this subpacket |
| 0x08 | 4 | `targetId` | Actor ID the subpacket is addressed to |
| 0x0C | 4 | reserved | 0 |
| 0x10 | 4 | `gameMessage.unknown1` | Always 0x14 |
| 0x14 | 4 | `gameMessage.timestamp` | Subpacket-level timestamp |
| 0x18 | 2 | `gameMessage.opcode` | **The opcode** — see [opcodes](/MeteorReborn/reference/game-opcodes/) |
| 0x1A | 2 | `gameMessage.serverId` | Origin server ID (for multi-server routing) |
| 0x1C | 4 | `gameMessage.unknown2` | 0 |
| 0x20 | ... | `data` | Opcode-specific payload (`subpacketSize - 0x20` bytes) |

The 0x20-byte subpacket header is constant. The payload (`data`) layout is
defined by the opcode — every Send/* and Receive/* packet class has its own
serializer in `src/MeteorReborn.Map/Packets/`.

## Reading & writing

`MeteorReborn.Common`:

- **`BasePacket(byte[] header, byte[] body)`** ctor — wraps a payload in a base packet
- **`SubPacket(ushort opcode, uint sourceId, byte[] data)`** ctor — builds a typed subpacket
- **`BasePacket.GetPacketBytes()`** → full serialized buffer to write to the socket
- **`new BasePacket(byte[] rawIncoming)`** + `GetSubpackets()` — parse incoming traffic

The signature pattern for a typed Send packet:

```csharp
public static SubPacket BuildPacket(uint sourceActorId, /* ... payload args ... */)
{
    byte[] data = new byte[OPCODE_SIZE];
    using (MemoryStream stream = new MemoryStream(data))
    using (BinaryWriter w = new BinaryWriter(stream))
    {
        w.Write(/* fields in order */);
    }
    return new SubPacket(OPCODE, sourceActorId, data);
}
```

For Receive packets, the constructor takes the data buffer and reads with
`BinaryReader`.

## Endianness

All numeric fields are **little-endian** on the wire. The C# `BinaryReader`
and `BinaryWriter` produce little-endian output by default — no manual
byte-swap needed.

## Compression

Some larger payloads (inventory list, friend list) use **zlib**. The wire
format embeds compressed segments inside the subpacket data; the
deserializer detects the `0x91` marker byte or a length prefix depending on
the opcode and pipes the relevant bytes through `System.IO.Compression.ZLibStream`.

## Test-server view

When the map server is running you can inspect packets via Wireshark — set a
display filter on `tcp.port == 1989` (or 54994 / 54992 / 17743). The
[GM commands](/MeteorReborn/reference/gm-commands/) include `!sendpacket
<opcode> <hexbytes>` for hand-crafting packets without recompiling.
