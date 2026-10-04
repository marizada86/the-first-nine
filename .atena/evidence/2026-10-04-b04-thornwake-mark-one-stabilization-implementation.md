---
status: complete-implementation-merged
kind: implementation-note
created: 2026-10-04
batch: B-04
plan: "[[2026-10-04-b04-thornwake-mark-one-stabilization]]"
instruction: "[[2026-10-04-b04-thornwake-mark-one-stabilization-instruction]]"
source_canon:
  - "[[2026-10-03-b00-opening-ending-and-production-resolution]]"
  - "[[2026-10-04-first-boss-mark-and-cure]]"
implementation_branch: b04-thornwake-mark-one-stabilization
base_commit: 9683a8c
published_commit: dfdf0be6b1e59b1158f172a10a12b8b84d90d076
survivability_fix_commit: b090847ec56bafb783c747755b00bce8243fa5ab
branch_publication_approved: true
remote_review_accepted: true
documentation_commit: a8c2ac185516ae6b2a3b6198a0102c303cc358a5
pull_request: "https://github.com/marizada86/the-first-nine/pull/3"
merge_commit: 36039cb2ad2803b0ac0c9d30f2d8dd9db158ce57
preserved_commits: [dfdf0be, b090847, a8c2ac1]
feature_branch_preserved: true
---

# B-04 - Mark I Thornwake stabilization

## Changed files

- `main.gd` - safe-wagon capture and restore, post-cure objectives, B-04 playtest tuning, and B-04 headless checks.
- `.atena/evidence/2026-10-04-b04-thornwake-mark-one-stabilization-implementation.md` - this note.
- `.atena/evidence/2026-10-04-b04-thornwake-mark-one-stabilization.md`, `.atena/specs/2026-10-04-b04-thornwake-mark-one-stabilization.md`, and `.atena/state/plan.yaml` - the ADD record reconciliation. It was amended into the original implementation commit `0a897fc`, so the final commit hash differs.

No asset, scene, project setting, canon, or instruction file was changed. No reference board was admitted to `res://`. Nothing is written to disk at runtime.

## What was implemented

- **Return objective.** After the mandatory first cure, the HUD objective reads `Return to the Wagon to secure the camp.` The cure message reads "`<ALLY>` wakes as a drow. Return to the Wagon to secure the camp."
- **Safe-wagon capture.** When Lolth arrives in the existing Wagon interaction area (`player.x < 305`) after the first cure, `capture_safe_wagon_state()` stores an in-memory snapshot and confirms: "CAMP SECURED — If Lolth falls, she returns to this moment at the Wagon." The HUD checkpoint label becomes `SAFE WAGON`.
  - The capture happens on arrival, not every frame. A later arrival replaces it, so the latest safe return always wins.
  - A return counts as safe only when no enemy is alive and no night defense is unfinished. This avoids saving a state that would fail again immediately.
- **Snapshot contents.** Operational data only: health, flame, provisions, wagon integrity, clock, recovered load, Wagon stock, repair and crafted state, brazier, Shadow Echoes, first-night flag, tutorial phase, night-wave progress, and which pickups were taken.
- **Secure objectives.**
  - Before the cap: `The Wagon is secure. Gather Shadow Echoes in Thornwake: X/3.`
  - At the cap: `The Wagon is secure. No deeper Mark can awaken in Thornwake.`
- **Post-Mark-I restore.** After a safe return, any failure (Lolth's death, wagon destruction, the Caravan Flame, or the plagued-ally failure) restores the latest snapshot through the existing defeat card. The confirmation reads: "Restored at the safe Wagon. Mark I and `<ALLY>`'s cure remain."
  - Mark I, the chosen cure, `awakened`, and the boss-defeat flag are narrative progression. A restore never overwrites them.
- **Cure fallback.** Before the first safe return, the existing cure checkpoint is still used. Each new cure and each new run clear the safe-wagon state.
- **Preserved behavior.**
  - A pre-Mark-I failure still restores the B-01 cave start.
  - Echoes stay unavailable before the cure and capped at 3/3 after it. Mark II is unreachable.
  - The Wagon stays `stationed` and `travel_locked`.
  - All B-01 to B-03 boundaries are unchanged.

## Playtest tuning (data, not canon)

| Value | B-03 | B-04 | Reason |
| --- | --- | --- | --- |
| `ANTLERED_HUNGER_HEALTH` | 8 | 12 | The B-03 fight ended in about five melee presses. It now takes about three full combos: 7 real-input presses with combos, or 12 single hits. |
| `BOSS_RECOVER` | 1.0 s | 1.2 s | A clearer punish window after each dodged lunge or charge, to offset the extra health. |
| `FIRST_THREAD_RANGE` / `DAMAGE` / `COOLDOWN` | 150 px / 2 / 1.2 s | unchanged | Reviewed and kept, so the shadow strike stays a supplement that does not outclass melee. |

Wind-up times, telegraphs, base melee, and dodge are unchanged.

## Validation

All runs used Godot 4.7.2 stable (official Linux x86_64 build, SHA-512 verified) in a scratch copy of the project.

- **Headless self-test.** `godot --headless --path . -- --self-test` exited with code 0 and printed:
  - `SELF_TEST_B01_PASS`
  - `SELF_TEST_B02_PASS`
  - `SELF_TEST_B03_PASS (... 12 melee hits)`
  - `SELF_TEST_B04_PASS: safe-wagon capture, post-Mark-I restore, preserved Mark I and cure, Echo gate and cap, and travel lock are ready`
  - `SELF_TEST_PASS`
- **B-04 test coverage.** `run_mark_one_stabilization_self_test()` checks:
  - the pre-Mark-I reset;
  - no Echoes before the cure;
  - the first cure and the return objective;
  - no capture away from the Wagon;
  - the cure-checkpoint fallback before a safe return;
  - no capture while an enemy is alive;
  - capture, its confirmation, and the X/3 objective;
  - the restore after a post-Mark-I failure, which must differ from the cure checkpoint;
  - preserved Mark I, cure, drow form, and boss flag;
  - the stationed, locked Wagon;
  - a later return replacing the snapshot, and the restore using it;
  - the 3/3 cap and the cap objective;
  - blocked Stonehook travel;
  - a new run clearing the safe state.
- **Negative controls.** Each of these 13 deliberate defects made the self-test fail (exit code 1):
  - missing capture;
  - stale restore (only the first capture kept);
  - restore ignored in favor of the cure checkpoint;
  - cure lost on restore;
  - Mark I lost on restore;
  - early Echoes;
  - cap overflow;
  - an unlocked Wagon after a safe return;
  - unsafe capture with enemies alive;
  - capture away from the Wagon;
  - the safe state surviving a new run;
  - the pre-Mark-I reset bypassed;
  - a missing return objective.
- **B-03 regression.** Five B-03 regression controls also still fail as expected: short lunge wind-up, short Wagon-charge wind-up, a second cure, Mark I twice, and `FIRST THREAD` before Mark I.
- **Real-time input run.** A run at 1280 by 720 under Xvfb, using real input actions across real frames, passed all 9 checks:
  - the tuned boss falls to melee input (7 presses);
  - the cure shows the return objective;
  - walking left into the Wagon area secures the camp (77 frames);
  - a kill grants one Echo, and the objective shows 1/3;
  - a post-Mark-I failure reaches the defeat card;
  - the restore keeps Mark I and AELIRA, returns Echoes to 0, and drops the unsaved stock;
  - Echoes stop at 3/3 with the cap objective;
  - travel stays locked.
- **Normal runs.** A normal 600-frame OpenGL run at 1280 by 720 exited with code 0 with no script errors. The only messages came from the container's missing audio device and V-Sync control. A 600-frame headless run exited with code 0 with no errors or warnings.
- **Screenshots** were captured and reviewed for the return objective, the camp secured, the Echo objective, the failure card, the restore at the safe Wagon, and the Echo cap.

## Fix: no capture of a terminal camp state

A review found an edge case in the published B-04 commit `dfdf0be`. `update_safe_wagon()` runs before `check_survival_failures()` in the same frame. A player who reached the Wagon with Flame or Provisions at zero could capture a safe-wagon state that failed at once. Every restore then landed in the same failure.

**Fix.** `is_at_safe_wagon()` now also requires a survivable camp: Flame, Provisions, Lolth's health, and Wagon integrity must all be above zero. Flame and Provisions were the required minimum. Health and integrity were added because they are the other two terminal-failure values.

**Effect.**

- A terminal arrival at the Wagon captures nothing, so the previous valid snapshot stays in place.
- The failure that follows restores that snapshot.
- All other B-04 behavior, tuning, objectives, locks, and narrative persistence are unchanged.

**Coverage.** The B-04 self-test now checks Flame and Provisions in turn. For each one, starting from a valid secured camp, it:

1. sets the value to zero;
2. walks Lolth into the Wagon area;
3. confirms the stored snapshot is unchanged;
4. triggers the survival failure;
5. confirms the restore returns the earlier valid state: Flame and Provisions above zero, the earlier stock and Echoes, and Mark I and the cure kept;
6. confirms the restored camp does not fail again.

**Validation of the fix** (Godot 4.7.2):

- The self-test exited with code 0 and printed `SELF_TEST_B01_PASS`, `SELF_TEST_B02_PASS`, `SELF_TEST_B03_PASS`, `SELF_TEST_B04_PASS`, and `SELF_TEST_PASS`.
- Three new negative controls failed as expected (exit code 1, `terminal=false`): the whole guard removed, only the Flame check removed, and only the Provisions check removed.
- All 13 original B-04 negative controls still fail as expected.
- The real-input runtime check still passes 9 of 9.
- A normal 600-frame OpenGL run at 1280 by 720 and a 600-frame headless run both exited with code 0 with no script errors.

## Known limitations

- **No disk save.** The safe-wagon state is in memory only, as approved. Quitting the game loses it.
- **Restore position.** A restore places Lolth at the standard camp spawn point, not at her exact position when the camp was secured.
- **Night snapshot.** A capture taken during a completed night defense restores that night with its waves already cleared.
- **After the cap.** Once Echoes reach 3/3, Thornwake has no further goal. Night waves continue but grant nothing.
- **Defeat card.** The defeat card still says "Press E to return to your checkpoint" and uses the existing key art.
- **Tuning.** The values are untuned beyond this pass. A human playtest should confirm the boss length and punish window.
- **Records.** The B-04 spec, evidence, and plan state record B-04 as complete and merged. The plan is closed.

## Publication state

- **Initial branch publication:** the project owner approved it, and `b04-thornwake-mark-one-stabilization` was pushed to `origin` at `dfdf0be6b1e59b1158f172a10a12b8b84d90d076`. `main` was not changed by that push.
- **Survivability fix:** a review of the published commit found that a terminal camp state (Flame or Provisions at zero) could be captured at the Wagon and restore into the same failure. The fix was approved and published to the same branch at `b090847ec56bafb783c747755b00bce8243fa5ab`.
- **Review:** the remote diff and the survivability fix have been reviewed and accepted.
- **Documentation follow-up:** the publication record was approved and pushed to the same branch as `a8c2ac1`.
- **Pull request:** the owner approved pull request [#3](https://github.com/marizada86/the-first-nine/pull/3), opened from the branch into `main`.
- **Merged:** the owner approved the merge. Pull request #3 was merged into `main` with a regular merge commit, `36039cb2ad2803b0ac0c9d30f2d8dd9db158ce57`, which preserves the three B-04 commits `dfdf0be`, `b090847`, and `a8c2ac1`.
- **Complete:** B-04 is complete, with status `complete-implementation-merged`. The plan is closed.
- **Feature branch:** `b04-thornwake-mark-one-stabilization` remains preserved on `origin`.
- **Next steps:** any further recommendation remains non-authorizing and requires its own approved plan.

## Next recommendation (non-authorizing)

This recommendation authorizes no work. Any next batch needs its own approved plan.

Consider a short human playtest of B-01 to B-04 at 1280 by 720 before planning further progression. Use it to confirm the boss length, the telegraph readability, the safe-wagon flow, and the post-cap Thornwake loop. Keep travel, Stonehook, Mark II, further cures, posts, pullers, new art, and later regions out of scope until a plan explicitly approves them.
