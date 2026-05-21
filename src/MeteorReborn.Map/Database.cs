// PM-COMPLETE → verbatim port de Map Server/Database.cs (2782 líneas).
// LANG-ADAPT: namespace + nullable + NLog→Serilog + MySql→Npgsql + NLua→MoonSharp (Lua/*).
﻿/*
===========================================================================
Copyright (C) 2015-2019 Project Meteor Dev Team

This file is part of Project Meteor Server.

Project Meteor Server is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Project Meteor Server is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with Project Meteor Server. If not, see <https:www.gnu.org/licenses/>.
===========================================================================
*/

using Npgsql;
using NpgsqlTypes;
using System;
using System.Collections.Generic;
using MeteorReborn.Common;
using Serilog;
using MeteorReborn.Map.utils;

using MeteorReborn.Map.Packets.Send.Player;
using MeteorReborn.Map.DataObjects;
using MeteorReborn.Map.Actors;
using MeteorReborn.Map.Packets.Receive.SupportDesk;
using MeteorReborn.Map.Actors.Chara.Ai;
using MeteorReborn.Map.Packets.Send.Actor.Battle;

namespace MeteorReborn.Map
{

    class Database
    {

        public static uint GetUserIdFromSession(String sessionId)
        {
            uint id = 0;
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand("SELECT * FROM sessions WHERE id = @sessionId AND expiration > NOW()", conn);
                    cmd.Parameters.AddParam("@sessionId", sessionId);
                    using (NpgsqlDataReader Reader = cmd.ExecuteReader())
                    {
                        while (Reader.Read())
                        {
                            id = Reader.GetUInt32("userId");
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
            return id;
        }

        public static Dictionary<uint, ItemData> GetItemGamedata()
        {
            using (var conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                Dictionary<uint, ItemData> gamedataItems = new Dictionary<uint, ItemData>();

                try
                {
                    conn.Open();

                    string query = @"
                                SELECT
                                *                                
                                FROM gamedata_items
                                LEFT JOIN gamedata_items_equipment        ON gamedata_items.catalogID = gamedata_items_equipment.catalogID
                                LEFT JOIN gamedata_items_accessory        ON gamedata_items.catalogID = gamedata_items_accessory.catalogID
                                LEFT JOIN gamedata_items_armor            ON gamedata_items.catalogID = gamedata_items_armor.catalogID
                                LEFT JOIN gamedata_items_weapon           ON gamedata_items.catalogID = gamedata_items_weapon.catalogID
                                LEFT JOIN gamedata_items_graphics         ON gamedata_items.catalogID = gamedata_items_graphics.catalogID                                
                                LEFT JOIN gamedata_items_graphics_extra   ON gamedata_items.catalogID = gamedata_items_graphics_extra.catalogID
                                ";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);

                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            uint id = reader.GetUInt32("catalogID");
                            ItemData item = null;

                            if (ItemData.IsWeapon(id))
                                item = new WeaponItem(reader);
                            else if (ItemData.IsArmor(id))
                                item = new ArmorItem(reader);
                            else if (ItemData.IsAccessory(id))
                                item = new AccessoryItem(reader);
                            else
                                item = new ItemData(reader);

                            gamedataItems.Add(item.catalogID, item);
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }

                return gamedataItems;
            }
        }

        public static Dictionary<uint, GuildleveData> GetGuildleveGamedata()
        {
            using (var conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                Dictionary<uint, GuildleveData> gamedataGuildleves = new Dictionary<uint, GuildleveData>();

                try
                {
                    conn.Open();

                    string query = @"
                                SELECT
                                *                                
                                FROM gamedata_guildleves
                                ";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);

                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            uint id = reader.GetUInt32("id");
                            GuildleveData guildleve = new GuildleveData(reader);
                            gamedataGuildleves.Add(guildleve.id, guildleve);
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }

                return gamedataGuildleves;
            }
        }

        public static void SavePlayerAppearance(Player player)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    query = @"
                    UPDATE characters_appearance SET 
                    mainHand = @mainHand,
                    offHand = @offHand,
                    head = @head,
                    body = @body,
                    legs = @legs,
                    hands = @hands,
                    feet = @feet,
                    waist = @waist,
                    neck = @neck,
                    leftFinger = @leftFinger,
                    rightFinger = @rightFinger,
                    leftEar = @leftEar,
                    rightEar = @rightEar
                    WHERE characterId = @charaId
                    ";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", player.actorId);
                    cmd.Parameters.AddParam("@mainHand", player.appearanceIds[Character.MAINHAND]);
                    cmd.Parameters.AddParam("@offHand", player.appearanceIds[Character.OFFHAND]);
                    cmd.Parameters.AddParam("@head", player.appearanceIds[Character.HEADGEAR]);
                    cmd.Parameters.AddParam("@body", player.appearanceIds[Character.BODYGEAR]);
                    cmd.Parameters.AddParam("@legs", player.appearanceIds[Character.LEGSGEAR]);
                    cmd.Parameters.AddParam("@hands", player.appearanceIds[Character.HANDSGEAR]);
                    cmd.Parameters.AddParam("@feet", player.appearanceIds[Character.FEETGEAR]);
                    cmd.Parameters.AddParam("@waist", player.appearanceIds[Character.WAISTGEAR]);
                    cmd.Parameters.AddParam("@neck", player.appearanceIds[Character.NECKGEAR]);
                    cmd.Parameters.AddParam("@leftFinger", player.appearanceIds[Character.L_RINGFINGER]);
                    cmd.Parameters.AddParam("@rightFinger", player.appearanceIds[Character.R_RINGFINGER]);
                    cmd.Parameters.AddParam("@leftEar", player.appearanceIds[Character.L_EAR]);
                    cmd.Parameters.AddParam("@rightEar", player.appearanceIds[Character.R_EAR]);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void SavePlayerCurrentClass(Player player)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    query = @"
                    UPDATE characters_parametersave SET 
                    mainSkill = @classId,
                    mainSkillLevel = @classLevel
                    WHERE characterId = @charaId
                    ";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", player.actorId);
                    cmd.Parameters.AddParam("@classId", player.charaWork.parameterSave.state_mainSkill[0]);
                    cmd.Parameters.AddParam("@classLevel", player.charaWork.parameterSave.state_mainSkillLevel);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void SavePlayerPosition(Player player)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    query = @"
                    UPDATE characters SET 
                    positionX = @x,
                    positionY = @y,
                    positionZ = @z,
                    rotation = @rot,
                    destinationZoneId = @destZone,
                    destinationSpawnType = @destSpawn,
                    currentZoneId = @zoneId,
                    currentPrivateArea = @privateArea,
                    currentPrivateAreaType = @privateAreaType
                    WHERE id = @charaId
                    ";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", player.actorId);
                    cmd.Parameters.AddParam("@x", player.positionX);
                    cmd.Parameters.AddParam("@y", player.positionY);
                    cmd.Parameters.AddParam("@z", player.positionZ);
                    cmd.Parameters.AddParam("@rot", player.rotation);
                    cmd.Parameters.AddParam("@zoneId", player.zoneId);
                    cmd.Parameters.AddParam("@privateArea", player.privateArea);
                    cmd.Parameters.AddParam("@privateAreaType", player.privateAreaType);
                    cmd.Parameters.AddParam("@destZone", player.destinationZone);
                    cmd.Parameters.AddParam("@destSpawn", player.destinationSpawnType);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void SavePlayerPlayTime(Player player)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    query = @"
                    UPDATE characters SET 
                    playTime = @playtime
                    WHERE id = @charaId
                    ";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", player.actorId);
                    cmd.Parameters.AddParam("@playtime", player.GetPlayTime(true));

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void SavePlayerHomePoints(Player player)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    query = @"
                    UPDATE characters SET 
                    homepoint = @homepoint,
                    homepointInn = @homepointInn
                    WHERE id = @charaId
                    ";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", player.actorId);
                    cmd.Parameters.AddParam("@homepoint", player.homepoint);
                    cmd.Parameters.AddParam("@homepointInn", player.homepointInn);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void SaveQuest(Player player, Quest quest)
        {
            int slot = player.GetQuestSlot(quest.actorId);
            if (slot == -1)
            {
                Log.Error("Tried saving quest player didn't have: Player: {0:x}, QuestId: {0:x}", player.actorId, quest.actorId);
                return;
            }
            else
                SaveQuest(player, quest, slot);
        }

        public static void SaveQuest(Player player, Quest quest, int slot)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    // LANG-ADAPT: MySQL `ON DUPLICATE KEY` → Postgres `ON CONFLICT (pk) DO UPDATE`.
                    // PK = (characterid, slot).
                    query = @"
                    INSERT INTO characters_quest_scenario
                    (characterId, slot, questId, currentPhase, questData, questFlags)
                    VALUES
                    (@charaId, @slot, @questId, @phase, @questData, @questFlags)
                    ON CONFLICT (characterId, slot) DO UPDATE SET
                    questId = EXCLUDED.questId, currentPhase = EXCLUDED.currentPhase, questData = EXCLUDED.questData, questFlags = EXCLUDED.questFlags
                    ";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", player.actorId);
                    cmd.Parameters.AddParam("@slot", slot);
                    cmd.Parameters.AddParam("@questId", 0xFFFFF & quest.actorId);
                    cmd.Parameters.AddParam("@phase", quest.GetPhase());
                    cmd.Parameters.AddParam("@questData", quest.GetSerializedQuestData());
                    cmd.Parameters.AddParam("@questFlags", quest.GetQuestFlags());

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void MarkGuildleve(Player player, uint glId, bool isAbandoned, bool isCompleted)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    query = @"
                    UPDATE characters_quest_guildleve_regional
                    SET abandoned = @abandoned, completed = @completed
                    WHERE characterId = @charaId and guildleveId = @guildleveId
                    ";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", player.actorId);
                    cmd.Parameters.AddParam("@guildleveId", glId);
                    cmd.Parameters.AddParam("@abandoned", isAbandoned);
                    cmd.Parameters.AddParam("@completed", isCompleted);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void SaveGuildleve(Player player, uint glId, int slot)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    // LANG-ADAPT: PM `ON DUPLICATE KEY` apuntaba a PK=id (auto-gen), nunca disparaba.
                    // Era código defensivo muerto → INSERT plain (PM-faithful behaviorally).
                    query = @"
                    INSERT INTO characters_quest_guildleve_regional
                    (characterId, slot, guildleveId, abandoned, completed)
                    VALUES
                    (@charaId, @slot, @guildleveId, @abandoned, @completed)
                    ";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", player.actorId);
                    cmd.Parameters.AddParam("@slot", slot);
                    cmd.Parameters.AddParam("@guildleveId", glId);
                    cmd.Parameters.AddParam("@abandoned", 0);
                    cmd.Parameters.AddParam("@completed", 0);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void RemoveGuildleve(Player player, uint glId)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    query = @"
                    DELETE FROM characters_quest_guildleve_regional 
                    WHERE characterId = @charaId and guildleveId = @guildleveId                 
                    ";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", player.actorId);
                    cmd.Parameters.AddParam("@guildleveId", glId);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void RemoveQuest(Player player, uint questId)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    query = @"
                    DELETE FROM characters_quest_scenario 
                    WHERE characterId = @charaId and questId = @questId                 
                    ";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", player.actorId);
                    cmd.Parameters.AddParam("@questId", 0xFFFFF & questId);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void CompleteQuest(Player player, uint questId)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    // LANG-ADAPT: PM `ON DUPLICATE KEY UPDATE characterId=characterId` = INSERT IGNORE
                    // idiom MySQL (silently skip duplicates). Postgres: `ON CONFLICT DO NOTHING`.
                    // PK = id (auto) → necesitamos chequear unique antes; en PM al no haber unique constraint
                    // este patrón es dead code, comportamiento real = plain INSERT.
                    query = @"
                    INSERT INTO characters_quest_completed
                    (characterId, questId)
                    VALUES
                    (@charaId, @questId)
                    ";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", player.actorId);
                    cmd.Parameters.AddParam("@questId", 0xFFFFF & questId);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static bool IsQuestCompleted(Player player, uint questId)
        {
            bool isCompleted = false;
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand("SELECT * FROM characters_quest_completed WHERE characterId = @charaId and questId = @questId", conn);
                    cmd.Parameters.AddParam("@charaId", player.actorId);
                    cmd.Parameters.AddParam("@questId", questId);
                    isCompleted = cmd.ExecuteScalar() != null;
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
            return isCompleted;
        }

        public static void LoadPlayerCharacter(Player player)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    //Load basic info                  
                    query = @"
                    SELECT 
                    name,            
                    positionX,
                    positionY,
                    positionZ,
                    rotation,
                    actorState,
                    currentZoneId,             
                    gcCurrent,
                    gcLimsaRank,
                    gcGridaniaRank,
                    gcUldahRank,
                    currentTitle,
                    guardian,
                    birthDay,
                    birthMonth,
                    initialTown,
                    tribe,
                    restBonus,
                    achievementPoints,
                    playTime,
                    destinationZoneId,
                    destinationSpawnType,
                    currentPrivateArea,
                    currentPrivateAreaType,
                    homepoint,
                    homepointInn
                    FROM characters WHERE id = @charId";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            player.displayNameId = 0xFFFFFFFF;
                            player.customDisplayName = reader.GetString(0);
                            player.oldPositionX = player.positionX = reader.GetFloat(1);
                            player.oldPositionY = player.positionY = reader.GetFloat(2);
                            player.oldPositionZ = player.positionZ = reader.GetFloat(3);
                            player.oldRotation = player.rotation = reader.GetFloat(4);
                            player.currentMainState = reader.GetUInt16(5);
                            player.zoneId = reader.GetUInt32(6);
                            player.isZoning = true;
                            player.gcCurrent = reader.GetByteAt(7);
                            player.gcRankLimsa = reader.GetByteAt(8);
                            player.gcRankGridania = reader.GetByteAt(9);
                            player.gcRankUldah = reader.GetByteAt(10);
                            player.currentTitle = reader.GetUInt32(11);
                            player.playerWork.guardian = reader.GetByteAt(12);
                            player.playerWork.birthdayDay = reader.GetByteAt(13);
                            player.playerWork.birthdayMonth = reader.GetByteAt(14);
                            player.playerWork.initialTown = reader.GetByteAt(15);
                            player.playerWork.tribe = reader.GetByteAt(16);
                            player.playerWork.restBonusExpRate = reader.GetInt32At(17);
                            player.achievementPoints = reader.GetUInt32(18);
                            player.playTime = reader.GetUInt32(19);
                            player.homepoint = reader.GetUInt32("homepoint");
                            player.homepointInn = reader.GetByte("homepointInn");
                            player.destinationZone = reader.GetUInt32("destinationZoneId");
                            player.destinationSpawnType = reader.GetByte("destinationSpawnType");

                            if (!reader.IsDBNull(reader.GetOrdinal("currentPrivateArea")))
                                player.privateArea = reader.GetString("currentPrivateArea");
                            player.privateAreaType = reader.GetUInt32("currentPrivateAreaType");

                            if (player.destinationZone != 0)
                                player.zoneId = player.destinationZone;

                            if (player.privateArea != null && !player.privateArea.Equals(""))
                                player.zone = Server.GetWorldManager().GetPrivateArea(player.zoneId, player.privateArea, player.privateAreaType);
                            else
                                player.zone = Server.GetWorldManager().GetZone(player.zoneId);
                        }
                    }

                    //Get class levels
                    query = @"
                        SELECT 
                        pug,
                        gla,
                        mrd,
                        arc,
                        lnc,

                        thm,
                        cnj,

                        crp,
                        bsm,
                        arm,
                        gsm,
                        ltw,
                        wvr,
                        alc,
                        cul,

                        min,
                        btn,
                        fsh
                        FROM characters_class_levels WHERE characterId = @charId";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            player.charaWork.battleSave.skillLevel[Player.CLASSID_PUG - 1] = reader.GetInt16("pug");
                            player.charaWork.battleSave.skillLevel[Player.CLASSID_GLA - 1] = reader.GetInt16("gla");
                            player.charaWork.battleSave.skillLevel[Player.CLASSID_MRD - 1] = reader.GetInt16("mrd");
                            player.charaWork.battleSave.skillLevel[Player.CLASSID_ARC - 1] = reader.GetInt16("arc");
                            player.charaWork.battleSave.skillLevel[Player.CLASSID_LNC - 1] = reader.GetInt16("lnc");

                            player.charaWork.battleSave.skillLevel[Player.CLASSID_THM - 1] = reader.GetInt16("thm");
                            player.charaWork.battleSave.skillLevel[Player.CLASSID_CNJ - 1] = reader.GetInt16("cnj");

                            player.charaWork.battleSave.skillLevel[Player.CLASSID_CRP - 1] = reader.GetInt16("crp");
                            player.charaWork.battleSave.skillLevel[Player.CLASSID_BSM - 1] = reader.GetInt16("bsm");
                            player.charaWork.battleSave.skillLevel[Player.CLASSID_ARM - 1] = reader.GetInt16("arm");
                            player.charaWork.battleSave.skillLevel[Player.CLASSID_GSM - 1] = reader.GetInt16("gsm");
                            player.charaWork.battleSave.skillLevel[Player.CLASSID_LTW - 1] = reader.GetInt16("ltw");
                            player.charaWork.battleSave.skillLevel[Player.CLASSID_WVR - 1] = reader.GetInt16("wvr");
                            player.charaWork.battleSave.skillLevel[Player.CLASSID_ALC - 1] = reader.GetInt16("alc");
                            player.charaWork.battleSave.skillLevel[Player.CLASSID_CUL - 1] = reader.GetInt16("cul");

                            player.charaWork.battleSave.skillLevel[Player.CLASSID_MIN - 1] = reader.GetInt16("min");
                            player.charaWork.battleSave.skillLevel[Player.CLASSID_BTN - 1] = reader.GetInt16("btn");
                            player.charaWork.battleSave.skillLevel[Player.CLASSID_FSH - 1] = reader.GetInt16("fsh");
                        }
                    }

                    //Get class experience
                    query = @"
                        SELECT 
                        pug,
                        gla,
                        mrd,
                        arc,
                        lnc,

                        thm,
                        cnj,

                        crp,
                        bsm,
                        arm,
                        gsm,
                        ltw,
                        wvr,
                        alc,
                        cul,

                        min,
                        btn,
                        fsh
                        FROM characters_class_exp WHERE characterId = @charId";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_PUG - 1] = reader.GetInt32("pug");
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_GLA - 1] = reader.GetInt32("gla");
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_MRD - 1] = reader.GetInt32("mrd");
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_ARC - 1] = reader.GetInt32("arc");
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_LNC - 1] = reader.GetInt32("lnc");
                            
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_THM - 1] = reader.GetInt32("thm");
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_CNJ - 1] = reader.GetInt32("cnj");
                            
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_CRP - 1] = reader.GetInt32("crp");
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_BSM - 1] = reader.GetInt32("bsm");
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_ARM - 1] = reader.GetInt32("arm");
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_GSM - 1] = reader.GetInt32("gsm");
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_LTW - 1] = reader.GetInt32("ltw");
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_WVR - 1] = reader.GetInt32("wvr");
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_ALC - 1] = reader.GetInt32("alc");
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_CUL - 1] = reader.GetInt32("cul");
                            
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_MIN - 1] = reader.GetInt32("min");
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_BTN - 1] = reader.GetInt32("btn");
                            player.charaWork.battleSave.skillPoint[Player.CLASSID_FSH - 1] = reader.GetInt32("fsh");
                        }
                    }

                    //Load Saved Parameters
                    query = @"
                        SELECT 
                        hp,
                        hpMax,
                        mp,
                        mpMax,
                        mainSkill
                        FROM characters_parametersave WHERE characterId = @charId";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            player.charaWork.parameterSave.hp[0] = reader.GetInt16At(0);
                            player.charaWork.parameterSave.hpMax[0] = reader.GetInt16At(1);
                            player.charaWork.parameterSave.mp = reader.GetInt16At(2);
                            player.charaWork.parameterSave.mpMax = reader.GetInt16At(3);

                            player.charaWork.parameterSave.state_mainSkill[0] = reader.GetByteAt(4);
                            player.charaWork.parameterSave.state_mainSkillLevel = player.charaWork.battleSave.skillLevel[reader.GetByteAt(4) - 1];
                        }
                    }

                    //Load appearance
                    query = @"
                        SELECT 
                        baseId,                       
                        size,
                        voice,
                        skinColor,
                        hairStyle,
                        hairColor,
                        hairHighlightColor,
                        hairVariation,
                        eyeColor,
                        characteristics,
                        characteristicsColor,
                        faceType,
                        ears,
                        faceMouth,
                        faceFeatures,
                        faceNose,
                        faceEyeShape,
                        faceIrisSize,
                        faceEyebrows,
                        mainHand,
                        offHand,
                        head,
                        body,
                        legs,
                        hands,
                        feet,
                        waist,
                        neck,
                        leftFinger,
                        rightFinger,
                        leftEar,
                        rightEar
                        FROM characters_appearance WHERE characterId = @charId";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            if (reader.GetUInt32("baseId") == 0xFFFFFFFF)
                                player.modelId = CharacterUtils.GetTribeModel(player.playerWork.tribe);
                            else
                                player.modelId = reader.GetUInt32("baseId");
                            player.appearanceIds[Character.SIZE] = reader.GetByte("size");
                            player.appearanceIds[Character.COLORINFO] = (uint)(reader.GetUInt16("skinColor") | (reader.GetUInt16("hairColor") << 10) | (reader.GetUInt16("eyeColor") << 20));
                            player.appearanceIds[Character.FACEINFO] = PrimitiveConversion.ToUInt32(CharacterUtils.GetFaceInfo(
                                reader.GetByte("characteristics"),
                                reader.GetByte("characteristicsColor"),
                                reader.GetByte("faceType"),
                                reader.GetByte("ears"),
                                reader.GetByte("faceMouth"),
                                reader.GetByte("faceFeatures"),
                                reader.GetByte("faceNose"),
                                reader.GetByte("faceEyeShape"),
                                reader.GetByte("faceIrisSize"),
                                reader.GetByte("faceEyebrows")));
                            player.appearanceIds[Character.HIGHLIGHT_HAIR] = (uint)(reader.GetUInt16("hairHighlightColor") | reader.GetUInt32("hairVariation") << 5 | reader.GetUInt32("hairStyle") << 10);
                            player.appearanceIds[Character.VOICE] = reader.GetByte("voice");
                            player.appearanceIds[Character.MAINHAND] = reader.GetUInt32("mainHand");
                            player.appearanceIds[Character.OFFHAND] = reader.GetUInt32("offHand");
                            player.appearanceIds[Character.HEADGEAR] = reader.GetUInt32("head");
                            player.appearanceIds[Character.BODYGEAR] = reader.GetUInt32("body");
                            player.appearanceIds[Character.LEGSGEAR] = reader.GetUInt32("legs");
                            player.appearanceIds[Character.HANDSGEAR] = reader.GetUInt32("hands");
                            player.appearanceIds[Character.FEETGEAR] = reader.GetUInt32("feet");
                            player.appearanceIds[Character.WAISTGEAR] = reader.GetUInt32("waist");
                            player.appearanceIds[Character.HEADGEAR] = reader.GetUInt32("head");
                            player.appearanceIds[Character.NECKGEAR] = reader.GetUInt32("neck");
                            player.appearanceIds[Character.R_EAR] = reader.GetUInt32("rightEar");
                            player.appearanceIds[Character.L_EAR] = reader.GetUInt32("leftEar");
                            player.appearanceIds[Character.R_RINGFINGER] = reader.GetUInt32("rightFinger");
                            player.appearanceIds[Character.L_RINGFINGER] = reader.GetUInt32("leftFinger");
                        }

                    }

                    //Load Status Effects
                    query = @"
                        SELECT 
                        statusId,
                        duration,
                        magnitude,
                        tick,
                        tier,
                        extra
                        FROM characters_statuseffect WHERE characterId = @charId";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var id = reader.GetUInt32("statusId");
                            var duration = reader.GetUInt32("duration");
                            var magnitude = reader.GetUInt64("magnitude");
                            var tick = reader.GetUInt32("tick");
                            var tier = reader.GetByte("tier");
                            var extra = reader.GetUInt64("extra");

                            var effect = Server.GetWorldManager().GetStatusEffect(id);
                            if (effect != null)
                            {
                                effect.SetDuration(duration);
                                effect.SetMagnitude(magnitude);
                                effect.SetTickMs(tick);
                                effect.SetTier(tier);
                                effect.SetExtra(extra);

                                // dont wanna send ton of messages on login (i assume retail doesnt)
                                player.statusEffects.AddStatusEffect(effect, null);
                            }
                        }
                    }

                    //Load Chocobo
                    query = @"
                        SELECT 
                        hasChocobo,
                        hasGoobbue,
                        chocoboAppearance,
                        chocoboName                             
                        FROM characters_chocobo WHERE characterId = @charId";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            player.hasChocobo = reader.GetBoolean(0);
                            player.hasGoobbue = reader.GetBoolean(1);
                            player.chocoboAppearance = reader.GetByteAt(2);
                            player.chocoboName = reader.GetString(3);
                        }
                    }

                    //Load Timers
                    query = @"
                        SELECT 
                        thousandmaws,
                        dzemaeldarkhold,
                        bowlofembers_hard,                
                        bowlofembers,
                        thornmarch,
                        aurumvale,
                        cutterscry,
                        battle_aleport,
                        battle_hyrstmill,
                        battle_goldenbazaar,
                        howlingeye_hard,
                        howlingeye,
                        castrumnovum,
                        bowlofembers_extreme,
                        rivenroad,
                        rivenroad_hard,
                        behests,
                        companybehests,
                        returntimer,
                        skirmish
                        FROM characters_timers WHERE characterId = @charId";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            for (int i = 0; i < player.timers.Length; i++)
                                player.timers[i] = reader.GetUInt32(i);
                        }
                    }

                    //Load Hotbar
                    LoadHotbar(player);

                    //Load Scenario Quests
                    query = @"
                        SELECT 
                        slot,
                        questId,
                        questData,
                        questFlags,
                        currentPhase
                        FROM characters_quest_scenario WHERE characterId = @charId";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int index = reader.GetUInt16(0);
                            player.playerWork.questScenario[index] = 0xA0F00000 | reader.GetUInt32(1);
                            string questData = null;
                            uint questFlags = 0;
                            uint currentPhase = 0;

                            if (!reader.IsDBNull(2))
                                questData = reader.GetString(2);
                            else
                                questData = "{}";

                            if (!reader.IsDBNull(3))
                                questFlags = reader.GetUInt32(3);
                            else
                                questFlags = 0;

                            if (!reader.IsDBNull(4))
                                currentPhase = reader.GetUInt32(4);

                            string questName = Server.GetStaticActors(player.playerWork.questScenario[index]).actorName;
                            player.questScenario[index] = new Quest(player, player.playerWork.questScenario[index], questName, questData, questFlags, currentPhase);
                        }
                    }

                    //Load Local Guildleves
                    query = @"
                        SELECT 
                        slot,
                        questId,
                        abandoned,
                        completed  
                        FROM characters_quest_guildleve_local WHERE characterId = @charId";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int index = reader.GetUInt16(0);
                            player.playerWork.questGuildleve[index] = 0xA0F00000 | reader.GetUInt32(1);
                        }
                    }

                    //Load Regional Guildleve Quests
                    query = @"
                        SELECT 
                        slot,
                        guildleveId,
                        abandoned,
                        completed  
                        FROM characters_quest_guildleve_regional WHERE characterId = @charId";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int index = reader.GetUInt16(0);
                            player.work.guildleveId[index] = reader.GetUInt16(1);
                            player.work.guildleveDone[index] = reader.GetBoolean(2);
                            player.work.guildleveChecked[index] = reader.GetBoolean(3);
                        }
                    }

                    //Load NPC Linkshell
                    query = @"
                        SELECT 
                        npcLinkshellId,
                        isCalling,
                        isExtra  
                        FROM characters_npclinkshell WHERE characterId = @charId";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int npcLSId = reader.GetUInt16(0);
                            player.playerWork.npcLinkshellChatCalling[npcLSId] = reader.GetBoolean(1);
                            player.playerWork.npcLinkshellChatExtra[npcLSId] = reader.GetBoolean(2);
                        }
                    }

                    player.GetItemPackage(ItemPackage.NORMAL).InitList(GetItemPackage(player, 0, ItemPackage.NORMAL));
                    player.GetItemPackage(ItemPackage.KEYITEMS).InitList(GetItemPackage(player, 0, ItemPackage.KEYITEMS));
                    player.GetItemPackage(ItemPackage.CURRENCY_CRYSTALS).InitList(GetItemPackage(player, 0, ItemPackage.CURRENCY_CRYSTALS));
                    player.GetItemPackage(ItemPackage.BAZAAR).InitList(GetItemPackage(player, 0, ItemPackage.BAZAAR));
                    player.GetItemPackage(ItemPackage.MELDREQUEST).InitList(GetItemPackage(player, 0, ItemPackage.MELDREQUEST));
                    player.GetItemPackage(ItemPackage.LOOT).InitList(GetItemPackage(player, 0, ItemPackage.LOOT));

                    player.GetEquipment().SetList(GetEquipment(player, player.charaWork.parameterSave.state_mainSkill[0]));
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }

        }

        public static InventoryItem[] GetEquipment(Player player, ushort classId)
        {
            InventoryItem[] equipment = new InventoryItem[player.GetEquipment().GetCapacity()];
            
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    SELECT
                                    equipSlot,
                                    itemId
                                    FROM characters_inventory_equipment                                    
                                    WHERE characterId = @charId AND (classId = @classId OR classId = 0) ORDER BY equipSlot";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    cmd.Parameters.AddParam("@classId", classId);

                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ushort equipSlot = reader.GetUInt16(0);
                            ulong uniqueItemId = reader.GetUInt16(1);
                            InventoryItem item = player.GetItemPackage(ItemPackage.NORMAL).GetItemByUniqueId(uniqueItemId);
                            equipment[equipSlot] = item;
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }

            return equipment;
        }

        public static void EquipItem(Player player, ushort equipSlot, ulong uniqueItemId)
        {

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    // LANG-ADAPT: ON DUPLICATE KEY → ON CONFLICT. PK = (characterId, classId, equipSlot).
                    string query = @"
                                    INSERT INTO characters_inventory_equipment
                                    (characterId, classId, equipSlot, itemId)
                                    VALUES
                                    (@characterId, @classId, @equipSlot, @uniqueItemId)
                                    ON CONFLICT (characterId, classId, equipSlot) DO UPDATE SET itemId = EXCLUDED.itemId;
                                    ";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@characterId", player.actorId);
                    cmd.Parameters.AddParam("@classId", (equipSlot == Player.SLOT_UNDERSHIRT || equipSlot == Player.SLOT_UNDERGARMENT) ? 0 : player.charaWork.parameterSave.state_mainSkill[0]);
                    cmd.Parameters.AddParam("@equipSlot", equipSlot);
                    cmd.Parameters.AddParam("@uniqueItemId", uniqueItemId);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }

        }

        public static void UnequipItem(Player player, ushort equipSlot)
        {

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    DELETE FROM characters_inventory_equipment                                    
                                    WHERE characterId = @characterId AND classId = @classId AND equipSlot = @equipSlot;
                                    ";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@characterId", player.actorId);
                    cmd.Parameters.AddParam("@classId", player.charaWork.parameterSave.state_mainSkill[0]);
                    cmd.Parameters.AddParam("@equipSlot", equipSlot);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }

        }
        public static void EquipAbility(Player player, byte classId, ushort hotbarSlot, uint commandId, uint recastTime)
        {
            commandId &= 0xFFFF;
            if (commandId > 0)
            {
                using (NpgsqlConnection conn = new NpgsqlConnection(
                    String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}",
                    ConfigConstants.DATABASE_HOST,
                    ConfigConstants.DATABASE_PORT,
                    ConfigConstants.DATABASE_NAME,
                    ConfigConstants.DATABASE_USERNAME,
                    ConfigConstants.DATABASE_PASSWORD)))
                {
                    try
                    {
                        conn.Open();
                        NpgsqlCommand cmd;
                        // LANG-ADAPT: ON DUPLICATE KEY → ON CONFLICT. PK = (characterId, classId, hotbarSlot).
                        string query = @"
                                    INSERT INTO characters_hotbar
                                    (characterId, classId, hotbarSlot, commandId, recastTime)
                                    VALUES
                                    (@charId, @classId, @hotbarSlot, @commandId, @recastTime)
                                    ON CONFLICT (characterId, classId, hotbarSlot) DO UPDATE SET commandId = EXCLUDED.commandId, recastTime = EXCLUDED.recastTime;
                        ";

                        cmd = new NpgsqlCommand(query, conn);
                        cmd.Parameters.AddParam("@charId", player.actorId);
                        cmd.Parameters.AddParam("@classId", classId);
                        cmd.Parameters.AddParam("@commandId", commandId);
                        cmd.Parameters.AddParam("@hotbarSlot", hotbarSlot);
                        cmd.Parameters.AddParam("@recastTime", recastTime);
                        cmd.ExecuteNonQuery();
                    }
                    catch (NpgsqlException e)
                    {
                        Log.Error(e.ToString());
                    }
                    finally
                    {
                        conn.Dispose();
                    }
                }
            }
            else
                UnequipAbility(player, hotbarSlot);
        }

        //Unequipping is done by sending an equip packet with 0xA0F00000 as the ability and the hotbar slot of the action being unequipped
        public static void UnequipAbility(Player player, ushort hotbarSlot)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(
                    String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}",
                    ConfigConstants.DATABASE_HOST,
                    ConfigConstants.DATABASE_PORT,
                    ConfigConstants.DATABASE_NAME,
                    ConfigConstants.DATABASE_USERNAME,
                    ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd;
                    string query = "";
                    
                    query = @"
                                DELETE FROM characters_hotbar
                                WHERE characterId = @charId AND classId = @classId AND hotbarSlot = @hotbarSlot
                        ";
                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    cmd.Parameters.AddParam("@classId", player.charaWork.parameterSave.state_mainSkill[0]);
                    cmd.Parameters.AddParam("@hotbarSlot", hotbarSlot);
                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }

        }

        public static void LoadHotbar(Player player)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    //Load Hotbar
                    query = @"
                        SELECT 
                        hotbarSlot,
                        commandId,
                        recastTime
                        FROM characters_hotbar WHERE characterId = @charId AND classId = @classId
                        ORDER BY hotbarSlot";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    cmd.Parameters.AddParam("@classId", player.GetCurrentClassOrJob());

                    player.charaWork.commandBorder = 32;

                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int hotbarSlot = reader.GetUInt16("hotbarSlot");
                            uint commandId = reader.GetUInt32("commandId");
                            player.charaWork.command[hotbarSlot + player.charaWork.commandBorder] = 0xA0F00000 | commandId;
                            player.charaWork.commandCategory[hotbarSlot + player.charaWork.commandBorder] = 1;
                            player.charaWork.parameterSave.commandSlot_recastTime[hotbarSlot] = reader.GetUInt32("recastTime");

                            //Recast timer
                            BattleCommand ability = Server.GetWorldManager().GetBattleCommand((ushort)(commandId));
                            player.charaWork.parameterTemp.maxCommandRecastTime[hotbarSlot] = (ushort) (ability != null ? ability.maxRecastTimeSeconds : 1);
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static ushort FindFirstCommandSlot(Player player, byte classId)
        {
            ushort slot = 0;
            using (NpgsqlConnection conn = new NpgsqlConnection(
                String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}",
                ConfigConstants.DATABASE_HOST,
                ConfigConstants.DATABASE_PORT,
                ConfigConstants.DATABASE_NAME,
                ConfigConstants.DATABASE_USERNAME,
                ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd;
                    string query = "";

                    //Drop
                    List<Tuple<ushort, uint>> hotbarList = new List<Tuple<ushort, uint>>();
                    query = @"
                        SELECT hotbarSlot
                        FROM characters_hotbar
                        WHERE characterId = @charId AND classId = @classId
                        ORDER BY hotbarSlot
                        ";
                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    cmd.Parameters.AddParam("@classId", classId);
                   
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            if (slot != reader.GetUInt16("hotbarSlot"))
                                break;

                            slot++;
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
            return slot;
        }

        public static List<InventoryItem> GetItemPackage(Character owner, uint slotOffset, uint type)
        {
            List<InventoryItem> items = new List<InventoryItem>();

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    SELECT
                                    serverItemId,
                                    itemId,
                                    server_items_modifiers.id AS modifierId,
                                    quantity,
                                    quality,

                                    dealingValue,
                                    dealingMode,
                                    dealingAttached1,
                                    dealingAttached2,
                                    dealingAttached3,
                                    dealingTag,
                                    bazaarMode,

                                    durability,
                                    mainQuality,
                                    subQuality1,
                                    subQuality2,
                                    subQuality3,
                                    param1,
                                    param2,
                                    param3,
                                    spiritbind,
                                    materia1,
                                    materia2,
                                    materia3,
                                    materia4,
                                    materia5

                                    FROM characters_inventory
                                    INNER JOIN server_items ON serverItemId = server_items.id
                                    LEFT JOIN server_items_modifiers ON server_items.id = server_items_modifiers.id
                                    LEFT JOIN server_items_dealing ON server_items.id = server_items_dealing.id
                                    WHERE characterId = @charId AND itemPackage = @type
                                    ORDER BY slot ASC";                                    

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", owner.actorId);
                    cmd.Parameters.AddParam("@type", type);

                    ushort slot = 0;
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {                           
                            InventoryItem item = new InventoryItem(reader);
                            items.Add(item);
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }

            return items;
        }       

        public static InventoryItem CreateItem(InventoryItem item, uint quantity)
        {
            return CreateItem(item.itemId, (int) quantity, item.quality, item.modifiers);
        }

        public static InventoryItem CreateItem(uint itemId, int quantity, byte quality, InventoryItem.ItemModifier modifiers = null)
        {
            InventoryItem insertedItem = null;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();



                    // LANG-ADAPT: PM `INSERT ...` + `cmd.LastInsertedId` (MySQL auto_increment) →
                    // Postgres `INSERT ... RETURNING id` + `ExecuteScalar`. Comportamiento idéntico.
                    string query = @"
                                    INSERT INTO server_items
                                    (itemId, quantity, quality)
                                    VALUES
                                    (@itemId, @quantity, @quality)
                                    RETURNING id;
                                    ";

                    string query2 = @"
                                    INSERT INTO server_items_modifiers
                                    (id, durability)
                                    VALUES
                                    (@id, @durability);
                                    ";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@itemId", itemId);
                    cmd.Parameters.AddParam("@quantity", quantity);
                    cmd.Parameters.AddParam("@quality", quality);
                    // LANG-ADAPT: Postgres devuelve bigint (Int64) para int unsigned columns.
                    var newId = (uint)(long)cmd.ExecuteScalar()!;

                    insertedItem = new InventoryItem(newId, itemId, quantity, quality, modifiers);

                    if (modifiers != null)
                    {
                        NpgsqlCommand cmd2 = new NpgsqlCommand(query2, conn);
                        cmd2.Parameters.AddParam("@id", insertedItem.uniqueId);
                        cmd2.Parameters.AddParam("@durability", modifiers.durability);
                        cmd2.ExecuteNonQuery();
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }

            return insertedItem;
        }

        public static void AddItem(Character owner, InventoryItem addedItem, ushort itemPackage, ushort slot)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    INSERT INTO characters_inventory
                                    (characterId, itemPackage, serverItemId, slot)
                                    VALUES
                                    (@charId, @itemPackage, @serverItemId, @slot)                                    
                                    ";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);

                    cmd.Parameters.AddParam("@serverItemId", addedItem.uniqueId);
                    cmd.Parameters.AddParam("@charId", owner.actorId);
                    cmd.Parameters.AddParam("@itemPackage", itemPackage);
                    cmd.Parameters.AddParam("@slot", slot);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void RemoveItem(Character owner, ulong serverItemId)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}; Allow User Variables=True", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    DELETE FROM characters_inventory
                                    WHERE characterId = @charId and serverItemId = @serverItemId;
                                    ";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", owner.actorId);
                    cmd.Parameters.AddParam("@serverItemId", serverItemId);
                    cmd.ExecuteNonQuery();

                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void UpdateItemPositions(List<InventoryItem> updated)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    UPDATE characters_inventory
                                    SET slot = @slot
                                    WHERE serverItemId = @serverItemId;
                                    ";

                    using (NpgsqlTransaction trans = conn.BeginTransaction())
                    {
                        using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn, trans))
                        {
                            foreach (InventoryItem item in updated)
                            {
                                cmd.Parameters.Clear();
                                cmd.Parameters.AddParam("@serverItemId", item.uniqueId);
                                cmd.Parameters.AddParam("@slot", item.slot);
                                cmd.ExecuteNonQuery();
                            }

                            trans.Commit();
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }

        }

        public static void SetQuantity(ulong serverItemId, int quantity)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    UPDATE server_items
                                    SET quantity = @quantity
                                    WHERE id = @serverItemId;
                                    ";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@serverItemId", serverItemId);
                    cmd.Parameters.AddParam("@quantity", quantity);
                    cmd.ExecuteNonQuery();

                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }

        }

        public static void SetDealingInfo(InventoryItem item)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    REPLACE INTO server_items_dealing
                                    (id, dealingValue, dealingMode, dealingAttached1, dealingAttached2, dealingAttached3, dealingTag, bazaarMode)
                                    VALUES 
                                    (@serverItemId, @dealingValue, @dealingMode, @dealingAttached1, @dealingAttached2, @dealingAttached3, @dealingTag, @bazaarMode);                                  
                                    ";
                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    item.SaveDealingInfo(cmd);
                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void ClearDealingInfo(InventoryItem item)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    DELETE FROM 
                                    server_items_dealing  
                                    WHERE 
                                    id = @serverItemId;
                                    ";
                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@serverItemId", item.uniqueId);
                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }
       
        public static SubPacket GetLatestAchievements(Player player)
        {
            uint[] latestAchievements = new uint[5];
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    //Load Last 5 Completed
                    string query = @"
                                    SELECT 
                                    characters_achievements.achievementId FROM characters_achievements 
                                    INNER JOIN gamedata_achievements ON characters_achievements.achievementId = gamedata_achievements.achievementId
                                    WHERE characterId = @charId AND rewardPoints <> 0 AND timeDone IS NOT NULL ORDER BY timeDone LIMIT 5";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        int count = 0;
                        while (reader.Read())
                        {
                            uint id = reader.GetUInt32(0);
                            latestAchievements[count++] = id;
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }

            return SetLatestAchievementsPacket.BuildPacket(player.actorId, latestAchievements);
        }

        public static SubPacket GetAchievementsPacket(Player player)
        {
            SetCompletedAchievementsPacket cheevosPacket = new SetCompletedAchievementsPacket();

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    SELECT packetOffsetId 
                                    FROM characters_achievements 
                                    INNER JOIN gamedata_achievements ON characters_achievements.achievementId = gamedata_achievements.achievementId
                                    WHERE characterId = @charId AND timeDone IS NOT NULL";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            uint offset = reader.GetUInt32(0);

                            if (offset < 0 || offset >= cheevosPacket.achievementFlags.Length)
                            {
                                Log.Error("SQL Error; achievement flag offset id out of range: " + offset);
                                continue;
                            }
                            cheevosPacket.achievementFlags[offset] = true;
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }

            return cheevosPacket.BuildPacket(player.actorId);
        }

        public static SubPacket GetAchievementProgress(Player player, uint achievementId)
        {
            uint progress = 0, progressFlags = 0;
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    SELECT progress, progressFlags 
                                    FROM characters_achievements 
                                    WHERE characterId = @charId AND achievementId = @achievementId";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", player.actorId);
                    cmd.Parameters.AddParam("@achievementId", achievementId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            progress = reader.GetUInt32(0);
                            progressFlags = reader.GetUInt32(1);
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
            return SendAchievementRatePacket.BuildPacket(player.actorId, achievementId, progress, progressFlags);
        }

        public static bool CreateLinkshell(Player player, string lsName, ushort lsCrest)
        {
            bool success = false;
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    INSERT INTO server_linkshells
                                    (name, master, crest)
                                    VALUES
                                    (@lsName, @master, @crest)
                                    ;
                                    ";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@lsName", lsName);
                    cmd.Parameters.AddParam("@master", player.actorId);
                    cmd.Parameters.AddParam("@crest", lsCrest);

                    cmd.ExecuteNonQuery();
                    success = true;
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
            return success;
        }


        public static void SaveNpcLS(Player player, uint npcLSId, bool isCalling, bool isExtra)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    // LANG-ADAPT: ON DUPLICATE KEY → ON CONFLICT. PK = (characterId, npcLinkshellId).
                    query = @"
                    INSERT INTO characters_npclinkshell
                    (characterId, npcLinkshellId, isCalling, isExtra)
                    VALUES
                    (@charaId, @lsId, @calling, @extra)
                    ON CONFLICT (characterId, npcLinkshellId) DO UPDATE SET
                    isCalling = EXCLUDED.isCalling, isExtra = EXCLUDED.isExtra
                    ";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", player.actorId);
                    cmd.Parameters.AddParam("@lsId", npcLSId);
                    cmd.Parameters.AddParam("@calling", isCalling ? 1 : 0);
                    cmd.Parameters.AddParam("@extra", isExtra ? 1 : 0);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static bool SaveSupportTicket(GMSupportTicketPacket gmTicket, string playerName)
        {
            string query;
            NpgsqlCommand cmd;
            bool wasError = false;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    query = @"
                    INSERT INTO supportdesk_tickets
                    (name, title, body, langCode)
                    VALUES
                    (@name, @title, @body, @langCode)";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@name", playerName);
                    cmd.Parameters.AddParam("@title", gmTicket.ticketTitle);
                    cmd.Parameters.AddParam("@body", gmTicket.ticketBody);
                    cmd.Parameters.AddParam("@langCode", gmTicket.langCode);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                    wasError = true;
                }
                finally
                {
                    conn.Dispose();
                }
            }

            return wasError;
        }

        public static bool isTicketOpen(string playerName)
        {
            bool isOpen = false;
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    SELECT
                                    isOpen
                                    FROM supportdesk_tickets
                                    WHERE name = @name
                                    ";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);

                    cmd.Parameters.AddParam("@name", playerName);

                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            isOpen = reader.GetBoolean(0);
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }

            return isOpen;
        }

        public static void closeTicket(string playerName)
        {
            bool isOpen = false;
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    UPDATE
                                    supportdesk_tickets
                                    SET isOpen = 0
                                    WHERE name = @name
                                    ";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@name", playerName);
                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static string[] getFAQNames(uint langCode = 1)
        {
            string[] faqs = null;
            List<string> raw = new List<string>();
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    SELECT
                                    title
                                    FROM supportdesk_faqs
                                    WHERE languageCode = @langCode
                                    ORDER BY slot
                                    ";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);

                    cmd.Parameters.AddParam("@langCode", langCode);

                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string label = reader.GetString(0);
                            raw.Add(label);
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                    faqs = raw.ToArray();
                }
            }
            return faqs;
        }

        public static string getFAQBody(uint slot, uint langCode = 1)
        {
            string body = string.Empty;
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    SELECT
                                    body
                                    FROM supportdesk_faqs
                                    WHERE slot=@slot and languageCode=@langCode";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@slot", slot);
                    cmd.Parameters.AddParam("@langCode", langCode);

                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            body = reader.GetString(0);
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
            return body;
        }

        public static string[] getIssues(uint lanCode = 1)
        {
            string[] issues = null;
            List<string> raw = new List<string>();
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    SELECT
                                    title
                                    FROM supportdesk_issues
                                    ORDER BY slot";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);

                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string label = reader.GetString(0);
                            raw.Add(label);
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                    issues = raw.ToArray();
                }
            }
            return issues;
        }

        public static void IssuePlayerChocobo(Player player, byte appearanceId, string name)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    // LANG-ADAPT: ON DUPLICATE KEY → ON CONFLICT. PK = characterId.
                    query = @"
                    INSERT INTO characters_chocobo
                    (characterId, hasChocobo, chocoboAppearance, chocoboName)
                    VALUES
                    (@characterId, @hasChocobo, @chocoboAppearance, @chocoboName)
                    ON CONFLICT (characterId) DO UPDATE SET
                    hasChocobo = EXCLUDED.hasChocobo, chocoboAppearance = EXCLUDED.chocoboAppearance, chocoboName = EXCLUDED.chocoboName";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@characterId", player.actorId);
                    cmd.Parameters.AddParam("@hasChocobo", 1);
                    cmd.Parameters.AddParam("@chocoboAppearance", appearanceId);
                    cmd.Parameters.AddParam("@chocoboName", name);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void ChangePlayerChocoboAppearance(Player player, byte appearanceId)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    query = @"
                    UPDATE characters_chocobo
                    SET
                    chocoboAppearance=@chocoboAppearance
                    WHERE
                    characterId = @characterId";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@characterId", player.actorId);
                    cmd.Parameters.AddParam("@chocoboAppearance", appearanceId);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }
        
        public static Dictionary<uint, StatusEffect> LoadGlobalStatusEffectList()
        {
            var effects = new Dictionary<uint, StatusEffect>();

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    var query = @"SELECT id, name, flags, overwrite, tickMs, hidden, silentOnGain, silentOnLoss, statusGainTextId, statusLossTextId FROM server_statuseffects;";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);

                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var id = reader.GetUInt32("id");
                            var name = reader.GetString("name");
                            var flags = reader.GetUInt32("flags");
                            var overwrite = reader.GetByte("overwrite");
                            var tickMs = reader.GetUInt32("tickMs");
                            var hidden = reader.GetBoolean("hidden");
                            var silentOnGain = reader.GetBoolean("silentOnGain");
                            var silentOnLoss = reader.GetBoolean("silentOnLoss");
                            var statusGainTextId = reader.GetUInt16("statusGainTextId");
                            var statusLossTextId = reader.GetUInt16("statusLossTextId");

                            var effect = new StatusEffect(id, name, flags, overwrite, tickMs, hidden, silentOnGain, silentOnLoss, statusGainTextId, statusLossTextId);

                            Lua.LuaEngine.LoadStatusEffectScript(effect);
                            effects.Add(id, effect);
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
            return effects;
        }

        public static void SavePlayerStatusEffects(Player player)
        {
            string[] faqs = null;
            List<string> raw = new List<string>();
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    using (NpgsqlTransaction trns = conn.BeginTransaction())
                    {
                        string query = @"
                                    REPLACE INTO characters_statuseffect
                                    (characterId, statusId, magnitude, duration, tick, tier, extra)
                                    VALUES
                                    (@actorId, @statusId, @magnitude, @duration, @tick, @tier, @extra)                                  
                                    ";
                        using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn, trns))
                        {    
                            foreach (var effect in player.statusEffects.GetStatusEffects())
                            {
                                var duration = MeteorReborn.Common.Utils.UnixTimeStampUTC(effect.GetEndTime()) - MeteorReborn.Common.Utils.UnixTimeStampUTC();

                                cmd.Parameters.AddParam("@actorId", player.actorId);
                                cmd.Parameters.AddParam("@statusId", effect.GetStatusEffectId());
                                cmd.Parameters.AddParam("@magnitude", effect.GetMagnitude());
                                cmd.Parameters.AddParam("@duration", duration);
                                cmd.Parameters.AddParam("@tick", effect.GetTickMs());
                                cmd.Parameters.AddParam("@tier", effect.GetTier());
                                cmd.Parameters.AddParam("@extra", effect.GetExtra());

                                cmd.ExecuteNonQuery();
                            }
                            trns.Commit();
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void LoadGlobalBattleCommandList(Dictionary<ushort, BattleCommand> battleCommandDict, Dictionary<Tuple<byte, short>, List<ushort>> battleCommandIdByLevel)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    int count = 0;
                    conn.Open();

                    // LANG-ADAPT: PM usaba backticks MySQL (`id`, `range`) para reserved-words.
                    // Postgres usa "..." para quoting; columnas en lowercase (post zz_lowercase_cols.sql)
                    // así que `id` no necesita quoting y `range` se mantiene unquoted (Postgres lo acepta).
                    var query = ("SELECT id, name, classJob, lvl, requirements, mainTarget, validTarget, aoeType, aoeRange, aoeMinRange, aoeConeAngle, aoeRotateAngle, aoeTarget, basePotency, numHits, positionBonus, procRequirement, range, minRange, rangeHeight, rangeWidth, statusId, statusDuration, statusChance, " +
                        "castType, castTime, recastTime, mpCost, tpCost, animationType, effectAnimation, modelAnimation, animationDuration, battleAnimation, validUser, comboId1, comboId2, comboStep, accuracyMod, worldMasterTextId, commandType, actionType, actionProperty FROM server_battle_commands;");

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);

                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var id = reader.GetUInt16("id");
                            var name = reader.GetString("name");
                            var battleCommand = new BattleCommand(id, name);

                            battleCommand.job = reader.GetByte("classJob");
                            battleCommand.level = reader.GetByte("lvl");
                            battleCommand.requirements = (BattleCommandRequirements)reader.GetUInt16("requirements");
                            battleCommand.mainTarget = (ValidTarget)reader.GetUInt16("mainTarget");
                            battleCommand.validTarget = (ValidTarget)reader.GetUInt16("validTarget");
                            battleCommand.aoeType = (TargetFindAOEType)reader.GetByte("aoeType");
                            battleCommand.basePotency = reader.GetUInt16("basePotency");
                            battleCommand.numHits = reader.GetByte("numHits");
                            battleCommand.positionBonus = (BattleCommandPositionBonus)reader.GetByte("positionBonus");
                            battleCommand.procRequirement = (BattleCommandProcRequirement)reader.GetByte("procRequirement");
                            battleCommand.range = reader.GetFloat("range");
                            battleCommand.minRange = reader.GetFloat("minRange");
                            battleCommand.rangeHeight = reader.GetInt32("rangeHeight");
                            battleCommand.rangeWidth = reader.GetInt32("rangeWidth");
                            battleCommand.statusId = reader.GetUInt32("statusId");
                            battleCommand.statusDuration = reader.GetUInt32("statusDuration");
                            battleCommand.statusChance = reader.GetFloat("statusChance");
                            battleCommand.castType = reader.GetByte("castType");
                            battleCommand.castTimeMs = reader.GetUInt32("castTime");
                            battleCommand.maxRecastTimeSeconds = reader.GetUInt32("recastTime");
                            battleCommand.recastTimeMs = battleCommand.maxRecastTimeSeconds * 1000;
                            battleCommand.mpCost = reader.GetInt16("mpCost");
                            battleCommand.tpCost = reader.GetInt16("tpCost");
                            battleCommand.animationType = reader.GetByte("animationType");
                            battleCommand.effectAnimation = reader.GetUInt16("effectAnimation");
                            battleCommand.modelAnimation = reader.GetUInt16("modelAnimation");
                            battleCommand.animationDurationSeconds = reader.GetUInt16("animationDuration");
                            battleCommand.aoeRange = reader.GetFloat("aoeRange");
                            battleCommand.aoeMinRange = reader.GetFloat("aoeMinRange");
                            battleCommand.aoeConeAngle = reader.GetFloat("aoeConeAngle");
                            battleCommand.aoeRotateAngle = reader.GetFloat("aoeRotateAngle");
                            battleCommand.aoeTarget = (TargetFindAOETarget)reader.GetByte("aoeTarget");

                            battleCommand.battleAnimation = reader.GetUInt32("battleAnimation");
                            battleCommand.validUser = (BattleCommandValidUser)reader.GetByte("validUser");

                            battleCommand.comboNextCommandId[0] = reader.GetInt32("comboId1");
                            battleCommand.comboNextCommandId[1] = reader.GetInt32("comboId2");
                            battleCommand.comboStep = reader.GetInt16("comboStep");
                            battleCommand.commandType = (CommandType) reader.GetInt16("commandType");
                            battleCommand.actionProperty = (ActionProperty)reader.GetInt16("actionProperty");
                            battleCommand.actionType = (ActionType)reader.GetInt16("actionType");
                            battleCommand.accuracyModifier = reader.GetFloat("accuracyMod");
                            battleCommand.worldMasterTextId = reader.GetUInt16("worldMasterTextId");

                            string folderName = "";

                            switch (battleCommand.commandType)
                            {
                                case CommandType.AutoAttack:
                                    folderName = "autoattack";
                                    break;
                                case CommandType.WeaponSkill:
                                    folderName = "weaponskill";
                                    break;
                                case CommandType.Ability:
                                    folderName = "ability";
                                    break;
                                case CommandType.Spell:
                                    folderName = "magic";
                                    break;
                            }

                            Lua.LuaEngine.LoadBattleCommandScript(battleCommand, folderName);
                            battleCommandDict.Add(id, battleCommand);

                            Tuple<byte, short> tuple = Tuple.Create<byte, short>(battleCommand.job, battleCommand.level);
                            if (battleCommandIdByLevel.ContainsKey(tuple))
                            {
                                battleCommandIdByLevel[tuple].Add(id);
                            }
                            else
                            {
                                List<ushort> list = new List<ushort>() { id };
                                battleCommandIdByLevel.Add(tuple, list);
                            }
                            count++;
                        }
                    }

                    Log.Information(String.Format("Loaded {0} battle commands.", count));
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void LoadGlobalBattleTraitList(Dictionary<ushort, BattleTrait> battleTraitDict, Dictionary<byte, List<ushort>> battleTraitJobDict)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    int count = 0;
                    conn.Open();

                    // LANG-ADAPT: PM backticks MySQL → Postgres no los acepta; columna en lowercase.
                    var query = ("SELECT id, name, classJob, lvl, modifier, bonus FROM server_battle_traits;");

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);

                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var id = reader.GetUInt16("id");
                            var name = reader.GetString("name");
                            var job = reader.GetByte("classJob");
                            var level = reader.GetByte("lvl");
                            uint modifier = reader.GetUInt32("modifier");
                            var bonus = reader.GetInt32("bonus");

                            var trait = new BattleTrait(id, name, job, level, modifier, bonus);

                            battleTraitDict.Add(id, trait);

                            if(battleTraitJobDict.ContainsKey(job))
                            {
                                battleTraitJobDict[job].Add(id);
                            }
                            else
                            {
                                battleTraitJobDict[job] = new List<ushort>();
                                battleTraitJobDict[job].Add(id);
                            }

                            count++;
                        }
                    }
                    Log.Information(String.Format("Loaded {0} battle traits.", count));
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void SetExp(Player player, byte classId, int exp)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    var query = String.Format(@"
                    UPDATE characters_class_exp
                    SET
                    {0} = @exp
                    WHERE
                    characterId = @characterId", CharacterUtils.GetClassNameForId(classId));
                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@characterId", player.actorId);
                    cmd.Parameters.AddParam("@exp", exp);
                    cmd.Prepare();
                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static void SetLevel(Player player, byte classId, short level)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    var query = String.Format(@"
                    UPDATE characters_class_levels
                    SET
                    {0} = @lvl
                    WHERE
                    characterId = @characterId", CharacterUtils.GetClassNameForId(classId));
                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@characterId", player.actorId);
                    cmd.Parameters.AddParam("@lvl", level);
                    cmd.Prepare();
                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

        public static Retainer LoadRetainer(Player player, int retainerIndex)
        {
            Retainer retainer = null;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    SELECT server_retainers.id as retainerId, server_retainers.name as name, actorClassId FROM characters_retainers                                    
                                    INNER JOIN server_retainers ON characters_retainers.retainerId = server_retainers.id
                                    WHERE characterId = @charaId
                                    ORDER BY id
                                    LIMIT 1 OFFSET @retainerIndex
                                    ";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", player.actorId);
                    cmd.Parameters.AddParam("@retainerIndex", retainerIndex - 1);

                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            uint retainerId = reader.GetUInt32("retainerId");
                            string name = reader.GetString("name");
                            uint actorClassId = reader.GetUInt32("actorClassId");

                            ActorClass actorClass = Server.GetWorldManager().GetActorClass(actorClassId);

                            retainer = new Retainer(retainerId, actorClass, player, 0, 0, 0, 0);
                            retainer.customDisplayName = name;
                            retainer.LoadEventConditions(actorClass.eventConditions);
                        }
                    }

                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }

                return retainer;
            }
        }

        public static void PlayerCharacterUpdateClassLevel(Player player, byte classId, short level)
        {
            string query;
            NpgsqlCommand cmd;

            string[] classNames = {
                "",
                "",
                "pug",
                "gla",
                "mrd",
                "",
                "",
                "arc",
                "lnc",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "thm",
                "cnj",
                "",
                "",
                "",
                "",
                "",
                "crp",
                "bsm",
                "arm",
                "gsm",
                "ltw",
                "wvr",
                "alc",
                "cul",
                "",
                "",
                "min",
                "btn",
                "fsh"
            };
            
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    query = String.Format(@"
                    UPDATE characters_class_levels
                    SET
                    {0}=@level
                    WHERE
                    characterId = @characterId", classNames[classId]);

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@level", level);
                    cmd.Parameters.AddParam("@characterId", player.actorId);

                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }
        }

    }
}
