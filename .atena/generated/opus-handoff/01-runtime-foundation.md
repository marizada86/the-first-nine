---
status: prepared-not-authorized
package: opus-runtime-foundation
---

# Opus handoff — Foundation of the clean runtime

## Goal

Create only the empty, data-driven Godot foundation described below. Do not port or rewrite the frozen prototype.

## Canonical context

- `.atena/vault/canon/2026-10-02-thalestriel-exodus-game-intent.md`
- `.atena/vault/canon/2026-10-03-production-reset-and-opus-handoff.md`
- `.atena/vault/drafts/2026-10-03-production-bible.md`
- `.atena/vault/drafts/2026-10-03-target-runtime-architecture.md`

## Allowed files

Create files only under a new `clean_runtime/` directory. It must be a separate Godot project. Do not edit `main.gd`, `main.tscn`, `project.godot`, `assets/` or `.atena/vault/canon/`.

## Required output

- A Godot project with `app/`, `actors/`, `world/`, `caravan/`, `progression/`, `ui/`, `content/`, and `tests/` directories.
- Typed data contracts and stable IDs for chapter, enemy, resource, recipe, mark and survivor.
- A minimal input adapter and a headless smoke scene that loads the contracts.
- A short `clean_runtime/README.md` listing file ownership and validation result.

## Non-goals

No gameplay chapter, art generation, asset copying, third-party dependency, UI skin, lore change, save migration, Git operation or external call.

## Acceptance and validation

Run `D:\Godot\godot.exe --headless --path clean_runtime --editor --quit`. Report modified files, command output summary, and any unresolved gap. Do not claim visual validation.
