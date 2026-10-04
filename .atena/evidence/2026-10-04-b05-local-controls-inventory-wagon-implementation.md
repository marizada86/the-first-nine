---
status: implemented-human-validated-awaiting-publication-approval
kind: local-implementation-evidence
created: 2026-10-04
batch: B-05
revision: "[[2026-10-04-b05-controls-and-wagon-menu-revision]]"
canonical_decision: "[[2026-10-04-separated-controls-and-wagon-management]]"
approval_mode: per-plan
implementation_branch: codex/b05-controls-wagon-inventory
implementation_base: 4400b59aab49ed2860c5c6369ba79b386a7d2e9a
implementation_commit: 43ab1128f62f164bdcce64d92ea1fe8bd0dfef4c
human_validation_accepted: true
human_validation_date: 2026-10-04
followup_push_approved: false
pull_request_approved: false
merge_approved: false
---

# B-05 local controls, inventory, wagon and readability follow-up

## Authority and preserved history

The owner explicitly requested local implementation before returning to Claude with results. Later IN_PLAN clarifications defer parry to a higher Mark, require only the dash body pose without stray graphics, and request larger enemy proportions. Those later instructions supersede the initial immediate-parry proposal. No parry implementation or unlock level is claimed.

Implementation uses the published original B-05 runtime at `4400b59`, not the older main runtime. Main remains at `9ea4fc1`; published history is intact. Eight local preparation records were preserved with a recoverable Git stash while switching to the feature base, then reapplied. Two record conflicts were reconciled without replacing the runtime. The stash is retained as a preparation backup, not the current implementation. The separate earlier review worktree's import-metadata changes are not part of this follow-up.

## Implemented behavior

- Independent melee and world-interaction handlers. Real E cannot attack; real left-click cannot collect/store/craft. Empty attacks show a swing with zero damage. Existing nearest target, facing, 1/1/2 combo, defeat and Echo rules remain.
- Space jump, Shift/right-trigger dash at every inspected Mark, J/left-face melee, E/top-face interaction, I carried inventory, M nearby wagon, controller Menu/Select contextual management access. Q/R role hotkeys are retired. Right-click remains inactive.
- `wagon_inventory_ui.gd` provides paused, mutually exclusive inventory and wagon panels over existing state. Inventory displays item slot costs and capacity, allows selection only, and does not duplicate items. Wagon Supplies preserves storage/crafting. The craft action is visible above recipe selection; the scroll view follows focus. Allies lists all eight with truthful states; cave roles remain locked in both widgets and callbacks. Existing prototype assignment/recall and two-post cap are retained without opening their gameplay route.
- World actions are queued only after GUI event consumption. Panel open/close and switching clear queued actions and use the existing one-frame resume guard. F4 snapshots exclude UI nodes, cached render bounds and input queues.
- New runs, safe-wagon and generic checkpoint restores clear transient combat visuals. A regression assertion exercises the generic fallback after actual damage/failure. F4 overrides also clear transient combat visuals; restore retains its exact saved gameplay state.
- The normal-speed combat runner uses elapsed-time wave/hurt waits with bounded timeouts and clean failure before accessing absent enemies. Its melee events are actual left-clicks rather than E.

## Enemy proportions and dash correction

| Thornwake enemy | Old cell size | New cell size | Revised melee center reach |
| --- | --- | --- | --- |
| Briar Hound | 96 px | 160 px | 114 px |
| Stag of Mire | 96 px | 200 px | approximately 152.33 px |
| Antlered Hunger | 160 px | 260 px | approximately 162.63 px |

Cell size includes source padding; it is not a claim that the entire opaque body has that height. The hound is larger than before but remains lower than standing Lolth. Feet align to the visible ground; labels and health bars sit above the visible body. Alpha >= 0.25 body bounds ignore near-transparent source noise and are cached once per cell. The enemy component of measured melee reach scales with the new cell, while Lolth's component remains unchanged. Enemy health, damage, timings and contact-damage radius are unchanged. These proportions still need human tuning acceptance.

The dash artifact had two contributors: supplementary dash VFX and a neighboring attack weapon spilling into the dash sprite cell. Dash VFX drawing is suppressed; source-region sampling excludes empty contaminated margins, not an edited/replaced PNG. Elf top margin: 32%; drow top: 23%, left: 15%. Destination subregions preserve the original body scale and pivot, including mirrored drawing. Initial smaller margins still left a thin detached stroke; visual inspection caught it, and final elf/drow captures show only the body pose. No new art was generated or admitted.

## Validation

Godot `D:/Godot/godot.exe`, 4.7.2 stable official Windows build. Normal runs use 1280x720 OpenGL3 on NVIDIA GTX 1650. No fixed FPS argument was needed. Final saved logs have no Godot script errors or warnings.

1. `D:/Godot/godot.exe --headless --path D:/dev/eclipse-game-jam --log-file D:/dev/eclipse-game-jam/.atena/generated/2026-10-04-b05-local-controls-validation/self-test.log -- --self-test`
   - Exit 0: `SELF_TEST_B01_PASS`, `SELF_TEST_B02_PASS`, `SELF_TEST_B03_PASS`, `SELF_TEST_B04_PASS`, `SELF_TEST_B05_PASS`, `SELF_TEST_PLAYTESTER_PASS`, `SELF_TEST_PASS`.
   - Legacy prototype tests pass without admitting later regions into the current cave progression. The B-05 miss test moved to 130 px because the new hound reach is 114 px. Only melee tests changed handlers; collection tests retain interaction.
2. `D:/Godot/godot.exe --path D:/dev/eclipse-game-jam --resolution 1280x720 --rendering-driver opengl3 --log-file D:/dev/eclipse-game-jam/.atena/generated/2026-10-04-b05-local-controls-validation/combat.log --script res://.atena/generated/2026-10-04-b05-combat-validation/validate_b05_combat.gd`
   - Exit 0, 9/9 checks, `B05_RUNTIME_PASS: 0 failures`.
   - Hound hit pressed at 78 px: enemy 1 -> 0, Lolth 3 -> 3. Stag miss pressed at 193 px: enemy 2 -> 2. Actual hound damage: Lolth 3 -> 2 with hurt visuals. Night advances and clears; F4 restore passes.
3. `D:/Godot/godot.exe --path D:/dev/eclipse-game-jam --resolution 1280x720 --rendering-driver opengl3 --log-file D:/dev/eclipse-game-jam/.atena/generated/2026-10-04-b05-local-controls-validation/runtime.log --script res://.atena/generated/2026-10-04-b05-local-controls-validation/validate_controls_and_menus.gd`
   - Exit 0, `LOCAL_CONTROLS_PASS: 33/33 checks`.
   - Covers narrative E/LMB separation; overlapping resource/enemy separation; inventory contents/pause/selection/close input; camp proximity; storage and E-confirmed Wheel Kit craft; all eight locked cave allies and guarded callbacks; retired Q/R; controller inventory/wagon access; F4 panel exclusion, UI-free snapshot and item restore; higher-Mark Shift dash; empty swing; inactive right-click; dash raster with/without supplementary VFX; enemy sizes/reach; real Space jump, J attack, controller melee/interaction; prototype two-post cap and recall without unlocking travel.
   - Early harness runs exposed a typed-array assignment error and an offscreen craft button. The harness uses typed-array `.assign`; the UI places crafting above recipe selection and follows keyboard focus. Only the final successful run is the acceptance result.
4. Normal smoke: same local path/resolution/OpenGL driver, `--quit-after 600`, log `normal-smoke.log`. Headless smoke: `--headless --quit-after 600`, log `headless-smoke.log`. Both exit 0 without script errors or warnings.
5. `validate_records.cjs` passed the ADD contract, 43 record/active-plan links, human-review/publication state and final Godot log checks. `git diff --check` and `git diff --cached --check` passed. No YAML parser dependency was installed; whole-file YAML parser verification remains a tooling limitation, distinct from the state/contract/link checks.

Original 11 negative controls remain historical original-B-05 evidence; they were not rerun for this revision. Do not report them as fresh follow-up results.

## Inspected normal-rendering captures

All paths are under `.atena/generated/2026-10-04-b05-local-controls-validation/`:

- `inventory-carried.png`, `wagon-supplies.png`, `wagon-allies.png`: English UI, separate carried/stock state, visible crafting, scrollable eight-ally roster and cave locks.
- `enemy-proportions.png`, `stag-proportions.png`, `boss-proportions.png`: relative size, grounded feet and clear overhead labels.
- `dash-clean.png`, `dash-drow.png`: clean body-only dash in both forms. `dash-baseline.png` is the paired no-VFX comparator, not an old pre-fix reference.
- `b05-hit.png`, `b05-miss.png`, `b05-dodge.png`, `b05-hurt.png`: measurable hit/miss and genuine damage distinction. The combat runner captures precede the final margin-only cleanup; final dash-specific captures are authoritative for that correction.

## Changed-file groups

- Runtime: `main.gd`, new `wagon_inventory_ui.gd` and its Godot UID.
- Validation: migrated original combat runner; new controls/menu runner, record validator, saved final logs and captures under the local validation directory.
- Records: approved control canon and legacy override link, revised and original B-05 specs, review and implementation evidence, active plan state, original instruction historical preface and English results/next-step handoff.
- No project settings, scene, image, dependency, published commit or later-region production asset was changed.

## Remaining checkpoint and limits

The human-review checkpoint was pending when commit `43ab112` was created. On 2026-10-04 the owner stated "tudo validado, vamos continuar", accepting the local implementation. This IN_PLAN acceptance is recorded without inventing a test-by-test human checklist or additional machine results. Saved state remains in memory only. Higher-Mark parry needs a future approved unlock/mechanics decision. Thornwake posts/missions and travel remain locked. No release export was produced.

B-05 stays active as `implemented-human-validated-awaiting-publication-approval`; B-04 remains the latest completed plan. No follow-up push, PR, merge or external handoff was authorized or performed. The next proposed step is a normal push to the same-named remote branch `codex/b05-controls-wagon-inventory`, leaving original B-05 history and main unchanged, once the owner specifically authorizes it. The English handoff is prepared in [[2026-10-04-b05-controls-and-wagon-menu-instruction]], not dispatched. B-06 is not started.
