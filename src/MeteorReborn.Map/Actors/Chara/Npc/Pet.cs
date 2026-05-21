// PM-COMPLETE → verbatim port de Map Server/Actors/Chara/Npc/Pet.cs (39 líneas).
// LANG-ADAPT: namespace + nullable + NLog→Serilog + MySql→Npgsql + Random.Shared→Random.Shared.
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


using MeteorReborn.Map.Actors.Chara.Ai;
using MeteorReborn.Map.Actors.Chara.Ai.Controllers;

namespace MeteorReborn.Map.Actors
{
    class Pet : BattleNpc
    {
        public Pet(int actorNumber, ActorClass actorClass, string uniqueId, Area spawnedArea, float posX, float posY, float posZ, float rot,
                    ushort actorState, uint animationId, string customDisplayName)
            : base(actorNumber, actorClass, uniqueId, spawnedArea, posX, posY, posZ, rot, actorState, animationId, customDisplayName)  
        {
            this.aiContainer = new AIContainer(this, new PetController(this), new PathFind(this), new TargetFind(this));            
            this.hateContainer = new HateContainer(this);
        }
    }
}
