// PM-COMPLETE → verbatim port de Map Server/Packets/Receive/GroupCreatedPacket.cs (54 líneas).
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
using System.IO;
using System.Text;

namespace MeteorReborn.Map.Packets.Receive
{
    class GroupCreatedPacket
    {    
        public ulong groupId;
        public string workString;

        public bool invalidPacket = false;

        public GroupCreatedPacket(byte[] data)
        {
            using (MemoryStream mem = new MemoryStream(data))
            {
                using (BinaryReader binReader = new BinaryReader(mem))
                {
                    try{
                        groupId = binReader.ReadUInt64();
                        workString = MeteorReborn.Common.Utils.ReadNullTermString(binReader);
                    }
                    catch (Exception){
                        invalidPacket = true;
                    }
                }
            }
        }

    }
}
