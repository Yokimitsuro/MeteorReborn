// PM-COMPLETE → verbatim port de Lobby Server/Packets/Receive/SessionPacket.cs (PM:22-56).
// LANG-ADAPT: namespace + nullable.

using System;
using System.IO;
using System.Text;

namespace MeteorReborn.Lobby.Packets.Receive;

class SessionPacket
{
    public bool invalidPacket = false;
    public UInt64 sequence;
    public String session = null!;
    public String version = null!;

    public SessionPacket(byte[] data)
    {
        using (MemoryStream mem = new MemoryStream(data))
        {
            using (BinaryReader binReader = new BinaryReader(mem))
            {
                try
                {
                    sequence = binReader.ReadUInt64();
                    binReader.ReadUInt32();
                    binReader.ReadUInt32();
                    session = Encoding.ASCII.GetString(binReader.ReadBytes(0x40)).Trim(new[] { '\0' });
                    version = Encoding.ASCII.GetString(binReader.ReadBytes(0x20)).Trim(new[] { '\0' });
                }
                catch (Exception)
                {
                    invalidPacket = true;
                }
            }
        }
    }
}
