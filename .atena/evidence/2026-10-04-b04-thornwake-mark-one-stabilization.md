---
status: implemented-awaiting-human-review
kind: b04-implementation-evidence
recorded: 2026-10-04
plan: "[[2026-10-04-b04-thornwake-mark-one-stabilization]]"
implementation_note: "[[2026-10-04-b04-thornwake-mark-one-stabilization-implementation]]"
implementation_branch: b04-thornwake-mark-one-stabilization
implementation_base: 9683a8c
implementation_commit: 0a897fc
push_approved: false
pull_request_approved: false
merge_approved: false
---

# Evidence — B-04 implementation

## Basis

B-00 requires that a safe return to the Wagon after Mark I save operational progress and that a later failure restore the last safe wagon state. B-03 records this as an outstanding limitation and recommends a bounded Thornwake stabilization and persistence slice.

## Proposed boundary

The prepared scope is limited to the first-cure Thornwake state: an in-memory safe-wagon snapshot, failure restoration, clear post-cure and Echo-cap objectives, and bounded tuning validation. Travel, Stonehook, Mark II, further cures, posts, pullers, art, and later regions remain excluded.

## Approved plan

The user approved this B-04 plan per plan on 2026-10-04. The plan records no new canon and makes no progression expansion.

## Execution gate

The approved records and implementation instruction had to be published to `main` before external implementation began. That gate was met: `main` at `9683a8c` contains the B-04 records. Push, pull request, merge, and publication remain separate approval gates.

## Implementation

Claude implemented B-04 on the local branch `b04-thornwake-mark-one-stabilization`, created from `origin/main` at `9683a8c`. The original implementation commit is `0a897fc`. This evidence reconciliation was amended into that same local commit, so the final commit hash differs and is reported outside the commit.

The full implementation note, with exact changed files, behavior, the tuning table, and test results, is `[[2026-10-04-b04-thornwake-mark-one-stabilization-implementation]]`. In summary:

- **Return objective:** after the first cure, the objective reads `Return to the Wagon to secure the camp.`
- **Safe-wagon capture:** arriving in the existing Wagon interaction area captures an in-memory snapshot of operational data and confirms "CAMP SECURED".
  - It is captured only when no enemy is alive and no night defense is unfinished.
  - The latest safe return replaces the previous snapshot.
- **Secure objectives:** `The Wagon is secure. Gather Shadow Echoes in Thornwake: X/3.`, then at the cap `The Wagon is secure. No deeper Mark can awaken in Thornwake.`
- **Restore:** after a safe return, a post-Mark-I failure restores the latest snapshot and keeps Mark I, the chosen cure, and the boss-defeat flag. Before the first safe return, the cure checkpoint remains the fallback.
- **Preserved:** pre-Mark-I failures still restore the B-01 cave start. Echoes stay gated and capped at 3/3. Mark II is unreachable. The Wagon stays `stationed` and `travel_locked`.
- **Playtest tuning (data, not canon):** Antlered Hunger health 8 → 12 and boss recovery 1.0 s → 1.2 s. `FIRST THREAD` was reviewed and kept at 150 px, 2 damage, and a 1.2 s cooldown.

## Validation

All runs used Godot 4.7.2 stable in a scratch copy of the project.

- **Headless self-test:** `godot --headless --path . -- --self-test` exited with code 0 and printed `SELF_TEST_B01_PASS`, `SELF_TEST_B02_PASS`, `SELF_TEST_B03_PASS`, `SELF_TEST_B04_PASS`, and `SELF_TEST_PASS`.
- **B-04 negative controls:** each of 13 deliberate defects made the self-test fail:
  - missing capture;
  - stale restore;
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
- **B-03 regression controls:** five still fail as expected: short lunge wind-up, short Wagon-charge wind-up, a second cure, Mark I twice, and `FIRST THREAD` before Mark I.
- **Real-time input run:** 9 of 9 checks passed at 1280 by 720 under Xvfb, using real inputs across real frames.
  - The tuned boss fell in 7 melee presses.
  - Walking into the Wagon area secured the camp.
  - The Echo objective counted 1/3.
  - A post-Mark-I failure restored the safe Wagon with Mark I and AELIRA kept, Echoes reset to 0, and the unsaved stock dropped.
  - The cap objective appeared at 3/3.
  - Travel stayed locked.
- **Normal runs:** a 600-frame OpenGL run at 1280 by 720 and a 600-frame headless run both exited with code 0 with no script errors. The only messages came from the container's missing audio device and V-Sync control.
- **Screenshots** were captured for the return objective, the camp secured, the Echo objective, the failure card, the restore at the safe Wagon, and the Echo cap.

## Known limitations

- **No disk save:** the safe-wagon state is in memory only, as approved. Quitting loses it.
- **Restore position:** a restore places Lolth at the standard camp spawn point, not at her exact secured position.
- **Night snapshot:** a capture taken after a completed night defense restores that night with its waves already cleared.
- **After the cap:** once Echoes reach 3/3, Thornwake has no further goal. Night waves continue but grant nothing.
- **Defeat card:** its wording ("Press E to return to your checkpoint") and key art are unchanged.
- **Tuning:** boss and `FIRST THREAD` values still need a human playtest.
- **Art gaps (unchanged):** the existing art gaps from earlier batches remain.

## Approval state

The user provisionally accepted the implementation pending this ADD record reconciliation. Human review is still open, and the B-04 plan remains active. The user has not approved a push, pull request, merge, or publication, and none has been performed.
