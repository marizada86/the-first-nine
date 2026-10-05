---
status: implemented-published-human-accepted-awaiting-merge
kind: bounded-runtime-plan
created: 2026-10-05
plan_id: 2026-10-05-b07-stonehook-first-encounter
origin: planned
implementation_preceded_spec: false
request_classification: NEW_PLAN
preparation_approved: true
preparation_authority: owner-approved-continuation-after-integrated-B06
approval_mode: per-plan
approval_selection: owner-selected-option-1
approved: 2026-10-05
approval_source: owner-selected-1-to-approve-the-presented-B07-scope-and-per-plan-mode
request_execution_classification: IN_PLAN
implementation_approved: true
execution_target: opus-5.5
baseline_commit: e189184e1928efca8172ce4a9c65996be81c206a
proposed_implementation_branch: codex/b07-stonehook-first-encounter
evidence: "[[2026-10-05-b07-stonehook-first-encounter]]"
instruction: "[[2026-10-05-b07-stonehook-first-encounter-instruction]]"
documentation_publication_approved: true
documentation_publication_source: owner-authorized-one-documentation-commit-and-normal-push-to-main
publication_snapshot: delivered-and-verified
documentation_published: true
delivery_commit: fcc98b63e1919c54b6df563c8de0c7173a7affcb
delivery_verified: true
implementation_branch: codex/b07-stonehook-first-encounter
implementation_base: fcc98b63e1919c54b6df563c8de0c7173a7affcb
implementation_evidence: "[[2026-10-05-b07-stonehook-first-encounter-implementation]]"
human_acceptance: accepted
push_approved: true
pull_request_approved: true
merge_approved: true
dispatch_approved: false
human_acceptance_date: 2026-10-05
implementation_commit: 4da953cd34469b8024eb2d3831ba7c8ae06cb34a
implementation_published: true
windows_review: "[[2026-10-05-b07-windows-review]]"
---

# B07 First Stonehook Encounter

Add one finite Scree Crawler encounter to the existing on-foot foothill corridor. Lolth can fight, evade or retreat to the cave; the ore remains accessible without a mandatory kill. The owner approved the presented scope and selected per-plan approval by answering option 1 on 2026-10-05. Implementation is assigned to Opus 5.5 after authorized document delivery and checkout verification; it has not started here. The preceding integrated slice was accepted in [[2026-10-05-b06-integrated-human-acceptance]].

## Sources and Existing Implementation

[[2026-10-03-caravan-survival-slow-travel]] preserves Stonehook's threat family while superseding earlier wagon departure rules. [[2026-10-03-continuous-caravan-ground-and-web-gates]] requires a continuous main floor. [[2026-10-04-first-boss-mark-and-cure]] and [[2026-10-04-separated-controls-and-wagon-management]] remain binding. The completed [[2026-10-04-b06-stonehook-foot-expedition]] supplies the legitimate departure gate, corridor, finite ore, fixed cave camp and restoration.

`main.gd` already preloads `assets/runtime_v2/enemies/stonehook/stonehook-threats-core-v1.png`. Its prototype spawner uses `SCREE CRAWLER` and burrow movement, but prototype contact/movement is not a complete telegraphed encounter. The frame selector compares title-case names, and region, geometry, bounds and safe-capture logic still assume cave actors. Do not enable `enter_stonehook()` or change the hub's `zone` to solve these assumptions.

The existing 1536x1024 RGBA atlas was inspected during preparation. The crawler is the upper-left artwork, not the other three creatures or an animation strip. Proposed source rectangle: (0, 0, 768, 480), excluding the staff visible at the lower row boundary. Its static artwork can support movement, facing, hit tint and procedural attack warnings; no new hand-drawn animation is promised. Preserve the source image and all existing assets.

## Scope and Technical Defaults

Create a stable encounter identity `stonehook_scree_crawler_01` on legitimate first entry into the foothills, at proposed x=2340 on the existing floor. It is available in day and night, never in the opening/tutorial and never through an F4-only Mark override. Use one actor, 3 health and one Shadow Echo on a credited kill, still subject to the existing 3/3 cap. Coordinates, health and attack timing are playtest defaults within this scope, not new lore.

Give this actor a specific encounter region independent of the cave hub and camera. Keep its full body inside the foothill span 1760-3040, never pursue Lolth into the approach or cave, never attack the wagon and never inflict damage across the regional boundary. Retreat cancels any pending strike. Border revisits and new days preserve the same live actor state and never generate another copy. Cave wave creation, wave completion and enemy clearing must operate on cave threats without erasing or counting this encounter.

Implement approach, windup, short ground lunge and recovery. Proposed defaults: movement 48 units/s, windup 0.7 s, lunge 0.25 s at 180 units/s, recovery 1.0 s and one 12-health hit per strike. Lock attack direction during windup, show a readable ground warning and label, and honor existing dash invulnerability and hurt cooldown. No invisible contact damage, true underground traversal or terrain destruction. Stop motion at region bounds and preserve facing through windup/recovery.

Select the crawler source by stable actor identity, not Lolth's region or title-case mismatch. Preserve native aspect ratio and grounded feet. Proposed visible alpha-body height is 120 pixels, separately from transparent cell padding. Prepare the exact source bounds once before gameplay using the existing alpha threshold and cache. Both melee reach and First Thread must agree with that body and vertical range; do not use the legacy 96-pixel generic reach. First Thread retains its existing damage and cooldown. A miss must not inflict damage; Lolth's attack pose must not trigger her hurt pose without an actual incoming hit. Draw enemy reflection, warning, labels and health bar correctly with the camera transform restored. Keep Thornwake/prototype geometry unchanged except explicitly tested encounter dispatch.

## Encounter Lifecycle and Restoration

Persist encounter activation, defeat and reward identity. Death alone cannot pay an Echo twice. Preserve the one-time ore and existing stock/carry capacity rules. A living foothill enemy must not prevent a safe capture at the cave when the cave's own threats and survival checks permit it; it must never make an unsafe cave safe.

A valid cave snapshot records encounter activation/defeat/reward flags alongside the existing saved Echoes and ore state. Failure rolls back all of them together. Preserve the existing clearing of transient enemies on safe restore: if the saved encounter is undefeated, it is re-created once on a subsequent legitimate foothill visit at initial health; if saved defeated, it remains defeated. Unsaved defeat and its Echo are both rolled back, not selectively retained. Ordinary retreat does not reset health. F4 exact restoration, unlike failure rollback, deep-restores the live encounter actor, health, position, facing and attack timers as well as the run snapshot. A new run clears all encounter fields.

## Non Goals and Allowed Files

No Stone Maw, Cliff Harrier, shrine, Mark II, additional cure, wagon travel, puller, missions/posts, axle/brakes unlock, parry, web gate, rope teleport, later region, new art/audio, asset binary edits, dependency, disk save or broad architecture rewrite. No foreground, seam, label or camera overhaul; existing B-06 limitations remain. No canonical files change.

Allowed production file: `main.gd`. New tests, runner, captures and documentation belong under `.atena/`. No changes to `project.godot`, scenes, existing assets, `wagon_inventory_ui.gd` or historical validators. If another production file, asset revision or new mechanic becomes necessary, report the gap and obtain a plan change rather than silently broadening the batch.

Preserve A/D/controller movement, Space jump, Shift dash, E interaction, left-click/J attack, C First Thread, I carried inventory, wagon-menu management, inactive right-click, legitimate route locks and existing UI/F4 pause policy. Mark and cure progression remain exactly as in B-06.

## Acceptance Criteria

1. Only legitimate foothill entry creates the single identified crawler; new game, tutorial and debug-only departure remain locked. Border/day oscillation cannot duplicate or reset it.
2. Sprite, feet, proportions, warning, facing and health bar are readable at 1280x720 in day and night, facing both ways. No other creature cell, foreign prop or opaque atlas rectangle is drawn. Exact bounds are cached before gameplay, not rescanned per frame.
3. Real attack and First Thread inputs damage the crawler inside visual reach and miss outside it. Windup precedes the enemy strike; dash avoids the strike, and a strike cannot damage more than once. An attack does not manufacture a hurt pose.
4. Retreat is always possible. No crawler, strike or reward reaches the cave; its life cannot block a valid cave save. Offscreen Thornwake night attacks still cause concrete wagon damage and normal camp failure.
5. One defeat gives at most one Echo within the unchanged cap, with no Mark II, cure or travel unlock. The ore and inventory/deposit loop remain independent of defeating the crawler.
6. Unsaved defeat/ore and reward roll back together on failure; safe-saved defeat stays defeated. Saved undefeated state recreates at most one enemy after restore. F4 deep restore and new-run reset cover all added fields.
7. Existing combat, controls, menus, route, geometry, facing, self-tests and smoke runs retain their intent. New assertions cover the new actor explicitly; historical tests are not weakened to obtain a pass.

## Gaps and Deferred Work

BLOCKING design gaps: none. Approval selection and scope approval were explicitly granted on 2026-10-05. The next checkpoint is authorized delivery of the approved documents, not a second implementation approval. Defaults above resolve encounter selection, location, tuning and rollback policy within the approved scope. Rendered asset suitability and human balance are validation obligations, not results already established. If the inspected crop cannot meet the visual criteria without an asset edit, execution must stop for an asset-scope decision.

DEFERRED: remaining Stonehook threats, boss/shrine and regional progression; additional animation art; all non-goals and the accepted B-06 limitations.

## Plan of Flight and Approval

- S-001 / B-001: region-specific lifecycle, fixed-source geometry and telegraphed combat.
- S-002 / B-002: snapshot, F4, cave-wave and reward integration.
- S-003 / B-003: deterministic and real-input validation, visual review and operational evidence.

Approval mode is per-plan. After authorized document delivery and checkout verification, Opus 5.5 may execute S-001 through S-003 within the unchanged scope without another batch or step approval. The step and batch identifiers remain useful progress labels, not extra approval gates. Stop for human acceptance before implementation publication; document publication, implementation push, PR, merge and external dispatch require separate explicit authority. No external message is sent automatically here. Read [[2026-10-05-b07-stonehook-first-encounter-instruction]] for the delivery gate and return requirements.

On 2026-10-05, the owner separately authorized one documentation-only commit and a normal push to main of this B-07 package and the integrated B-06 acceptance receipt. This clears document-publication authorization only. These committed records describe the pre-push snapshot, not a successful push yet. The resulting commit and verified remote outcome are supplied after publication in the owner's handoff; Opus must verify that fetched commit and clear its local delivery checkpoint before implementation. No extra commit containing its own hash is required. Future implementation push, PR, merge and external dispatch remain unauthorized.

## Validation and Evidence

Use Godot 4.7.2 (`D:/Godot/godot.exe` for owner-local validation). Add a B-07 headless self-test and a real-input runner in isolated scratch checkouts. Filter physical controller motion before the first gameplay frame for keyboard-only tests, prove the isolation and test synthetic noise separately; retain a real controller section. Measure settled motion rather than sampling mid-deceleration.

Exercise lifecycle, attacks/misses/First Thread/dash, regional fences, cave threats/capture, cap, ore, rollback, F4 and reset. Capture day/night in both directions plus windup, hit, miss and retreat at 1280x720. Run existing B-06 route/combat/menu/geometry/facing regressions, the full self-test and rendered/headless 600-frame smoke runs. Report Linux results separately from official Windows validation; no CI or fresh Windows claim may be inferred from another platform.

Reject faulty controls for duplicate spawn, wrong creature cell, wrong reach, omitted warning, repeated hit, pursuit past bounds, cave-wave actor erasure, remote safe-capture confusion, repeated reward, incomplete failure rollback and incomplete F4 restore. A negative result needs a genuine nonzero exit and the named assertion, not a parser/import crash. Do not claim these controls were run during preparation.

Save raw logs, case manifests and captures, then compare every criterion with evidence. Keep completed-plan history and old test results unchanged. Reconcile implementation status and any separately authorized publication facts; completion requires review and human acceptance, not just self-test output.

## Delivery Verification and Implementation Checkpoint

On 2026-10-05, the owner supplied the published documentation commit `fcc98b63e1919c54b6df563c8de0c7173a7affcb` and the explicit implementation handoff. The executor fetched origin and verified that commit as `origin/main`, a direct child of `e189184`; the committed delivery checker passed. The local delivery checkpoint was then cleared. The earlier `pre-push` snapshot and false publication field describe the dated pre-push checkpoint and are superseded here, not rewritten. S-001 through S-003 were executed locally on `codex/b07-stonehook-first-encounter` from that commit. Results, implementation decisions and limitations are in [[2026-10-05-b07-stonehook-first-encounter-implementation]]. The plan awaits human review: nothing is pushed, no PR or merge exists, human acceptance is pending and no B-08 work has started.

## Publication Review and Owner Acceptance

The previously local-only implementation checkpoint is superseded by the verified publication of `4da953cd34469b8024eb2d3831ba7c8ae06cb34a` on `origin/codex/b07-stonehook-first-encounter`. Earlier sections remain dated implementation history.

Fresh Atena Windows review of 4da953c: Godot 4.7.2, GTX 1650, full runner exit 0; B07 24/24 and real-input 28/28; B06 30/30 and 53/53; combat/noise 9/9 each; menus 33/33; geometry 46/46; facing 65/65 and 102/102; self-test and both 600-frame smoke passes; 11 faulty controls genuinely rejected, zero project diagnostics; eight fresh captures inspected.

Owner replied "aceito, borah" after the Windows technical report, accepting B-07 with its listed limitations and explicitly authorizing record publication, PR opening, regular merge, operational closure and B-08 proposal preparation only. No itemized owner playtest or B-08 implementation approval is inferred.

The accepted limitations are static art, unreviewed balance, foreground occlusion, overlapping labels/ore and in-memory saves; F4 encounter restore was headless-tested. No new executor Linux run or CI result is claimed. Opening and merging the PR are authorized but have not occurred at this records checkpoint. B-08 remains an inactive preparation-only proposal.
