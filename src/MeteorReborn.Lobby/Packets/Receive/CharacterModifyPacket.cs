// PM-COMPLETE → verbatim port de Lobby Server/Packets/Receive/CharacterModifyPacket.cs (PM:22-66).
// LANG-ADAPT: namespace + nullable.

using System;
using System.IO;
using System.Text;

namespace MeteorReborn.Lobby.Packets.Receive;

class CharacterModifyPacket
{
    public UInt64 sequence;
    public uint characterId;
    public uint personType;
    public byte slot;
    public byte command;
    public ushort worldId;
    public String characterName = null!;
    public String characterInfoEncoded = null!;

    public bool invalidPacket = false;

    public CharacterModifyPacket(byte[] data)
    {
        using (MemoryStream mem = new MemoryStream(data))
        {
            using (BinaryReader binReader = new BinaryReader(mem))
            {
                try
                {
                    sequence = binReader.ReadUInt64();
                    characterId = binReader.ReadUInt32();
                    personType = binReader.ReadUInt32();
                    slot = binReader.ReadByte();
                    command = binReader.ReadByte();
                    worldId = binReader.ReadUInt16();

                    characterName = Encoding.ASCII.GetString(binReader.ReadBytes(0x20)).Trim(new[] { '\0' });
                    characterInfoEncoded = Encoding.ASCII.GetString(binReader.ReadBytes(0x190)).Trim(new[] { '\0' });
                }
                catch (Exception)
                {
                    invalidPacket = true;
                }
            }
        }
    }
}
