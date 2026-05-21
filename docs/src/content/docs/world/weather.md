---
title: Weather
description: FFXIV 1.0 reference for Meteor Reborn.
---

### (WIP) Research

 

The following have thus far been gleamed from videos to determine the 'rules' of XIV's weather system as far as what retail was doing. 

 
-  Weather in a given location can only change every eight hours, at, 00:00, 08:00. and 16:00 
  -  Weather can last more than one cycle 
  -  Weather transition times appears to generally be 5 seconds for open content, and instanced areas 1 second. A couple video instances of estimate 10s for Gloomy and Sandy.
 
-  Cities do not use anything beyond the first four IDs in regular scenarios (ex. When event weather isn't in effect) 
  -  City weather is separate from the weather of the neighbouring field zone
 
-  Some zones may inherit the weather of its parent zone? 
  -  Thus far it appears open dungeons take the weather from the field they're from 
  -  Inns and Grand Company offices might inherit the weather of their respective city? That or just a lot of coincidences found thus far in videos.
 
-  Market Wards are always Clear weather? 
-  Merchants Ward (Waking Sands) is always Fine weather?
 
-  Aurora weather was added in 1.23a, appears to have been made part of the regular weather cycles for the regions, cities included.
 
-  Instanced content and PrivateAreas can set its weather irrespective of the zone 
  -  Ex. Ul'dah's intro tutorial in one video had Fine weather throughout the whole process and cycle, then once regular gameplay was reached it was Cloudy in the actual zone
 

 

 TO-DO 

 
- See if there's any patterns of weather required for the non-base four weathers. Ex. Can Stormy weather come on its own volition, or does it only follow certain weathers. 
- Find more sources to further validate the above points made. 
- Check Dalamud vids at somepoint to see if it applies to *every* zone permanently for that given update 
- Check ferry vids to see if it's timed to a weather cycle along the way to match the zone it's heading to
 

### Region Table

 

A list of which regions have files related to varying weather effects. The client appears to default to the first weather entry for that given region if one is set by the server which doesn't exist for that region. 

Duplicated [Region IDs](/MeteorReborn/world/regions/) were dropped as they all appeared to use the same weather. 

 

  

                             
| Weather Name | Internal Name | ID | 101  sea_s0 | 102  roc_r0 | 103  fst_f0 | 104  wil_w0 | 105  lak_l0 | 108  sea_s1 | 109  roc_r1 | 111  ocn_o0 | 112  ocn_o1 | 113  ocn_o2 | 202  prv_s0 | 204  prv_f0 | 205  prv_w0 | 207  000_10 | 208  prv_00 | 209  prv_i0 | 801  art_s0 | 802  art_r0 | 803  art_f0 | 804  art_w0 | 805  srt_o0 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| WEATHER_CLEAR | wtr_fine | 8001 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| WEATHER_FINE | wtr_suny | 8002 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  | ✅ | ✅ |  |  |  |  |  |  | ✅ | ✅ | ✅ | ✅ | ✅ |
| WEATHER_CLOUDY | wtr_clod | 8003 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |  | ✅ | ✅ |  |  |  |  |  |  | ✅ | ✅ | ✅ | ✅ | ✅ |
| WEATHER_FOGGY | wtr_mist | 8004 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |  | ✅ | ✅ |  |  |  |  |  |  | ✅ | ✅ | ✅ | ✅ | ✅ |
| WEATHER_WINDY |  | 8005 |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| WEATHER_BLUSTERY | wtr_stom | 8006 | ✅ | ✅ |  |  |  |  |  |  |  | ✅ |  |  |  |  |  |  | ✅ | ✅ |  |  |  |
| WEATHER_RAINY | wtr_rain | 8007 | ✅ | ✅ |  | ✅ | ✅ | ✅ |  |  |  | ✅ |  |  |  |  | ✅ |  | ✅ | ✅ | ✅ | ✅ |  |
| WEATHER_SHOWERY |  | 8008 |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| WEATHER_THUNDERY |  | 8009 |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| WEATHER_STORMY | wtr_bolt | 8010 |  |  | ✅ |  |  |  |  | ✅ | ✅ | ✅ |  |  |  |  |  |  |  |  | ✅ |  | ✅ |
| WEATHER_DUSTY |  | 8011 |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| WEATHER_SANDY | wtr_sand | 8012 |  |  |  | ✅ |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | ✅ |  |
| WEATHER_HOT |  | 8013 |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| WEATHER_BLISTERING | wtr_heat | 8014 |  |  |  | ✅ |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| WEATHER_SNOWY |  | 8015 |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| WEATHER_WINTRY |  | 8016 |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| WEATHER_GLOOMY | wtr_fogd | 8017 |  |  |  |  | ✅ |  |  |  |  | ✅ |  |  |  |  |  |  |  |  |  |  |  |
| WEATHER_SEASONAL | wtr_hall | 8027 | ✅ |  | ✅ | ✅ |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| WEATHER_PRIMAL | wtr_smmn | 8028 |  | ✅ | ✅ | ✅ |  |  | ✅ |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| WEATHER_SEASONAL_FIREWORKS | wtr_smmr | 8029 | ✅ |  | ✅ | ✅ |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | ✅ |
| WEATHER_DALAMUD | wtr_comp | 8030 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |  | ✅ |  |  |  |  |  |  |  |  |  |  |  | ✅ |
| WEATHER_AURORA | wtr_chry | 8031 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |  | ✅ |  |  |  |  |  |  |  |  |  |  |  | ✅ |
| WEATHER_DALAMUDTHUNDER | wtr_xmas | 8032 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |  |  | ✅ |  |  |  |  |  |  |  |  |  |  |  | ✅ |
| WEATHER_DAY | wtr_h001 | 8065 | ✅ | ✅ | ✅ | ✅ | ✅ |  |  | ✅ |  |  |  |  |  |  |  |  |  |  |  |  |  |
| WEATHER_TWILIGHT | wtr_h002 | 8066 | ✅ |  | ✅ | ✅ |  |  |  | ✅ |  |  |  |  |  |  |  |  |  |  |  |  |  |
| ??? | wtr_h003 | 8067 |  |  | ✅ | ✅ |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| ??? | wtr_h004 | 8068 |  |  | ✅ | ✅ |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| ??? | wtr_h005 | 8069 |  |  |  | ✅ |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| ??? | wtr_e001 | 8081 |  |  |  |  |  |  |  |  |  | ✅ |  |  |  |  |  |  |  |  |  |  |  |
