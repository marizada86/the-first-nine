---
status: implemented-awaiting-human-review
kind: bounded-runtime-plan
created: 2026-10-05
plan_id: 2026-10-05-b08-stonehook-cliff-harrier
origin: planned
implementation_preceded_spec: false
request_classification: NEW_PLAN
approval_mode: per-plan
approval_selection: owner-selected-option-1
approved: 2026-10-05
approval_source: owner-message-approving-the-revised-B08-scope-and-selecting-option-1
request_execution_classification: IN_PLAN
implementation_approved: true
execution_target: cloud-executor
baseline_commit: 4d3c5c1ae5411aaf58e6fd7ae8333e45ecef7ac1
implementation_branch: codex/b08-stonehook-cliff-harrier
evidence: "[[2026-10-05-b08-stonehook-cliff-harrier]]"
instruction: "[[2026-10-05-b08-stonehook-cliff-harrier-instruction]]"
prior_plan: "[[2026-10-05-b07-stonehook-first-encounter]]"
documentation_published: false
push_approved: false
pull_request_approved: false
merge_approved: false
dispatch_approved: false
implementation_evidence: "[[2026-10-05-b08-stonehook-cliff-harrier-implementation]]"
human_acceptance: pending
---

# B08 Stonehook Cliff Harrier

Add one finite Cliff Harrier encounter to the existing on-foot foothills, alongside the accepted Scree Crawler. The owner approved this revised scope and selected per-plan approval (option 1) in the 2026-10-05 implementation message. That message supplies the scope directly; the owner-local B-08 drafts were not published and are not required. B-07 is complete and integrated at `4d3c5c1` ([[2026-10-05-b07-windows-review]]).

## Sources and Existing Implementation

[[2026-10-03-caravan-survival-slow-travel]], [[2026-10-03-continuous-caravan-ground-and-web-gates]], [[2026-10-04-first-boss-mark-and-cure]] and [[2026-10-04-separated-controls-and-wagon-management]] remain binding. [[2026-10-04-b06-stonehook-foot-expedition]] supplies the corridor, departure gate, ore and fixed cave camp. [[2026-10-05-b07-stonehook-first-encounter]] supplies the conventions to reuse:

- a separate foothill actor outside the cave `shades` list;
- identity-based sprite selection;
- startup bounds;
- body-based reach;
- a warning drawn above the foreground;
- post-motion contact;
- snapshot flags, and the clear patrol span 2400-2860 chosen against the foreground overlay.

The existing atlas `assets/runtime_v2/enemies/stonehook/stonehook-threats-core-v1.png` holds the bird in its upper-right cell. Inspected at preparation with the game's alpha rule (>= 0.25):

- The proposed crop `Rect2(768, 0, 768, 497)` contains only the bird, with wings, claws and native right-facing pose.
- Its alpha bounds are `(37, 8, 613, 488)`.
- Rows 496-497 are empty, and the next cell's creature begins at row 500.

## Scope and Technical Defaults

One actor, `stonehook_cliff_harrier_01`, activates on legitimate expedition access once Lolth first reaches x >= 2600, day or night. The defaults below are adjustable playtest data within this scope, not canon.

**Placement and health**
- Home x=2760.
- Patrol 2400-2860, limited by the visible body footprint.
- Health 3, and one capped Echo per credited defeat.

**Flight**
- Hover: the claws sit 30 px above the floor, with a bob of at most 6 px.
- Approach at 70/s.
- Retreat at 45/s while Lolth is within 100 units.
- The visible alpha body is 110 px tall, at native aspect.

**Attack**
- Windup 0.8 s, with the target and direction locked at windup start.
- A short, continuous 0.3 s dive toward the locked target x, at no more than 220/s horizontally and never past that x.
- Recovery 1.2 s.
- At most one existing one-point hurt per strike.

Grounded melee and First Thread reach the bird without a jump. Its world position is its displayed anchor, so the existing vertical check covers its altitude. Ability range, damage and cooldown are unchanged, and global reach is not enlarged.

The warning is a readable ground strip and label drawn above the foreground. The rules for the Harrier's movement and strikes are:

- no retargeting or teleporting;
- dash invulnerability and hurt cooldown are honored;
- no idle contact damage;
- no cave pursuit or Wagon attack;
- the body, strike and warning stay within their bounds;
- pending attacks cancel when Lolth leaves the foothills.

Prepare the exact crop bounds before gameplay, using a separate counter so the B-07 crawler-crop assertions keep their meaning. Never cycle other atlas cells.

## Independent Encounter State and Restoration

**Separate state.** Each actor has its own identity, live health, and activation, defeat and reward flags. Killing or clearing one never alters the other. Each pays at most one Echo under the unchanged 3/3 cap.

**What stays independent.** Cave waves and safe-capture scans neither erase nor count foothill actors. Ore collection and deposit stay independent of either kill. Concrete offscreen cave threats and terminal failure are preserved.

**Saving and failure.** Snapshots save both flag sets with Echoes and ore. Failure rolls back unsaved defeats and rewards consistently. A saved undefeated actor is recreated once, at initial health, on legitimate re-entry; a saved defeated actor stays defeated. All four saved combinations are tested: neither defeated, crawler only, Harrier only, both.

**F4 and new runs.** F4 deep-restores both live actors with their timers, positions and flags. A new run clears all added state.

## Non Goals and Allowed Files

Only `main.gd` may change in production. Tests, captures and records belong under `.atena/`.

The following are out of scope:

- Stone Maw, the shrine, Mark II and additional cures;
- wagon travel, pullers, missions/posts and parry;
- web/rope traversal and later regions;
- new art or audio, binary asset edits and dependencies;
- disk saves and broad architecture.

Controls, menus, progression locks, continuous terrain, accepted crawler behavior and historical validators/results are preserved.

## Acceptance Criteria

1. Only legitimate access at x >= 2600 creates exactly one Harrier. Border/day oscillation duplicates neither actor and resets neither actor's health.
2. The Harrier uses only its own crop, with wings and claws and native aspect, and hovers and bobs within limits. It is readable in day/night and both facings under camera offsets. Bounds are prepared before gameplay.
3. Grounded melee and First Thread hit inside the visible reach and miss outside it. The nearest eligible target is selected. Vertical reach follows the displayed position.
4. The windup warning precedes every dive with a locked target and direction. A dash avoids the dive. A strike hurts at most once, never across the region boundary and never at idle.
5. Both actors coexist in simultaneous combat with independent health, defeat and reward. Each pays at most one Echo under the cap, and neither affects the ore, cave waves or capture.
6. The four saved combinations, unsaved rollback, F4 exact restore (also through real input) and new-run reset are consistent.
7. B-07, B-06 and core regressions, the full self-test and the smoke runs keep their intent. Faulty controls are genuinely rejected.

## Gaps and Deferred Work

BLOCKING gaps: none.

The approval and scope come from the owner's message. One resolvable default was adjusted at preparation:

- **Arithmetic.** The visible body is 138 px wide at a height of 110 px. Body-based melee reach is therefore 44 + 69.1 = 113.1, and the maximum dive is 220 × 0.3 = 66, so a dive from the proposed 180 initiation distance can never connect (113.1 + 66 = 179.1).
- **Adjustment.** Attack initiation is set to 170, keeping a 9-unit margin. This is reported for review.
- **Other numbers** stay as proposed unless validation shows a need; any change will be reported.

DEFERRED: the remaining Stonehook threats, Stone Maw, the shrine and progression, animation art, balance tuning and the existing B-06/B-07 visual limitations.

## Plan of Flight and Approval

Approval mode is per-plan. After this record is activated, S-001 through S-003 run without intermediate approvals. Publication, push, PR, merge, dependencies and scope expansion remain separate gates. Human acceptance is required before completion.

- **S-001 / B-001:** bird geometry, movement and telegraphed combat.
- **S-002 / B-002:** independent two-actor rewards, camp coexistence and restoration.
- **S-003 / B-003:** validation, inspected captures and operational reconciliation.

## Validation and Evidence

Save fresh artifacts under `.atena/generated/2026-10-05-b08-validation/`:

- a headless B-08 suite and a real-input runtime fixture with controller isolation before the first frame;
- faulty controls for wrong artwork, unreachable flight, late bounds preparation, retargeting, repeated damage, boundary escape, shared defeat/reward state, duplicate rewards and incomplete restoration;
- the B-07, B-06 and core regressions, the self-test and both smoke runs;
- inspected day/night, facing, warning/strike/recovery and two-actor captures.

Linux executor results are kept separate from any reported Windows evidence.

## Implementation Checkpoint

On 2026-10-05, S-001 through S-003 were executed locally on `codex/b08-stonehook-cliff-harrier` from verified integrated main `4d3c5c1`. Results, tuning adjustments, inspected captures and limitations are in [[2026-10-05-b08-stonehook-cliff-harrier-implementation]]. The plan awaits human review: nothing is pushed, no PR or merge exists, human acceptance is pending and no B-09 work has started. The earlier "in implementation" wording describes the dated pre-implementation checkpoint and is superseded here.
