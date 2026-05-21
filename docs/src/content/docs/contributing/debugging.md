---
title: Debugging
description: Common failure modes, how to diagnose them, and how to fix.
---

## Service won't start

### "Listening on port already in use"

Another process owns the port. On Windows:

```powershell
netstat -ano | findstr :1989
taskkill /pid <pid> /f
```

Or restart Docker (`docker compose down`) and try again.

### "Cannot connect to postgres"

The DB container isn't healthy yet. Check:

```bash
docker compose ps                       # postgres should say "Up X (healthy)"
docker compose logs postgres | tail -30
```

If init scripts are still loading (first boot), wait. If they failed, look for
errors in the log and fix the offending SQL file.

### Map server "Could not find staticactors.bin"

Working directory issue. The map server reads from `./staticactors.bin`
relative to its CWD. In Docker that's `/app/staticactors.bin` and the
Dockerfile copies it. In native mode, copy:

```bash
cp data/staticactors.bin src/MeteorReborn.Map/
cp -r data/scripts src/MeteorReborn.Map/
```

…before `dotnet run`.

## Client crashes / disconnects

### After PLAY in launcher, ffxivgame.exe closes immediately

The in-memory patch didn't apply. Check the launcher's status panel — it
should say `ffxivgame.exe lanzado (PID ...)`. If `WriteProcessMemory failed`,
the RVAs don't match your client binary.

Verify version:

```bash
# Read game.ver from your install
type "E:\Program Files (x86)\SquareEnix\FINAL FANTASY XIV\game.ver"
# Should be 2012.09.19.0001
```

If older, let the launcher patch first.

### Client reaches lobby but disconnects on character select

That's the known [zone-in incomplete](/MeteorReborn/project/unfinished-content/#zone-in-chain-incomplete)
issue. Map server creates the session but doesn't flush all required packets,
so the client times out around 12 seconds.

Diagnose with:

```bash
docker compose logs -f map | grep -E "Session|Loaded|spawn|disconnect"
```

You should see `Loaded session list` followed by silence — that's the bug
firing.

### Lua script error log filling the screen

```
[ERR] LuaEngine.RunGMCommand: ./scripts/X.lua - cannot access field Y of userdata<Z>
```

PM script calls a C# member that doesn't exist (NLua silently ignored;
MoonSharp surfaces). Find and patch the script:

```bash
grep -rn "\\.<missing_member>(" data/scripts/
```

Usually you can comment the line and add a `-- FINISH-PM:` note, as we did
in `data/scripts/commands/gm/spawn.lua` for `actor.SetAppearance`.

## Database issues

### "column X does not exist" / camelCase complaints

Map server queries lowercase column names (after `zz_lowercase_cols.sql`
migration). If you imported a new SQL dump and forgot to add lowercase
ALTERs, you'll get errors like:

```
column "actorClassId" does not exist
HINT: Perhaps you meant to reference the column "X.actorclassid".
```

Fix: append the missing ALTERs to `data/sql/zz_lowercase_cols.sql`:

```sql
ALTER TABLE "newtable" RENAME COLUMN "someCamelCol" TO somecamelcol;
```

…and apply them live:

```bash
docker exec -i meteorreborn-postgres psql -U meteor -d meteor < data/sql/zz_lowercase_cols.sql
```

### "Writing values of 'System.UInt32' is not supported..."

You added a `cmd.Parameters.AddWithValue("@x", someUint)` call. Npgsql 9
can't infer the Postgres type from raw `uint`. Two fixes:

- Use the existing `AddParam` extension (it's the renamed version that
  handles the conversion):

  ```csharp
  cmd.Parameters.AddParam("@x", someUint);
  ```

- Or cast at the call site:

  ```csharp
  cmd.Parameters.AddWithValue("@x", (long)someUint);
  ```

### "Convert.ToByte" overflow

PM stored `tinyint(4)` columns that allow negative values; MySQL's
`GetByte()` wraps them to unsigned (-1 → 0xFF). Postgres preserves the sign,
so `(byte)Convert.ToByte(-1)` overflows.

Use the `DataReaderExtensions.GetByte` method (already in MeteorReborn.Common)
instead of the built-in `reader.GetByte(int)`:

```csharp
// Instead of:
byte b = reader.GetByte("recastGroup");
// Use:
byte b = reader.GetByte("recastGroup");   // routes through unchecked cast
```

Same applies for `GetInt16`, `GetUInt16`, `GetUInt32`, etc.

## Performance / resource issues

### Map server burning 100% CPU at idle

PM uses `Console.ReadLine()` to keep the main thread alive. In Docker
without a TTY, `Console.ReadLine()` returns `null` immediately and the loop
spins.

We patched `Program.cs` to fall back to `Thread.Sleep(60000)` on EOF:

```csharp
while (startServer) {
    string input = Console.ReadLine();
    if (input == null) { Thread.Sleep(60000); continue; }
    Server.GetCommandProcessor().DoCommand(input, null);
}
```

If you see this regress after a refactor, that's the cause.

### Postgres grows unbounded

The session table accumulates rows over time (we don't clean expired
sessions automatically). Periodic cleanup:

```sql
DELETE FROM sessions WHERE expiration < NOW();
```

Add a scheduled task or cron job if you run a public server.

## Networking issues

### World → Map "Failed to connect"

The world server reads `server_zones.serverip` to find its map server.
Default value is `'map'` (Docker DNS name).

- **Docker mode**: world container resolves `map` via docker DNS — should work
- **Native mode**: needs `UPDATE server_zones SET serverip='127.0.0.1';`

If you see the error in Docker, check map is listening:

```bash
docker exec meteorreborn-map ss -tln | grep 1989
```

### Client can't reach lobby

Launcher writes `LobbyHostNameRva` (up to 20 bytes at `imageBase + 0xB90110`)
into the client. If the host you typed in **Lobby server** field doesn't
match a routable IP from the client's perspective, the client can't connect.

`127.0.0.1` works when client + Docker run on the same Windows host (port
forward). For LAN access, use the host's LAN IP and ensure the firewall
allows TCP 54994 inbound.

## Tools to know

- `docker compose logs -f <service>` — live tail
- `docker compose exec <service> sh` — get a shell inside a container
- `docker exec -it meteorreborn-postgres psql -U meteor -d meteor` — DB CLI
- Wireshark filter `tcp.port == 1989` — capture map traffic
- `!getinfo <actorId>` in-game — dump everything about an actor
- `!sendpacket <opcode> <hexbytes>` — send a raw packet without recompiling

## When stuck

1. Check `docker compose logs -f` for **all** services — the error might be
   one service away from where you're looking
2. Reproduce in a minimal way (single test account, single zone)
3. `git bisect` between a known-working tag (e.g. `v0.1.0`) and HEAD
4. Open an issue with the logs, your `git describe`, and reproduction steps
