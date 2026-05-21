// PM-COMPLETE → verbatim port de World Server/Program.cs (112 líneas).
// LANG-ADAPT: namespace + nullable + NLog→Serilog + MySql→Npgsql donde aplique.
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

using Serilog;
using MeteorReborn.World.DataObjects;
using Npgsql;
using NpgsqlTypes;

namespace MeteorReborn.World
{
    class Program
    {
        

        static void Main(string[] args)
        {
            // set up logging
            Log.Logger = new LoggerConfiguration().MinimumLevel.Debug().WriteTo.Console().CreateLogger();

            bool startServer = true;

            Log.Information("==================================");
            Log.Information("Project Meteor: World Server");
            Log.Information("Version: 0.1");            
            Log.Information("==================================");

#if DEBUG
            TextWriterTraceListener myWriter = new TextWriterTraceListener(System.Console.Out);
            Trace.Listeners.Add(myWriter);

            if (System.Diagnostics.Debugger.IsAttached)
            {
                System.Threading.Thread.Sleep(5000);
            }

#endif

            //Load Config
            ConfigConstants.Load();
            ConfigConstants.ApplyLaunchArgs(args);

            //Test DB Connection
            Log.Information("Testing DB connection... ");
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

            //Check World ID
            DBWorld thisWorld = Database.GetServer(ConfigConstants.DATABASE_WORLDID);
            if (thisWorld != null)
            {
                Log.Information("Successfully pulled world info from DB. Server name is {0}.", thisWorld.name);
                ConfigConstants.PREF_SERVERNAME = thisWorld.name;
            }
            else
            {
                Log.Information("World info could not be retrieved from the DB. Welcome and MOTD will not be displayed.");
                ConfigConstants.PREF_SERVERNAME = "Unknown";
            }
          
            //Start server if A-OK
            if (startServer)
            {
                Server server = new Server();                
                server.StartServer();

                while (startServer)
                {
                    String input = Console.ReadLine();
                    // LANG-ADAPT: en Docker sin TTY, Console.ReadLine() devuelve null inmediato
                    // y el loop quemaría 100% CPU. PM original siempre corría con consola real.
                    // Fix: cuando stdin está cerrado (EOF), bloquear con sleep largo (PM-faithful idle).
                    if (input == null) { System.Threading.Thread.Sleep(60000); continue; }
                    Log.Information("[Console Input] " + input);
                    //cp.DoCommand(input, null);
                }
            }

            Log.Information("Press any key to continue...");
            Console.ReadKey();
        }
    }
}
