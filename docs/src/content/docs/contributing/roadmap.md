---
title: Roadmap
description: Where Meteor Reborn is heading. Living document, expect movement.
---

This roadmap is **aspirational**. It reflects current priorities, not
commitments. Tasks shift as we learn what's actually possible.

## v0.1.x — Alpha foundation (current)

Status: shipped as [v0.1.0](https://github.com/Yokimitsuro/MeteorReborn/releases/tag/v0.1.0).

What works:

- ✅ Four services + Postgres in Docker
- ✅ Native mode documented
- ✅ Account creation + lobby + character creation
- ✅ Launcher with ZIPATCH downloader and applier
- ✅ Docs site

Known gaps (still in this minor):

- 🔄 Patch the zone-in chain for stable in-world entry
- 🔄 Wire `server_eventnpc_spawn_locations` loader in map
- 🔄 Lua audit pass

## v0.2.x — Stable in-world

Goal: a player creates an account, picks a character, and stays in-world
without disconnects.

- Complete `Player.SendZoneInPackets` chain with proper flush sequencing
- Load event NPCs (1294 rows) so towns aren't empty
- Audit Lua scripts for NLua-tolerated bugs (`lua_lint.py`)
- Add reconnect handling — currently a dropped TCP kills the session forever
- Smoke-test with all 6 starting classes
- Add a startup health-check endpoint to each service for orchestrators

Stretch:

- Wireshark protocol dissector (`.lua` plugin) for FFXIV 1.0

## v0.3.x — Combat & content

Goal: kill a wharf rat. Cast Cure on yourself. Equip an item.

- Combat loop end-to-end (attack timer, damage calc, death/respawn)
- Action bar correctly populated per class
- Status effects fire and tick down
- Auto-attack works
- Inventory updates persist
- Loot drops on enemy death
- More spawn locations seeded — at least 30 monsters per starting region

## v0.4.x — Multi-player

Goal: two players in the same zone can see each other and chat.

- AOE broadcast — when one player moves, nearby players see the update
- Party system (invite, leave, party chat)
- Linkshell creation and chat
- `/tell` cross-zone messaging
- Friend list works
- Authoritative "who's in zone N" tracking for performance

## v0.5.x — Quests & progression

Goal: complete the opening main scenario quest sequence.

- Event director system wired for scripted scenes
- Dialogue choices propagate to quest state
- Quest item rewards
- XP and level-up flow
- Class quests at level 10
- Aetheryte attunement and teleportation

## v0.9.x — Polish & beta

- All 524 quests have at least placeholder scripts
- Battle NPCs in every zone (auto-generation tool)
- Music + weather feel right per zone
- Launcher polishing: progress accuracy, error messages, theme
- Docs has full screenshot library
- Test coverage > 50% on Common, > 20% on Map

## v1.0.0 — Stable

The release we tag when:

- Every starting city → endgame zone is reachable
- A solo player can play through the opening MSQ
- No "expected" disconnects within an hour of gameplay
- The launcher Just Works for non-developers
- Docs are searchable, accurate, and trusted

## Long term

These are not on a roadmap — they're "if the project grows" ideas:

- **Web admin panel** — view sessions, kick players, edit DB via UI
- **In-game GM UI** — replace `!` chat commands with a /gm panel
- **Wireshark dissector** in tree
- **Content authoring tools** — graphical placement of NPCs/spawns in a map
- **Replay / packet recording** — capture client sessions for regression testing
- **CI integration tests** — spin up the stack in GitHub Actions, drive it
  with a mock client, assert known good packets
- **Public test server** — community-hosted instance for newcomers
- **Multi-world routing** — multiple `world` instances per shard, sharded by zone
- **Cross-platform launcher** — Avalonia or Tauri for Linux/macOS support
- **Steam integration** — only if it's legal and SE doesn't mind

## What we won't do

- Port to 2.x / 5.x / 7.x — out of scope; mature emulators exist for those
- Bundle the FFXIV client — illegal
- Add anti-cheat — single-player or trusted-community focus; not chasing
  exploit-tolerance
- Build a "live operations" team — this is a hobby project, not a service

## Helping the roadmap

If you can knock out an item on this list, [open a PR](/MeteorReborn/contributing/git-workflow/).
Smaller items in [unfinished content](/MeteorReborn/project/unfinished-content/)
are good first targets.
