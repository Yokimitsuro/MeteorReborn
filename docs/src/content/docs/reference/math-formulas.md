---
title: Math formulas
description: Mirrored from the FFXIV Classic Wiki for offline reference.
---

:::note[Source]
This page is mirrored from the [FFXIV Classic Wiki](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Math_Formula). Original authors retain credit; reproduced here because the upstream wiki is intermittently offline.
:::

Functions to reproduce values the client derives from its own scripts. Presented in LUA. 

 

### Scaled experience reward from quests

  

```

function calcSkillPoint(player, lvl, weight)
    weight = weight / 100
    return math.ceil(expTable[lvl] * weight)  
    -- expTable is a table listing total XP needed per level
end
```

  

### Command MP cost

  

```
local commandCost = {  
    -- Some example base MP costs before the formula scales the cost to current level
    ["raise"] = 150,
    ["cure"] = 40,
    ["cura"] = 100,
    ["curaga"] = 150,
    ["firaga"] = 255,
    ["thundara"] = 135,
};

function calculateCommandCost(skillName, level)
    if skillName and level and commandCost[skillName] then
        if level <= 10 then
            return math.ceil((100 + level * 10) * (commandCost[skillName] * 0.001));
        elseif level <= 20 then
            return math.ceil((200 + (level - 10) * 20) * (commandCost[skillName] * 0.001));            
        elseif level <= 30 then
            return math.ceil((400 + (level - 20) * 40) * (commandCost[skillName] * 0.001));       
        elseif level <= 40 then
             return math.ceil((800 + (level - 30) * 70) * (commandCost[skillName] * 0.001));   
        elseif level <= 50 then
            return math.ceil((1500 + (level - 40) * 130) * (commandCost[skillName] * 0.001)); 
        elseif level <= 60 then
            return math.ceil((2800 + (level - 50) * 200) * (commandCost[skillName] * 0.001)); 
        elseif level <= 70 then
            return math.ceil((1500 + (level - 60) * 320) * (commandCost[skillName] * 0.001)); 
        else
            return math.ceil((8000 + (level - 70) * 500) * (commandCost[skillName] * 0.001)); 
        end;
  end;
  return 1;
end

```

            

### Navigation menu

   

#### Personal tools

  
- [Log in](20231222212115/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Special:UserLogin&returnto=Math+Formula) 
    

#### Namespaces

  
- [Page](/MeteorReborn/reference/math-formulas/) 
- [Discussion](20231222212115/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Talk:Math_Formula&action=edit&redlink=1) 
   

#### Variants[](#)

   
      

#### Views

  
- [Read](/MeteorReborn/reference/math-formulas/) 
- [View source](20231222212115/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Math_Formula&action=edit) 
- [View history](20231222212115/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Math_Formula&action=history) 
   

#### More[](#)

   
    

#### Search

          [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Main_Page)  

#### Navigation

   
- [Main page](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Main_Page)
- [Recent changes](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:RecentChanges)
- [Random page](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:Random)
- [Help](20231222212115/https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents) 
    

#### Tools

   
- [What links here](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:WhatLinksHere/Math_Formula)
- [Related changes](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:RecentChangesLinked/Math_Formula)
- [Special pages](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:SpecialPages)
- [Printable version](20231222212115/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Math_Formula&printable=yes)
- [Permanent link](20231222212115/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Math_Formula&oldid=32)
- [Page information](20231222212115/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Math_Formula&action=info) 
       
-  This page was last edited on 26 October 2017, at 09:31. 
  
- [Privacy policy](http://ffxivclassic.fragmenterworks.com/wiki/index.php/FFXIV_Classic_Wiki:Privacy_policy) 
- [About FFXIV Classic Wiki](http://ffxivclassic.fragmenterworks.com/wiki/index.php/FFXIV_Classic_Wiki:About) 
- [Disclaimers](http://ffxivclassic.fragmenterworks.com/wiki/index.php/FFXIV_Classic_Wiki:General_disclaimer) 
    (window.RLQ=window.RLQ||[]).push(function(){mw.config.set({"wgPageParseReport":{"limitreport":{"cputime":"0.008","walltime":"0.011","ppvisitednodes":{"value":22,"limit":1000000},"ppgeneratednodes":{"value":58,"limit":1000000},"postexpandincludesize":{"value":0,"limit":2097152},"templateargumentsize":{"value":0,"limit":2097152},"expansiondepth":{"value":2,"limit":40},"expensivefunctioncount":{"value":0,"limit":100},"timingprofile":["100.00% 0.000 1 -total"]},"cachereport":{"timestamp":"20231222212227","ttl":86400,"transientcontent":false}}});});(window.RLQ=window.RLQ||[]).push(function(){mw.config.set({"wgBackendResponseTime":138});});
