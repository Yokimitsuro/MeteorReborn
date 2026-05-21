"""
MySQL → Postgres converter for FFXIV 1.0 PM-style SQL dumps.

Usage:
    python sql_mysql_to_postgres.py <input.sql> <output.sql>

Transformations:
  * Strip HeidiSQL/mysqldump header & footer noise (/*!...*/ comments,
    CREATE DATABASE, USE, LOCK/UNLOCK, SET FOREIGN_KEY_CHECKS, etc).
  * Type mapping:
      int(N) unsigned    -> bigint
      int(N)             -> integer
      bigint(N) unsigned -> numeric (no native uint64 in PG)
      smallint(N) unsigned -> integer
      smallint(N)        -> smallint
      tinyint(N) unsigned -> smallint
      tinyint(N)         -> smallint
      bit                -> boolean
      datetime           -> timestamp
  * MySQL escapes:  \\'   -> ''     \\\\ -> \\
  * Backticks `x` -> "x" (preserves case; later lowercased by zz_lowercase_cols.sql).
  * AUTO_INCREMENT, ENGINE=, DEFAULT CHARSET, COLLATE: stripped.
  * Inline KEY/UNIQUE KEY/FULLTEXT KEY/INDEX inside CREATE TABLE: commented out
    (Postgres uses separate CREATE INDEX which we don't generate here).
  * CREATE TABLE IF NOT EXISTS "x" -> DROP TABLE IF EXISTS "x" CASCADE; CREATE TABLE "x"
    (so re-running replaces the table data cleanly).
  * MySQL date sentinel '0000-00-00' -> NULL.
"""

import re
import sys
from pathlib import Path


def convert(content: str) -> str:
    # 1) MySQL conditional comments  /*!40000 ... */;   /*!40101 SET ... */
    content = re.sub(r'/\*!\d{5}\s.*?\*/;?', '', content, flags=re.DOTALL)
    content = re.sub(r'/\*M!\d+\s.*?\*/;?', '', content, flags=re.DOTALL)

    # 2) Remove standalone comment block --- ... ---
    content = re.sub(r'^-- (---+|=+).*$', '', content, flags=re.MULTILINE)

    # 3) Strip header sections that Postgres doesn't accept
    #    CREATE DATABASE may span multiple lines (HeidiSQL puts charset comment after)
    content = re.sub(r'CREATE\s+DATABASE\s+(IF\s+NOT\s+EXISTS\s+)?[`"]?\w+[`"]?[^;]*;?',
                     '', content, flags=re.IGNORECASE)
    content = re.sub(r'^USE\s+`?\w+`?\s*;\s*$', '', content, flags=re.MULTILINE | re.IGNORECASE)
    content = re.sub(r'^LOCK\s+TABLES.*?;\s*$', '', content, flags=re.MULTILINE | re.IGNORECASE)
    content = re.sub(r'^UNLOCK\s+TABLES\s*;\s*$', '', content, flags=re.MULTILINE | re.IGNORECASE)
    content = re.sub(r'^SET\s+@?@?\w+\s*=.*?;\s*$', '', content, flags=re.MULTILINE | re.IGNORECASE)
    content = re.sub(r'^SET\s+NAMES\s+.*?;\s*$', '', content, flags=re.MULTILINE | re.IGNORECASE)
    content = re.sub(r'^SET\s+FOREIGN_KEY_CHECKS.*?;\s*$', '', content, flags=re.MULTILINE | re.IGNORECASE)
    content = re.sub(r'^COMMIT\s*;\s*$', '', content, flags=re.MULTILINE | re.IGNORECASE)
    content = re.sub(r'^START\s+TRANSACTION\s*;\s*$', '', content, flags=re.MULTILINE | re.IGNORECASE)

    # 3b) REPLACE INTO → INSERT INTO (DROP TABLE already wipes; safe to plain INSERT).
    content = re.sub(r'\bREPLACE\s+INTO\b', 'INSERT INTO', content, flags=re.IGNORECASE)

    # 3c) Strip standalone DROP TABLE IF EXISTS (we'll add our own right before CREATE).
    #     Matches both backtick and double-quote forms (runs before backtick conversion).
    content = re.sub(r'^\s*DROP\s+TABLE\s+IF\s+EXISTS\s+[`"][^`"]+[`"]\s*;\s*$',
                     '', content, flags=re.MULTILINE | re.IGNORECASE)

    # 4) MySQL escapes  \\ -> placeholder, \' -> '', placeholder -> \\
    PLACEHOLDER = '\x01\x01'
    content = content.replace('\\\\', PLACEHOLDER)
    content = content.replace("\\'", "''")
    content = content.replace('\\"', '"')
    content = content.replace(PLACEHOLDER, '\\\\')

    # 5) MySQL date sentinel
    content = content.replace("'0000-00-00'", "NULL")
    content = content.replace("'0000-00-00 00:00:00'", "NULL")

    # 6) Type conversions (order matters — most specific first).
    #    NB: `\bint(11)\b` does NOT match because `)` isn't a word char and the next
    #    char (space/comma) also isn't — no word boundary. Use lookahead `(?=\W|$)`.
    content = re.sub(r'\bbigint\(\d+\)\s+unsigned(?=\W|$)', 'numeric(20,0)', content)
    content = re.sub(r'\bint\(\d+\)\s+unsigned(?=\W|$)', 'bigint', content)
    content = re.sub(r'\bmediumint\(\d+\)\s+unsigned(?=\W|$)', 'integer', content)
    content = re.sub(r'\bsmallint\(\d+\)\s+unsigned(?=\W|$)', 'integer', content)
    content = re.sub(r'\btinyint\(\d+\)\s+unsigned(?=\W|$)', 'smallint', content)
    content = re.sub(r'\bbigint\(\d+\)(?=\W|$)', 'bigint', content)
    content = re.sub(r'\bint\(\d+\)(?=\W|$)', 'integer', content)
    content = re.sub(r'\bmediumint\(\d+\)(?=\W|$)', 'integer', content)
    content = re.sub(r'\bsmallint\(\d+\)(?=\W|$)', 'smallint', content)
    content = re.sub(r'\btinyint\(\d+\)(?=\W|$)', 'smallint', content)
    content = re.sub(r'\bbit\b', 'boolean', content)
    content = re.sub(r'\bdatetime\b', 'timestamp', content)
    content = re.sub(r'\bunsigned\b', '', content)  # any remaining

    # 7) Backticks → double quotes (case-preserving)
    content = re.sub(r'`([^`]+)`', r'"\1"', content)

    # 8) Drop MySQL-specific clauses
    content = re.sub(r'\bAUTO_INCREMENT(?:=\d+)?\s*', '', content)
    content = re.sub(r'\bENGINE\s*=\s*\w+\s*', '', content)
    content = re.sub(r'\bDEFAULT\s+CHARSET\s*=\s*\w+\s*', '', content)
    content = re.sub(r'\bCHARACTER\s+SET\s+\w+\s*', '', content)
    content = re.sub(r'\bCOLLATE\s*=?\s*\w+\s*', '', content)
    content = re.sub(r"\bCOMMENT\s*=?\s*'[^']*'\s*", '', content)
    content = re.sub(r"\bCOMMENT\s+'[^']*'", '', content)  # column comments inline

    # 9) Inline indexes in CREATE TABLE: comment out (Postgres uses CREATE INDEX)
    content = re.sub(r'^\s*(KEY|UNIQUE\s+KEY|FULLTEXT\s+KEY|INDEX|FULLTEXT)\s+.*?,?\s*$',
                     '', content, flags=re.MULTILINE | re.IGNORECASE)
    # Foreign keys: also comment for simplicity (load order may differ)
    content = re.sub(r'^\s*CONSTRAINT\s+.*?,?\s*$',
                     '', content, flags=re.MULTILINE | re.IGNORECASE)

    # 10) CREATE TABLE [IF NOT EXISTS] "name" ( ... )  →  DROP TABLE + CREATE
    #     Single pass that handles both forms. Preserves the `(` so column defs follow.
    content = re.sub(
        r'CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?"([^"]+)"\s*\(',
        lambda m: f'DROP TABLE IF EXISTS "{m.group(1)}" CASCADE;\nCREATE TABLE "{m.group(1)}" (',
        content, flags=re.IGNORECASE
    )

    # 12) Clean up: multiple blank lines → single
    content = re.sub(r'\n\s*\n\s*\n+', '\n\n', content)

    # 13) Fix CREATE TABLE trailing commas before closing )
    content = re.sub(r',(\s*\))', r'\1', content)

    return content.strip() + '\n'


def main():
    if len(sys.argv) != 3:
        print(__doc__)
        sys.exit(1)
    src = Path(sys.argv[1])
    dst = Path(sys.argv[2])
    raw = src.read_bytes().decode('utf-8', errors='replace')
    converted = convert(raw)
    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.write_text(converted, encoding='utf-8')
    print(f"OK: {src.name} -> {dst} ({len(converted)} bytes)")


if __name__ == '__main__':
    main()
