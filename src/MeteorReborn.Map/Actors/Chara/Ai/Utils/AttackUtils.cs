// PM-COMPLETE → verbatim port de Map Server/Actors/Chara/Ai/Utils/AttackUtils.cs (40 líneas).
// LANG-ADAPT: namespace + nullable + NLog→Serilog + Random.Shared→Random.Shared.
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

using MeteorReborn.Map.Actors;
namespace MeteorReborn.Map.Actors.Chara.Ai.Utils
{
    static class AttackUtils
    {
        public static int CalculateDamage(Character attacker, Character defender)
        {
            int dmg = CalculateBaseDamage(attacker, defender);

            return dmg;
        }

        public static int CalculateBaseDamage(Character attacker, Character defender)
        {
            // todo: actually calculate damage
            return Random.Shared.Next(10) * 10;
        }
    }
}
