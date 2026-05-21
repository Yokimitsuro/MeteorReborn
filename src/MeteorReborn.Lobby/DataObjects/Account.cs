// PM-COMPLETE → verbatim port de Lobby Server/DataObjects/Account.cs (PM:22-31).
// LANG-ADAPT: namespace + nullable. EF mapping vive en LobbyDbContext.OnModelCreating
// (Fluent API) para preservar los public fields PM en lugar de cambiar a properties.

using System;

namespace MeteorReborn.Lobby.DataObjects;

class Account
{
    public UInt32 id;
    public string name = null!;
}
