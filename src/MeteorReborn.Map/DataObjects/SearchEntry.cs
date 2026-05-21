// PM-COMPLETE → verbatim port de Map Server/DataObjects/SearchEntry.cs (PM:22-56).
// LANG-ADAPT: namespace + nullable.

using System;
using System.IO;
using System.Text;

namespace MeteorReborn.Map.DataObjects;

class SearchEntry
{
    public ushort preferredClass;
    public ushort langauges;
    public ushort location;
    public ushort grandCompany;
    public ushort status;
    public ushort currentClass;
    public string name = null!;
    public ushort[] classes = new ushort[2 * 20];
    public ushort[] jobs = new ushort[8];

    public void WriteSearchEntry(BinaryWriter writer)
    {
        writer.Write((UInt16)preferredClass);
        writer.Write((UInt16)langauges);
        writer.Write((UInt16)location);
        writer.Write((UInt16)grandCompany);
        writer.Write((UInt16)status);
        writer.Write((UInt16)currentClass);

        writer.Write(Encoding.ASCII.GetBytes(name), 0, Encoding.ASCII.GetByteCount(name) >= 0x20 ? 0x20 : Encoding.ASCII.GetByteCount(name));

        for (int i = 0; i < classes.Length; i++)
            writer.Write((UInt16)classes[i]);
        for (int i = 0; i < jobs.Length; i++)
            writer.Write((UInt16)jobs[i]);
    }
}
