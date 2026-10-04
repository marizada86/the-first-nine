---
status: complete-implementation-merged
kind: bounded-runtime-fix-plan
created: 2026-10-04
plan_id: 2026-10-04-b05-thornwake-combat-readability
approval_mode: per-plan
approval_selection: user-explicit-2026-10-04
approved: 2026-10-04
request_classification: NEW_PLAN
depends_on:
  - "[[2026-10-04-b04-thornwake-mark-one-stabilization]]"
  - "[[2026-10-04-playtester-debug-controls]]"
evidence: "[[2026-10-04-b05-thornwake-combat-readability]]"
implementation_instruction: "[[2026-10-04-b05-thornwake-combat-readability-instruction]]"
implementation_evidence: "[[2026-10-04-b05-thornwake-combat-readability-implementation]]"
implementation_branch: codex/b05-controls-wagon-inventory
original_implementation_branch: b05-thornwake-combat-readability
implementation_base: 9ea4fc1bbfabd5be50a2d7f334b9b11325b8a77b
implementation_push_approved: true
original_published_commit: 4400b59aab49ed2860c5c6369ba79b386a7d2e9a
published_commit: e5832da604226b33f424d18248b24f0825c568aa
followup_push_approved: true
revision_evidence: "[[2026-10-04-b05-local-controls-inventory-wagon-implementation]]"
pull_request_approved: true
merge_approved: true
pull_request: https://github.com/marizada86/the-first-nine/pull/4
merge_commit: bc7796e0fad33f5d7b773af3eaefc07749ec81b4
merged_feature_head: e5832da604226b33f424d18248b24f0825c568aa
closure_evidence: "[[2026-10-04-b05-documentation-closure]]"
---

## Current closure: B-05 integrated and completed

PR [#4](https://github.com/marizada86/the-first-nine/pull/4) was merged with a regular merge at `bc7796e0fad33f5d7b773af3eaefc07749ec81b4`, from `codex/b05-controls-wagon-inventory` at `e5832da604226b33f424d18248b24f0825c568aa` into `main`. All six PR commits and both feature branches are preserved. The original implementation branch `b05-thornwake-combat-readability` at `4400b59` is historical, not the current integrated delivery.

The owner separately authorized branch publication, PR opening, regular merge, and this documentation closure/publication on main. Initial local-only restrictions describe their original checkpoints; they do not negate those later approvals. Opus's delivered final review reported no blockers on `e5832da`; its reproduced Linux results are reviewer evidence, not fresh Atena results or CI checks.

B-05 is the last completed plan; the active-plan slot is cleared. This closure changes records only. No runtime, art, saved test outputs, canonical gameplay rules or dependencies change; no B-06 or branch deletion is authorized. Parry, balance tuning, higher-Mark progression and disk saves remain deferred. See [[2026-10-04-b05-documentation-closure]] and [[2026-10-04-b05-pull-request]] for verification and approval provenance.

## Historical preparation, implementation and review

The following sections preserve the original checkpoints and their evidence. Any pending-review, local-only, main-unchanged or no-PR/no-merge statement below refers to that stage, not today's closed state. Original implementation values superseded by later controls/geometry corrections remain historical.

# B-05 plan — Thornwake melee damage and animation readability

## Source and intent

During a human playtest on 2026-10-04, the user confirmed the F4 playtester controls work and reported that the primary attack appears not to damage enemies while Lolth also appears to play a hurt animation. Prepare this as the next bounded Opus 5.5 implementation batch. The report is user evidence, not a claim that the exact root cause is proven.

## Scope

1. Reproduce the player-visible melee problem in Thornwake using normal movement and primary input, including a night enemy reached through the F4 playtester controls.
2. Make a valid melee hit visibly and reliably lower the intended enemy's health, while preserving the approved three-strike combo and enemy defeat/Echo rules.
3. Make attack, dodge and hurt visuals represent their respective actions. A dodge or attack must not show the hurt pose/effect unless Lolth actually takes damage.
4. Check simultaneous enemy contact: if a real enemy strike lands during a player attack, both game-state outcomes must be correct and visually readable. Do not hide legitimate damage simply to make the animation look better.
5. Keep F4, day/night controls, and reversible playtester sessions working for repeatable human testing.

## Grounded observations to investigate

- `handle_primary()` in `main.gd` subtracts health only when the distance between player and enemy positions is under `INTERACT_RADIUS` (currently 56 px). The player sprite is drawn at 200 px high. This could produce a visual reach mismatch, but it has not yet been proven to be the sole cause of the reported failure.
- `perform_dodge()` sets `hurt_cooldown` for dodge invulnerability. `draw_player()` uses that same value to select the hurt pose and draw a pink hurt effect. The dodge visual checks for `mark_vfx_kind == "dash"`, while `perform_dodge()` emits `"dodge"`. This is a concrete state-to-pose mismatch.
- In the normal update, primary input is handled before enemy movement and contact checks. The player could also genuinely take a hit during an attack. Record health before/after to distinguish this from false hurt visuals.
- Existing B-03 self-tests prove direct close-range `handle_primary()` can lower enemy health. They do not establish that the real-input reach and visual feedback match player expectations.

## Non-goals

- No new attack ability, enemy type, art asset, companion control, travel unlock, region, Mark progression, or cure.
- No broader combat rebalance beyond a measured melee reach/feedback correction needed for this defect.
- No new dependencies, canon edits, asset admission, disk-save system, remote publication, PR, or merge in this batch.

## Acceptance criteria

1. At 1280×720, a real primary key or mouse press during Thornwake combat produces a visible hit and measurable enemy-health decrease when the enemy is within the intended melee reach. A miss beyond that reach does not damage the enemy and is visually distinguishable.
2. A successful series of melee hits can defeat a Briar Hound and progress the night wave; the B-03 boss and Mark-I first-cure path retain their existing behavior.
3. Attack pose/effect appears for an attack; dodge pose/effect appears for a dodge; hurt pose/effect appears only after actual Lolth health loss. Genuine overlapping attacks and enemy damage remain possible and understandable.
4. Opening and closing F4 playtester, forced night/day, restoration, safe-wagon checkpoints and B-01 through B-04 regressions still pass.
5. Godot 4.7.2 headless self-test passes; a normal-rendering 1280×720 real-input check records enemy and Lolth health before/after, animation states, and an inspected visual capture.

## Impacts and gaps

- Runtime: primary-hit selection/reach and player pose/effect separation in `main.gd`.
- Test evidence: targeted combat assertions, real-input check, and a normal-rendering capture. Document any tuning as playtest values.
- Operational records: B-05 spec, implementation note, evidence, and plan state only after the approved work occurs.
- RESOLVED: the locally tested F4 playtester source (`4ef349b`) and approval record (`a31c12c`) were pushed to remote `main` on 2026-10-04. Opus must still fetch and verify the latest `origin/main` before editing.
- RESOLVED: the owner selected per-plan approval and approved this bounded B-05 scope on 2026-10-04.
- RESOLVABLE during execution: choose the smallest melee range/pose implementation after measuring the real failure.
- DEFERRED: unrelated animation polish, other regions, and all previously deferred gameplay progression.

## Plan of flight

1. Publish or otherwise deliver the exact reviewed F4 playtester source to the Opus working environment after explicit authorization. Verify commit and clean source state; do not overwrite local work.
2. Opus reads this spec, relevant canon/records, and the B-05 instruction. Reproduce the reported failure before changing combat.
3. Implement only the melee and animation correction, with targeted positive/negative tests.
4. Validate headless and normal real-input play at 1280×720, then prepare English implementation evidence with exact results and known limitations.
5. Return for human review. Push, PR and merge require separate explicit authorization.

## Approval checkpoint

The owner selected `per-plan` for the single stable batch, `B-05`, on 2026-10-04. The separately authorized push of local commit `4ef349b` and the approval record `a31c12c` succeeded on remote `main`. The implementation is ready for Opus after it fetches and verifies the current source. This approval does not authorize a later implementation push, pull request or merge.

## Original implementation checkpoint

- **Status:** implemented locally on `b05-thornwake-combat-readability`, from `origin/main` at `9ea4fc1`, and awaiting human review.
- **Root causes found:**
  - The 56 px hit test was narrower than the visible body contact (about 82 px for a Briar Hound).
  - A miss gave no feedback.
  - The hound's legitimate lunge damage followed the missed attack.
  - A dodge was drawn as hurt, because the `dodge` VFX kind did not match the `dash` draw check and `hurt_cooldown` drove the hurt visuals.
- **Fix:** measured melee reach at visible contact; a distinct miss swing; an enemy hit flash; and separate attack, dodge, and hurt states. Hurt visuals appear only after real health loss.
- **Validation:** the Godot 4.7.2 headless self-test passes (B-01 to B-05 and playtester); 11 B-05 negative controls fail as expected; the real-input runner passes 9 of 9; normal and headless runs are error-free.
- **Details:** exact health values, captures, and limitations are in `[[2026-10-04-b05-thornwake-combat-readability-implementation]]`.
- **Historical approval state at implementation:** publication had not yet been approved. The later publication is recorded below.

## Original revision and publication checkpoint

The original approved implementation was subsequently published with owner authorization on `b05-thornwake-combat-readability` at `4400b59aab49ed2860c5c6369ba79b386a7d2e9a`. It has not been merged. The preparation and execution instructions above describe the original batch and its historical gate.

Independent review found an uncleared hurt/action state on generic checkpoint restore and a frame-count-dependent real-input runner. Details and validation are in [[2026-10-04-b05-controls-and-wagon-menu-review]]. These corrections were accepted by the owner's "tudo validado, vamos continuar" on 2026-10-04, then published with explicit authorization to `codex/b05-controls-wagon-inventory`. B-05 awaits technical review; PR and merge remain unapproved.

The owner's new input/management definition is canonical in [[2026-10-04-separated-controls-and-wagon-management]]. The bounded extension is in [[2026-10-04-b05-controls-and-wagon-menu-revision]]. The owner approved local implementation before returning to Claude, then explicitly deferred parry to a higher Mark and requested clean dash and larger enemies. Results and the authorized publication are in [[2026-10-04-b05-local-controls-inventory-wagon-implementation]]. Do not use the original shared-primary instruction to implement the new controls. No PR or merge is authorized.
