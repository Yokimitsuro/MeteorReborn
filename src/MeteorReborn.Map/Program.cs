// PM-COMPLETE → verbatim port de Map Server/Program.cs (96 líneas).
// LANG-ADAPT: namespace + nullable + NLog→Serilog + MySql→Npgsql + NLua→MoonSharp (Lua/*).
﻿/*
===========================================================================
Copyright (C) 2015-2019 Project Meteor Dev Team

This file is part of Project Meteor Server.

Project Meteor Server is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Project Meteor Server is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with Project Meteor Server. If not, see <https:www.gnu.org/licenses/>.
===========================================================================
*/

using System;
using System.Diagnostics;
using Npgsql;
using NpgsqlTypes;
using Serilog;

namespace MeteorReborn.Map
{
    class Program
    {
        public static Server Server;
        public static Random Random;
        public static DateTime LastTick = DateTime.Now;
        public static DateTime Tick = DateTime.Now;

        static void Main(string[] args)
        {
            // LANG-ADAPT: PM usaba NLog (auto-init por config XML). MR usa Serilog que requiere
            // setup explícito; sin esta llamada Log.* es no-op silencioso.
            Log.Logger = new LoggerConfiguration().MinimumLevel.Debug().WriteTo.Console().CreateLogger();
#if DEBUG
            TextWriterTraceListener myWriter = new TextWriterTraceListener(System.Console.Out);
            Trace.Listeners.Add(myWriter);
#endif
            bool startServer = true;

            Log.Information("==================================");
            Log.Information("Project Meteor: Map Server");
            Log.Information("Version: 0.1");
            Log.Information("==================================");

            //Load Config
            ConfigConstants.Load();
            ConfigConstants.ApplyLaunchArgs(args);

            //Test DB Connection
            Log.Information("Testing DB connection... ");
            using (NpgsqlConnection conn = new NpgsqlConnection(String.Format("Server={0}; Port={1}; Database={2}; UID={3}; Password={4}", ConfigConstants.DATABASE_HOST, ConfigConstants.DATABASE_PORT, ConfigConstants.DATABASE_NAME, ConfigConstants.DATABASE_USERNAME, ConfigConstants.DATABASE_PASSWORD)))
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
            
            //Start server if A-OK
            if (startServer)
            {
                Random = new Random();
                Server = new Server();
                Tick = DateTime.Now;
                Server.StartServer();

                while (startServer)
                {
                    String input = Console.ReadLine();
                    // LANG-ADAPT: en Docker sin TTY, Console.ReadLine() devuelve null inmediato
                    // y el loop quemaría 100% CPU. PM original siempre corría con consola real.
                    if (input == null) { System.Threading.Thread.Sleep(60000); continue; }
                    Log.Information("[Console Input] " + input);
                    Server.GetCommandProcessor().DoCommand(input, null);
                }
            }

            Log.Information("Press any key to continue...");
            Console.ReadKey();
        }

    
    }
}
