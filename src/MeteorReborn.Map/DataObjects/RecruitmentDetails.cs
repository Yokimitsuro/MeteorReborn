// PM-COMPLETE → verbatim port de Map Server/DataObjects/RecruitmentDetails.cs (PM:22-40).
// LANG-ADAPT: namespace + nullable.

namespace MeteorReborn.Map.DataObjects;

class RecruitmentDetails
{
    public string recruiterName = null!;
    public string comment = null!;

    public uint purposeId;
    public uint locationId;
    public uint subTaskId;
    public uint timeSinceStart;

    public uint[] discipleId = new uint[4];
    public uint[] classjobId = new uint[4];
    public byte[] minLvl = new byte[4];
    public byte[] maxLvl = new byte[4];
    public byte[] num = new byte[4];

}
