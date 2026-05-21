---
title: FAQs
description: Mirrored from the FFXIV Classic Wiki for offline reference.
---

:::note[Source]
This page is mirrored from the [FFXIV Classic Wiki](http://ffxivclassic.fragmenterworks.com/wiki/index.php/FAQs). Original authors retain credit; reproduced here because the upstream wiki is intermittently offline.
:::

### General

 

#### None of the commands work / Lots of LUA errors in the log

  You didn't copy the /scripts/ folder to your map server directory. 

#### I cannot connect to Seventh Umbral

  Project Meteor is **not** associated with that project, but that server has not functioned in quite some time. You'll only get as far as seeing the title screen with it, as its lobby server will time-out if you attempt to open the character select screen. 

#### _______ in the interface doesn't work

  Some elements of the Main Menu (opened via dash on numpad) are either in a read-only state so you can see it, but not modify. Others will cause a LUA script error to appear in your chat log. More client functionality will be restored over time as the project progresses. 

#### _______ in the world doesn't work

  Currently, the only functioning elements are doors with known IDs assigned while you're in the zone ID associated with it, and whichever NPCs are scripted to have player interaction.  

#### How do I skip the opening tutorial?

 As it stands, you'll have to go into map server's scripts folder and modify player.lua. Notepad will work if you have no dedicated LUA reader. Open it up and comment out the If statement involving player:getPlayTime. LUA commenting uses -- for a line, or --[[ with --]] to comment a block. Now create/recreate a character and [warp](/MeteorReborn/reference/gm-commands/) out of the starting location. 

#### I keep seeing script errors in the log

 These are for debugging purposes and will be remedied over time as the actors (NPCs/Enemies/etc) are implemented. 

#### What are the commands?

  Refer to [Debug_Commands](/MeteorReborn/reference/gm-commands/) 

#### The game hangs at the loading screen

  This is an uncommon issue with the Map server. Just close and reload it, the game will prompt and error and return you to the lobby where you can try again. 

#### I only see actors in the Adventurer's Guild

  The cities are broken up into two zone IDs internally, as they were on retail servers. One for the Adventurer's Guild, and one for the rest of the city.  Seamless changing of Zone IDs are currently not implemented, but you can utilize the [warp](/MeteorReborn/reference/gm-commands/) command to change them yourself.  The zone IDs for the cities are as follow: 

     
| Location | Guild | City |
|---|---|---|
| Limsa Lominsa | 133 | 230 |
| Gridania | 155 | 206 |
| Ul'dah | 175 | 209 |

 

#### I can't get a certain Zone ID to work

  The zone list from [Regions](/MeteorReborn/world/regions/) isn't fully implemented in the server_zones database.  Some of the zoneName and className fields have yet to be determined for authenticity. 

#### How do I use the mounts?

  There is currently no ingame means of obtaining them on the master branch.   To manually add the Chocobo and/or Goobue mount to a character: 
-  Open up your ffxiv_server database, get your character's ID from the characters table  
-  Go into the characters_chocobo table, insert a row, enter the character's ID in the first column 
-  Set the hasChocobo/hasGoobue boolean flags from 0 to 1, leave chocoboAppearance to null, and give it a name. 
-  Reload the map server if you had it running for it to reload the character data
  On the current develop branch, the chocobo rental NPCs work in their respective city, and are currently flagged to issue you a chocobo if you so desire.  Chocobo barding menu crashes the client currently. We're already aware of the reasons why, just don't select it. 

### Client

 

#### The game exe crashes immediately

  If you're running a processor which has 16 or more threads available, FFXIV will immediately crash. A quick fix is to: 
-  Load up the Seventh Umbral launcher,  
-  Open up Task Manager and go into the Detail tab.  
-  Right-click `Launcher.exe` (which has orange-bordered FFXIV icon), select "Set affinity".  
-  Set the CPU affinity for the launcher to 15 or less CPU threads.  
-  The game should launch properly from there. 
 

#### I cannot find ffxivgame.exe

  Update your client to v1.23b using the Seventh Umbral launcher. The base retail version didn't have it yet. 

 

 

### Server

 

#### The login page doesn't show

  Ensure your Apache/PHP/SQL services are properly running and that the contents of the www folder from the Project Meteor Server have been copied over.  Also ensure the ports are properly open. Default settings have port 80 for Apache, 3306 for SQL. The latter can be changed for the project by modifying <Project Directory>/data/config.ini           

### Navigation menu

   

#### Personal tools

  
- [Log in](20231222212125/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Special:UserLogin&returnto=FAQs) 
    

#### Namespaces

  
- [Page](/MeteorReborn/project/faqs/) 
- [Discussion](20231222212125/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Talk:FAQs&action=edit&redlink=1) 
   

#### Variants[](#)

   
      

#### Views

  
- [Read](/MeteorReborn/project/faqs/) 
- [View source](20231222212125/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=FAQs&action=edit) 
- [View history](20231222212125/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=FAQs&action=history) 
   

#### More[](#)

   
    

#### Search

          [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Main_Page)  

#### Navigation

   
- [Main page](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Main_Page)
- [Recent changes](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:RecentChanges)
- [Random page](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:Random)
- [Help](20231222212125/https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents) 
    

#### Tools

   
- [What links here](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:WhatLinksHere/FAQs)
- [Related changes](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:RecentChangesLinked/FAQs)
- [Special pages](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:SpecialPages)
- [Printable version](20231222212125/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=FAQs&printable=yes)
- [Permanent link](20231222212125/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=FAQs&oldid=1197)
- [Page information](20231222212125/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=FAQs&action=info) 
       
-  This page was last edited on 12 June 2021, at 19:09. 
  
- [Privacy policy](http://ffxivclassic.fragmenterworks.com/wiki/index.php/FFXIV_Classic_Wiki:Privacy_policy) 
- [About FFXIV Classic Wiki](http://ffxivclassic.fragmenterworks.com/wiki/index.php/FFXIV_Classic_Wiki:About) 
- [Disclaimers](http://ffxivclassic.fragmenterworks.com/wiki/index.php/FFXIV_Classic_Wiki:General_disclaimer) 
    (window.RLQ=window.RLQ||[]).push(function(){mw.config.set({"wgPageParseReport":{"limitreport":{"cputime":"0.020","walltime":"0.024","ppvisitednodes":{"value":77,"limit":1000000},"ppgeneratednodes":{"value":94,"limit":1000000},"postexpandincludesize":{"value":0,"limit":2097152},"templateargumentsize":{"value":0,"limit":2097152},"expansiondepth":{"value":2,"limit":40},"expensivefunctioncount":{"value":0,"limit":100},"timingprofile":["100.00% 0.000 1 -total"]},"cachereport":{"timestamp":"20231222212236","ttl":86400,"transientcontent":false}}});});(window.RLQ=window.RLQ||[]).push(function(){mw.config.set({"wgBackendResponseTime":206});});
