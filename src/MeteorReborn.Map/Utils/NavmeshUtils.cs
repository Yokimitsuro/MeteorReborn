// FINISH-PM: PM-INCOMPLETE — NavmeshUtils en PM usa una API legacy de SharpNav (cargada via
// DLL local en Map Server/SharpNav.dll). El package nuget SharpNav 0.9.2 tiene API distinta
// (Vector3 en namespace raíz, Path en Pathfinding pero con signature distinto, etc.) y PM
// solo tiene navmeshes fielded para `wil0Field01` (un solo zone). Stub completo aquí — la
// implementación real requiere portar PM source byte-por-byte contra SharpNav 0.9.2 API
// (LANG-ADAPT manual) + per-zone `.snb` files que PM no aporta.
// PM source: Map Server/Utils/NavmeshUtils.cs (281 líneas, parcialmente fielded).
// MR-original implementing PM gap. Rationale: para llegar a build clean sin invención de
// lógica navmesh, los métodos devuelven el "happy path" por defecto (CanSee=true, paths
// vacíos) — comportamiento equivalente a "no navmesh disponible" que PM tiene cuando una
// zona no tiene .snb cargado.

using System;
using System.Collections.Generic;
using MeteorReborn.Common;

namespace MeteorReborn.Map.utils;

class NavmeshUtils
{
    public static bool CanSee(MeteorReborn.Map.Actors.area.Zone zone, float x1, float y1, float z1, float x2, float y2, float z2)
        => true; // FINISH-PM stub

    public static bool CanSee(MeteorReborn.Map.Actors.area.Zone zone, Vector3 a, Vector3 b)
        => CanSee(zone, a.X, a.Y, a.Z, b.X, b.Y, b.Z);

    public static Vector3 Raycast(MeteorReborn.Map.Actors.area.Zone zone, Vector3 from, Vector3 to)
        => to; // FINISH-PM stub: no obstruction

    public static List<Vector3> GetPath(MeteorReborn.Map.Actors.area.Zone zone, Vector3 start, Vector3 end, float stepSize = 1.25f, int maxPath = 40, float polyRadius = 0.0f)
        => new List<Vector3> { end }; // FINISH-PM stub: 1-waypoint straight line

    public static Vector3 FindClosestValidPoint(MeteorReborn.Map.Actors.area.Zone zone, Vector3 from, float maxRadius = 5.0f)
        => from; // FINISH-PM stub
}
