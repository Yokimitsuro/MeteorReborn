---
title: How the port was done
description: Translation rules from PM .NET Framework + MySQL + NLua to MR .NET 10 + Postgres + MoonSharp.
---

Project Meteor (PM) originally runs on .NET Framework + MySQL + NLua + Mono.
Meteor Reborn (MR) moves it to **.NET 10 + PostgreSQL + Npgsql + MoonSharp +
Serilog**, while keeping the wire-level bytes byte-exact with what the 1.23b
client expects.

Every change against PM falls into one of four categories. Look for these
prefixes in the code (`// PM-...`, `// FINISH-PM`, `// LANG-ADAPT`).

## Categories

### PM-COMPLETE — verbatim port

The file existed in PM and was copied byte-by-byte to MR, with citations like
`// PM-COMPLETE → verbatim port de Map Server/Server.cs (PM:42-87)`.

These are the bulk of the C# code. Pure mechanical translation of types,
namespaces (`FFXIVClassic_*` → `MeteorReborn.*`) and `using` directives.

### PM-INCOMPLETE — finished by MR

PM had the logic started but unfinished — usually a method stub, a
half-implemented packet, or dead code paths. MR completes it.

Example: PM's `Player.SendZoneInPackets()` had the structure but didn't actually
queue `SetMap` / `SetMusic` for some cases. The MR version finishes the chain.

### PM-MISSING + FINISH-PM — MR-original additions

PM didn't implement it, but the 1.23b client requires it for the modern stack
to work. MR adds it tagged with `// FINISH-PM:`.

Concrete examples:

- **HTTP Login server** (`MeteorReborn.Login`) — PM had a PHP/WAMP login service
  PM never ported to C#. MR's `MeteorReborn.Login` is a minimal ASP.NET service
  that exposes `/api/account` + `/api/auth/login` and writes to the same
  `sessions` table.

- **`DataReaderExtensions.cs`** — PM read MySQL `tinyint unsigned` directly via
  `MySqlDataReader.GetByte`. Npgsql is strict and reads Postgres `smallint` as
  `Int16` — even when the column holds `-1` as a sentinel. MR wraps via
  `unchecked` cast to preserve PM's bit-pattern semantics.

- **`NpgsqlParameterExtensions.cs` + `AddParam`** — Npgsql 9 won't infer the
  Postgres type from raw `uint`. We renamed all 148 PM `AddWithValue(@p, uint)`
  callsites to `AddParam(@p, uint)`, which routes through a typed extension
  that casts to `(long) → Bigint`.

### LANG-ADAPT — stack adaptation, behavior identical

Adaptations purely driven by the .NET 10 / Postgres / MoonSharp / WPF stack.
Must be **observably identical** to PM behavior.

Examples:

- `Ionic.Zlib.ZlibStream` → `System.IO.Compression.ZLibStream`
- `NLog` → `Serilog` — `Log.Info(...)` → `Log.Information(...)`
- `cmd.LastInsertedId` (MySQL auto-increment) → `INSERT ... RETURNING id` + `ExecuteScalar`
- `ON DUPLICATE KEY UPDATE` → `ON CONFLICT (pk) DO UPDATE SET col = EXCLUDED.col`
- `GROUP BY bsl.bnpcId` → `SELECT DISTINCT ON (bsl.bnpcId)` (Postgres equivalent of MySQL's permissive group-by)
- `IPAddress.Parse(host)` (only literal IPs) → `IPAddress.TryParse` + `Dns.GetHostAddresses` fallback (so service names like `map` work)
- NLua silent member-miss → MoonSharp strict; fix call sites or `CaseInsensitiveScriptLoader`
- `Console.ReadLine()` blocking → in Docker, returns null instantly. Added sleep-on-EOF guard so servers don't burn 100% CPU in containerized environments.

## Configuration

Configs live in `data/config/*.ini` (4 files). Docker copies them into each
container at build time. Native mode requires copying them to each service's
working directory manually.

The `.ini` format is read by `STA_INIFile.cs` (PM-COMPLETE verbatim). MR's
Docker variants use `host=postgres`/`server_ip=map` (Docker service DNS); the
README and `getting-started/native` page document how to switch them back to
`127.0.0.1` for non-Docker setups.

## Reading the code

When you open a file in `src/`, the top comment tells you which mode it's in:

```csharp
// PM-COMPLETE → verbatim port de Map Server/Actors/StaticActors.cs (146 líneas).
// LANG-ADAPT: namespace + nullable + NLog→Serilog.
```

If a method has a `// FINISH-PM:` comment inside, that's the MR-finished bit
(PM had a stub there). If you see `// LANG-ADAPT:`, that's an adaptation that
preserves PM behavior on the modern stack.

That convention makes it easy to:

- **Audit** how much of MR is faithful PM vs new code
- **Compare back** with PM source on the cited file/line
- **Triage bugs**: PM-INCOMPLETE areas are the likeliest source of issues
