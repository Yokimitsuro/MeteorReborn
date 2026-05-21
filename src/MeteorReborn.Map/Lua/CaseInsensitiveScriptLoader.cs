// LANG-ADAPT (PM-MISSING — MR-original).
// PM corría en Windows (filesystem case-insensitive). Los scripts Lua hacen
// `require("battleUtils")` o `require("Ability")` pero los archivos en disco están en lowercase
// (battleutils.lua, ability.lua). En Linux/Docker es case-sensitive → MoonSharp falla.
//
// Este loader wrapea FileSystemScriptLoader y baja el modname a lowercase antes de resolver,
// reproduciendo el comportamiento Windows que PM asumía.

using MoonSharp.Interpreter;
using MoonSharp.Interpreter.Loaders;

namespace MeteorReborn.Map.Lua;

public class CaseInsensitiveScriptLoader : FileSystemScriptLoader
{
    public override string ResolveModuleName(string modname, Table globalContext)
        => base.ResolveModuleName(modname.ToLowerInvariant(), globalContext);
}
