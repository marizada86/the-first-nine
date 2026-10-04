---
status: implemented-published-awaiting-pr
kind: runtime-stabilization-plan
created: 2026-10-04
plan_id: 2026-10-04-b04-thornwake-mark-one-stabilization
depends_on:
  - "[[2026-10-03-b00-opening-ending-and-production-resolution]]"
  - "[[2026-10-04-b03-first-boss-mark-and-cure]]"
approval_mode: per-plan
approval_selection: user-explicit-2026-10-04
approved: 2026-10-04
implementation_branch: b04-thornwake-mark-one-stabilization
implementation_base: 9683a8c
implementation_commit: 0a897fc
implementation_evidence: "[[2026-10-04-b04-thornwake-mark-one-stabilization-implementation]]"
published_commit: dfdf0be6b1e59b1158f172a10a12b8b84d90d076
survivability_fix_commit: b090847ec56bafb783c747755b00bce8243fa5ab
branch_publication_approved: true
remote_review_accepted: true
pull_request_approved: false
merge_approved: false
---

# B-04 plan — Mark I Thornwake stabilization

## Scope

Stabilize the post-first-cure Thornwake loop without expanding progression. Implement B-00's safe-wagon operational save after Mark I, restore that safe state after a post-Mark-I failure, and provide clear English objectives while Echoes remain capped in Thornwake.

## Approved defaults proposed for this plan

- The safe-wagon state is an in-memory prototype state, captured when the Mark-I player returns to the Wagon after the mandatory first cure.
- Narrative progression (Mark I and the chosen cure) remains persistent across a failure. The saved operational state covers the camp's recoverable runtime data, such as health, flame, provisions, wagon integrity, time, recovered load, wagon stock, repair state, and active Thornwake loop state.
- Before the first safe return, the existing cure checkpoint remains the fallback. After a safe return, failure restores the latest safe-wagon state.
- Post-cure messaging guides the player back to the Wagon to secure the camp. Once secure, the HUD states the current Echo count and explains that no deeper Mark can awaken in Thornwake.
- Antlered Hunger and `FIRST THREAD` tuning is limited to explicit playtest values and validation; it changes no canon, enemies, abilities, or progression boundaries.

## Non-goals

Do not enable wagon travel, Stonehook access, Mark II or later Marks, a second cure, ally posts or pullers, Web Anchors, new maps, new art, asset admission, H-02/H-03 runtime content, dependencies, a pull request, merge, or publication.

## Acceptance criteria

- After the first cure, the HUD clearly directs Lolth to return to the Wagon and secure the camp.
- Returning to the Wagon captures a safe operational state and gives clear English confirmation.
- A post-Mark-I failure restores the latest safe-wagon operational state while retaining Mark I and the chosen cure.
- The existing pre-Mark-I failure behavior still restores the B-01 cave start.
- Echoes remain unavailable before the cure, capped at 3/3 after it, and cannot produce Mark II.
- The post-cap objective clearly states that Thornwake cannot awaken a deeper Mark.
- Any boss or `FIRST THREAD` tuning is documented as playtest data and keeps melee, dodge, telegraphs, the Wagon lock, and all B-03 boundaries intact.
- Deterministic headless coverage includes capture, post-Mark-I failure/reload, pre-Mark-I regression, Echo cap, and locked travel. A normal 1280×720 run is error-free.

## Validation and evidence

Run the Godot self-test, targeted negative controls for the safe-wagon state, and normal visual/runtime checks. Record an English implementation note with changed files, exact test results, known gaps, and a non-authorizing next recommendation.

## Plan of flight

1. Map the current checkpoint and failure paths against the B-00 save rule.
2. Implement the bounded safe-wagon state and objective states.
3. Add deterministic positive and negative validation.
4. Run headless and normal Godot validation and capture evidence.
5. Request review before any push, pull request, or merge.

## Implementation status

- **Status:** implemented and published to its branch, awaiting a pull request. The user first accepted the implementation provisionally, pending the ADD record reconciliation. The plan remains active.
- **Branch:** the work is on the local branch `b04-thornwake-mark-one-stabilization`, created from `origin/main` at `9683a8c`.
- **Commit:** the original implementation commit was `0a897fc`. The record reconciliation was amended into it, producing the published commit `dfdf0be6b1e59b1158f172a10a12b8b84d90d076`.
- **Initial branch publication:** the project owner approved it, and `b04-thornwake-mark-one-stabilization` was pushed to `origin` at `dfdf0be6b1e59b1158f172a10a12b8b84d90d076`. `main` was not changed by that push.
- **Survivability fix:** a review of the published commit found that a terminal camp state (Flame or Provisions at zero) could be captured at the Wagon and restore into the same failure. The fix was approved and published to the same branch at `b090847ec56bafb783c747755b00bce8243fa5ab`.
- **Review:** the remote diff and the survivability fix have been reviewed and accepted.
- **Pull request and merge:** neither has been authorized or performed. B-04 remains the active plan, with status `implemented-published-awaiting-pr`.
- **Evidence:** `[[2026-10-04-b04-thornwake-mark-one-stabilization]]` and the implementation note `[[2026-10-04-b04-thornwake-mark-one-stabilization-implementation]]`, which records the exact changed files, tuning, test results, and known limitations.
