---
status: approved-awaiting-external-execution
kind: planning-evidence
created: 2026-10-04
request_classification: NEW_PLAN
origin: preparation
preparation_approved: true
approval_mode: per-plan
approved: 2026-10-04
approval_source: owner-selected-1-to-approve-the-presented-B06-implementation-scope
request_execution_classification: IN_PLAN
implementation_approved: true
execution_target: opus-5.5
preparation_commit: 0a82ead8384969a11399f20ef3dcf3828734df27
documentation_publication_approved: true
documentation_published: true
delivery_commit: 77ee387d5649a131ae20c5910b2dc7421c76f22f
runtime_changed: false
push_approved: false
dispatch_approved: false
spec: "[[2026-10-04-b06-stonehook-foot-expedition]]"
instruction: "[[2026-10-04-b06-stonehook-foot-expedition-instruction]]"
local_baseline: 2f34635ff5adf735e51a7c144862e7c1bba37bed
gameplay_baseline: 05eac1e7a639e213f39cff81b1e75305727ab4d0
---

# B-06 Expedition Planning Evidence

The owner reported "tudo funcionando" after the recommended final Thornwake playtest. That overall human confirmation was recorded locally in `2f34635`, without inventing itemized tests or publishing it. The owner then answered "pode" to preparing the proposed B-06 plan and English Opus prompt. That initial authorization covered preparation only. No active plan existed before this preparation; the enemy-facing correction remains the last completed plan.

## Inspected Sources and Runtime Constraints

Read the ADD contract, persistent state, completed B-04 and B-05 boundaries, current facing/merge receipt, and the approved caravan, continuous-ground, first-cure, control and Stonehook visual decisions. Preserve the newer caravan rule over older first-cure wagon-departure wording.

`main.gd` uses a 1280x720 viewport, x=190 cave anchor, GROUND_Y=555 and a viewport-width movement clamp. `spawn_zone()` resets player position and clears runtime arrays. `enter_stonehook()` requires the wagon travel lock to be bypassed and then instantiates the prototype Stonehook scene. That is not an approved on-foot corridor. The legacy Stonehook branch also enables hazards/rope routes, enemy/boss hooks and progression paths that this proposal must not accidentally expose.

Camp checks and `wagon_inventory_ui.gd` contain x/zone assumptions; rendering, enemy sheet selection, night waves, safe restore and objective text also follow the single current `zone`. Backgrounds and foregrounds fill the screen rather than spanning a connected world. Scoped separation of player region, world/view position and stationary hub state is therefore necessary; removing the travel lock alone is not sufficient.

Existing runtime preloads include the Stonehook route texture and salvage art. No new image, audio, dependency or asset admission is needed for the proposed first corridor. Existing floor movement remains flat; optional rope/hazard mechanics and the full region are deferred. No source or canonical decision is edited during this inspection.

## Proposed Decisions and Preserved Boundaries

The spec proposes one gradual route, one finite ore pickup, a physical return to the cave, continued offscreen camp survival/threat simulation and correct operational rollback. These are bounded technical/playtest defaults, not implemented facts. It preserves one cure, Mark I, Echo cap, dash, inactive parry, protected relics/family, stationary travel-locked wagon and existing in-memory save semantics.

Preparation commit `0a82ead` left the implementation approval unconfigured and pending. The previous integrated playtest did not grant B-06 approval. The subsequent explicit plan approval is recorded below; it is not backdated into the preparation stage.

## Preparation Validation and Delivery Limits

At preparation time, the validator checked required ADD directories, links, exact preservation of the completed-plan/history state, the pending unconfigured approval gate, allowed documentation paths and unchanged runtime/assets/configuration. It is a scoped structural check, not a full YAML parser or new Godot test. Prior machine results and captures remain historical evidence and are not overwritten or represented as B-06 passes.

Files created for preparation are the spec, this evidence, the English instruction and a scoped preparation validator; only the active-plan slot/cursor is updated in persistent state. The English instruction now records approval and authorized repository delivery. An external executor must stop if the acceptance/preparation/approval/delivery records are missing from its checkout, rather than reviewing or implementing an older branch. Future implementation publication and external dispatch still require separate explicit owner authorization.

The `write-page` skill guided descriptive headings, separation of observed facts from proposed defaults and a self-contained English handoff. The established local `.atena/` format and destination are preserved; no external Page is created.

Preparation validation completed with exit 0 and `B06_PREPARATION_PASS`: 14 resolved links, required ADD structure, unconfigured approval/implementation/publication gates, exact previous completed-plan/history preservation and unchanged runtime/assets/settings/canon. Scoped whitespace checks pass. This validates the prepared documents, not the planned corridor or any B-06 gameplay behavior. The old facing closure validator belongs to its closed-plan checkpoint and is not a substitute for the current preparation check.

## Per Plan Approval and Remaining Delivery Gate

On 2026-10-04, the owner selected "1" in response to the presented question approving the B-06 implementation scope and choosing its approval level. This request is IN_PLAN. The selection records `per-plan` approval for the complete bounded S-001 through S-004 scope and B-001 through B-003 batches. No new batch or step approvals are required while that scope remains unchanged. Execution is assigned to Opus 5.5 after delivery, not to local Atena implementation.

At approval commit `77ee387`, the spec, instruction and active plan agreed on `approved-awaiting-external-delivery`, implementation approval and the separate publication/dispatch gates. The validator checked that approval checkpoint rather than the superseded preparation checkpoint. Completed-plan history, previous validation and all gameplay/canon were unchanged. No new implementation branch, B-06 gameplay tests, push, PR, merge or message to Opus had occurred at that stage.

Approval validation completed with exit 0 and `B06_APPROVAL_PASS`: 14 resolved links, required ADD structure, explicit owner approval, pending delivery/publication gates and exact preservation of the previous completed-plan/history state. The changed-file and whitespace checks pass; runtime, assets, settings and canon are unchanged. This is approval-record validation, not execution of any B-06 gameplay acceptance criterion.

## Authorized Documentation Publication

The owner answered "autorizado" to publication of the three local documentation commits on main so Claude could read them. This request is IN_PLAN and covers the bounded documentation delivery and its operational reconciliation, not future implementation publication, PR, merge or messaging.

A fresh fetch confirmed no remote-only commits and exactly three local commits ahead. The scoped approval validator passed before publication. A normal push advanced origin/main from `05eac1e` to `77ee387`; `git ls-remote` confirmed the full remote HEAD as `77ee387d5649a131ae20c5910b2dc7421c76f22f`. The published commits are `2f34635` (owner playtest acceptance), `0a82ead` (B-06 preparation) and `77ee387` (per-plan approval).

The documentation delivery checkpoint is now cleared, with status `approved-awaiting-external-execution`. The executor must read this reconciliation or a later descendant and verify the files/approval before creating its implementation branch. No local B-06 implementation, new engine results, PR, merge, branch deletion or message to Opus occurred. `push_approved: false` continues to protect future implementation publication; the separately authorized documentation push is recorded by the documentation publication fields.

Delivery reconciliation validation passed with exit 0 and `B06_DELIVERY_PASS`: 14 resolved links, required ADD structure, consistent per-plan approval/documentation publication, approval commit present on origin/main, separate future implementation publication gates, exact prior completed-plan/history preservation and unchanged runtime/assets/settings/canon. Scoped whitespace checks pass. These are documentation checks, not B-06 gameplay results.
