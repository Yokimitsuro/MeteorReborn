// PM-COMPLETE → verbatim port de Map Server/Actors/Area/Zone.cs (220 líneas).
// LANG-ADAPT: namespace + nullable + NLog→Serilog + Program.Random→Random.Shared.
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

using MeteorReborn.Common;
using Serilog;
using MeteorReborn.Map.Actors;
using MeteorReborn.Map.Lua;
using MeteorReborn.Map.Packets.Send.Actor;
using System;
using System.Collections.Generic;

namespace MeteorReborn.Map.Actors.area
{
    class Zone : Area
    {        
        Dictionary<string, Dictionary<uint, PrivateArea>> privateAreas = new Dictionary<string, Dictionary<uint, PrivateArea>>();
        Dictionary<string, List<PrivateAreaContent>> contentAreas = new Dictionary<string, List<PrivateAreaContent>>();
        Object contentAreasLock = new Object();

        // FINISH-PM: PM declara `SharpNav.TiledNavMesh tiledNavMesh; SharpNav.NavMeshQuery navMeshQuery;`
        // (PM Zone.cs:40-41). SharpNav removido del csproj — ver NavmeshUtils.cs.
        // Stub como `object?` para preservar la referencia campo en consumers que asignan null.
        public object? tiledNavMesh;
        public object? navMeshQuery;

        public Int64 pathCalls;
        public Int64 prevPathCalls = 0;
        public Int64 pathCallTime;

        public Zone(uint id, string zoneName, ushort regionId, string classPath, ushort bgmDay, ushort bgmNight, ushort bgmBattle, bool isIsolated, bool isInn, bool canRideChocobo, bool canStealth, bool isInstanceRaid, bool loadNavMesh = false)
            : base(id, zoneName, regionId, classPath, bgmDay, bgmNight, bgmBattle, isIsolated, isInn, canRideChocobo, canStealth, isInstanceRaid)
        {
            // FINISH-PM: PM Zone.cs:53-67 carga navmesh via SharpNav DLL legacy. Stub: NavmeshUtils
            // está stubeado y SharpNav nuget removido (ver NavmeshUtils.cs). Bloque desactivado hasta
            // que el navmesh real se porte.
            if (loadNavMesh)
            {
                Log.Debug("Navmesh loading skipped for {Zone} (FINISH-PM stub)", zoneName);
            }
        }

        public void AddPrivateArea(PrivateArea pa)
        {
            if (privateAreas.ContainsKey(pa.GetPrivateAreaName()))
                privateAreas[pa.GetPrivateAreaName()][pa.GetPrivateAreaType()] = pa;
            else
            {
                privateAreas[pa.GetPrivateAreaName()] = new Dictionary<uint, PrivateArea>();
                privateAreas[pa.GetPrivateAreaName()][pa.GetPrivateAreaType()] = pa;
            }
        }

        public PrivateArea GetPrivateArea(string type, uint number)
        {
            if (privateAreas.ContainsKey(type))
            {
                Dictionary<uint, PrivateArea> instances = privateAreas[type];
                if (instances.ContainsKey(number))
                    return instances[number];
                else
                    return null;
            }
            else
                return null;
        }

        public override SubPacket CreateScriptBindPacket()
        {
            bool isEntranceDesion = false;

            List<LuaParam> lParams;
            lParams = LuaUtils.CreateLuaParamList(classPath, false, true, zoneName, "", -1, canRideChocobo ? (byte)1 : (byte)0, canStealth, isInn, false, false, false, true, isInstanceRaid, isEntranceDesion);
            return ActorInstantiatePacket.BuildPacket(actorId, actorName, className, lParams);        
        }

        public void AddSpawnLocation(SpawnLocation spawn)
        {
            //Is it in a private area?
            if (!spawn.privAreaName.Equals(""))
            {
                if (privateAreas.ContainsKey(spawn.privAreaName))
                {
                    Dictionary<uint, PrivateArea> levels = privateAreas[spawn.privAreaName];
                    if (levels.ContainsKey(spawn.privAreaLevel))
                        levels[spawn.privAreaLevel].AddSpawnLocation(spawn);
                    else
                        Log.Error("Tried to add a spawn location to non-existing private area level \"{0}\" in area {1} in zone {2}", spawn.privAreaName, spawn.privAreaLevel, zoneName);
                }
                else
                    Log.Error("Tried to add a spawn location to non-existing private area \"{0}\" in zone {1}", spawn.privAreaName, zoneName);
            }
            else            
                mSpawnLocations.Add(spawn);            
        }

        public void SpawnAllActors(bool doPrivAreas)
        {
            foreach (SpawnLocation spawn in mSpawnLocations)            
                SpawnActor(spawn);

            if (doPrivAreas)
            {
                foreach (Dictionary<uint, PrivateArea> areas in privateAreas.Values)
                {
                    foreach (PrivateArea pa in areas.Values)
                        pa.SpawnAllActors();
                }
            }
        }

        public Actor FindActorInZone(uint id)
        {
            lock (mActorList)
            {
                if (!mActorList.ContainsKey(id))
                {
                    foreach (Dictionary<uint, PrivateArea> paList in privateAreas.Values)
                    {
                        foreach (PrivateArea pa in paList.Values)
                        {
                            Actor actor = pa.FindActorInArea(id);
                            if (actor != null)
                                return actor;
                        }
                    }

                    foreach (List<PrivateAreaContent> paList in contentAreas.Values)
                    {
                        foreach (PrivateArea pa in paList)
                        {
                            Actor actor = pa.FindActorInArea(id);
                            if (actor != null)
                                return actor;
                        }
                    }


                    return null;
                }
                else
                    return mActorList[id];
            }
        }

        public PrivateAreaContent CreateContentArea(Player starterPlayer, string areaClassPath, string contentScript, string areaName, string directorName, params object[] args)
        {
            lock (contentAreasLock)
            {
                Director director = CreateDirector(directorName, true, args);

                if (director == null)
                    return null;

                if (!contentAreas.ContainsKey(areaName))
                    contentAreas.Add(areaName, new List<PrivateAreaContent>());
                PrivateAreaContent contentArea = new PrivateAreaContent(this, classPath, areaName, 1, director, starterPlayer);                
                contentAreas[areaName].Add(contentArea);
                
                return contentArea;
            }
        }

        public void DeleteContentArea(PrivateAreaContent area)
        {
            if (contentAreas.ContainsKey(area.GetPrivateAreaName()))
            {
                contentAreas[area.GetPrivateAreaName()].Remove(area);
            }
        }

        public override void Update(DateTime tick)
        {
            base.Update(tick);

            foreach (var a in privateAreas.Values)
                foreach(var b in a.Values)
                    b.Update(tick);

            foreach (var a in contentAreas.Values)
                foreach (var b in a)
                    b.Update(tick);

            // todo: again, this is retarded but debug stuff
            var diffTime = tick - lastUpdate;
            
            if (diffTime.TotalSeconds >= 10)
            {
                if (this.pathCalls > 0)
                {
                    Log.Debug("Number of pathfinding calls {0} average time {1}ms. {2} this tick", pathCalls, (float)(pathCallTime / pathCalls), pathCalls - prevPathCalls);
                    prevPathCalls = pathCalls;
                }
                lastUpdate = tick;
            }
        }
    }
}
