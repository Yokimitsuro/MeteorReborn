---
title: Recipes — how to add X
description: Step-by-step guides for the most common contribution patterns.
---

## Add a new GM command

**Goal**: typing `!mything <args>` in chat fires your code.

1. Create `data/scripts/commands/gm/mything.lua`:

   ```lua
   require("global");

   properties = {
       permissions = 0,
       parameters = "ds",   -- "d"=decimal, "s"=string, "ds"=int+string, etc.
       description = "Demo command — echoes input.",
   }

   function onTrigger(player, argc, count, message)
       if (count == nil or message == nil) then
           player:SendMessage(0x20, "", "Usage: !mything <n> <text>");
           return;
       end
       for i = 1, count do
           player:SendMessage(0x20, "", i .. ": " .. message);
       end
   end;
   ```

2. Restart map (`docker compose restart map`) — file index is built at startup.
3. In-game: `!mything 3 hello` → prints "1: hello", "2: hello", "3: hello".
4. Update [GM commands reference](/MeteorReborn/reference/gm-commands/) with
   your new command in the relevant table.

## Add a new packet handler

**Goal**: when the client sends opcode `0xABCD`, route it to a new C# handler.

1. Define the receive packet in `src/MeteorReborn.Map/Packets/Receive/`:

   ```csharp
   // PM-MISSING (FINISH-PM): handler for opcode 0xABCD (client → server,
   // <describe purpose>).
   public class MyReceivePacket {
       public uint someField;
       public string someText;

       public MyReceivePacket(byte[] data) {
           using var ms = new MemoryStream(data);
           using var r = new BinaryReader(ms);
           someField = r.ReadUInt32();
           someText = Encoding.ASCII.GetString(r.ReadBytes(32)).TrimEnd('\0');
       }
   }
   ```

2. Define the response packet in `src/MeteorReborn.Map/Packets/Send/`:

   ```csharp
   public class MyResponsePacket {
       public const ushort OPCODE = 0xABCE;
       public const uint PACKET_SIZE = 0x40;

       public static SubPacket BuildPacket(uint sourceId, uint replyValue) {
           byte[] data = new byte[PACKET_SIZE];
           using var ms = new MemoryStream(data);
           using var w = new BinaryWriter(ms);
           w.Write(replyValue);
           return new SubPacket(OPCODE, sourceId, data);
       }
   }
   ```

3. Wire the case in `src/MeteorReborn.Map/PacketProcessor.cs`:

   ```csharp
   case 0xABCD:
       var p = new MyReceivePacket(subpacket.data);
       // ... handle p.someField etc.
       session.QueuePacket(MyResponsePacket.BuildPacket(session.id, ...));
       client.FlushQueuedSendPackets();      // critical — see port-notes
       break;
   ```

4. Update [game opcodes reference](/MeteorReborn/reference/game-opcodes/) with
   the new opcode in the relevant table.

## Add a new Lua NPC

**Goal**: a populace NPC at coordinates X/Y/Z in zone Z that says hi.

1. Pick an actor class from `gamedata_actor_class` (or create a new one if
   the model exists in the client). For a generic populace, use one of the
   `Populace*` classes:

   ```sql
   SELECT id, classpath FROM gamedata_actor_class
   WHERE classpath LIKE '%/Populace%' LIMIT 5;
   ```

2. Insert a row in `server_spawn_locations`:

   ```sql
   INSERT INTO server_spawn_locations (actorclassid, uniqueid, zoneid,
       privateareaname, privatearealevel, positionx, positiony, positionz,
       rotation, motionpack)
   VALUES (1000123, 'mynpc_001', 170, '', 0, 25.0, 200.0, -450.0, 0, 0);
   ```

3. Create the Lua at `data/scripts/unique/wil0Field01/PopulaceStandard/mynpc_001.lua`:

   ```lua
   require("global");

   function init(player, npc)
       return "/Chara/Npc/Populace/PopulaceStandard", false, false, false,
              false, false, 0, 0;
   end

   function onEventStart(player, npc, triggerName)
       player:SendMessage(0x20, "", "Hello, traveler!");
   end
   ```

4. Restart map. The NPC should spawn at your coordinates.

## Add a new SQL table or import

**Goal**: bring data from an external dump into the schema.

1. Convert the MySQL dump:

   ```bash
   python tools/sql_mysql_to_postgres.py source.sql data/sql/newtable.sql
   ```

2. If new table has camelCase columns, append ALTER statements to
   `data/sql/zz_lowercase_cols.sql`:

   ```sql
   ALTER TABLE "newtable" RENAME COLUMN "someCol" TO somecol;
   ```

3. Test locally:

   ```bash
   docker exec -i meteorreborn-postgres psql -U meteor -d meteor < data/sql/newtable.sql
   docker exec -i meteorreborn-postgres psql -U meteor -d meteor < data/sql/zz_lowercase_cols.sql
   ```

4. To reset the DB and re-init from scratch with the new files:

   ```bash
   docker compose down -v   # wipes postgres-data volume
   docker compose up -d
   ```

5. If new table needs to be read by .NET code, add a loader in the
   appropriate service (e.g. `WorldManager.LoadX()` for map). Reference an
   existing loader like `LoadActorClasses()` as a template.

6. Update [database schema](/MeteorReborn/architecture/database/) with the
   new table in the relevant group.

## Add a new launcher feature

**Goal**: change UI or behavior in `tools/MeteorReborn.Launcher`.

1. The launcher is a single-window WPF app. Most state lives in
   `MainWindow.xaml.cs` and persists to `%APPDATA%\MeteorReborn\launcher.json`.
2. For new settings, add a field to `LauncherSettings` and a corresponding
   `TextBox` in `MainWindow.xaml`.
3. For new behaviors (e.g. CRC verification on patches), the relevant files
   are:

   | File | What lives here |
   |------|-----------------|
   | `MainWindow.xaml.cs` | UI events, settings load/save |
   | `GameLauncher.cs` | Process spawn + memory patching |
   | `PatchFile.cs` | ZIPATCH parser |
   | `Patcher.cs` | Download + apply pipeline |
   | `VersionChecker.cs` | game.ver lookup |
   | `PatcherWindow.xaml.cs` | Patch progress modal |

4. Build & test:

   ```bash
   cd tools/MeteorReborn.Launcher
   dotnet build -c Release
   .\bin\Release\net10.0-windows\MeteorReborn.Launcher.exe
   ```

5. Update [launcher setup](/MeteorReborn/getting-started/launcher/) docs if
   user-visible.

## Add a new docs page

**Goal**: extend this site.

1. Create the Markdown file at `docs/src/content/docs/<section>/<slug>.md`:

   ```markdown
   ---
   title: My new page
   description: Short description for SEO / search.
   ---

   Content goes here. Markdown + a few [Starlight components](https://starlight.astro.build/components/).
   ```

2. Add the page to the sidebar in `docs/astro.config.mjs`:

   ```js
   {
       label: 'My section',
       items: [
           { label: 'My new page', slug: 'my-section/my-new-page' },
           // ...
       ],
   },
   ```

3. Test locally:

   ```bash
   cd docs
   npm run dev
   # browse http://localhost:4321/MeteorReborn/my-section/my-new-page/
   ```

4. `npm run build` — must succeed with 0 errors.

5. Open a PR. On merge to `master`, the deploy workflow publishes
   automatically.
