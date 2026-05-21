---
title: GM / Debug commands
description: Mirrored from the FFXIV Classic Wiki for offline reference.
---

:::note[Source]
This page is mirrored from the [FFXIV Classic Wiki](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Debug_Commands). Original authors retain credit; reproduced here because the upstream wiki is intermittently offline.
:::

*Updated as of commit 38014f8(2016-08-19)* 

The following commands are available as part of the Project Meteor Server. 
 They can be used by typing their usage examples into the chat box within the game. 

 

### Standard commands

 

#### help

 

    
| help | Prints out a list of available commands |
|---|---|
| Usage | !help |
| !help <command> |  |

 

  
| Parameters |  |
|---|---|
| <command> | Brings up the help description for the given command |

 

 

 

#### mypos

 

  
| mypos | Prints out your absolute location in the current region |
|---|---|
| Usage | !mypos |

 

 

 

#### music

 

  
| music | Plays music <id> to player |
|---|---|
| Usage | !music <id> |

 

  [](/MeteorReborn/world/music/)
| Parameters |  |
|---|---|
| <id> | Plays the music defined at <id>. Refer to Music for a list of IDs |

 

 

 

#### warp

 

    
| warp | Warp to a location from a list, or enter a <zone> with coordinates <x> <y> <z> |
|---|---|
| Usage | !warp <spawn list> |
| !warp <zone> <x> <y> <z> |  |
| !warp <zone> <x> <y> <z> <privateArea> <targetname> |  |

 

   [](/MeteorReborn/world/regions/)     
| Parameters |  |
|---|---|
| <spawn list> | The ID from the list of locations as defined in server_zones_spawnlocations in the database |
| <zone> | Value of the zone to head to.  Refer to Regions for the list of zone IDs |
| <X> | X Position |
| <Y> | Y Position |
| <Z> | Z Position |
| <privateArea> | Warp into a defined private area of a given zone ID |
| <targetname> | Name of player to select remotely. Two words, firstname & lastname, separated by a space |

 

 

 

#### nudge

 

    
| nudge | Positions your character forward a set <distance>, defaults to 5 units |
|---|---|
| Usage | !nudge |
| !nudge <distance> |  |
| !nudge <distance> <up/down> |  |

 

   
| Parameters |  |
|---|---|
| <distance> | The amount of units to move forward |
| <up/down> | Nudge vertically instead.  Up, U, or +, for moving up.  Down, D, or -, for moving down |

 

#### speed

 

    
| speed | Set movement speed for player. Enter no value to reset to default |
|---|---|
| Usage | !speed |
| !speed <run> |  |
| !speed <stop> <walk> <run> |  |

 

    
| Parameters |  |
|---|---|
| <stop> | Stationary speed (does nothing for players) |
| <walk> | Walking speed |
| <run> | Running speed |

 

 

 

### Server Administration commands

 

#### giveitem

 

    
| giveitem | Adds <item> <qty> to <location> for player or <targetname> |
|---|---|
| Usage | !giveitem <item> <qty> |
| !giveitem <item> <qty> <location> |  |
| !giveitem <item> <qty> <location> <targetname> |  |

 

    
 
| Parameters |  |
|---|---|
| <item> | Item ID to give, as defined in xtx_itemName |
| <qty> | Quantity of item to add |
| <location> | Inventory location to go into (eg, Bag, Key Item, Loot, Currency) as defined in global.lua from the scripts folder.  Defaults to INVENTORY_COMMON |
| <targetname> | Name of player to select remotely. Two words, firstname & lastname, separated by a space |

 

#### givegil

 

   
| givegil | Adds gil <qty> to player or <targetname> |
|---|---|
| Usage | !givegil <qty> |
| !givegil <qty> <targetname> |  |

 

   
| Parameters |  |
|---|---|
| <qty> | Quantity of gil to add |
| <targetname> | Name of player to select remotely. Two words, firstname & lastname, separated by a space |

 

 

 

#### givecurrency

 

   
| givecurrency | Adds <item> to currency by amount <qty> to player or <targetname> |
|---|---|
| Usage | !givecurrency <item> <qty> |
| !givecurrency <item> <qty> <targetname> |  |

 

    
| Parameters |  |
|---|---|
| <item> | Item ID to give, as defined in xtx_itemName |
| <qty> | Quantity of item to add |
| <targetname> | Name of player to select remotely. Two words, firstname & lastname, separated by a space |

 

 

 

#### givekeyitem

 

   
| givekeyitem | Adds <keyitem> to player or <targetname> |
|---|---|
| Usage | !giveitem <keyitem> |
| !giveitem <keyitem> <target name> |  |

 

   
| Parameters |  |
|---|---|
| <keyitem> | Item ID to give, as defined in xtx_itemName |
| <targetname> | Name of player to select remotely. Two words, firstname & lastname, separated by a space |

 

#### delitem

 

    
| delitem | Removes <item> <qty> from <location> for player or <targetname> |
|---|---|
| Usage | !delitem <item> <qty> |
| !delitem <item> <qty> <location> |  |
| !delitem <item> <qty> <location> <targetname> |  |

 

    
 
| Parameters |  |
|---|---|
| <item> | Item ID to remove, as defined in xtx_itemName |
| <qty> | Quantity of item to remove |
| <location> | Inventory location to remove from (eg, Bag, Key Item, Loot, Currency) as defined in global.lua from the scripts folder.  Defaults to INVENTORY_COMMON |
| <targetname> | Name of player to select remotely. Two words, firstname & lastname, separated by a space |

 

 

 

#### delcurrency

 

   
| delcurrency | Removes currency <qty> from player or <targetname> |
|---|---|
| Usage | !delcurrency <item> <qty> |
| !delcurrency <item> <qty> <targetname> |  |

 

    
| Parameters |  |
|---|---|
| <item> | Item ID to give, as defined in xtx_itemName |
| <qty> | Quantity of item to add |
| <targetname> | Name of player to select remotely. Two words, firstname & lastname, separated by a space |

 

 

 

#### delkeyitem

 

   
| delkeyitem | Removes <keyitem> from player or <targetname> |
|---|---|
| Usage | !delkeyitem <keyitem> |
| !delkeyitem <keyitem> <target name> |  |

 

   
| Parameters |  |
|---|---|
| <keyitem> | Item ID to remove, as defined in xtx_itemName |
| <targetname> | Name of player to select remotely. Two words, firstname & lastname, separated by a space |

 

#### weather

 

    
| weather | Change the weather client-side to <id> and optional <transition> for player |
|---|---|
| Usage | !weather <id> |
| !weather <id> <transition> |  |
| !weather <id> <transition> <zonewide> |  |

 

  [](/MeteorReborn/world/weather/)  
| Parameters |  |
|---|---|
| <id> | Changes to the weather defined at <id>. Refer to Weather  for a list of IDs |
| <transition> | Fades from the current weather effect to the next one, in seconds |
| <zonewide> | Sets the weather change to every player within the same zone |

 

### Debug commands

 

#### endevent

 

   
| endevent | Passes endEvent() to player or <targetname> to close a script |
|---|---|
| Usage | !endevent |
| !endevent <targetname> |  |

 

  
| Parameters |  |
|---|---|
| <targetname> | Name of player to select remotely. Two words, firstname & lastname, separated by a space |

 

#### sendpacket

 

   
| sendpacket | Sends a custom <packet> to player or <targetname> |
|---|---|
| Usage | !sendpacket <packet> |
| !sendpacket <packet> <targetname> |  |

 

  `` 
| Parameters |  |
|---|---|
| <packet> | Filename of the packet to look for from within a folder named packets in the Map Server directory |
| <targetname> | Name of player to select remotely. Two words, firstname & lastname, separated by a space |

 

#### graphic

 

  
| graphic | Changes appearance for equipment with given parameters |
|---|---|
| Usage | !graphic <slot> <wID> <eID> <vID> <cID> |

 

      
| Parameters |  |
|---|---|
| <slot> | Slot type |
| <wID> | Weapon type |
| <eID> | Equipment type |
| <vID> | Variant type |
| <cID> | Color type |

 

 ********************                            
|  |  |  |  |  |
|---|---|---|---|---|
| slot | weaponID | equipID | variantID | colorID |
| 0 - ??? | ??? | Height? | ??? | ??? |
| 1 – Colors | EyeColor | HairColor | SkinColor | ?? |
| 2 – Head? | ??? | FaceType/Eyes | FacialFeatures | ??? |
| 3 – Hair | ??? | HairStyle | Highlight | ??? |
| 4 - ??? |  |  |  |  |
| 5 - MainHand | Model | SubType | Variant | Color Where Applicable |
| 6 - OffHand | Model | SubType | Variant | Color Where Applicable |
| 7 - Special Mainhand | Model | SubType | Variant | Color Where Applicable |
| 8 - Special Offhand | Model | SubType | Variant | Color Where Applicable |
| 9 - Throwing | Model | SubType | Variant | Color Where Applicable |
| 10 - Pack | Model | SubType | Variant | Color Where Applicable |
| 11 - Pouch | Model | SubType | Variant | Color Where Applicable |
| 12 - Head | ??? | Model | Variant | Color Where Applicable |
| 13  - Body | ??? | Model | Variant | Color Where Applicable |
| 14 - Legs | ??? | Model | Variant | Color Where Applicable |
| 15 - Hands | ??? | Model | Variant | Color Where Applicable |
| 16 - Feet | ??? | Model | Variant | Color Where Applicable |
| 17 - Belt | ??? | Model | Variant |  |
| 18 - Neck | ??? | Model | ??? | ??? |
| 19 - Right Ear | ??? | Model | ??? | ??? |
| 20 - Left Ear | ??? | Model | ??? | ??? |
| 21 - Right Wrist | ??? | Model | ??? | ??? |
| 22 - Left Wrist | ??? | Model | ??? | ??? |
| 23 - Right Ring #1 | ??? | Model | ??? | ??? |
| 24 - Left Ring #1 | ??? | Model | ??? | ??? |
| 25 - Right Ring #2 | ??? | Model | ??? | ??? |
| 26 - Left Ring #2 | ??? | Model | ??? | ??? |
| 27 - ??? |  |  |  |  |

 
- Warning: Improper weapon combinations/objects placed in slots 5 and/or 6 can crash the game. Ex. Dual-wielding swords.
 

[Kyne's list of IDs](20231222212124/https://docs.google.com/spreadsheets/d/1VPLeavtXps31guP0ADXTsTTjX4eMK-VwrvDug7kHVso/edit#gid=370822967) [Paru's list of IDs](20231222212124/https://docs.google.com/document/d/1DJq3fp-3omlZ4Bsejd5tPhAb3ZvYczdVpSZO4QGWG3Y/edit?usp=sharing) 

           

### Navigation menu

   

#### Personal tools

  
- [Log in](20231222212124/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Special:UserLogin&returnto=Debug+Commands) 
    

#### Namespaces

  
- [Page](/MeteorReborn/reference/gm-commands/) 
- [Discussion](20231222212124/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Talk:Debug_Commands&action=edit&redlink=1) 
   

#### Variants[](#)

   
      

#### Views

  
- [Read](/MeteorReborn/reference/gm-commands/) 
- [View source](20231222212124/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Debug_Commands&action=edit) 
- [View history](20231222212124/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Debug_Commands&action=history) 
   

#### More[](#)

   
    

#### Search

          [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Main_Page)  

#### Navigation

   
- [Main page](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Main_Page)
- [Recent changes](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:RecentChanges)
- [Random page](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:Random)
- [Help](20231222212124/https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents) 
    

#### Tools

   
- [What links here](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:WhatLinksHere/Debug_Commands)
- [Related changes](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:RecentChangesLinked/Debug_Commands)
- [Special pages](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:SpecialPages)
- [Printable version](20231222212124/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Debug_Commands&printable=yes)
- [Permanent link](20231222212124/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Debug_Commands&oldid=1072)
- [Page information](20231222212124/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Debug_Commands&action=info) 
       
-  This page was last edited on 26 August 2019, at 08:52. 
  
- [Privacy policy](http://ffxivclassic.fragmenterworks.com/wiki/index.php/FFXIV_Classic_Wiki:Privacy_policy) 
- [About FFXIV Classic Wiki](http://ffxivclassic.fragmenterworks.com/wiki/index.php/FFXIV_Classic_Wiki:About) 
- [Disclaimers](http://ffxivclassic.fragmenterworks.com/wiki/index.php/FFXIV_Classic_Wiki:General_disclaimer) 
    (window.RLQ=window.RLQ||[]).push(function(){mw.config.set({"wgPageParseReport":{"limitreport":{"cputime":"0.072","walltime":"0.088","ppvisitednodes":{"value":80,"limit":1000000},"ppgeneratednodes":{"value":86,"limit":1000000},"postexpandincludesize":{"value":0,"limit":2097152},"templateargumentsize":{"value":0,"limit":2097152},"expansiondepth":{"value":2,"limit":40},"expensivefunctioncount":{"value":0,"limit":100},"timingprofile":["100.00% 0.000 1 -total"]},"cachereport":{"timestamp":"20231222201716","ttl":86400,"transientcontent":false}}});});(window.RLQ=window.RLQ||[]).push(function(){mw.config.set({"wgBackendResponseTime":67});});
