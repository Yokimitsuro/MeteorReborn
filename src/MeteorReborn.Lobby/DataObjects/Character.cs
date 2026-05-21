// PM-COMPLETE → verbatim port de Lobby Server/DataObjects/Character.cs (PM:22-64).
// LANG-ADAPT: namespace + nullable + NLog → Serilog.

using System;
using Serilog;

namespace MeteorReborn.Lobby.DataObjects;

class Character
{
    public uint id;
    public ushort slot;
    public ushort serverId;
    public string name = null!;
    public ushort state;
    public string charaInfo = null!;
    public bool isLegacy;
    public bool doRename;
    public uint currentZoneId;

    public byte guardian;
    public byte birthMonth;
    public byte birthDay;

    public uint currentClass = 3;
    public uint currentJob = 0;
    public int currentLevel = 1;

    public byte initialTown;
    public byte tribe;

    public static CharaInfo EncodedToCharacter(String charaInfo)
    {
        charaInfo.Replace("+", "-");
        charaInfo.Replace("/", "_");
        byte[] data = System.Convert.FromBase64String(charaInfo);

        Log.Debug("------------Base64 printout------------------");
        Log.Debug(MeteorReborn.Common.Utils.ByteArrayToHex(data));
        Log.Debug("------------Base64 printout------------------");

        CharaInfo chara = new CharaInfo();

        return chara;
    }
}
