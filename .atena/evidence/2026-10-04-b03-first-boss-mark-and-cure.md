---
status: implemented-awaiting-human-review
kind: b03-implementation-evidence
recorded: 2026-10-04
plan: "[[2026-10-04-b03-first-boss-mark-and-cure]]"
implementation_note: "[[2026-10-04-b03-first-boss-implementation]]"
implementation_branch: b03-first-boss-mark-and-cure
implementation_base: 15e39eb
implementation_commit: ac091fa
push_pr_merge_approved: false
---

# Evidence - B-03 implementation

## Preparation

The user approved B-03 per plan on 2026-10-04. Its gameplay decisions are recorded in `[[2026-10-04-first-boss-mark-and-cure]]`; its Claude work order is `[[2026-10-04-b03-first-boss-mark-and-cure-instruction]]`.

The external gate recorded during preparation was met before implementation: the reconciled B-02 records and the B-03 package were pushed to `main` as `15e39eb`.

## Implementation

Claude implemented B-03 on the local branch `b03-first-boss-mark-and-cure`, created from `origin/main` at `15e39eb`. The original implementation commit is `ac091fa`. This evidence reconciliation was amended into that same local commit, so the final commit hash differs and is reported outside the commit.

The full implementation note, with exact changed files and behavior, is `[[2026-10-04-b03-first-boss-implementation]]`. In summary:

- **Boss start:** from the B-02 safe camp, one English camp action ("FACE THE ANTLERED HUNGER", F / left shoulder at the Wagon) starts the encounter. Nothing starts it automatically.
- **Antlered Hunger:** the only B-03 combatant. It telegraphs a lunge at Lolth and a charge at the Wagon on every third attack. Pre-Mark-I failures restore the B-01 cave start.
- **Shar shell:** boss defeat enters a neutral, skippable Shar shell that shows only English controls. The legacy comic text and storyboard are no longer loaded or rendered.
- **Mark I:** applies once. Lolth becomes drow and gains `FIRST THREAD`, a short-range shadow strike. Melee and dodge are unchanged.
- **One cure:** all eight Thalestriel are offered by name, and exactly one can be cured. The chosen ally becomes a non-controllable drow; seven remain plagued. No ally post is assigned in Thornwake.
- **Wagon:** stays `stationed` and `travel_locked`. Stonehook stays blocked.
- **Echoes:** begin only after the cure and stop at the Mark II threshold (3).

## Validation

All runs used Godot 4.7.2 stable in a scratch copy of the project.

- **Headless self-test:** `godot --headless --path . -- --self-test` exited with code 0 and printed `SELF_TEST_B01_PASS`, `SELF_TEST_B02_PASS`, `SELF_TEST_B03_PASS`, and `SELF_TEST_PASS`.
- **Negative controls:** each of 13 deliberate B-03 defects made the self-test fail:
  - the boss starts automatically;
  - a short lunge wind-up;
  - a short Wagon-charge wind-up;
  - no Echo cap;
  - Echoes before the cure;
  - a second cure allowed;
  - Mark I applied twice;
  - the shell skipping Mark I;
  - travel unlocking after the cure;
  - the cure auto-posting an ally;
  - the boss-defeat flag surviving a reset;
  - `FIRST THREAD` dealing no damage;
  - `FIRST THREAD` working before Mark I.
- **Real-time input run:** 14 of 14 checks passed at 1280 by 720 under Xvfb, using real input actions across real frames. They cover the boss start, both telegraphs, victory, the Shar shell, Mark I, the one-cure lock, the travel lock, and `FIRST THREAD`, melee, and dodge input after Mark I.
- **Normal runs:** a 600-frame OpenGL run at 1280 by 720 and a 600-frame headless run both exited with code 0 with no script errors. The only messages came from the container's missing audio device and V-Sync control.
- **Screenshots** were captured for the safe-camp action, boss start, lunge telegraph, Wagon-charge telegraph, Shar shell, cure choice, Mark I with the cure and travel lock, and `FIRST THREAD`.

## Known limitations

- **Boss tuning:** boss and `FIRST THREAD` values are untuned playtest data. With full melee combos, the boss falls in about five presses.
- **Saving after Mark I:** B-00's "safe return to the wagon saves progress after Mark I" is not implemented. After Mark I, only the cure creates a checkpoint.
- **After the cure:** the normal Thornwake day/night cycle resumes, with Briar Hound and Stag of Mire nights as the only Echo source. Echoes stop at 3/3, and the HUD objective falls back to the cave-camp text.
- **Final presentation:** final H-02 panels and an approved English H-02 script are still required. The six internal shell beats are not mapped to H-02 panels.
- **Art gaps (unchanged):** the pre-Mark elf sprite reads as drow, there is no cave backdrop, enemies draw behind the camp, and the foreground overlay partly covers the boss label.
- **Unused file:** the legacy storyboard file remains in `assets/concept-art/comic/` but is unreferenced.

## Approval state

The user provisionally accepted the implementation pending this ADD record reconciliation. Human review is still open. The user has not approved a push, pull request, merge, or publication, and none has been performed.
