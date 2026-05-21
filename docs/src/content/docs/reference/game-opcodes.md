---
title: Game opcodes
description: Mirrored from the FFXIV Classic Wiki for offline reference.
---

:::note[Source]
This page is mirrored from the [FFXIV Classic Wiki](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes). Original authors retain credit; reproduced here because the upstream wiki is intermittently offline.
:::

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

  

   [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/GameOpcode:Tell_Message_(Server)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/GameOpcode:Group_Message_(Server)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/GameOpcode:Tell_Message_Error) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/GameOpcode:Generic_Log_Message)
| Server -> Client |  |
|---|---|
| Opcode | Packet Name |
| 0x0C8 | Tell Message |
| 0x0C9 | Group Message |
| 0x0CA | Tell Message Error |
| 0x0CB | Generic Log Message |

   

   [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/GameOpcode:Tell_Message_(Client)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/GameOpcode:Group_Message_(Client))
| Client -> Server |  |
|---|---|
| Opcode | Packet Name |
| 0x0C8 | Tell Message |
| 0x0C9 | Group Message |

   

### Zone Channel

  

   [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Pong) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Unknown:0x002) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/GameOpcode:Say_Message_(Server)) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Reset_Engine&action=edit&redlink=1) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Map) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Mass_Delete_Actor_Start) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Mass_Delete_Actor_End) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Mass_Delete_Actor_Body_(x1)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Mass_Delete_Actor_Body_(x10)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Mass_Delete_Actor_Body_(x20)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Mass_Delete_Actor_Body_(x40)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Music) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Weather) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Logout)  [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Dalamud_Phase) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Quit_Game) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Create_Actor) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Remove_Actor) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Load_Class_Script_for_Actor) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Unload_Class_Script&action=edit&redlink=1) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Actor_Position) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Move_Actor_to_Position) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Actor_Speeds) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:DEPRECATED) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Actor_Target_(Animated)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Turn_Actor_to_Target) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Actor_Appearance_(x32)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Actor_Appearance_(x16)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Bind_BG_MapObj_to_Actor) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Play_BG_animation) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Play_particle_animation_on_actor_(w.o_stopping)&action=edit&redlink=1) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Head_to_Actor_(/w_speed)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Head_to_Position_(/w_speed)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Actor_Head_Orientation_(/w_speed)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Reset_Head) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Actor_Target_(Immediate)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Play_Animation/Effect) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Do_Emote) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Map_Change_%26_UI_Change) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Actor_Quest_Icon) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Show/Hide_Weapon) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Show_Countdown) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:DEPRECATED) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:SetTalkEventCondition) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:KickClientOrderEvent) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:StartServerOrderEventFunction) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:EndClientOrderEvent) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:DEPRECATED) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:General_Data_Packet) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Actor_MainState) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:SetEventStatus) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Set_Actor_Work_Values_(SyncMemory)&action=edit&redlink=1) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:SetTargetTime) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Command_Result_(x01_Log/Effect)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Command_Result_(x10_Log/Effect)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Command_Result_(x18_Log/Effect)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Command_Result_(No_Log/Effect)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Actor_Name) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Delete_Group&action=edit&redlink=1) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Actor_SubState) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Actor_Icon_(ChangeActorExtraStat)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:ItemPackage_Chunk_Start) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:ItemPackage_Chunk_End) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Add_Item_(x01)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Add_Item_(x08,_variable)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Add_Item_(x16)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Add_Item_(x32)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Add_Item_(x64)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Set_Equipment_Id_(x01)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Set_Equipment_Id_(x08,_variable)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Set_Equipment_Id_(x16)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Set_Equipment_Id_(x32)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Set_Equipment_Id_(x64)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Remove_Item_(x01)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Remove_Item_(x08,_variable)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Remove_Item_(x16)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Remove_Item_(x32)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Remove_Item_(x64)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(Source_Actor)_(30b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(Source_Actor)_(38b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(Source_Actor)_(40b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(Source_Actor)_(50b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(Source_Actor)_(70b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(Custom_Sender)_(48b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(Custom_Sender)_(58b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(Custom_Sender)_(68b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(Custom_Sender)_(78b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(Custom_Sender)_(98b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(DispId_Sender)_(30b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(DispId_Sender)_(38b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(DispId_Sender)_(40b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(DispId_Sender)_(50b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(DispId_Sender)_(60b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(No_Source_Actor)_(28b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(No_Source_Actor)_(38b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(No_Source_Actor)_(38b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(No_Source_Actor)_(48b)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Text_Sheet_Message_(No_Source_Actor)_(68b)&action=edit&redlink=1) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:SetNoticeEventCondition) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:SetEmoteEventCondition) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Inventory_Begin_Change) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Inventory_End_Change) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:SetPushEventConditionWithCircle) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:SetPushEventConditionWithFan) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:DEPRECATED) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:DEPRECATED) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:DEPRECATED) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:DEPRECATED) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:SetPushEventConditionWithTriggerBox) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Set_Item_Modifier_(x1)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Set_Status_@_Index&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Set_All_Status&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Set_Group_Work_Values&action=edit&redlink=1) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Actor_In_Different_Zone) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Group_Packet_Header&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Group_Begin&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Group_End&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Group_Members_Body_(x8,_variable)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Group_Members_Body_(x16)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Group_Members_Body_(x32)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Group_Members_Body_(x64)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Group_Duty_Members_Body_(x8,_variable)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Group_Duty_Members_Body_(x16)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Group_Duty_Members_Body_(x32)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Group_Duty_Members_Body_(x64)&action=edit&redlink=1) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Occupancy_Group) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Create_Named_Group_(IE:_LS)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Create_Named_Group_(x8,_variable)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Set_Active_Linkshell&action=edit&redlink=1) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Group_LayoutID)  [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Party_Map_Marker_Update) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Retainer_Star_(ChangeSystemStat)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Mass_Set_Item_Modifier_Begin) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Mass_Set_Item_Modifier) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Mass_Set_Item_Modifier_End) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Send_Addiction_Limit_Message) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Stops_control_(0x14)_and_starts_(0x15).&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Set_Grand_Company_Info&action=edit&redlink=1) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Emnity_Indicator) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_SpecialEventWork) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Chocobo_Ride) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Chocobo_Name) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Has_Chocobo) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Achievements_Completed) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Latest_Achievements) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Total_Achievement_Points) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Player_Title) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Achievement_Earned_Packet) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Respond_Achievement_Completion_Rate) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Set_Gobbue_Appearance&action=edit&redlink=1) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Has_Gobbue_Mount) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:JobQuestCompleteTriple) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Cutscene_Book_Details) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Current_Job) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:EntrustItem) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:HamletSupplyRanking&action=edit&redlink=1) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Set_Dream_Result_(Required_for_wakeup)) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:HamletDefenseScore&action=edit&redlink=1) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:DEPRECATED) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Recruiting_Started_Response&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Recruiting_Ended_Response&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Recruiting_State_Response_(Open_Party)&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Recruiting_Acceptment_Response&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Recruitment_Search_Results&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Get_Recruitment_Info&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Add_Blacklist_Response&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Remove_Blacklist_Response&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Send_Blacklist&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Add_Friendlist_Response&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Remove_Friendlist_Response&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Send_Friendlist&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Friend_Status_Update_Response&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Faq_Request_Response&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Faq_Body_Response&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Send_Issue_Options&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Makes_GM_Icon_Reply_appear&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:GM_Message_Response&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:GM_Ticket_Sent_Response&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Confirm_GM_ticket_ended&action=edit&redlink=1) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Item_Search_Start) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Item_Search_Result) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Item_Search_End) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Retainer_Search_End) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Retainer_Search_Results) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Retainer_Search_Update) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Retainer_Search_Transaction_History)  [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Player_Search_Information_Response) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Player_Search_Comment_Response) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Close_Item_Search) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:DEPRECATED._GM%3F&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:DEPRECATED._GM%3F&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:DEPRECATED._GM%3F&action=edit&redlink=1)
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

   

   [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Ping) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Unknown:0x002) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/GameOpcode:Say_Message_(Client)) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Client_Langauge) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Unknown:0x007) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Position_Update) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Target_Locked) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Target_Selected) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Starting/Ending_Cutscene) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Countdown_Started) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Event_Start_Request) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Event_Result) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Data_Request&action=edit&redlink=1) [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Game_Opcodes:Linkshell_Active_Request) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Item_Package_Update_Request&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Group_Created&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Achievement_Progress_Request&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Recruitment_Start_Request&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Recruitment_End_Request&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Party_Window_Opened,_State_Request&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Recruiting_Accepted&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Search_Result_Request&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Get_Recruitment_Details&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Blacklist_Add&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Blacklist_Remove&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Blacklist_Request&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Friendlist_Add&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Friendlist_Remove&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Friendlist_Request&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Opcodes:Friendlist_Status_Request&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Opcodes:FAQ_%26_Info_List_Request&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Opcodes:FAQ_%26_Info_Body_Request&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Issue_List_Request&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Opcodes:Is_GM_Ticket_Active_Request&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:GM_Response_Request&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:GM_Ticket_Sent&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:End_GM_Ticket_Request&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Track_Retainer&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Begin_Item_Category_Search&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Begin_Retainer_Search&action=edit&redlink=1)   [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Set_Search_Info&action=edit&redlink=1) [](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes:Begin_Player_Search&action=edit&redlink=1)  
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

             

### Navigation menu

   

#### Personal tools

  
- [Log in](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Special:UserLogin&returnto=Game+Opcodes) 
    

#### Namespaces

  
- [Page](/MeteorReborn/reference/game-opcodes/) 
- [Discussion](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Talk:Game_Opcodes&action=edit&redlink=1) 
   

#### Variants[](#)

   
      

#### Views

  
- [Read](/MeteorReborn/reference/game-opcodes/) 
- [View source](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes&action=edit) 
- [View history](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes&action=history) 
   

#### More[](#)

   
    

#### Search

          [](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Main_Page)  

#### Navigation

   
- [Main page](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Main_Page)
- [Recent changes](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:RecentChanges)
- [Random page](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:Random)
- [Help](20231222212121/https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents) 
    

#### Tools

   
- [What links here](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:WhatLinksHere/Game_Opcodes)
- [Related changes](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:RecentChangesLinked/Game_Opcodes)
- [Special pages](http://ffxivclassic.fragmenterworks.com/wiki/index.php/Special:SpecialPages)
- [Printable version](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes&printable=yes)
- [Permanent link](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes&oldid=1039)
- [Page information](20231222212121/http://ffxivclassic.fragmenterworks.com/wiki/index.php?title=Game_Opcodes&action=info) 
       
-  This page was last edited on 30 June 2019, at 14:22. 
  
- [Privacy policy](http://ffxivclassic.fragmenterworks.com/wiki/index.php/FFXIV_Classic_Wiki:Privacy_policy) 
- [About FFXIV Classic Wiki](http://ffxivclassic.fragmenterworks.com/wiki/index.php/FFXIV_Classic_Wiki:About) 
- [Disclaimers](http://ffxivclassic.fragmenterworks.com/wiki/index.php/FFXIV_Classic_Wiki:General_disclaimer) 
    (window.RLQ=window.RLQ||[]).push(function(){mw.config.set({"wgPageParseReport":{"limitreport":{"cputime":"0.075","walltime":"0.087","ppvisitednodes":{"value":21,"limit":1000000},"ppgeneratednodes":{"value":36,"limit":1000000},"postexpandincludesize":{"value":0,"limit":2097152},"templateargumentsize":{"value":0,"limit":2097152},"expansiondepth":{"value":2,"limit":40},"expensivefunctioncount":{"value":0,"limit":100},"timingprofile":["100.00% 0.000 1 -total"]},"cachereport":{"timestamp":"20231222152005","ttl":86400,"transientcontent":false}}});});(window.RLQ=window.RLQ||[]).push(function(){mw.config.set({"wgBackendResponseTime":75});});
