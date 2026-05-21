// PM-COMPLETE → verbatim port de Map Server/DataObjects/database/DBWorld.cs (PM:22-40).
// LANG-ADAPT: namespace + nullable. PM-NOTE: PM usa namespace antiguo `FFXIVClassic_Lobby_Server.dataobjects`
// (residuo histórico antes del rename a Meteor); en MR lo normalizamos a `MeteorReborn.Map.DataObjects.database`.

namespace MeteorReborn.Map.DataObjects.database;

class DBWorld
{
    public ushort id;
    public string address = null!;
    public ushort port;
    public ushort listPosition;
    public ushort population;
    public string name = null!;
    public bool isActive;
    public string motd = null!;
}
