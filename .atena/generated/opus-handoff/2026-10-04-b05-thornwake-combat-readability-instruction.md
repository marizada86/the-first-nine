---
status: historical-instruction-published-revision-awaiting-technical-review
kind: external-implementation-instruction
created: 2026-10-04
batch: B-05
plan: "[[2026-10-04-b05-thornwake-combat-readability]]"
---

# B-05 — Thornwake melee damage and animation readability

## Current follow-up checkpoint

The original implementation described below was published at `4400b59` on `b05-thornwake-combat-readability`. It is not merged. The owner approved independent controls, inventory and wagon management, then deferred parry to a higher Mark and requested clean dash and larger enemies. That follow-up is implemented as `43ab112`, human validation was accepted, and the owner explicitly authorized its publication on 2026-10-04 to `codex/b05-controls-wagon-inventory`. First publication was verified at `bb4a0d4`; publication reconciliation follows on that branch. Read [[2026-10-04-b05-controls-and-wagon-menu-revision]], [[2026-10-04-b05-local-controls-inventory-wagon-implementation]] and [[2026-10-04-b05-controls-and-wagon-menu-instruction]] for current results and read-only review instructions. The remaining sections preserve the original historical execution instruction, not authorization to reimplement, open a PR or merge the revision.

## Execution gate

Current operational override: the owner accepted revision `43ab112` and explicitly authorized its branch publication on 2026-10-04. Human validation and the authorized publication are done; PR and merge still require explicit authorization. The rest of this section preserves the original execution gate.

The project owner approved B-05 with `per-plan` approval on 2026-10-04. Remote `main` now contains the tested F4 playtester source commit `4ef349b` and the B-05 approval record `a31c12c`. Fetch the latest `origin/main` and report the exact starting commit before editing. Do not work from an older branch without F4, and do not silently recreate or omit the playtester changes.

## Read before editing

- `.atena/add.yaml` and `.atena/state/plan.yaml`
- `.atena/specs/2026-10-04-b05-thornwake-combat-readability.md`
- `.atena/evidence/2026-10-04-b05-thornwake-combat-readability.md`
- `.atena/specs/2026-10-04-b04-thornwake-mark-one-stabilization.md`
- `.atena/evidence/2026-10-04-b04-thornwake-mark-one-stabilization-implementation.md`
- `.atena/specs/2026-10-04-playtester-debug-controls.md`
- `.atena/evidence/2026-10-04-playtester-debug-controls.md`
- Relevant current canon for the caravan, Thornwake, Mark I and survival boundaries.

## Reproduce and implement

Use Godot 4.7.2. Open the local F4 playtester, force night, approach a Briar Hound, and use the actual primary input. Log enemy health, Lolth health, distance, facing, pose and VFX at input and during the following frames. Distinguish a melee miss, a damaging hit, a dodge display issue and an actual enemy hit on Lolth.

Investigate `handle_primary()`, `INTERACT_RADIUS`, `perform_dodge()`, `draw_player()`, and the same-frame order of player attack and enemy contact. The 56 px center-distance test and the use of `hurt_cooldown` for both dodge protection and hurt visuals are concrete leads, not instructions to blindly increase reach or suppress damage. Choose the smallest fix that makes real input, hit feedback, health changes and animations agree.

Preserve the three-strike melee combo, Briar Hound and Stag behavior, B-03 boss/Mark I/first cure, B-04 safe-wagon restore, and F4 playtester restoration. Do not add new art, powers, enemies, regions, travel, Marks, cures, dependencies or disk saves.

## Validation and return

Run targeted real-input positive and negative combat checks, full headless self-tests, and a normal 1280×720 rendering pass. Capture the hit, miss, dodge and actual hurt visuals. State exact before/after health values for both Lolth and an enemy. Verify a Briar Hound can be defeated and the night wave progresses. Record changed files, test commands/results, remaining gaps, and an English implementation note.

Stop after a local implementation for human review. Do not push, open a PR, merge, or publish without separate explicit authorization.
