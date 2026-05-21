---
title: Packet headers
description: FFXIV 1.0 reference for Meteor Reborn.
---

FFXIV uses the TCP protocol to communicate with both the map servers as well as the lobby servers. Commands are separated into subpackets, which can be combined into one base packet. The maximum packet size is 0xFFFF. 

  

### Base Packets

 

This is the main packet container for all subpackets. It can contain a number of subpackets to be processed. Each base packet begins with a 0x10 byte header. Below is how the base packet header is laid out: 

 

   
| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | A | B | C | D | E | F |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Is Authenticated | Is Compressed/Encoded | Connection Type | Packet Size | Number of Subpackets | Timestamp in Miliseconds |  |  |  |  |  |  |  |  |  |  |

 

These are the descriptions of the fields: 

 
- **Is Authenticated**: 99% of the time this will be 1. It is only set to 0 on the initial handshake packet. 
- **Is Compressed/Encoded**: The meaning of this byte depends if the client is communicating to the lobby server or the map server. If it is the lobby server, it indicates the packet is currently encrypted using Blowfish. If it is to the map server, it means the packet is compressed using zip compression. The server can set these to 0 and send unencrypted/uncompressed packets and have them read properly. Great for development and debugging. 
- **Connection Type**: When the client connects to the map server, these will be flagged either 0x1 (Zone Connection), 0x2 (Chat Connection), or 0x3 (Lobby Connection) to define the connection type of the socket. After the server responds, these will always be set to 0x0. Not tested for lobby server.  
- **Packet Size**: The total size of the packet including header. 
- **Number of Subpackets**: The number of subpackets this base packet contains. 
- **Timestamp in Miliseconds**: A unix timestamp in miliseconds.
 

### Subpackets

 

A base packet can hold a number of subpackets. Each one begins with a 0x10 byte header. Below is how the subpacket header is laid out: 

 

  
| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | A | B | C | D | E | F |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Subpacket Size | Type | Source Id | Target Id | Unknown |  |  |  |  |  |  |  |  |  |  |  |

 

These are the descriptions of the fields: 

 
- **Subpacket Size**: The total size of the subpacket including header. 
- **Type**: This field defines what this subpacket does: 
  - 0x0: Initial Handshake 
  - 0x2: Zone Server Related (Unknown) 
  - 0x3: Game Packet 
  - 0x7: Zone Server Related (Unknown) 
  - 0x8: Zone Server Related (Unknown)
 
- **Source Id**: The actor that triggered this subpacket.  
- **Target Id**: The actor this subpacket is for. 
- **Unknown**: Still have not figured out what this field does.
 

### Game Packets

 

Type 0x3 subpackets are the main game packets that both the lobby and map server use to control the game. They also have their own header after the subpacket header. It is 0x10 bytes in size. 

 

  
| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | A | B | C | D | E | F |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Unknown (Always 0x14) | Opcode | Unknown (Always 0x00) | Timestamp | Unknown |  |  |  |  |  |  |  |  |  |  |  |

 

These are the descriptions of the fields: 

 
- **Opcode**: The opcode defining what this game packet does. Check the page Opcodes for a list of opcodes. 
- **Timestamp**: The current time in seconds. This is used for setting the game time as well and tracking connection health.
 

### Other Types

 

While 99% of packets are type 0x3, there are a few other packet types that follow a different format. 

  

       
| Server -> Client |  |
|---|---|
| Opcode | Packet Name |
| 0x02 | SetupPacket Response, 0x38 in size. |
| 0x03 | Game Packet |
| 0x07 | Zone Start? 0x18 in size. |
| 0x08 | Pong Response |
| 0x0A | SecSetupPacket Response, 0x290 in size. |

   

       
| Client -> Server |  |
|---|---|
| Opcode | Packet Name |
| 0x01 | SetupPacket, 0x38 in size. |
| 0x03 | Game Packet |
| 0x07 | Ping |
| 0x08 | Zone Start Response |
| 0x09 | SecSetupPacket, 0x278 in size. |
