---
title: Animations & VFX
description: FFXIV 1.0 reference for Meteor Reborn.
---

### How it works

 

When an animation is required to play on an actor an "animationId" is used to define both the animation that is played as well as the particle effect that may accompany it. This "id" is actually a bitpacked value in the following format: 

 

   
|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| VFX Number | Animation Number | VFX Category |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 |

 
-  **Animation Number:** The specific file number to play within the animation category folder (see below). 
-  **VFX Category:** Sets the VFX folder category that will be play from. 
-  **VFX Number:** The specific file number to play within the VFX category folder (see below).
 

If you look inside your `FFXIV Install Folder/client/` folder, you will notice a `chara` and `vfx` folder. The former contains model and animation info for every pc, monster, and object model. Based on the actor model and it's state, an animation category folder path will be made. For example a Hyur male in a passive state standing will load animation files in thise folder `FINAL FANTASY XIV/client/chara/pc/c001/act/cmn/em1/base/`. The animation number provided matches the numbered files in this folder. Therefore we can deduce all possible animations for a specific set of state. 

The particle effect portion is stored in the `VFX` folder. Unlike animations, the category to load from is not based on state and rather is provided. See below for the mapping between the category number and folder name. For example category `5` is provided with the VFX number `30`. This means the particle effect `FINAL FANTASY XIV/client/vfx/itm/0030` will be loaded and played along with the animation. 

Note that some animations/vfx were not implemented or required to be paired with each other (such as the throw snowball animation and snowball effect). Animations may also include sound effects as well. 

 

### Animation Categories

 

               
| Category Folder | Description |
|---|---|
| em1 | Animations while passive. |
| em2 | Animations while sitting on the floor. |
| em3 | Animations while sitting on a chair. |
| lib |  |
| lil |  |
| lui |  |
| fid | Field idle animations. Set on NPCs using a motion pack. |
| bid | Battle idle animations. |
| rid | Riding idle animations. |
| sid | Sitting idle animations. |
| atk | Auto attack animations. |
| mgc | Magic casting animations. |
| wsc | Weapon Skill animations. |
| btl | Throwing animations. |

 

### VFX Categories

 

                           
| Category Number | Category Folder | Description |
|---|---|---|
| 1 | mgk | Magic effects. |
| 2 | sys |  |
| 3 | etc |  |
| 4 | lib | Various effects and animations. |
| 5 | itm | Item effects for passive state. |
| 6 | itm | Item effects for active state? |
| 7 | itm | Item effects for sitting on an object. |
| 8 | itm | Item effects for sitting on the ground. |
| 9 | itm | Item effects for an unknown state. Tries to call 'em4' folder from character model, perhaps placeholder for mounts? |
| 10 | kao |  |
| 11 | gl1-3 | Three bitshifted values for displaying a guildleve plate.  Causes character to animate with em1/4001 to throw the guildleve up |
| 12 | gl1-3 | Three bitshifted values for displaying a guildleve plate.  Does nothing with the character.  Meant for receiving a shared guildleve perhaps? |
| 13 | cbi |  |
| 14 | abl | Ability effects. |
| 15 | pop | Spawning effects. |
| 16 | cft | Crafting effects (success/fail/etc). |
| 17 | btl |  |
| 18 | wsc | Weapon Skill Character effects. |
| 19 | wss | Monster Skill effects. |
| 20 | pic | Gathering effects (using buffs, swing animations on character) |
| 21 | liu | Hand animations. |
| 22 | lin |  |
| 23 | lif |  |
| 24 | lil | Speaking animations. |
| 25 | atk |  |
| 33 | wss | Same as 19? |

           

### Navigation menu

   

#### Personal tools

  
- Log in 
    

#### Namespaces

  
- [Page](/MeteorReborn/world/animations/) 
- Discussion 
   

#### Variants

   
      

#### Views

  
- [Read](/MeteorReborn/world/animations/) 
- View source 
- View history 
   

#### More

   
    

#### Search

            

#### Navigation

   
- Main page
- Recent changes
- Random page
- [Help](20231222212114/https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents) 
    

#### Tools

   
- What links here
- Related changes
- Special pages
- Printable version
- Permanent link
- Page information 
       
-  This page was last edited on 22 June 2019, at 14:41. 
  
- Privacy policy 
- About FFXIV Classic Wiki 
- Disclaimers 
    (window.RLQ=window.RLQ||[]).push(function(){mw.config.set({"wgPageParseReport":{"limitreport":{"cputime":"0.011","walltime":"0.013","ppvisitednodes":{"value":10,"limit":1000000},"ppgeneratednodes":{"value":16,"limit":1000000},"postexpandincludesize":{"value":0,"limit":2097152},"templateargumentsize":{"value":0,"limit":2097152},"expansiondepth":{"value":2,"limit":40},"expensivefunctioncount":{"value":0,"limit":100},"timingprofile":["100.00% 0.000 1 -total"]},"cachereport":{"timestamp":"20231222085737","ttl":86400,"transientcontent":false}}});});(window.RLQ=window.RLQ||[]).push(function(){mw.config.set({"wgBackendResponseTime":72});});
