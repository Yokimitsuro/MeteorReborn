// PM-COMPLETE → verbatim port de Map Server/Packets/Send/Actor/PlayAnimationOnActorPacket.cs (37 líneas).
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

using MeteorReborn.Common;
using Serilog;
using System;

namespace MeteorReborn.Map.Packets.Send.Actor
{
    class PlayAnimationOnActorPacket
    {
        public const ushort OPCODE = 0x00DA;
        public const uint PACKET_SIZE = 0x28;

        public static SubPacket BuildPacket(uint sourceActorId, uint animationID)
        {
            return new SubPacket(OPCODE, sourceActorId, BitConverter.GetBytes((ulong)animationID));
        }
    }
}
