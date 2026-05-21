// PM-COMPLETE → verbatim port de Lobby Server/ConfigConstants.cs (PM:22-111).
// LANG-ADAPT: namespace + NLog `Program.Log` → Serilog `Log`. Comportamiento idéntico.

using System;
using System.IO;
using System.Linq;
using System.Net;

using MeteorReborn.Common;
using Serilog;

namespace MeteorReborn.Lobby;

class ConfigConstants
{
    public static String OPTIONS_BINDIP = null!;
    public static String OPTIONS_PORT = null!;
    public static bool OPTIONS_TIMESTAMP = false;

    public static String DATABASE_HOST = null!;
    public static String DATABASE_PORT = null!;
    public static String DATABASE_NAME = null!;
    public static String DATABASE_USERNAME = null!;
    public static String DATABASE_PASSWORD = null!;

    public static bool Load()
    {
        Log.Information("Loading lobby_config.ini file");

        if (!File.Exists("./lobby_config.ini"))
        {
            Log.Error("FILE NOT FOUND!");
            Log.Error("Loading defaults...");
        }

        INIFile configIni = new INIFile("./lobby_config.ini");

        ConfigConstants.OPTIONS_BINDIP =        configIni.GetValue("General", "server_ip", "127.0.0.1");
        ConfigConstants.OPTIONS_PORT =          configIni.GetValue("General", "server_port", "54994");
        ConfigConstants.OPTIONS_TIMESTAMP =     configIni.GetValue("General", "showtimestamp", "true").ToLower().Equals("true");

        ConfigConstants.DATABASE_HOST =         configIni.GetValue("Database", "host", "");
        ConfigConstants.DATABASE_PORT =         configIni.GetValue("Database", "port", "");
        ConfigConstants.DATABASE_NAME =         configIni.GetValue("Database", "database", "");
        ConfigConstants.DATABASE_USERNAME =     configIni.GetValue("Database", "username", "");
        ConfigConstants.DATABASE_PASSWORD =     configIni.GetValue("Database", "password", "");

        return true;
    }
    public static void ApplyLaunchArgs(string[] launchArgs)
    {
        var args = (from arg in launchArgs select arg.ToLower().Trim().TrimStart('-')).ToList();

        for (var i = 0; i + 1 < args.Count; i += 2)
        {
            var arg = args[i];
            var val = args[i + 1];
            var legit = false;

            if (arg == "ip")
            {
                IPAddress ip;
                if (IPAddress.TryParse(val, out ip!) && (legit = true))
                    OPTIONS_BINDIP = val;
            }
            else if (arg == "port")
            {
                UInt16 port;
                if (UInt16.TryParse(val, out port) && (legit = true))
                    OPTIONS_PORT = val;
            }
            else if (arg == "user" && (legit = true))
            {
                DATABASE_USERNAME = val;
            }
            else if (arg == "p" && (legit = true))
            {
                DATABASE_PASSWORD = val;
            }
            else if (arg == "db" && (legit = true))
            {
                DATABASE_NAME = val;
            }
            else if (arg == "host" && (legit = true))
            {
                DATABASE_HOST = val;
            }
            if (!legit)
            {
                Log.Error("Invalid parameter <{Val}> for argument: <--{Arg}> or argument doesnt exist!", val, arg);
            }
        }
    }
}
