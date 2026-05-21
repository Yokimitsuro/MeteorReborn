// PM-COMPLETE → verbatim port de Lobby Server/Packets/Receive/SecurityHandshakePacket.cs (PM:22-54).
// LANG-ADAPT: namespace + nullable.

using System;
using System.IO;
using System.Text;

namespace MeteorReborn.Lobby.Packets.Receive;

class SecurityHandshakePacket
{
    public string ticketPhrase = null!;
    public uint clientNumber;

    public bool invalidPacket = false;

    public SecurityHandshakePacket(byte[] data)
    {
        using (MemoryStream mem = new MemoryStream(data))
        {
            using (BinaryReader binReader = new BinaryReader(mem))
            {
                try
                {
                    binReader.BaseStream.Seek(0x34, SeekOrigin.Begin);
                    ticketPhrase = Encoding.ASCII.GetString(binReader.ReadBytes(0x40)).Trim(new[] { '\0' });
                    clientNumber = binReader.ReadUInt32();
                }
                catch (Exception)
                {
                    invalidPacket = true;
                }
            }
        }
    }
}
