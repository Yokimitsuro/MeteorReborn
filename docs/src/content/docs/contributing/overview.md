---
title: How to help
description: What Meteor Reborn needs, where to start, how to land your first PR.
---

Meteor Reborn is a small project with a big surface — 5 services, 65 SQL
dumps, 1254 Lua scripts, a launcher and a docs site. Almost any kind of
contribution is welcome and there's something for nearly any skill set.

## What we need most

In rough priority order:

1. **Zone-in chain completion** (.NET / packet protocol) — the client times
   out ~12 seconds after `Session has been added` because some packets in
   `Player.SendZoneInPackets` aren't flushed. The single biggest blocker to
   actual gameplay. See [unfinished content](/MeteorReborn/project/unfinished-content/#zone-in-chain-incomplete).
2. **Event NPC loader** (.NET) — `server_eventnpc_spawn_locations` ships 1294
   rows of NPCs that map server doesn't load yet. Wiring this would populate
   towns with vendors and quest givers.
3. **Lua audit** (Lua) — go through `data/scripts/` and fix calls to
   non-existent C# members (NLua silently ignored them, MoonSharp doesn't).
   Pattern to grep: `actor\.[A-Z]\w+\(` that aren't real methods on `Npc`,
   `Player`, etc.
4. **Battle NPC spawn content** (SQL / game design) — only 7 monster spawn
   locations ship by default. Curating more from the 134 available actor
   classes is content work that doesn't require deep .NET knowledge.
5. **Docs improvements** (Markdown) — page expansions, screenshots, examples.
   You're reading the docs right now — open the **Edit page** link in the
   sidebar to suggest changes.
6. **Test coverage** (.NET) — only `MeteorReborn.Common` has tests today. TCP
   integration tests against the running stack would prevent regressions.
7. **Launcher polish** (.NET WPF) — UX issues, progress reporting accuracy,
   error messages.

## Who fits what

| Background | Where you'll feel at home |
|------------|---------------------------|
| C# / .NET | Servers (Common, Lobby, World, Map, Login) or Launcher |
| SQL / DBA | `data/sql/`, schema migrations, query optimization |
| Reverse engineering / FFXIV 1.0 | Wire protocol, opcode coverage, client behavior |
| Lua | `data/scripts/` — NPCs, quests, GM commands, effects |
| DevOps / Docker | CI workflows, deploy automation, Dockerfile improvements |
| Game design | Battle NPC content, quest pacing, populace spawns |
| Frontend / docs | This site (Astro Starlight), README, screenshots |

## First steps

1. **Get the stack running locally** — follow [Docker setup](/MeteorReborn/getting-started/docker/)
   or [native setup](/MeteorReborn/getting-started/native/). Verify with a
   curl against the login endpoint and a `docker compose logs map` that shows
   `Map Server has started`.
2. **Set up the dev environment** — see [dev environment](/MeteorReborn/contributing/dev-setup/).
3. **Pick a task** — browse [GitHub Issues](https://github.com/Yokimitsuro/MeteorReborn/issues),
   or grab something from [unfinished content](/MeteorReborn/project/unfinished-content/).
4. **Branch from `develop`** — see [git workflow](/MeteorReborn/contributing/git-workflow/).
5. **Open a PR against `develop`** — small, scoped changes preferred. Big
   refactors should be discussed in an issue first.

## What we don't accept

- Cheats / exploits for retail FFXIV (we're a 1.0 emulator, not a tooling
  project for the live game)
- Redistribution of SQUARE ENIX-owned assets (client binaries, `.patch`
  files, audio/textures)
- Code without a clear PM-COMPLETE / FINISH-PM / LANG-ADAPT classification
  — see [code conventions](/MeteorReborn/contributing/conventions/)
- Force-pushes to `develop` or `master` (PR-only)
- Mass refactors that aren't motivated by a real bug or feature

## Communication

| Channel | What for |
|---------|----------|
| [GitHub Issues](https://github.com/Yokimitsuro/MeteorReborn/issues) | Bug reports, feature requests, blocking questions |
| [GitHub Discussions](https://github.com/Yokimitsuro/MeteorReborn/discussions) | Open-ended design questions |
| PR review comments | Code-level back-and-forth |

There's no Discord or chat room (yet). If the project grows enough to need
one, we'll set it up.

## License & contribution agreement

Meteor Reborn inherits **AGPL-3.0** from Project Meteor. By submitting a PR
you agree your contribution is licensed under AGPL-3.0. We don't require a
CLA — the standard "inbound = outbound" GitHub flow applies.

This is an educational reverse-engineering project. **Do not** submit code
derived from leaked SQUARE ENIX sources or NDA-protected materials.
