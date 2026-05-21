/*
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

// PM-COMPLETE → verbatim port de Lobby Server/Database.cs (PM:22-773).
// LANG-ADAPT: namespace + MySql.Data.MySqlClient → Npgsql (driver swap, queries idénticas).
// NLog `Program.Log` → Serilog `Log`. `cmd.LastInsertedId` (MySQL auto_increment) → wrapping
// con `INSERT ... RETURNING id` + ExecuteScalar (Postgres equivalent — comportamiento idéntico).
// Connection string format adaptado a Postgres ("Host=...; Port=...; Database=...; Username=...; Password=...").

using System;
using System.Collections.Generic;

using MeteorReborn.Common;
using MeteorReborn.Lobby.DataObjects;
using Npgsql;
using NpgsqlTypes;
using Serilog;

namespace MeteorReborn.Lobby
{
    //charState: 0 - Reserved, 1 - Inactive, 2 - Active

    class Database
    {
        public static uint GetUserIdFromSession(String sessionId)
        {
            uint id = 0;
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
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

        public static bool ReserveCharacter(uint userId, uint slot, uint serverId, String name, out uint pid, out uint cid)
        {
            bool alreadyExists = false;
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    pid = 0;
                    cid = 0;
                    //Check if there exists a character not reserved by the user with the same name and in the same server                  
                    NpgsqlCommand cmd = new NpgsqlCommand("SELECT * FROM characters WHERE (name=@name AND serverId=@serverId AND (userId!=@userId OR state!=0))", conn);
                    cmd.Parameters.AddParam("@serverId", serverId);
                    cmd.Parameters.AddParam("@name", name);
                    cmd.Parameters.AddParam("@userId", userId);
                    using (NpgsqlDataReader Reader = cmd.ExecuteReader())
                    {
                        if (Reader.HasRows)
                        {
                            Log.Debug("[SQL] Found character with same name. Exiting...");
                            return true; //Early exit as we don't need to bother with anything else in this.
                        }
                    }

                    //Now check for a reserved character
                    NpgsqlCommand cmd3 = new NpgsqlCommand("SELECT * FROM characters WHERE userId=@userId AND state=0", conn);
                    cmd3.Parameters.AddParam("@userId", userId);

                    using (NpgsqlDataReader Reader = cmd3.ExecuteReader())
                    {
                        if (Reader.HasRows) //We can reasonably assume that there's only one reserved character per used id
                        {
                            Reader.Read();
                            cid = Reader.GetUInt16(0);
                            pid = 0xBABE;
                        }
                    }

                    if (cid != 0) //Update our reservation
                    {
                        NpgsqlCommand cmd2 = new NpgsqlCommand();
                        cmd2.Connection = conn;
                        cmd2.CommandText = "UPDATE characters SET serverId = @serverId, name = @name WHERE id = @cid";
                        cmd2.Parameters.AddParam("@serverId", serverId);
                        cmd2.Parameters.AddParam("@name", name);
                        cmd2.Parameters.AddParam("@cid", cid);
                        cmd2.Prepare();
                        cmd2.ExecuteNonQuery();
                    } else //Reserve
                    {
                        NpgsqlCommand cmd2 = new NpgsqlCommand();
                        cmd2.Connection = conn;
                        // LANG-ADAPT: PM usa `INSERT ...` + `cmd2.LastInsertedId` (MySQL auto_increment).
                        // Postgres equivalent: `INSERT ... RETURNING id` + `ExecuteScalar`. Comportamiento idéntico.
                        cmd2.CommandText = "INSERT INTO characters(userId, slot, serverId, name, state) VALUES(@userId, @slot, @serverId, @name, 0) RETURNING id";
                        cmd2.Parameters.AddParam("@userId", userId);
                        cmd2.Parameters.AddParam("@slot", slot);
                        cmd2.Parameters.AddParam("@serverId", serverId);
                        cmd2.Parameters.AddParam("@name", name);
                        cmd2.Prepare();
                        // LANG-ADAPT: Postgres devuelve bigint (Int64) para int unsigned columns.
                        cid = (uint)(long)cmd2.ExecuteScalar()!;
                        pid = 0xBABE;
                    }
                }

                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                    Log.Error(e.ToString());
                    cid = 0;
                    pid = 0;
                }
                finally
                {
                    conn.Dispose();
                }
                Log.Debug("[SQL] CID={0} Created on 'characters' table.", cid);
            }
            return alreadyExists;
        }

        public static void MakeCharacter(uint accountId, uint cid, CharaInfo charaInfo)
        {
            //Update character entry
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = @"
                                        UPDATE characters SET 
                                        state=2,
                                        currentZoneId=@zoneId,
                                        positionX=@x,
                                        positionY=@y,
                                        positionZ=@z,
                                        rotation=@r,
                                        guardian=@guardian,
                                        birthDay=@birthDay,
                                        birthMonth=@birthMonth,
                                        initialTown=@initialTown,
                                        tribe=@tribe
                                        WHERE userId=@userId AND id=@cid;
            
                                        INSERT INTO characters_appearance
                                        (characterId, baseId, size, voice, skinColor, hairStyle, hairColor, hairHighlightColor, hairVariation, eyeColor, faceType, faceEyebrows, faceEyeShape, faceIrisSize, faceNose, faceMouth, faceFeatures, ears, characteristics, characteristicsColor, mainhand, offhand, head, body, hands, legs, feet, waist)
                                        VALUES
                                        (@cid, 4294967295, @size, @voice, @skinColor, @hairStyle, @hairColor, @hairHighlightColor, @hairVariation, @eyeColor, @faceType, @faceEyebrows, @faceEyeShape, @faceIrisSize, @faceNose, @faceMouth, @faceFeatures, @ears, @characteristics, @characteristicsColor, @mainhand, @offhand, @head, @body, @hands, @legs, @feet, @waist)
                                        ";
                    cmd.Parameters.AddParam("@userId", accountId);
                    cmd.Parameters.AddParam("@cid", cid);
                    cmd.Parameters.AddParam("@guardian", charaInfo.guardian);
                    cmd.Parameters.AddParam("@birthDay", charaInfo.birthDay);
                    cmd.Parameters.AddParam("@birthMonth", charaInfo.birthMonth);
                    cmd.Parameters.AddParam("@initialTown", charaInfo.initialTown);
                    cmd.Parameters.AddParam("@tribe", charaInfo.tribe);

                    cmd.Parameters.AddParam("@zoneId", charaInfo.zoneId);
                    cmd.Parameters.AddParam("@x", charaInfo.x);
                    cmd.Parameters.AddParam("@y", charaInfo.y);
                    cmd.Parameters.AddParam("@z", charaInfo.z);
                    cmd.Parameters.AddParam("@r", charaInfo.rot);

                    cmd.Parameters.AddParam("@size", charaInfo.appearance.size);
                    cmd.Parameters.AddParam("@voice", charaInfo.appearance.voice);
                    cmd.Parameters.AddParam("@skinColor", charaInfo.appearance.skinColor);
                    cmd.Parameters.AddParam("@hairStyle", charaInfo.appearance.hairStyle);
                    cmd.Parameters.AddParam("@hairColor", charaInfo.appearance.hairColor);
                    cmd.Parameters.AddParam("@hairHighlightColor", charaInfo.appearance.hairHighlightColor);
                    cmd.Parameters.AddParam("@hairVariation", charaInfo.appearance.hairVariation);
                    cmd.Parameters.AddParam("@eyeColor", charaInfo.appearance.eyeColor);
                    cmd.Parameters.AddParam("@faceType", charaInfo.appearance.faceType);
                    cmd.Parameters.AddParam("@faceEyebrows", charaInfo.appearance.faceEyebrows);
                    cmd.Parameters.AddParam("@faceEyeShape", charaInfo.appearance.faceEyeShape);
                    cmd.Parameters.AddParam("@faceIrisSize", charaInfo.appearance.faceIrisSize);
                    cmd.Parameters.AddParam("@faceNose", charaInfo.appearance.faceNose);
                    cmd.Parameters.AddParam("@faceMouth", charaInfo.appearance.faceMouth);
                    cmd.Parameters.AddParam("@faceFeatures", charaInfo.appearance.faceFeatures);
                    cmd.Parameters.AddParam("@ears", charaInfo.appearance.ears);
                    cmd.Parameters.AddParam("@characteristics", charaInfo.appearance.characteristics);
                    cmd.Parameters.AddParam("@characteristicsColor", charaInfo.appearance.characteristicsColor);

                    cmd.Parameters.AddParam("@mainhand", charaInfo.weapon1);
                    cmd.Parameters.AddParam("@offhand", charaInfo.weapon2);
                    cmd.Parameters.AddParam("@head", charaInfo.head);
                    cmd.Parameters.AddParam("@body", charaInfo.body);
                    cmd.Parameters.AddParam("@legs", charaInfo.legs);
                    cmd.Parameters.AddParam("@hands", charaInfo.hands);
                    cmd.Parameters.AddParam("@feet", charaInfo.feet);
                    cmd.Parameters.AddParam("@waist", charaInfo.belt);

                    cmd.ExecuteNonQuery();

                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                   
                    conn.Dispose();
                    return;
                }
                finally
                {
                }


                //Create Level and EXP entries
                try
                {
                    NpgsqlCommand cmd = new NpgsqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = String.Format("INSERT INTO characters_class_levels(characterId, {0}) VALUES(@characterId, 1);", CharacterCreatorUtils.GetClassNameForId((short)charaInfo.currentClass));
                    cmd.Parameters.AddParam("@characterId", cid);
                    cmd.Prepare();
                    cmd.ExecuteNonQuery();

                    NpgsqlCommand cmd2 = new NpgsqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = String.Format("INSERT INTO characters_class_exp(characterId) VALUES(@characterId2)");
                    cmd.Parameters.AddParam("@characterId2", cid);
                    cmd.Prepare();
                    cmd.ExecuteNonQuery();
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                   
                    conn.Dispose();
                    return;
                }

                //Create Parameter Save
                try
                {
                    NpgsqlCommand cmd = new NpgsqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = String.Format("INSERT INTO characters_parametersave(characterId, hp, hpMax, mp, mpMax, mainSkill, mainSkillLevel) VALUES(@characterId, 1900, 1000, 115, 115, @mainSkill, 1);", CharacterCreatorUtils.GetClassNameForId((short)charaInfo.currentClass));
                    cmd.Parameters.AddParam("@characterId", cid);
                    cmd.Parameters.AddParam("@mainSkill", charaInfo.currentClass);
                    cmd.Prepare();
                    cmd.ExecuteNonQuery();

                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                    conn.Dispose();
                    return;
                }

                //Create Hotbar
                try
                {
                    NpgsqlCommand cmd = new NpgsqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = "SELECT id FROM server_battle_commands WHERE classJob = @classjob AND lvl = 1 ORDER BY id DESC";
                    cmd.Parameters.AddParam("@classJob", charaInfo.currentClass);
                    cmd.Prepare();
                    List<uint> defaultActions = new List<uint>();
                    using (var reader = cmd.ExecuteReader())
                    {
                        while(reader.Read())
                        {
                            defaultActions.Add(reader.GetUInt32("id"));
                        }
                    }
                    NpgsqlCommand cmd2 = new NpgsqlCommand();
                    cmd2.Connection = conn;
                    cmd2.CommandText = "INSERT INTO characters_hotbar (characterId, classId, hotbarSlot, commandId, recastTime) VALUES (@characterId, @classId, @hotbarSlot, @commandId, 0)";
                    cmd2.Parameters.AddParam("@characterId", cid);
                    cmd2.Parameters.AddParam("@classId", charaInfo.currentClass);
                    // LANG-ADAPT: Postgres schema tiene hotbarslot=integer y commandid=bigint
                    // (PM MySQL eran tinyint/smallint y MySQL admitía cross-type assignment).
                    cmd2.Parameters.Add("@hotbarSlot", NpgsqlDbType.Integer);
                    cmd2.Parameters.Add("@commandId", NpgsqlDbType.Bigint);

                    for (int i = 0; i < defaultActions.Count; i++)
                    {
                        cmd2.Parameters["@hotbarSlot"].Value = i;
                        cmd2.Parameters["@commandId"].Value = (long)defaultActions[i];
                        cmd2.Prepare();
                        cmd2.ExecuteNonQuery();
                    }
                }
                catch(NpgsqlException e)
                {
                    Log.Error(e.ToString());
                }
                finally
                {
                    conn.Dispose();
                }
            }

            Log.Debug("[SQL] CID={0} state updated to active(2).", cid);
        }

        public static bool RenameCharacter(uint userId, uint characterId, uint serverId, String newName)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    //Check if exists                    
                    NpgsqlCommand cmd = new NpgsqlCommand("SELECT * FROM characters WHERE name=@name AND serverId=@serverId", conn);
                    cmd.Parameters.AddParam("@serverId", serverId);
                    cmd.Parameters.AddParam("@name", newName);
                    using (NpgsqlDataReader Reader = cmd.ExecuteReader())
                    {
                        if (Reader.HasRows)
                        {
                            return true;
                        }
                    }

                    cmd = new NpgsqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = "UPDATE characters SET name=@name, DoRename=0 WHERE id=@cid AND userId=@uid";
                    cmd.Parameters.AddParam("@uid", userId);
                    cmd.Parameters.AddParam("@cid", characterId);
                    cmd.Parameters.AddParam("@name", newName);
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

                Log.Debug("[SQL] CID={0} name updated to \"{1}\".", characterId, newName);

                return false;
            }
        }

        public static void DeleteCharacter(uint characterId, String name)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand();
                    cmd.Connection = conn;
                    cmd.CommandText = "UPDATE characters SET state=1 WHERE id=@cid AND name=@name";
                    cmd.Parameters.AddParam("@cid", characterId);
                    cmd.Parameters.AddParam("@name", name);
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

            Log.Debug("[SQL] CID={0} deleted.", characterId);
        }

        public static List<World> GetServers()
        {
            string query;
            NpgsqlCommand cmd;
            List<World> worldList = new List<World>();

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    query = "SELECT * FROM servers WHERE isActive=true";
                    cmd = new NpgsqlCommand(query, conn);

                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ushort id;
                            string address;
                            ushort port;
                            ushort listPosition;
                            ushort population;
                            string name;
                            bool isActive;

                            id = reader.GetUInt16("id");
                            address = reader.GetString("address");
                            port = reader.GetUInt16("port");
                            listPosition = reader.GetUInt16("listPosition");
                            population = 2;
                            name = reader.GetString("name");
                            isActive = reader.GetBoolean("isActive");

                            worldList.Add(new World(id, address, port, listPosition, population, name, isActive));
                        }
                    }
                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                    worldList = new List<World>();
                }
                finally
                {
                    conn.Dispose();
                }
            }
            return worldList;
        }

        public static World GetServer(uint serverId)
        {
            string query;
            NpgsqlCommand cmd;
            World world = null;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    query = "SELECT * FROM servers WHERE id=@ServerId";
                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@ServerId", serverId);

                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ushort id;
                            string address;
                            ushort port;
                            ushort listPosition;
                            ushort population;
                            string name;
                            bool isActive;

                            id = reader.GetUInt16("id");
                            address = reader.GetString("address");
                            port = reader.GetUInt16("port");
                            listPosition = reader.GetUInt16("listPosition");
                            population = 2; //TODO
                            name = reader.GetString("name");
                            isActive = reader.GetBoolean("isActive");

                            world = new World(id, address, port, listPosition, population, name, isActive);
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

            return world;           
        }

        public static List<Character> GetCharacters(uint userId)
        {
            List<Character> characters = new List<Character>();
            using (var conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                conn.Open();

                //Load basic info                  
                string query = @"
                    SELECT 
                    id,            
                    slot,
                    serverId,
                    name,
                    isLegacy,
                    doRename,
                    currentZoneId,             
                    guardian,
                    birthMonth,
                    birthDay,
                    initialTown,
                    tribe,
                    mainSkill,
                    mainSkillLevel
                    FROM characters
                    INNER JOIN characters_parametersave ON id = characters_parametersave.characterId
                    WHERE userId = @userId AND state = 2
                    ORDER BY slot";
                NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                cmd.Parameters.AddParam("@userId", userId);
                using (NpgsqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Character chara = new Character();
                        chara.id = reader.GetUInt32("id");
                        chara.slot = reader.GetUInt16("slot");
                        chara.serverId = reader.GetUInt16("serverId");
                        chara.name = reader.GetString("name");
                        chara.isLegacy = reader.GetBoolean("isLegacy");
                        chara.doRename = reader.GetBoolean("doRename");
                        chara.currentZoneId = reader.GetUInt32("currentZoneId");
                        chara.guardian = reader.GetByte("guardian");
                        chara.birthMonth = reader.GetByte("birthMonth");
                        chara.birthDay = reader.GetByte("birthDay");
                        chara.initialTown = reader.GetByte("initialTown");
                        chara.tribe = reader.GetByte("tribe");
                        chara.currentClass = reader.GetByte("mainSkill");
                        //chara.currentJob = ???
                        chara.currentLevel = reader.GetInt16("mainSkillLevel");
                        characters.Add(chara);
                    }
                }

            }
            return characters;
        }

        public static Character GetCharacter(uint userId, uint charId)
        {
            Character chara = null;
            using (var conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                    SELECT 
                    id,            
                    slot,
                    serverId,
                    name,
                    isLegacy,
                    doRename,
                    currentZoneId,             
                    guardian,
                    birthMonth,
                    birthDay,
                    initialTown,
                    tribe,
                    mainSkill,
                    mainSkillLevel
                    FROM characters
                    INNER JOIN characters_parametersave ON id = characters_parametersave.characterId
                    WHERE id = @charId";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charId", charId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            chara = new Character();
                            chara.id = reader.GetUInt32("id");
                            chara.slot = reader.GetUInt16("slot");
                            chara.serverId = reader.GetUInt16("serverId");
                            chara.name = reader.GetString("name");
                            chara.isLegacy = reader.GetBoolean("isLegacy");
                            chara.doRename = reader.GetBoolean("doRename");
                            chara.currentZoneId = reader.GetUInt32("currentZoneId");
                            chara.guardian = reader.GetByte("guardian");
                            chara.birthMonth = reader.GetByte("birthMonth");
                            chara.birthDay = reader.GetByte("birthDay");
                            chara.initialTown = reader.GetByte("initialTown");
                            chara.tribe = reader.GetByte("tribe");
                            chara.currentClass = reader.GetByte("mainSkill");
                            //chara.currentJob = ???
                            chara.currentLevel = reader.GetInt16("mainSkillLevel");
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
            return chara;
        }

        public static Appearance GetAppearance(uint charaId)
        {
            Appearance appearance = new Appearance();
            using (var conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    //Load appearance
                    string query = @"
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
                            leftIndex,
                            rightIndex,
                            leftFinger,
                            rightFinger,
                            leftEar,
                            rightEar
                            FROM characters_appearance WHERE characterId = @charaId";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", charaId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            appearance.size = reader.GetByte("size");
                            appearance.voice = reader.GetByte("voice");
                            appearance.skinColor = reader.GetUInt16("skinColor");
                            appearance.hairStyle = reader.GetUInt16("hairStyle");
                            appearance.hairColor = reader.GetUInt16("hairColor");
                            appearance.hairHighlightColor = reader.GetUInt16("hairHighlightColor");
                            appearance.hairVariation = reader.GetUInt16("hairVariation");
                            appearance.eyeColor = reader.GetUInt16("eyeColor");
                            appearance.characteristics = reader.GetByte("characteristics");
                            appearance.characteristicsColor = reader.GetByte("characteristicsColor");
                            appearance.faceType = reader.GetByte("faceType");
                            appearance.ears = reader.GetByte("ears");
                            appearance.faceMouth = reader.GetByte("faceMouth");
                            appearance.faceFeatures = reader.GetByte("faceFeatures");
                            appearance.faceNose = reader.GetByte("faceNose");
                            appearance.faceEyeShape = reader.GetByte("faceEyeShape");
                            appearance.faceIrisSize = reader.GetByte("faceIrisSize");
                            appearance.faceEyebrows = reader.GetByte("faceEyebrows");

                            appearance.mainHand = reader.GetUInt32("mainHand");
                            appearance.offHand = reader.GetUInt32("offHand");
                            appearance.head = reader.GetUInt32("head");
                            appearance.body = reader.GetUInt32("body");
                            appearance.mainHand = reader.GetUInt32("mainHand");
                            appearance.legs = reader.GetUInt32("legs");
                            appearance.hands = reader.GetUInt32("hands");
                            appearance.feet = reader.GetUInt32("feet");
                            appearance.waist = reader.GetUInt32("waist");
                            appearance.neck = reader.GetUInt32("neck");
                            appearance.leftFinger = reader.GetUInt32("leftFinger");
                            appearance.rightFinger = reader.GetUInt32("rightFinger");
                            appearance.leftIndex = reader.GetUInt32("leftIndex");
                            appearance.rightIndex = reader.GetUInt32("rightIndex");
                            appearance.leftEar = reader.GetUInt32("leftEar");
                            appearance.rightEar = reader.GetUInt32("rightEar");
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

            return appearance;
        }

        public static List<String> GetReservedNames(uint userId)
        {
            List<String> reservedNames = new List<String>();
            using (var conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = "SELECT name FROM reserved_names WHERE userId=@UserId";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@UserId", userId);
                    using (NpgsqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            reservedNames.Add(reader.GetString("name"));
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
            return reservedNames;
        }

        public static List<Retainer> GetRetainers(uint userId)
        {
            return new List<Retainer>();
        }

    }
}
