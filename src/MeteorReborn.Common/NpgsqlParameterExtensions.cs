// LANG-ADAPT — Npgsql 9 rechaza `AddWithValue("@x", uintValue)` porque uint no tiene PG type
// nativo (PG no tiene unsigned types). Las extension methods C# NO ganan sobre el
// `AddWithValue(string, object)` instance method (boxing siempre prefiere el instance), por eso
// se introduce un NUEVO nombre `AddParam` para forzar resolución por overload de extension.
//
// Comportamiento idéntico a PM (PM con MySql aceptaba uint directamente vía implicit conv).

using Npgsql;
using NpgsqlTypes;

namespace MeteorReborn.Common;

public static class NpgsqlParameterExtensions
{
    // Overloads tipados — el compilador elige el más específico antes de caer al object.
    public static NpgsqlParameter AddParam(this NpgsqlParameterCollection coll, string name, uint value)
        => coll.Add(new NpgsqlParameter(name, NpgsqlDbType.Bigint) { Value = (long)value });

    public static NpgsqlParameter AddParam(this NpgsqlParameterCollection coll, string name, ushort value)
        => coll.Add(new NpgsqlParameter(name, NpgsqlDbType.Smallint) { Value = (short)value });

    public static NpgsqlParameter AddParam(this NpgsqlParameterCollection coll, string name, ulong value)
        => coll.Add(new NpgsqlParameter(name, NpgsqlDbType.Numeric) { Value = (decimal)value });

    public static NpgsqlParameter AddParam(this NpgsqlParameterCollection coll, string name, sbyte value)
        => coll.Add(new NpgsqlParameter(name, NpgsqlDbType.Smallint) { Value = (short)value });

    public static NpgsqlParameter AddParam(this NpgsqlParameterCollection coll, string name, byte value)
        => coll.Add(new NpgsqlParameter(name, NpgsqlDbType.Smallint) { Value = (short)value });

    // Fallback object — para todo lo demás (string, int, long, bool, float, double, byte[], etc).
    public static NpgsqlParameter AddParam(this NpgsqlParameterCollection coll, string name, object value)
        => coll.AddWithValue(name, value ?? DBNull.Value);
}
