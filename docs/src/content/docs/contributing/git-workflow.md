---
title: Git workflow
description: Gitflow with master + develop, feature branches, and how to land a PR cleanly.
---

Meteor Reborn follows a slightly opinionated **gitflow** with two long-lived
branches and short-lived feature/release/hotfix branches.

## Branches

| Branch | Lifetime | Pushable directly? | What's on it |
|--------|----------|---------------------|--------------|
| `master` | permanent | ❌ No (PR or release-merge only) | Tagged releases, always green |
| `develop` | permanent | ❌ No (PR only) | Integration branch, latest features |
| `feature/<name>` | short | ✅ Yes (yours) | Single feature or bugfix |
| `release/<x.y.z>` | short | ✅ Yes (release manager) | Stabilization before tagging |
| `hotfix/<x.y.z>` | short | ✅ Yes | Critical patch on `master` |

## Day-to-day flow

```bash
# Start from develop
git checkout develop
git pull

# Make a feature branch
git checkout -b feature/zone-in-fix

# ... work, commit ...
git push -u origin feature/zone-in-fix

# Open PR feature/zone-in-fix → develop
gh pr create --base develop --head feature/zone-in-fix \
  --title "Complete zone-in packet chain" \
  --body "..."
```

After review + merge, delete the feature branch:

```bash
git checkout develop
git pull
git branch -d feature/zone-in-fix
git push origin --delete feature/zone-in-fix
```

## Release flow

Releases come out of `develop` via a stabilization branch:

```bash
git checkout develop
git pull
git checkout -b release/0.2.0

# (optional) bump version strings in code / docs, smoke-test
git push -u origin release/0.2.0

# When ready:
git checkout master
git pull
git merge --no-ff release/0.2.0
git tag -a v0.2.0 -m "v0.2.0 — Zone-in working"
git push origin master --tags

# Bring the merge back into develop
git checkout develop
git merge --no-ff release/0.2.0
git push origin develop

# Clean up
git branch -d release/0.2.0
git push origin --delete release/0.2.0
```

Then create the GitHub Release:

```bash
gh release create v0.2.0 \
  --title "v0.2.0 — Zone-in working" \
  --notes-file .github/release-notes/v0.2.0.md \
  --prerelease
```

(Drop `--prerelease` once we hit a stable `v1.0.0`.)

## Hotfix flow

Critical bug on `master`:

```bash
git checkout master
git pull
git checkout -b hotfix/0.2.1

# ... fix, commit ...
git push -u origin hotfix/0.2.1

# Merge to master AND back to develop
git checkout master
git merge --no-ff hotfix/0.2.1
git tag v0.2.1
git push origin master --tags

git checkout develop
git merge --no-ff hotfix/0.2.1
git push origin develop

git branch -d hotfix/0.2.1
git push origin --delete hotfix/0.2.1
```

## Pull request guidelines

- **Title**: imperative ("Add zone-in completion", "Fix Lua case-sensitivity"),
  not "Adding ..." or "Fixed ..."
- **Body**: what + why; include reproduction steps for bug fixes
- **Scope**: one feature or one bug per PR. Multiple unrelated fixes = multiple PRs
- **Tests**: add or update tests in `tests/MeteorReborn.Common.Tests/` if you
  changed Common
- **Conventions**: tag your changes with PM-COMPLETE / FINISH-PM / LANG-ADAPT
  per [code conventions](/MeteorReborn/contributing/conventions/)
- **Build**: ensure `dotnet build MeteorReborn.sln` is green before pushing
- **Docs**: if you added or changed behavior, update the relevant docs page

## Commit message style

Soft-imperative, ~50-char first line, optional body separated by a blank line:

```
Complete zone-in packet chain

Previously map server stopped at DeleteAllActors and the client
timed out ~12s later. Now sends:
- SetActorIsZoning(false), SetDalamud(0)
- SetMusic from zone.bgmDay
- SetWeather (Clear default)
- SetMap (region + zone)
- Self spawn packets via GetSpawnPackets()
- WorldMaster + DebugActor spawn
- FlushQueuedSendPackets()

PM-INCOMPLETE → finished per protocol observed in 1.23b client.
```

The repo does **not** require Conventional Commits (`feat:`, `fix:`, etc.) —
some commits use that style as habit but it's not enforced.

## Don't

- ❌ Force-push to `develop` or `master`
- ❌ Rebase someone else's branch without asking
- ❌ Squash-merge feature branches with multiple meaningful commits (use the
  default "Merge commit" or "Rebase" option in the GitHub UI)
- ❌ Push directly to `master` without going through release/* or hotfix/*
- ❌ Use `git push --no-verify` to skip hooks

## Do

- ✅ Pull `develop` before branching (`git pull` is cheap)
- ✅ Rebase your own feature branch on top of latest `develop` before opening a PR
- ✅ Keep PRs small (< 500 LoC ideally)
- ✅ Tag releases on `master` with annotated tags (`git tag -a`, not lightweight)
- ✅ Delete merged branches both locally and on the remote

## CI / GitHub Actions

The repo has one workflow today: `.github/workflows/deploy-docs.yml`. It
builds the docs site on every push to `master`/`develop` that touches
`docs/**`, and deploys to GitHub Pages only on `master`.

A future workflow should:

- Run `dotnet build` + `dotnet test` on every PR
- Build Docker images and push them to GHCR on `master` tags
- Build the launcher and attach the binary to GitHub Releases
