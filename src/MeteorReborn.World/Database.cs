// PM-COMPLETE → verbatim port de World Server/Database.cs (586 líneas).
// LANG-ADAPT: namespace + nullable + NLog→Serilog + MySql→Npgsql donde aplique.
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

using System;
using MeteorReborn.Common;
using Serilog;
using System.Collections.Generic;

using MeteorReborn.World.DataObjects;
using MeteorReborn.World.DataObjects.Group;
using Npgsql;
using NpgsqlTypes;

namespace MeteorReborn.World
{
    class Database
    {
        public static DBWorld GetServer(uint serverId)
        {
            using (var conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                DBWorld world = null;
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand("SELECT name, address, port FROM servers WHERE id = @serverId", conn);
                    cmd.Parameters.AddParam("@serverId", (long)serverId);
                    using (NpgsqlDataReader Reader = cmd.ExecuteReader())
                    {
                        while (Reader.Read())
                        {
                            world = new DBWorld();
                            world.id = serverId;
                            world.name = Reader.GetString("name");
                            world.address = Reader.GetString("address");
                            world.port = Reader.GetUInt16("port");                           
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

                return world;
            }
        }   

        public static bool LoadZoneSessionInfo(Session session)
        {
            string characterName, currentLinkshell;
            uint currentZone = 0;
            uint destinationZone = 0;
            bool readIn = false;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand("SELECT name, currentZoneId, destinationZoneId, currentActiveLinkshell FROM characters WHERE id = @charaId", conn);
                    cmd.Parameters.AddParam("@charaId", session.sessionId);
                    using (NpgsqlDataReader Reader = cmd.ExecuteReader())
                    {
                        while (Reader.Read())
                        {
                            characterName = Reader.GetString("name");
                            currentZone = Reader.GetUInt32("currentZoneId");
                            destinationZone = Reader.GetUInt32("destinationZoneId");
                            currentLinkshell = Reader.GetString("currentActiveLinkshell");

                            session.characterName = characterName;
                            session.currentZoneId = currentZone;
                            session.activeLinkshellName = currentLinkshell;                            

                            readIn = true;
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

            return readIn;
        }

        public static void GetAllCharaNames(Dictionary<uint, string> mIdToNameMap)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand("SELECT id, name FROM characters", conn);
                    using (NpgsqlDataReader Reader = cmd.ExecuteReader())
                    {
                        while (Reader.Read())
                        {
                            uint id = Reader.GetUInt32("id");
                            string name = Reader.GetString("name");
                            mIdToNameMap.Add(id, name);
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

        public static uint GetCurrentZoneForSession(uint charId)
        {
            uint currentZone = 0;
            uint destinationZone = 0;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand("SELECT currentZoneId, destinationZoneId FROM characters WHERE id = @charaId", conn);
                    cmd.Parameters.AddParam("@charaId", (long)charId);
                    using (NpgsqlDataReader Reader = cmd.ExecuteReader())
                    {
                        while (Reader.Read())
                        {
                            currentZone = Reader.GetUInt32("currentZoneId");
                            destinationZone = Reader.GetUInt32("destinationZoneId");
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

            if (currentZone == 0 && destinationZone != 0)
                return destinationZone;
            if (currentZone != 0 && destinationZone == 0)
                return currentZone;
            else
            {
                return 0;
            }
        }

        public static List<RetainerGroupMember> GetRetainers(uint charaId)
        {
            List<RetainerGroupMember> members = new List<RetainerGroupMember>();
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand("SELECT id, name, actorClassId, cdIDOffset, placeName, conditions, level FROM server_retainers INNER JOIN characters_retainers ON retainerId = server_retainers.id WHERE characterId = @charaId", conn);
                    cmd.Parameters.AddParam("@charaId", (long)charaId);
                    using (NpgsqlDataReader Reader = cmd.ExecuteReader())
                    {
                        while (Reader.Read())
                        {
                            uint id = Reader.GetUInt32("id") | 0xE0000000;
                            string name = Reader.GetString("name");
                            uint actorClassId = Reader.GetUInt32("actorClassId");
                            byte cdIDOffset = Reader.GetByte("cdIDOffset");
                            ushort placeName = Reader.GetUInt16("placeName");
                            byte conditions = Reader.GetByte("conditions");
                            byte level = Reader.GetByte("level");

                            members.Add(new RetainerGroupMember(id, name, actorClassId, cdIDOffset, placeName, conditions, level));
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
            return members;
        }

        public static Linkshell GetLinkshell(ulong groupIndex, string lsName)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand("SELECT id, name, crestIcon, master FROM server_linkshells WHERE name = @lsName", conn);
                    cmd.Parameters.AddParam("@lsName", lsName);
                    using (NpgsqlDataReader Reader = cmd.ExecuteReader())
                    {
                        while (Reader.Read())
                        {
                            ulong lsId = Reader.GetUInt64("id");
                            string name = Reader.GetString("name");
                            ushort crest = Reader.GetUInt16("crestIcon");
                            uint master = Reader.GetUInt32("master");

                            Linkshell linkshell = new Linkshell(lsId, groupIndex, name, crest, master, 0xa);
                            return linkshell;
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
            return null;
        }

        public static Linkshell GetLinkshell(ulong groupIndex, ulong lsId)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand("SELECT name, crestIcon, master FROM server_linkshells WHERE id = @lsId", conn);
                    cmd.Parameters.AddParam("@lsId", (long)lsId);
                    using (NpgsqlDataReader Reader = cmd.ExecuteReader())
                    {
                        while (Reader.Read())
                        {
                            string name = Reader.GetString("name");
                            ushort crest = Reader.GetUInt16("crestIcon");
                            uint master = Reader.GetUInt32("master");

                            Linkshell linkshell = new Linkshell(lsId, groupIndex, name, crest, master, 0xa);
                            return linkshell;
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
            return null;
        }

        public static List<LinkshellMember> GetLSMembers(Linkshell ls)
        {
            List<LinkshellMember> memberList = new List<LinkshellMember>();            
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand("SELECT characterId, linkshellId, rank FROM characters_linkshells WHERE linkshellId = @lsId", conn);
                    cmd.Parameters.AddParam("@lsId", ls.dbId);
                    using (NpgsqlDataReader Reader = cmd.ExecuteReader())
                    {
                        while (Reader.Read())
                        {
                            uint characterId = Reader.GetUInt32("characterId");
                            ulong linkshellId = Reader.GetUInt64("linkshellId");
                            byte rank = Reader.GetByte("rank");

                            LinkshellMember member = new LinkshellMember(characterId, linkshellId, rank);
                            memberList.Add(member);
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
            memberList.Sort();
            return memberList;
        }

        public static List<LinkshellMember> GetPlayerLSMembership(uint charaId)
        {
            List<LinkshellMember> memberList = new List<LinkshellMember>();
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand("SELECT characterId, linkshellId, rank FROM characters_linkshells WHERE characterId = @charaId", conn);
                    cmd.Parameters.AddParam("@charaId", (long)charaId);
                    using (NpgsqlDataReader Reader = cmd.ExecuteReader())
                    {
                        while (Reader.Read())
                        {
                            uint characterId = Reader.GetUInt32("characterId");
                            ulong linkshellId = Reader.GetUInt64("linkshellId");
                            byte rank = Reader.GetByte("rank");

                            LinkshellMember member = new LinkshellMember(characterId, linkshellId, rank);
                            memberList.Add(member);
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
            return memberList;
        }

        public static ulong CreateLinkshell(string name, ushort crest, uint master)
        {
            string query;
            NpgsqlCommand cmd;
            ulong lastId = 0;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    // LANG-ADAPT: PM `INSERT ...` + `cmd.LastInsertedId` (MySQL auto_increment) →
                    // Postgres `INSERT ... RETURNING id` + `ExecuteScalar`. Comportamiento idéntico.
                    query = @"
                    INSERT INTO server_linkshells
                    (name, crestIcon, master, rank)
                    VALUES
                    (@name, @crestIcon, @master, @rank)
                    RETURNING id
                    ";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@name", name);
                    cmd.Parameters.AddParam("@crestIcon", crest);
                    cmd.Parameters.AddParam("@master", master);
                    cmd.Parameters.AddParam("@rank", 0xa);

                    var scalar = cmd.ExecuteScalar();
                    if (scalar != null)
                        lastId = Convert.ToUInt64(scalar);
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

            return lastId;
        }

        public static bool DeleteLinkshell(ulong lsId)
        {
            throw new NotImplementedException();
        }

        public static bool LinkshellAddPlayer(ulong lsId, uint charaId, byte rank = LinkshellManager.RANK_MEMBER)
        {
            string query;
            NpgsqlCommand cmd;

            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    query = @"
                    INSERT INTO characters_linkshells 
                    (characterId, linkshellId, rank)
                    VALUES
                    (@charaId, @lsId, @rank)             
                    ";

                    cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", (long)charaId);
                    cmd.Parameters.AddParam("@lsId", (long)lsId);
                    cmd.Parameters.AddParam("@rank", rank);
                    cmd.ExecuteNonQuery();

                }
                catch (NpgsqlException e)
                {
                    Log.Error(e.ToString());
                    conn.Dispose();
                    return false;
                }
                finally
                {
                    conn.Dispose();
                }
            }

            return true;
        }

        public static bool LinkshellRemovePlayer(ulong lsId, uint charaId)
        {
            bool success = false;
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();

                    string query = @"
                                    DELETE FROM characters_linkshells                                   
                                    WHERE characterId = @charaId AND linkshellId = @lsId;
                                    ";

                    NpgsqlCommand cmd = new NpgsqlCommand(query, conn);
                    cmd.Parameters.AddParam("@charaId", (long)charaId);
                    cmd.Parameters.AddParam("@lsId", (long)lsId);
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

        public static bool ChangeLinkshellCrest(ulong lsId, ushort newCrestId)
        {
            bool success = false;
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand("UPDATE server_linkshells SET crestIcon = @crestIcon WHERE id = @lsId", conn);
                    cmd.Parameters.AddParam("@lsId", (long)lsId);
                    cmd.Parameters.AddParam("@crestIcon", newCrestId);
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

        public static bool LinkshellChangeRank(uint charaId, byte rank)
        {
            bool success = false;
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand("UPDATE characters_linkshells SET rank = @rank WHERE characterId = @charaId", conn);
                    cmd.Parameters.AddParam("@charaId", (long)charaId);
                    cmd.Parameters.AddParam("@rank", rank);
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

        public static bool SetActiveLS(Session session, string name)
        {
            bool success = false;
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand("UPDATE characters SET currentActiveLinkshell = @lsName WHERE id = @charaId", conn);
                    cmd.Parameters.AddParam("@charaId", session.sessionId);
                    cmd.Parameters.AddParam("@lsName", name);
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

        public static bool LinkshellIsBannedName(string name)
        {
            return false;
        }

        public static bool LinkshellExists(string name)
        {
            bool hasLS = false;
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
            {
                try
                {
                    conn.Open();
                    NpgsqlCommand cmd = new NpgsqlCommand("SELECT * FROM server_linkshells WHERE name = @lsName", conn);
                    cmd.Parameters.AddParam("@lsName", name);
                    object result = cmd.ExecuteScalar();
                    // LANG-ADAPT: Postgres bigint → boxed Int64. Convert para chequear > 0.
                    hasLS = result != null && Convert.ToInt64(result) > 0;
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
            return hasLS;
        }
    }
}
