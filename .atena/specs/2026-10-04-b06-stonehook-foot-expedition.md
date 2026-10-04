---
status: draft-awaiting-approval-selection
kind: bounded-runtime-plan
created: 2026-10-04
plan_id: 2026-10-04-b06-stonehook-foot-expedition
origin: planned
implementation_preceded_spec: false
request_classification: NEW_PLAN
preparation_approved: true
preparation_authority: owner-stated-pode-to-plan-and-English-Opus-prompt
approval_mode: unconfigured
implementation_approved: false
push_approved: false
pull_request_approved: false
merge_approved: false
dispatch_approved: false
local_baseline: 2f34635ff5adf735e51a7c144862e7c1bba37bed
gameplay_baseline: 05eac1e7a639e213f39cff81b1e75305727ab4d0
proposed_implementation_branch: codex/b06-stonehook-foot-expedition
evidence: "[[2026-10-04-b06-stonehook-foot-expedition]]"
instruction: "[[2026-10-04-b06-stonehook-foot-expedition-instruction]]"
---

# B-06 First Stonehook Foot Expedition

B-06 proposes the first reversible expedition from the cave to early Stonehook. Lolth walks through a connected route, collects one regional resource and returns to the same wagon. The wagon, relics and eight family members remain at the cave. This document is ready for approval selection, not implementation: the owner authorized preparation only.

## Authoritative Sources and Existing State

Use [[2026-10-03-caravan-survival-slow-travel]], [[2026-10-03-caravan-relics-cave-prologue-and-travel]], [[2026-10-03-continuous-caravan-ground-and-web-gates]], [[2026-10-04-first-boss-mark-and-cure]] and [[2026-10-04-separated-controls-and-wagon-management]]. Later approved caravan decisions supersede the older statement that the wagon departs after the first cure. Early Stonehook must be reached on foot, not by moving the wagon or selecting another map.

The current game has a 1280x720 screen, a fixed player clamp and prototype region switches that clear arrays and reset player position. `enter_stonehook()` is blocked by the wagon travel lock. The existing Stonehook branch includes a relocated camp, hazards, rope teleport routes, boss and Mark-II paths. Enabling that branch wholesale would violate this scope. Completed B-01 through B-05 and the facing correction remain accepted; the owner reports the integrated Thornwake slice functioning. No new per-item human results are inferred.

## Proposed Scope and Technical Impact

Implement a bounded continuous route using existing runtime backgrounds, ground, Lolth, pickup and camp assets. Distinguish Lolth's world position and displayed region from the cave hub's fixed position and state. Add the minimum horizontal world-to-view translation necessary for the route; do not replace the scene architecture, install dependencies or generalize all later regions.

Keep Thornwake's existing start, tutorial, boss and first-cure sequence. Outward access becomes available only after legitimate Mark I, exactly one cure, repaired wagon and a previously captured survivable safe-wagon state. Mere F4 Mark changes, old completion buttons and the test-only travel bypass must not grant ordinary expedition access. Gate departure, not return: an already-away player must always be able to walk back while the run is active.

Proposed playtest geometry, not lore: retain the original Thornwake world span 0-1280 and cave anchor at x=190; add a 480-unit transition band from x=1280 to x=1760 and one 1280-unit foothill span ending at x=3040. Keep the main floor at the existing GROUND_Y=555. Camera translation is zero for the original cave/tutorial view. Expose route dimensions as named data; adjustment is permitted only within this one-corridor scope and must be reported and tested. No automatic teleport, full-screen temporal fade, loading card or region reset occurs at the border.

The transition spatially blends existing backgrounds and foregrounds so vegetation thins, rock increases and the palette cools. Do not use a full-screen dissolve between discrete scenes as a substitute. HUD, inventory, wagon UI and F4 panel stay in screen coordinates. Compose world translation with the existing sprite reflections and explicitly restore drawing context. Preserve grounded feet, native Thornwake proportions, shared-outline reach, hit feedback and cached bounds.

Place one finite, one-slot `IRON ORE` pickup on the accessible foothill floor, using the existing salvage art and `metal` item type. Give pickups stable identities. Revisiting the border must not recreate collected resources, duplicate carried items or refill the camp. The pickup can be carried back and deposited through the existing E/menu workflow; full inventory or wagon stock must retain the item and show the existing capacity feedback. The regional resource is a small proof of the expedition loop, not an unlock for axle/brakes or later progression.

## Camp Simulation and Restoration

The cave remains the only wagon interaction and checkpoint location. Camera position or the displayed Stonehook label must not enable remote deposit, crafting, ally management or safe capture. In particular, replace or guard assumptions such as `player.x < 305` and `zone != 0` where necessary; do not create a second camp in Stonehook. I still opens Lolth's carried inventory away from the wagon.

The world clock, Flame and Provisions retain their current rules. Existing Thornwake night waves, concrete attackers, wagon damage/defense and failure checks continue while Lolth is offscreen. Do not pause the camp, clear its enemies when crossing, replace enemies with abstract offscreen damage or run the same wave twice. Enemy behavior and rendering must use the enemy's originating region rather than incorrectly treating every actor as belonging to Lolth's displayed region. Existing UI pause and F4 pause behavior remain unchanged.

On death or terminal camp failure anywhere on the route, restore the last valid cave snapshot with Mark I and the same chosen cure. Never capture at zero Flame, Provisions, health or integrity. Extend operational snapshot coverage to the route, camera and regional pickup state so restoring cannot duplicate ore or mix pre/post-return data. Before a safe deposit/save, failure loses unsaved expedition loot as part of operational rollback; after a valid safe return, the saved stock and pickup state agree. Existing enemy-clear-on-restore behavior stays unchanged.

F4 restoration must deep-restore the added route fields, world position, camera, pickup identities and original camp/snapshot data. Debug Mark overrides remain inspection only. A new run resets every expedition field and again blocks departure until legitimate first-cure milestones.

## Non Goals and Protected Behavior

Do not enable wagon travel, pullers, additional cures, Mark II or later Marks, parry, posts/missions, the Stone Maw encounter/shrine, axle/brakes crafting, rope-route teleportation, Web Anchors, Hollowroot, new art/audio, atlas admission, equipment, disk saves or Attraction tuning. No new Stonehook combat is introduced in this traversal slice; the established cave threats remain active. Future Stonehook combat requires another approved scope.

Preserve A/D and controller movement, Space jump, Shift dash, E interaction, left-click/J attack, I inventory, wagon-menu ally management and C/its controller equivalent for First Thread. Right-click stays inactive. Preserve UI click consumption, existing pause policy, combat values, relic protection and the eight-member family. No canon file changes. Ambient-audio transition remains deferred because this batch admits no new audio assets or dependencies.

Allowed production files are `main.gd` and, only for necessary proximity/context guards, `wagon_inventory_ui.gd`. Evidence, tests and operational records belong under `.atena/`. Existing assets, `project.godot`, `main.tscn`, dependency/configuration files and unrelated completed records are not implementation targets. A broader architectural change requires a plan change and approval first.

## Acceptance Criteria

1. A new game, pre-boss state, uncured Mark I and debug-only Mark I cannot leave the original Thornwake bounds. Legitimate first cure plus safe return enables the on-foot departure without unlocking wagon travel.
2. Real movement input traverses the full route in both directions with no reset, jump in world position, floor gap or region-selection screen. At least five transition positions are captured at 1280x720 in day and night; the gradient and fixed screen-space HUD are readable.
3. The wagon and family have one fixed cave anchor before, during and after departure. Their state is unchanged merely by crossing. Remote E/M/UI requests cannot deposit, craft, assign allies or capture a safe snapshot.
4. Ore can be collected once, retained across ordinary border revisits and deposited once on return. Capacity handling is preserved. Safe snapshot rollback/recapture keeps pickup identity and stock consistent.
5. Clock and survival continue offscreen. An existing Stag actually damages the fixed cave wagon while Lolth is in the foothills; terminal failure restores the cave snapshot with Mark I and the chosen cure intact.
6. F4 exact restoration and new-run reset cover all new route data. Border oscillation cannot replenish enemies, loot or survival meters.
7. Reaching the far route limit, accumulating capped Echoes, interacting with old region controls or using ordinary camp UI never enables Stone Maw, Mark II, a second cure, parry, travel, posts or later regions. Thornwake Echoes remain capped at 3/3 in this slice.
8. Existing self-tests, real-input combat/menu checks and facing/geometry checks retain their intent. No production test bypass or weakened assertion is used to conceal a regression. Every changed assertion must explain the narrow B-06 boundary it supersedes.

## Gaps and Grounded Defaults

BLOCKING design gaps: none for this proposal. Execution still requires approval selection, explicit plan approval and delivery of the exact records to the executor; those are gates, not fabricated implementation results.

RESOLVABLE defaults are the short route geometry, legitimate departure gate, one stable ore pickup, persistent camp simulation, spatial visual blend and return-to-cave failure semantics above. They are proposed technical/playtest choices requiring plan approval, not new canon. The existing preloads supply visual assets; no generated reference is silently admitted.

DEFERRED work includes full Stonehook combat, material progression, Mark II, higher powers, audio, later-region terrain, permanent save files and broader tuning. If the executor finds the bounded camp/route separation impossible without a broader rewrite or new design choice, stop with a PLAN_CHANGE_REQUEST rather than silently changing scope.

## Plan of Flight and Approval Checkpoints

- S-001 in B-001: implement legitimate departure, one continuous corridor and scoped world-to-view translation; preserve the fixed cave anchor and original tutorial view.
- S-002 in B-002: add the stable ore/return loop and audit remote camp guards, offscreen camp simulation and all protected progression paths.
- S-003 in B-002: extend safe-wagon and F4 operational restoration plus new-run reset for route state.
- S-004 in B-003: run positive/negative, real-input, rendered and regression checks; write English implementation evidence and stop for human review.

Stable batches are B-001 Route and Rendering, B-002 Camp and State, B-003 Validation and Evidence. `per-plan` approves the local/executor implementation scope as one unit; `per-batch` stops before each batch; `per-step` stops before each S-001 through S-004. Current mode is `unconfigured`, with all implementation steps pending. Plan approval explicitly covers the bounded coordinate/context change described above, not a general architecture rewrite. Push, PR, merge, external dispatch and dependency gates remain separate.

## Validation and Evidence

Use `D:/Godot/godot.exe` for Windows; an external environment may use its available Godot executable without editing production files or claiming Windows reproduction. Record actual version, commands, exit codes, diagnostics and platform. Use wall-clock timeouts, not a fixed-FPS workaround.

Add isolated B-06 headless checks and a real-input outward/return runner. Include targeted faulty controls for bypassed departure prerequisites, border respawn/ore duplication, remote wagon/snapshot access, paused offscreen camp, lost route rollback/F4 fields and accidental Mark-II/travel unlock. Each faulty control must fail a named assertion with a genuine nonzero exit, not merely a parse error. Include camera-offset combat/UI tests and frozen captures demonstrating that sprite reflection and HUD transforms remain correct.

Run the full existing self-test, 9-check combat and 33-check menu runners, independent 46-check geometry and 65/102-check facing suites where applicable; distinguish reruns from historical evidence and document justified fixture adaptations for the new coordinate context. Preserve prior committed logs/captures and write new output under `.atena/generated/2026-10-04-b06-validation/`. Perform normal/headless smoke runs and report limitations without claiming CI, performance profiling or disk persistence.

Write `.atena/evidence/2026-10-04-b06-stonehook-foot-expedition-implementation.md` only after actual execution. Reconcile the spec, evidence and plan cursor to the real implemented/review state; do not mark merged/complete while implementation or human review is pending.

## Recovery and Delivery

Use a codex-prefixed feature branch from the verified current approved baseline, preserving local work and all existing branches. Normal corrective commits are the recovery path; no destructive resets, force-pushes or amending published history. The current local baseline includes unpushed acceptance `2f34635`; the preparation documents are also local. The owner must separately approve their publication/delivery before a cloud executor can rely on them. A missing commit or record is a delivery blocker: do not reconstruct an unseen spec from a pasted summary.

The English handoff is prepared but not sent. It tells Opus to check the live approval mode, exact repository state and delivery before editing. No runtime, art, branch publication or external message is performed during preparation.
