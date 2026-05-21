---
title: Math formulas
description: FFXIV 1.0 reference for Meteor Reborn.
---

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

  
- Log in 
    

#### Namespaces

  
- [Page](/MeteorReborn/reference/math-formulas/) 
- Discussion 
   

#### Variants

   
      

#### Views

  
- [Read](/MeteorReborn/reference/math-formulas/) 
- View source 
- View history 
   

#### More

   
    

#### Search

            

#### Navigation

   
- Main page
- Recent changes
- Random page
- [Help](20231222212115/https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents) 
    

#### Tools

   
- What links here
- Related changes
- Special pages
- Printable version
- Permanent link
- Page information 
       
-  This page was last edited on 26 October 2017, at 09:31. 
  
- Privacy policy 
- About FFXIV Classic Wiki 
- Disclaimers 
    (window.RLQ=window.RLQ||[]).push(function(){mw.config.set({"wgPageParseReport":{"limitreport":{"cputime":"0.008","walltime":"0.011","ppvisitednodes":{"value":22,"limit":1000000},"ppgeneratednodes":{"value":58,"limit":1000000},"postexpandincludesize":{"value":0,"limit":2097152},"templateargumentsize":{"value":0,"limit":2097152},"expansiondepth":{"value":2,"limit":40},"expensivefunctioncount":{"value":0,"limit":100},"timingprofile":["100.00% 0.000 1 -total"]},"cachereport":{"timestamp":"20231222212227","ttl":86400,"transientcontent":false}}});});(window.RLQ=window.RLQ||[]).push(function(){mw.config.set({"wgBackendResponseTime":138});});
