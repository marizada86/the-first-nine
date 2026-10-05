---
status: prepared-inactive-dependency-cleared-awaiting-mode
kind: future-bounded-runtime-proposal
created: 2026-10-05
plan_id: 2026-10-05-b08-stonehook-cliff-harrier
origin: planned
implementation_preceded_spec: false
request_classification: PLAN_DEVIATION
deviation_id: DEV-001-b08-preparation
preparation_approved: true
preparation_authority: owner-selected-option-1-to-prepare-now-without-implementation
approval_mode: unconfigured
implementation_approved: false
active_plan: false
scope_approved: true
scope_approval_source: owner-approved-delivery-of-the-revised-english-b08-prompt
approval_mode_selection: pending-owner-sent-per-plan-prompt
execution_target: opus-5.5-cloud
depends_on: "[[2026-10-05-b07-stonehook-first-encounter]]"
preparation_checkout: fcc98b63e1919c54b6df563c8de0c7173a7affcb
implementation_base: 4d3c5c1ae5411aaf58e6fd7ae8333e45ecef7ac1
proposed_implementation_branch: codex/b08-stonehook-cliff-harrier
evidence: "[[2026-10-05-b08-stonehook-cliff-harrier]]"
instruction: "[[2026-10-05-b08-stonehook-cliff-harrier-instruction]]"
push_approved: false
pull_request_approved: false
merge_approved: false
dispatch_approved: false
---

# B08 Stonehook Cliff Harrier Proposal

Prepare one second, finite Stonehook encounter using the existing Cliff Harrier artwork. The proposed enemy uses low flight, a visible dive warning and a recovery window, adding variety without enabling a boss or further progression. The owner approved the revised scope and requested its English cloud prompt. B-07 is technically validated, accepted, merged and operationally closed. B-08 remains inactive until approval-mode selection and activation; sending the self-contained owner prompt with its explicit per-plan selection can provide that choice to the cloud executor.

## Sources and Dependency Gate

[[2026-10-03-caravan-survival-slow-travel]] retains Stonehook's regional threat family and stationary early cave hub. [[2026-10-03-continuous-caravan-ground-and-web-gates]] protects the connected floor. [[2026-10-04-first-boss-mark-and-cure]] and [[2026-10-04-separated-controls-and-wagon-management]] preserve current progression and inputs. [[2026-10-05-b07-stonehook-first-encounter]] defines the preceding crawler, identity, combat, reward and restore work.

B-07 implementation `4da953c` passed Atena's fresh Windows validation and was accepted with its documented limitations. PR #7 was regularly merged at `2684dac`; the documentation closure is published at `4d3c5c1ae5411aaf58e6fd7ae8333e45ecef7ac1`, which is the verified integrated main and readiness baseline. See [[2026-10-05-b07-windows-review]]. Production `main.gd` is unchanged since the reviewed implementation. The cloud executor must fetch and verify this base or a later compatible descendant, then read the integrated B-07 code and records.

B-08 still requires an explicit approval mode and activation before implementation. The local drafts are not published. The owner-sent self-contained English prompt may deliver the exact revised scope directly; if used, persist it in the planned B-08 records before implementation rather than requiring missing files. No new B-08 publication, PR or merge is authorized.

## Proposed Encounter and Movement

Use one stable identity `stonehook_cliff_harrier_01`. Proposed activation: legitimate expedition access plus first arrival at x>=2600 in the existing foothills. Initial position: x=2760, with a proposed clear patrol span 2400-2860, clamped by the visible half-width. This leaves the crawler encounter earlier on the route and requires no larger map, new ground or forced kill. Available day and night; activation, health and defeat persist across ordinary visits and days. One Harrier and the existing crawler are the only foothill encounters in scope.

Use an approach/retreat phase, frozen windup, short dive to a projected floor position and recovery back to low flight. Proposed tuning: 3 health, 1 capped Echo, approach 70 units/s, retreat 45 units/s inside a 100-unit distance, attack initiation at 180 units, windup 0.8 s, dive 0.3 s, maximum horizontal dive speed 220 units/s, recovery 1.2 s and one existing one-point hurt per strike in Lolth's three-health model. These are playtest defaults, not canon. Bound travel distance by speed and elapsed time; never teleport to the player or retarget during a strike.

Low flight remains reachable by the current grounded attack and First Thread; jumping is optional, not a requirement. Proposed visual hover height is 30 pixels above the existing floor, with at most 6 pixels of visual bob. Geometry, hurt testing and targeting must use the actual displayed position rather than a separate invisible anchor. During windup, show a readable landing warning on the floor and lock horizontal target/direction. Attack damage is active only during the strike, at most once per strike, with existing hurt cooldown and dash invulnerability honored. No idle contact damage or unseen vertical attack.

Cancel a pending attack when Lolth retreats out of the foothills. The entire enemy body stays inside the clear 2400-2860 patrol; strikes and projected warnings stay inside 1760-3040 with footprint-aware bounds. These constraints avoid the existing opaque foreground without editing it. The Harrier never enters the approach/cave, attacks the wagon or damages across the boundary. Ordinary retreat preserves health; it is not a heal/reward reset. Implement behavior with the existing accepted B-07 encounter conventions, not a general flying-navigation system.

## Artwork and Targeting

The existing `assets/runtime_v2/enemies/stonehook/stonehook-threats-core-v1.png` is already preloaded. Its upper-right bird artwork is a static pose, not a new flight animation strip. Proposed source rectangle: (768, 0, 768, 497). Read-only preparation found its claw pixels through y=495; neighboring lower-row artwork becomes opaque at y=499. This crop is a grounded starting point, not a rendered acceptance result.

Preserve native aspect ratio, wings and claws, using a proposed visible alpha-body height of 110 pixels rather than padded-cell height. Reuse B-07's accepted fixed-source selection and prewarmed bounds, adapted only for this actor. No other creature cell or bottom-row boss may appear when nearby or defeated. Use procedural motion, facing, warning, hit tint and the existing short defeat display, not unrelated atlas cells as animation frames.

Melee and First Thread must distinguish the two actors by their actual accepted geometry and reach policy. Preserve the existing ability range, damage and cooldown. Tests must cover nearest eligible target, an out-of-range enemy closer by a misleading anchor, vertical reach, both facings and camera offsets. Do not enlarge global reach, hurt radii or contact damage to mask poor placement. Preserve crawler and Thornwake geometry and behavior.

## Two Encounter State and Camp Coexistence

Reuse the actual accepted B-07 lifecycle and extend it minimally to two stable identities. Spawning, clearing, saving and reward credit must not depend on array order, shared enemy name or a single global defeated flag. Killing one must never kill, reward, reset, erase or suppress the other. Border/day oscillation creates no duplicates. The two encounters do not need separation steering or ally mechanics; simultaneous combat is allowed and must be tested.

Preserve concrete offscreen cave waves, survival, wagon damage and terminal failure. Neither foothill enemy blocks a legitimate cave safe capture or cave wave completion; cave wave creation/clearing never erases either foothill enemy. Local pause policy for UI/F4 remains unchanged. The finite ore can be collected, carried and deposited independently of either kill, with the same capacity and identity rules.

Snapshot activation/defeat/reward flags for each actor consistently with saved Echoes and ore. On failure, unsaved kills and rewards roll back together for each actor. Follow the accepted B-07 transient-clearing policy: saved undefeated encounters recreate once at initial health on a subsequent legitimate visit; saved defeated encounters remain defeated. Ordinary retreat does not reset a living actor. Cover all four saved defeat combinations: neither, crawler only, Harrier only, both. F4 exact restore deep-restores both actors' live states, timers, positions and the original snapshot without reward leakage. New run clears all added fields.

## Non Goals and Impacts

Do not enable Stone Maw, shrine, Mark II, second cure, wagon travel, pullers/posts/missions, axle/brakes progression, parry, web/rope traversal, later regions, terrain hazards, new art/audio, binary asset edits, dependencies, disk saves or broad camera/AI architecture. No canonical files or completed records change. Existing documented visual and balance limitations remain.

Future allowed production edit: `main.gd` only, based on the integrated B-07 version. Tests, fixtures, captures and operational evidence belong under `.atena/`. Preserve existing historical validators/results; add explained regression wrappers only if a previous single-actor boundary assertion needs an explicit two-actor adaptation. Another production file or asset requirement needs a plan change. During preparation, no production edit is allowed at all.

## Acceptance Criteria

1. Legitimate later foothill entry creates exactly one Harrier, never before the route gate or through debug-only Mark changes. Crossing, day changes and retreat cannot duplicate/reset either encounter.
2. Day/night renders at 1280x720 show only the bird, with natural proportions, intact crop, correct facing, stable body/target alignment, readable warning and camera-correct labels. Exact source bounds are prepared before gameplay.
3. Grounded melee and First Thread hit/miss correctly. The dive is visibly warned, locks its target, moves continuously, hits at most once and can be escaped with dash. A player attack does not produce a hurt pose without genuine damage.
4. Both enemies can coexist. Killing/crediting one leaves the other unchanged; each pays at most one capped Echo. The unchanged 3/3 cap never opens Mark II, a cure or travel.
5. Retreat, the continuous floor, offscreen cave threats, safe capture, inventory and ore loop remain functional. No remote damage or remote camp access appears.
6. Failure restore passes all four saved defeat combinations and rolls unsaved rewards/ore back coherently. F4 exact restore and new-run reset cover both identities and live actor state.
7. Accepted B-07 encounter tests and B-06/core regressions retain their protected behavior. Results are fresh and platform-specific; historical evidence is never presented as a new run.

## Gaps and Approval

The B-07 implementation dependency is resolved at the verified integrated base above; no technical dependency blocker remains. Approval-mode selection and B-08 activation are pending operational gates, not engine results. Asset suitability and attack balance are later validation obligations; if the fixed existing artwork cannot meet the criteria without a binary edit, stop for an asset-scope decision.

RESOLVABLE proposed defaults: low flight rather than inaccessible aerial combat; one finite bird after the ore approach; reusable static artwork; bounded telegraphed dive; per-actor save/reward identity. DEFERRED: all non-goals, later Stonehook progression and additional hand-drawn animation.

The earlier option 1 authorized proposal preparation only. The owner's later approval accepts this revised scope and requests its English cloud prompt. Local approval mode remains unconfigured until the owner selects it; the self-contained owner-sent prompt explicitly selects option 1, per-plan, when dispatched by the owner. Before implementation, persist the mode, approval source, scope and active checkpoint. Publication, PR and merge retain independent gates.

## Future Plan of Flight and Validation

- S-001 / B-001: inspect the accepted B-07 base, add bird geometry and telegraphed movement with reachable targeting.
- S-002 / B-002: integrate two identities, camp coexistence, reward credit and restoration.
- S-003 / B-003: headless and real-input tests, negative controls, inspected captures and owner review.

Future validation uses Godot 4.7.2 (`D:/Godot/godot.exe` on owner-local Windows), with isolated scratch runs and recorded actual commands/version/platform/exits. Exercise activation/visit/day repetition, both-target selection, flight and dive targeting, windup/locked aim/dash/recovery, bounds, reward cap, cave waves, ore, four save combinations, F4 and reset. Run accepted B-07 tests, B-06 route/combat/menu/geometry/facing regressions, full self-tests and rendered/headless 600-frame smoke checks. Controller filtering must precede gameplay in keyboard-only tests; keep separate trigger-noise and controller checks.

Capture day/night and both facings, grounded hit/miss, dive warning/strike/recovery and both enemies together. Inspect sprite crop, targeting, position continuity and UI readability. Keep Linux and Windows results separate. Reject genuine faulty controls for unreachable hover, wrong artwork, late bounds preparation, live retargeting, repeated strike damage, cross-boundary dive, shared identity/defeat flags, repeated reward, lost actor on cave-wave clear and incomplete restore. Parser/import crashes are not successful negative controls.

Save evidence under `.atena/generated/2026-10-05-b08-validation/` and a future implementation note, without overwriting earlier results. Reconcile actual implementation status and separately authorized publication facts; stop for human acceptance. No test or capture result is claimed at preparation time.
