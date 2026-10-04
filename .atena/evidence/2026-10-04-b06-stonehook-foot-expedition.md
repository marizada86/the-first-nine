---
status: prepared-awaiting-approval-selection
kind: planning-evidence
created: 2026-10-04
request_classification: NEW_PLAN
origin: preparation
preparation_approved: true
approval_mode: unconfigured
implementation_approved: false
runtime_changed: false
push_approved: false
dispatch_approved: false
spec: "[[2026-10-04-b06-stonehook-foot-expedition]]"
instruction: "[[2026-10-04-b06-stonehook-foot-expedition-instruction]]"
local_baseline: 2f34635ff5adf735e51a7c144862e7c1bba37bed
gameplay_baseline: 05eac1e7a639e213f39cff81b1e75305727ab4d0
---

# B-06 Expedition Planning Evidence

The owner reported "tudo funcionando" after the recommended final Thornwake playtest. That overall human confirmation was recorded locally in `2f34635`, without inventing itemized tests or publishing it. The owner then answered "pode" to preparing the proposed B-06 plan and English Opus prompt. This authorizes preparation, not implementation, publication, external dispatch or merge. No active plan existed before this preparation; the enemy-facing correction remains the last completed plan.

## Inspected Sources and Runtime Constraints

Read the ADD contract, persistent state, completed B-04 and B-05 boundaries, current facing/merge receipt, and the approved caravan, continuous-ground, first-cure, control and Stonehook visual decisions. Preserve the newer caravan rule over older first-cure wagon-departure wording.

`main.gd` uses a 1280x720 viewport, x=190 cave anchor, GROUND_Y=555 and a viewport-width movement clamp. `spawn_zone()` resets player position and clears runtime arrays. `enter_stonehook()` requires the wagon travel lock to be bypassed and then instantiates the prototype Stonehook scene. That is not an approved on-foot corridor. The legacy Stonehook branch also enables hazards/rope routes, enemy/boss hooks and progression paths that this proposal must not accidentally expose.

Camp checks and `wagon_inventory_ui.gd` contain x/zone assumptions; rendering, enemy sheet selection, night waves, safe restore and objective text also follow the single current `zone`. Backgrounds and foregrounds fill the screen rather than spanning a connected world. Scoped separation of player region, world/view position and stationary hub state is therefore necessary; removing the travel lock alone is not sufficient.

Existing runtime preloads include the Stonehook route texture and salvage art. No new image, audio, dependency or asset admission is needed for the proposed first corridor. Existing floor movement remains flat; optional rope/hazard mechanics and the full region are deferred. No source or canonical decision is edited during this inspection.

## Proposed Decisions and Preserved Boundaries

The spec proposes one gradual route, one finite ore pickup, a physical return to the cave, continued offscreen camp survival/threat simulation and correct operational rollback. These are bounded technical/playtest defaults, not implemented facts. It preserves one cure, Mark I, Echo cap, dash, inactive parry, protected relics/family, stationary travel-locked wagon and existing in-memory save semantics.

The owner has not selected an approval level for this new plan. Modes/checkpoints are explicitly defined in the spec; `unconfigured` is not executable. No new branch, implementation, actual B-06 validation, push, PR, merge or message to Opus. The previous integrated playtest does not grant B-06 approval.

## Preparation Validation and Delivery Limits

The preparation validator checks required ADD directories, links, exact preservation of the completed-plan/history state, the pending unconfigured approval gate, allowed documentation paths and unchanged runtime/assets/configuration. It is a scoped structural check, not a full YAML parser or new Godot test. Prior machine results and captures remain historical evidence and are not overwritten or represented as B-06 passes.

Files created for preparation are the spec, this evidence, the English instruction and a scoped preparation validator; only the active-plan slot/cursor is updated in persistent state. The English instruction remains a draft until approval is recorded and the exact records are delivered. An external executor must stop if the local acceptance/preparation records are missing remotely, rather than reviewing or implementing an older branch. Publication and dispatch require separate explicit owner authorization.

The `write-page` skill guided descriptive headings, separation of observed facts from proposed defaults and a self-contained English handoff. The established local `.atena/` format and destination are preserved; no external Page is created.

Preparation validation completed with exit 0 and `B06_PREPARATION_PASS`: 14 resolved links, required ADD structure, unconfigured approval/implementation/publication gates, exact previous completed-plan/history preservation and unchanged runtime/assets/settings/canon. Scoped whitespace checks pass. This validates the prepared documents, not the planned corridor or any B-06 gameplay behavior. The old facing closure validator belongs to its closed-plan checkpoint and is not a substitute for the current preparation check.
