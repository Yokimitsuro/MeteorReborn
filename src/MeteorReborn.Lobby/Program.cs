// PM-COMPLETE → verbatim port de Lobby Server/Program.cs (PM:22-87).
// LANG-ADAPT: namespace + NLog `LogManager.GetCurrentClassLogger()` → Serilog `Log.Logger`
// configurado en Main. `MySqlConnection` → `NpgsqlConnection`. Comportamiento idéntico.
// `Program.Log` campo público estático eliminado: Serilog usa `Log.Information/Error` global
// (PM lo usaba via `Program.Log.Info(...)` que en MR ya se traduce a `Serilog.Log.Information(...)`).

using System;
using System.Diagnostics;
using System.Threading;

using Npgsql;
using Serilog;

namespace MeteorReborn.Lobby;

class Program
{
    static void Main(string[] args)
    {

        // set up logging
        Log.Logger = new LoggerConfiguration()
            .MinimumLevel.Debug()
            .WriteTo.Console()
            .CreateLogger();
#if DEBUG
        TextWriterTraceListener myWriter = new TextWriterTraceListener(System.Console.Out);
        Trace.Listeners.Add(myWriter);
#endif
        Log.Information("==================================");
        Log.Information("Project Meteor: Lobby Server");
        Log.Information("Version: 0.1");
        Log.Information("==================================");

        bool startServer = true;

        //Load Config
        ConfigConstants.Load();
        ConfigConstants.ApplyLaunchArgs(args);

        //Test DB Connection
        Log.Information("Testing DB connection to \"{Host}\"... ", ConfigConstants.DATABASE_HOST);
        using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Host={0}; Port={1}; Database={2}; Username={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
        {
            try
            {
                conn.Open();
                conn.Close();

                Log.Information("Connection ok.");
            }
            catch (NpgsqlException e)
            {
                Log.Error(e.ToString());
                startServer = false;
            }
        }

        //Start Server if A-OK
        if (startServer)
        {
            Server server = new Server();
            server.StartServer();
            while (true) Thread.Sleep(10000);
        }

        Log.Information("Press any key to continue...");
        Console.ReadKey();
    }


}
