// PM-MISSING (PM-faithful extension) → LANG-ADAPT bridge para Npgsql.
// PM código consume `MySqlDataReader.GetUInt32(string)`, `GetUInt16(string)`, `GetByte(string)`,
// `GetBoolean(string)` accessors-by-name. Npgsql `IDataReader` no tiene esos overloads.
// Estos extension methods exponen la misma API PM-faithful sobre cualquier `IDataReader`.
//
// LANG-ADAPT detalle: usan `Convert.To*` en vez de `GetFieldValue<T>` porque Postgres
// devuelve `integer` (int32) para columnas que PM esperaba como `smallint unsigned` (ushort).
// Convert hace cast permisivo (sin exact-match). Comportamiento idéntico a PM cuando los
// valores caben en el tipo destino.

using System.Data;

namespace MeteorReborn.Common;

public static class DataReaderExtensions
{
    // LANG-ADAPT (PM-faithful): MySqlDataReader.GetByte() / GetUInt16() etc. on signed
    // MySQL columns (e.g. tinyint(4)=-1) return the underlying *unsigned* representation
    // (0xFF=255). Postgres preserves sign (smallint -1), so Convert.ToByte(-1) throws.
    // We wrap with `unchecked` cast to reproduce MySQL's bit-preserving semantics.
    public static uint GetUInt32(this IDataReader r, string name) => WrapToUInt32(r.GetValue(r.GetOrdinal(name)));
    public static ushort GetUInt16(this IDataReader r, string name) => WrapToUInt16(r.GetValue(r.GetOrdinal(name)));
    public static ulong GetUInt64(this IDataReader r, string name) => WrapToUInt64(r.GetValue(r.GetOrdinal(name)));
    public static byte GetByte(this IDataReader r, string name) => WrapToByte(r.GetValue(r.GetOrdinal(name)));
    public static short GetInt16(this IDataReader r, string name) => Convert.ToInt16(r.GetValue(r.GetOrdinal(name)));
    public static int GetInt32(this IDataReader r, string name) => Convert.ToInt32(r.GetValue(r.GetOrdinal(name)));
    public static long GetInt64(this IDataReader r, string name) => Convert.ToInt64(r.GetValue(r.GetOrdinal(name)));
    public static bool GetBoolean(this IDataReader r, string name) => Convert.ToBoolean(r.GetValue(r.GetOrdinal(name)));
    public static string GetString(this IDataReader r, string name) => Convert.ToString(r.GetValue(r.GetOrdinal(name)))!;
    public static float GetFloat(this IDataReader r, string name) => Convert.ToSingle(r.GetValue(r.GetOrdinal(name)));
    public static double GetDouble(this IDataReader r, string name) => Convert.ToDouble(r.GetValue(r.GetOrdinal(name)));

    // Overloads por ordinal
    public static uint GetUInt32(this IDataReader r, int ordinal) => WrapToUInt32(r.GetValue(ordinal));
    public static ushort GetUInt16(this IDataReader r, int ordinal) => WrapToUInt16(r.GetValue(ordinal));
    public static ulong GetUInt64(this IDataReader r, int ordinal) => WrapToUInt64(r.GetValue(ordinal));

    // LANG-ADAPT: `IDataReader.GetByte(int) / GetInt16(int) / GetInt32(int)` son métodos
    // interface estrictos (Npgsql falla si PG type no matchea exactamente CLR type). PM esperaba
    // MySQL permisivo. Estas extensiones con nombre distinto (-At suffix) evitan la colisión
    // con el instance method y aplican Convert.To* permisivo idéntico a MySqlConnector.
    public static byte GetByteAt(this IDataReader r, int ordinal) => WrapToByte(r.GetValue(ordinal));
    public static short GetInt16At(this IDataReader r, int ordinal) => Convert.ToInt16(r.GetValue(ordinal));
    public static int GetInt32At(this IDataReader r, int ordinal) => Convert.ToInt32(r.GetValue(ordinal));
    public static long GetInt64At(this IDataReader r, int ordinal) => Convert.ToInt64(r.GetValue(ordinal));

    // PM-faithful wrap helpers: cast through signed→unsigned bit pattern when source is signed.
    private static byte WrapToByte(object v) => v switch
    {
        sbyte sb => unchecked((byte)sb),
        short s  => unchecked((byte)s),
        int i    => unchecked((byte)i),
        long l   => unchecked((byte)l),
        _        => Convert.ToByte(v),
    };
    private static ushort WrapToUInt16(object v) => v switch
    {
        short s => unchecked((ushort)s),
        int i   => unchecked((ushort)i),
        long l  => unchecked((ushort)l),
        _       => Convert.ToUInt16(v),
    };
    private static uint WrapToUInt32(object v) => v switch
    {
        int i   => unchecked((uint)i),
        long l  => unchecked((uint)l),
        _       => Convert.ToUInt32(v),
    };
    private static ulong WrapToUInt64(object v) => v switch
    {
        long l  => unchecked((ulong)l),
        _       => Convert.ToUInt64(v),
    };

    public static T GetFieldValue<T>(this IDataReader r, string name) where T : notnull
    {
        int ordinal = r.GetOrdinal(name);
        if (r is System.Data.Common.DbDataReader dbr)
            return dbr.GetFieldValue<T>(ordinal);
        return (T)r.GetValue(ordinal);
    }
}
