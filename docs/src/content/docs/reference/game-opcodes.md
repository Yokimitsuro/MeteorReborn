---
title: Game opcodes
description: FFXIV 1.0 reference for Meteor Reborn.
---

This is a list of all the various opcodes that FFXIV 1.23b uses. Empty names are unknown packets. Packets labeled `DEPRECATED` mean the code they responded to was probably macroed out in the retail build, and the client doesn't do anything when one is sent. 

 

### Lobby Channel

  

               
| Server -> Client |  |
|---|---|
| Opcode | Packet Name |
| 0x001 |  |
| 0x002 | Error |
| 0x00C | Account List |
| 0x00D | Character List |
| 0x00E | Modify Character Reply |
| 0x00F | Select Character Reply |
| 0x010 |  |
| 0x015 | World List |
| 0x016 | Import Name List |
| 0x017 | Retainer List |
| 0x1F4 |  |
| 0x1F5 |  |

   

       
| Client -> Server |  |
|---|---|
| Opcode | Packet Name |
| 0x003 | Get Characters |
| 0x004 | Select Character |
| 0x005 | Get Accounts |
| 0x00B | Modify Character |
| 0x00F | Finish Mod Retainers |

   

### Chat Channel

  

      
| Server -> Client |  |
|---|---|
| Opcode | Packet Name |
| 0x0C8 | Tell Message |
| 0x0C9 | Group Message |
| 0x0CA | Tell Message Error |
| 0x0CB | Generic Log Message |

   

    
| Client -> Server |  |
|---|---|
| Opcode | Packet Name |
| 0x0C8 | Tell Message |
| 0x0C9 | Group Message |

   

### Zone Channel

  

                                                                                                                                                                                                     
| Server -> Client |  |
|---|---|
| Opcode | Packet Name |
| 0x001 | Pong |
| 0x002 | Unknown 0x002 |
| 0x003 | Say Message |
| 0x004 | Reset Engine |
| 0x005 | Set Map |
| 0x006 | Mass Delete Actor Start |
| 0x007 | Mass Delete Actor End |
| 0x008 | Mass Delete Actor Body (x1) |
| 0x009 | Mass Delete Actor Body (x10) |
| 0x00A | Mass Delete Actor Body (x20) |
| 0x00B | Mass Delete Actor Body (x40) |
| 0x00C | Set Music |
| 0x00D | Set Weather |
| 0x00E | Logout |
| 0x00F |  |
| 0x010 | Set Dalamud Phase |
| 0x011 | Quit Game |
| 0x0CA | Create Actor |
| 0x0CB | Remove Actor |
| 0x0CC | Load Class Script for Actor |
| 0x0CD | Unload Class Script |
| 0x0CE | Set Actor Position |
| 0x0CF | Move Actor to Position |
| 0x0D0 | Set Actor Speeds |
| 0x0D2 | DEPRECATED |
| 0x0D3 | Set Actor Target (Animated) |
| 0x0D4 | Turn Actor to Target |
| 0x0D6 | Set Actor Appearance (x32) |
| 0x0D7 | Set Actor Appearance (x16) |
| 0x0D8 | Bind BG MapObj to Actor |
| 0x0D9 | Play BG animation |
| 0x0DA | Play particle animation on actor (w.o stopping) |
| 0x0DB | Set Head to Actor (/w speed) |
| 0x0DC | Set Head to Position (/w speed) |
| 0x0DD | Set Actor Head Orientation (/w speed) |
| 0x0DE | Reset Head |
| 0x0DF | Set Actor Target (Immediate) |
| 0x0E0 | Play Animation/Effect |
| 0x0E1 | Do Emote |
| 0x0E2 | Map Change & UI Change |
| 0x0E3 | Set Actor Quest Icon |
| 0x0E4 | Show/Hide Weapon |
| 0x0E5 | Show Countdown |
| 0x12C | DEPRECATED |
| 0x12E | SetTalkEventCondition |
| 0x12F | KickClientOrderEvent |
| 0x130 | StartServerOrderEventFunction |
| 0x131 | EndClientOrderEvent |
| 0x132 | DEPRECATED |
| 0x133 | General Data Packet |
| 0x134 | Set Actor MainState |
| 0x136 | SetEventStatus |
| 0x137 | Set Actor Work Values (SyncMemory) |
| 0x138 | SetTargetTime |
| 0x139 | Command Result (x01 Log/Effect) |
| 0x13A | Command Result (x10 Log/Effect) |
| 0x13B | Command Result (x18 Log/Effect) |
| 0x13C | Command Result (No Log/Effect) |
| 0x13D | Set Actor Name |
| 0x143 | Delete Group |
| 0x144 | Set Actor SubState |
| 0x145 | Set Actor Icon (ChangeActorExtraStat) |
| 0x146 | ItemPackage Chunk Start |
| 0x147 | ItemPackage Chunk End |
| 0x148 | Add Item (x01) |
| 0x149 | Add Item (x08, variable) |
| 0x14A | Add Item (x16) |
| 0x14B | Add Item (x32) |
| 0x14C | Add Item (x64) |
| 0x14D | Set Equipment Id (x01) |
| 0x14E | Set Equipment Id (x08, variable) |
| 0x14F | Set Equipment Id (x16) |
| 0x150 | Set Equipment Id (x32) |
| 0x151 | Set Equipment Id (x64) |
| 0x152 | Remove Item (x01) |
| 0x153 | Remove Item (x08, variable) |
| 0x154 | Remove Item (x16) |
| 0x155 | Remove Item (x32) |
| 0x156 | Remove Item (x64) |
| 0x157 | Text Sheet Message (Source Actor) (30b) |
| 0x158 | Text Sheet Message (Source Actor) (38b) |
| 0x159 | Text Sheet Message (Source Actor) (40b) |
| 0x15A | Text Sheet Message (Source Actor) (50b) |
| 0x15B | Text Sheet Message (Source Actor) (70b) |
| 0x15C | Text Sheet Message (Custom Sender) (48b) |
| 0x15D | Text Sheet Message (Custom Sender) (58b) |
| 0x15E | Text Sheet Message (Custom Sender) (68b) |
| 0x15F | Text Sheet Message (Custom Sender) (78b) |
| 0x160 | Text Sheet Message (Custom Sender) (98b) |
| 0x161 | Text Sheet Message (DispId Sender) (30b) |
| 0x162 | Text Sheet Message (DispId Sender) (38b) |
| 0x163 | Text Sheet Message (DispId Sender) (40b) |
| 0x164 | Text Sheet Message (DispId Sender) (50b) |
| 0x165 | Text Sheet Message (DispId Sender) (60b) |
| 0x166 | Text Sheet Message (No Source Actor) (28b) |
| 0x167 | Text Sheet Message (No Source Actor) (38b) |
| 0x168 | Text Sheet Message (No Source Actor) (38b) |
| 0x169 | Text Sheet Message (No Source Actor) (48b) |
| 0x16A | Text Sheet Message (No Source Actor) (68b) |
| 0x16B | SetNoticeEventCondition |
| 0x16C | SetEmoteEventCondition |
| 0x16D | Inventory Begin Change |
| 0x16E | Inventory End Change |
| 0x16F | SetPushEventConditionWithCircle |
| 0x170 | SetPushEventConditionWithFan |
| 0x171 | DEPRECATED |
| 0x172 | DEPRECATED |
| 0x173 | DEPRECATED |
| 0x174 | DEPRECATED |
| 0x175 | SetPushEventConditionWithTriggerBox |
| 0x176 | Set Item Modifier (x1) |
| 0x177 | Set Status @ Index |
| 0x179 | Set All Status |
| 0x17A | Set Group Work Values |
| 0x17B | Set Actor In Different Zone |
| 0x17C | Group Packet Header |
| 0x17D | Group Begin |
| 0x17E | Group End |
| 0x17F | Group Members Body (x8, variable) |
| 0x180 | Group Members Body (x16) |
| 0x181 | Group Members Body (x32) |
| 0x182 | Group Members Body (x64) |
| 0x183 | Group Duty Members Body (x8, variable) |
| 0x184 | Group Duty Members Body (x16) |
| 0x185 | Group Duty Members Body (x32) |
| 0x186 | Group Duty Members Body (x64) |
| 0x187 | Set Occupancy Group (DOUBLE CHECK!) |
| 0x188 | Create Named Group (IE: LS) |
| 0x189 | Create Named Group (x8, variable) |
| 0x18A | Set Active Linkshell |
| 0x18B | Set Group LayoutID |
| 0x18C |  |
| 0x18D | Party Map Marker Update (x16, variable) |
| 0x18E | Set Retainer Star (ChangeSystemStat) |
| 0x18F | Mass Set Item Modifier Begin |
| 0x190 | Mass Set Item Modifier |
| 0x191 | Mass Set Item Modifier End |
| 0x192 | Send Addiction Limit Message |
| 0x193 | Stops control (0x14) and starts (0x15). |
| 0x194 | Set Grand Company Info |
| 0x195 | Set Emnity Indicator |
| 0x196 | Set SpecialEventWork |
| 0x197 | Set Chocobo Ride |
| 0x198 | Set Chocobo Name |
| 0x199 | Set Has Chocobo |
| 0x19A | Set Achievements Completed |
| 0x19B | Set Latest Achievements |
| 0x19C | Set Total Achievement Points |
| 0x19D | Set Player Title |
| 0x19E | Achievement Earned Packet |
| 0x19F | Respond Achievement Completion Rate |
| 0x1A0 | Set Gobbue Appearance |
| 0x1A1 | Set Has Gobbue Mount |
| 0x1A2 | JobQuestCompleteTriple |
| 0x1A3 | Set Cutscene Book Details |
| 0x1A4 | Set Current Job |
| 0x1A5 | EntrustItem |
| 0x1A6 | HamletSupplyRanking |
| 0x1A7 | Set Dream Result (Required for wakeup) |
| 0x1A8 | HamletDefenseScore |
| 0x1C2 | DEPRECATED |
| 0x1C3 | Recruiting Started Response |
| 0x1C4 | Recruiting Ended Response |
| 0x1C5 | Recruiting State Response (Open Party) |
| 0x1C6 | Recruiting Acceptment Response |
| 0x1C7 | Recruitment Search Results |
| 0x1C8 | Get Recruitment Info |
| 0x1C9 | Add Blacklist Response |
| 0x1CA | Remove Blacklist Response |
| 0x1CB | Send Blacklist |
| 0x1CC | Add Friendlist Response |
| 0x1CD | Remove Friendlist Response |
| 0x1CE | Send Friendlist |
| 0x1CF | Friend Status Update Response |
| 0x1D0 | Faq Request Response |
| 0x1D1 | Faq Body Response |
| 0x1D2 | Send Issue Options |
| 0x1D3 | Makes GM Icon Reply appear |
| 0x1D4 | GM Message Response |
| 0x1D5 | GM Ticket Sent Response |
| 0x1D6 | Confirm GM ticket ended |
| 0x1D7 | Item Search Start |
| 0x1D8 | Item Search Result |
| 0x1D9 | Item Search End |
| 0x1DA | Retainer Search End |
| 0x1DB | Retainer Search Results |
| 0x1DC | Retainer Search Update |
| 0x1DD | Retainer Search Transaction History |
| 0x1DE |  |
| 0x1DF | Player Search Information Response |
| 0x1E0 | Player Search Comment Response |
| 0x1E1 | Close Item Search |
| 0x1F4 | DEPRECATED. GM? |
| 0x1F5 | DEPRECATED. GM? |
| 0x1F6 | DEPRECATED. GM? |

   

                                                
| Client -> Server |  |
|---|---|
| Opcode | Packet Name |
| 0x001 | Ping |
| 0x002 | Unknown 0x002 |
| 0x003 | Say Message |
| 0x006 | Client Langauge |
| 0x007 | Unknown 0x007 |
| 0x0CA | Position Update |
| 0x0CC | Target Locked |
| 0x0CD | Target Selected |
| 0x0CE | Starting/Ending Cutscene |
| 0x0CF | Countdown Started |
| 0x12D | Event Start Request |
| 0x12E | Event Result |
| 0x12F | Data Request |
| 0x130 | Linkshell Active Request |
| 0x131 | Item Package Update Request |
| 0x133 | Group Created |
| 0x135 | Achievement Progress Request |
| 0x1C3 | Recruitment Start Request |
| 0x1C4 | Recruitment End Request |
| 0x1C5 | Party Window Opened, State Request |
| 0x1C6 | Recruiting Accepted |
| 0x1C7 | Search Result Request |
| 0x1C8 | Get Recruitment Details |
| 0x1C9 | Blacklist Add |
| 0x1CA | Blacklist Remove |
| 0x1CB | Blacklist Request |
| 0x1CC | Friendlist Add |
| 0x1CD | Friendlist Remove |
| 0x1CE | Friendlist Request |
| 0x1CF | Friendlist Status Request |
| 0x1D0 | FAQ & Info List Request |
| 0x1D1 | FAQ & Info Body Request |
| 0x1D2 | Issue List Request |
| 0x1D3 | Is GM Ticket Active Request |
| 0x1D4 | GM Response Request |
| 0x1D5 | GM Ticket Sent |
| 0x1D6 | End GM Ticket Request |
| 0x1D7 | Track Retainer |
| 0x1D8 | Begin Item Category Search |
| 0x1D9 | Begin Retainer Search |
| 0x1DA |  |
| 0x1DB |  |
| 0x1DC | Set Search Info |
| 0x1DD | Begin Player Search |
| 0x1DE |  |
| 0x1DF | Begin Item Name Search |
