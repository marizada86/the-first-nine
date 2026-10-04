---
status: implemented-awaiting-human-review
kind: bounded-visual-correction-plan
created: 2026-10-04
plan_id: 2026-10-04-enemy-facing-correction
origin: planned
implementation_preceded_spec: false
request_classification: NEW_PLAN
approval_mode: per-plan
approved: 2026-10-04
approval_source: explicit-owner-selection-1
evidence: "[[2026-10-04-enemy-facing-correction]]"
depends_on: "[[2026-10-04-b05-documentation-closure]]"
implementation_approved: true
implementation_branch: codex/enemy-facing-correction
implementation_base: 39cd7d3d46a8afb3894889920e0840cbae573e7b
push_approved: false
pull_request_approved: false
merge_approved: false
---

# Enemy facing correction

## Intent and inspected evidence

The owner reports that enemy animations remain right-facing when enemies move left. B-05 is completed; no active plan existed when this report arrived. This is a new bounded corrective plan, not a reopening of B-05 or authorization for B-06.

At local main `39cd7d3d46a8afb3894889920e0840cbae573e7b`, movement computes horizontal direction, but spawned enemies have no persistent facing field and `draw_shades()` draws the source cell without mirroring. Inspected Briar Hound, Stag of Mire and Antlered Hunger atlases all face right. Lolth already uses a scoped horizontal drawing transform; enemy drawing does not.

## Scope and non-goals

Track each enemy's facing direction and mirror the existing enemy sprite when facing left. Cover Thornwake Hound, Stag and boss approach/telegraph/strike/recovery/defeated poses. Account for the generic movement path without unlocking prototype regions or altering their AI/atlas selection.

Keep source images and frame selection, native aspect, centered visible body, grounded feet, widths/shared-outline melee reach, prewarmed caches, health, damage, contact radius and timing unchanged. Restore drawing transforms before labels, health bars or other scene elements. Do not mirror the entire scene or mutate source artwork.

No new art, dependencies, adapter installation, GPU/performance profiling, controls, parry, progression, ally roles, disk saves, B-06, push, PR or merge.

## Grounded decisions and gaps

- RESOLVABLE: introduce persistent enemy-facing state initialized towards its initial attack target, with a compatibility fallback for existing dictionaries.
- RESOLVABLE: moving enemies face actual signed movement, including negative-speed retreat on the generic path. Stationary enemies retain their last valid facing; zero horizontal distance must not flicker.
- RESOLVABLE: Thornwake telegraphs/strikes retain their committed attack direction even if Lolth crosses behind them. Recovery and defeat retain facing unless a new approach/movement requires a turn. No AI targeting or attack-lock semantics change.
- RESOLVABLE: mirror around the centered visible-body anchor, not a full-atlas edge. Preserve shared geometry/feet and leave text/bars unmirrored.
- RESOLVABLE: project has no game-dev CLI or `.game-dev/adapter.json`; use existing Godot-owned deterministic tests/captures as fallback, without claiming sealed runs.
- BLOCKING gaps: none. The owner selected option 1 on 2026-10-04, authorizing the complete local plan with per-plan approval. Publication and merge remain separately gated.
- DEFERRED: balance, pose-dependent reach tuning, UI crowding, higher-Mark abilities and progression.

## Acceptance criteria

1. All three Thornwake species visually face left during leftward movement and right during rightward movement.
2. Direction reversal, zero-motion holding, initial spawn and defeated pose behave consistently; attack-facing stays locked through windup/strike when a target crosses sides.
3. Horizontal reflection changes orientation only: native aspect, visible-body center, floor alignment, current-frame outline width and melee hit/miss boundaries remain correct in both directions.
4. Labels/bars/Lolth/wagon/background are not reflected. Existing controls, inventory/wagon menus, dash, F4 snapshot restoration and safe-wagon restore regressions pass.
5. Cached-outline preparation remains unchanged; no gameplay-added pixel scans or source-asset edits. Existing validation evidence is not overwritten.
6. A targeted negative control lacking direction update or sprite reflection is detected. No new gameplay feature, unlock, dependency or publication occurs.

## Plan of flight and approval checkpoints

- S-001 / B-001: add minimal persistent facing and scoped sprite reflection; validate both movement paths and locked attack direction.
- S-002 / B-001: add isolated facing/geometry and rendered-capture checks for both sides, reversals, stationary/defeated cases, labels and restores; include deliberately faulty direction/reflection controls. Reuse independent geometry assertions.
- S-003 / B-001: run full headless self-test, real-input combat/menu regressions and normal/headless smoke checks with `D:/Godot/godot.exe`; inspect bounded paired captures, document results and return for owner review.

The owner selected per-plan (option 1), approving S-001 through S-003 as one local corrective scope. All three steps are implemented and validated. External publication/merge remain separate gates; this selection does not approve push.

## Impacts, recovery and reconciliation

Expected production changes are limited to enemy facing state/update and drawing in `main.gd`; isolated validation and English records live under `.atena/`. No architecture or canon change. Create a separate codex-prefixed correction branch after approval if committing implementation; preserve existing branches and user work. Recovery uses a normal corrective/revert commit if separately needed, never reset, amend published history or force-push.

Preserve B-05 completed state and previous history. Record actual test exits, visual inspection and limitations distinctly. Human acceptance of B-05 does not imply acceptance of this new fix. Reconcile the new plan only after its own execution/review; no automatic remote action.

## Implemented local outcome

Persistent facing is initialized at spawn, updated from signed motion on the generic path, and locked to committed attack direction through Thornwake windup/strike. Stationary recovery/defeat hold their orientation. Drawing reflects only the sprite around the visible-body center, then resets its transform. No art, shared geometry/reach, damage, timing or input rule changed.

Godot 4.7.2: 65/65 headless direction checks; 102/102 rendered checks (12 pose reflection comparisons and unchanged labels/markers/full-scene exterior); three faulty subclasses rejected with exit 1; independent geometry 46/46; actual-input combat 9/9 and menus 33/33; full self-test and both 600-frame smoke runs pass. See the linked evidence for exact process results, captures, initial harness corrections and limitations. Human review of this fix is pending; no push, PR, merge or B-06.
