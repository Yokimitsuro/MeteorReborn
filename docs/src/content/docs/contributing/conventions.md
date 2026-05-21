---
title: Code conventions
description: The four PM-mode classifiers and how to apply them to your changes.
---

Every code change in Meteor Reborn falls into exactly one of four classifiers.
These show up as comments at the top of files and inline near tricky bits,
and they're the **most important** convention in the codebase — they make
the relationship between MR and Project Meteor explicit and auditable.

## The four classifiers

### PM-COMPLETE — verbatim port

The file (or block) existed in PM and was copied byte-by-byte to MR, with a
citation pointing back to the original source.

File-header form:

```csharp
// PM-COMPLETE → verbatim port de Map Server/Actors/StaticActors.cs (146 líneas).
// LANG-ADAPT: namespace + nullable + NLog→Serilog.
```

Most files are PM-COMPLETE. They contain the literal PM behavior translated
to .NET 10 syntax. **Don't refactor PM-COMPLETE code "for clarity"** — doing
so makes diffs against PM unreadable and hides real fixes inside cosmetic
changes.

When to use it: when you ported (or are about to port) a file from PM as-is.

### PM-INCOMPLETE — finished by MR

PM had the logic started but unfinished. MR completes it.

Example:

```csharp
public void DoZoneIn(Player player, ushort spawnType) {
    // PM-INCOMPLETE: PM stopped at DeleteAllActorsPacket; the rest of the
    // chain (SetMap/SetMusic/SetWeather + player spawn + inventory) was
    // never wired. Finishing here per the protocol the 1.23b client expects.
    player.playerSession.QueuePacket(DeleteAllActorsPacket.BuildPacket(...));
    QueuePacket(SetMusicPacket.BuildPacket(...));
    QueuePacket(SetWeatherPacket.BuildPacket(...));
    // ...
}
```

When to use it: PM had a stub or partial implementation, and you completed it
based on protocol knowledge (not new content design).

### PM-MISSING + FINISH-PM — MR-original addition

PM didn't have it at all, but the 1.23b client expects it for the modern
stack to work. MR adds it tagged with `FINISH-PM`.

Examples in the codebase today:

- **`MeteorReborn.Login`** — the entire HTTP login service. PM had a PHP/WAMP
  external login; MR ported its responsibility into C# because we don't run
  PHP. Files marked `// FINISH-PM: PM-MISSING — PM no tiene Login Server HTTP.`
- **`DataReaderExtensions.cs`** in Common — bridging Npgsql's strict typing
  back to PM's MySQL semantics (`tinyint(4) = -1` → `byte 0xFF`).
- **`NpgsqlParameterExtensions.cs` + `AddParam` rename** — 148 call sites
  renamed from `AddWithValue` because Npgsql 9 won't infer Postgres type
  from raw `uint`.

When to use it: when you have to add something PM lacked entirely. **Cite the
gap explicitly** in the FINISH-PM comment.

### LANG-ADAPT — stack adaptation, behavior identical

A change driven purely by the .NET 10 / Postgres / MoonSharp / WPF stack
where the observable behavior is **identical** to PM.

Examples:

```csharp
// LANG-ADAPT: NLog Log.Info → Serilog Log.Information
Log.Information("Loaded {0} actor classes.", count);

// LANG-ADAPT: MySQL `cmd.LastInsertedId` → Postgres `INSERT ... RETURNING id`.
cid = (uint)(long)cmd.ExecuteScalar()!;

// LANG-ADAPT: MySQL `ON DUPLICATE KEY` → Postgres `ON CONFLICT DO UPDATE`.
```

When to use it: when the change is mechanical translation of one library /
DB / language feature to another, with no functional difference visible to
the client.

If your change isn't observably identical, it's PM-INCOMPLETE or PM-MISSING,
not LANG-ADAPT.

## File header pattern

New `.cs` files start with:

```csharp
// PM-{COMPLETE|INCOMPLETE|MISSING} → <one-line summary>.
// {Cite PM source if applicable: PM/<file>:<lines>}
// LANG-ADAPT: <list adaptations from PM>.

using ...;
```

For files that are 100% MR-original (no PM ancestor), use `PM-MISSING (MR-original
infrastructure)` as the first line.

## Inline annotations

Inside a method, annotate non-obvious lines with the appropriate classifier:

```csharp
public byte GetByte(int ordinal) {
    var v = reader.GetValue(ordinal);
    // LANG-ADAPT: PM's MySqlDataReader.GetByte() returns the underlying
    // unsigned byte even for tinyint(4) signed columns (e.g. -1 → 0xFF).
    // Npgsql preserves sign in Int16 — wrap with unchecked to match.
    if (v is short s) return unchecked((byte)s);
    return Convert.ToByte(v);
}
```

These annotations help future readers (including you in 6 months) understand
why the code is the way it is.

## Naming

Match PM's case style:

- **Classes**: `PascalCase` (`Server`, `Player`, `BattleNpc`)
- **Methods**: `PascalCase` (`LoadActorClasses`, `SendZoneInPackets`)
- **Fields**: `camelCase` (`actorId`, `currentZoneId`)
- **Locals**: `camelCase` (`int count = 0`)
- **Constants**: `UPPER_SNAKE_CASE` (`STATIC_ACTORS_PATH`)
- **Namespaces**: `MeteorReborn.<Service>.<Subarea>`

Some files use lowercase namespaces (`player`, `npc`, `director`, `state`,
`group`, `area`) to avoid CS0118 type/namespace collisions. That's
intentional — see `GlobalUsings.cs` in Map.

## Don't

- ❌ Reformat existing PM-COMPLETE code "while you're there"
- ❌ Rename PM fields without a structural reason (breaks the audit trail)
- ❌ Add LINQ where PM uses imperative loops (PM perf characteristics vs LINQ allocations is unproven)
- ❌ Introduce dependencies PM didn't have without a `LANG-ADAPT` justification
- ❌ Commit `// TODO` without an explanation of what's pending
- ❌ Remove a PM-INCOMPLETE comment until the gap is truly closed

## Do

- ✅ Cite PM source file/line when porting
- ✅ Explain the "why" in `LANG-ADAPT` comments
- ✅ Add `FINISH-PM` notes when filling PM's blanks
- ✅ Keep diffs surgical — one classifier per commit when practical
- ✅ Write unit tests for new MR-original logic

## Migrations and SQL

For SQL changes:

- Schema dumps in `data/sql/<table>.sql` are PM-COMPLETE / alt-PM imports
- Post-load migrations in `data/sql/zz_*.sql` are MR-original — always
  prefix `zz_` so they load last and document the LANG-ADAPT reasoning in
  the SQL comments

For Lua changes:

- PM Lua scripts in `data/scripts/` are PM-COMPLETE
- MR-only scripts (new GM commands, etc.) start with a top comment block
- Patches to PM scripts that fix NLua-tolerated bugs get a `-- FINISH-PM:`
  comment explaining what was wrong

## Auditing

Quick greps to take a snapshot:

```bash
# How much code is verbatim PM
grep -lr "PM-COMPLETE" src/ | wc -l

# What MR-only additions exist
grep -lrn "PM-MISSING\|FINISH-PM" src/

# Where adaptations happen
grep -rn "LANG-ADAPT" src/ | head -30
```
