---
title: Utilities
description: The Python and C# tools shipped under tools/ for development and content management.
---

The `tools/` folder ships a small set of helpers used during development. All
are self-contained and need no external services besides Python 3 and (for
some) a running PostgreSQL.

## `tools/MeteorReborn.Launcher/`

The end-user launcher (Windows WPF, .NET 10). Detailed in
[client setup](/MeteorReborn/getting-started/launcher/). Source files:

| File | What it does |
|------|--------------|
| `MainWindow.xaml` / `.cs` | Login UI, settings, PLAY button |
| `BlowfishCipher.cs` | FFXIV-specific Blowfish (same key schedule as PM) |
| `GameLauncher.cs` | Spawns suspended `ffxivgame.exe`, patches memory at known RVAs, resumes |
| `VersionChecker.cs` | Reads `<gamePath>/game.ver`, compares to target `2012.09.19.0001` |
| `PatchFile.cs` | ZIPATCH parser (port of SeventhUmbral) — applies one `.patch` file |
| `PatchManifest.cs` | Hardcoded list of 49 patches + expected sizes |
| `PatchDownloader.cs` | HttpClient-based downloader with byte-level progress |
| `Patcher.cs` | Two-phase pipeline: download missing, then apply in chronological order |
| `PatcherWindow.xaml` / `.cs` | Modal progress UI (download + apply bars) |

## `tools/sql_mysql_to_postgres.py`

MySQL → PostgreSQL SQL dump converter. Used to bring data from upstream PM
dumps (HeidiSQL / mysqldump exports) into MR's Postgres schema.

```bash
python tools/sql_mysql_to_postgres.py input.sql output.sql
```

Transforms applied:

- Strips HeidiSQL/mysqldump chrome (`/*! ... */` comments, `LOCK TABLES`,
  `SET FOREIGN_KEY_CHECKS=0`, `COMMIT`, etc.)
- `\` `→ `"` for identifier quoting (case-preserving)
- Type mapping: `int(N) unsigned` → `bigint`, `tinyint(N)` → `smallint`, `bit` → `boolean`, `datetime` → `timestamp`
- `REPLACE INTO` → `INSERT INTO`
- `CREATE TABLE [IF NOT EXISTS]` → `DROP TABLE IF EXISTS x CASCADE; CREATE TABLE x`
- Inline `KEY`/`UNIQUE KEY`/`CONSTRAINT` → commented out (Postgres uses separate `CREATE INDEX`)
- MySQL escapes `\'` → `''`, `'0000-00-00'` → `NULL`
- AUTO_INCREMENT, ENGINE=, DEFAULT CHARSET, COLLATE: stripped

## Tools not shipped (yet)

Ideas worth implementing later:

- `tools/gen_battlenpc_spawns.py` — auto-generate `server_battlenpc_*` rows
  from `gamedata_actor_class` + zone hints to populate more enemies than PM's 7
- `tools/lua_lint.py` — static check for invalid Lua syntax or non-existent
  C# member calls (would have caught `actor.SetAppearance(...)` before runtime)
- `tools/opcode_diff.py` — compare MR's `PacketProcessor` switch cases against
  client capture data to flag missing handlers
