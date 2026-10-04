---
status: implemented-awaiting-review
kind: implementation-note
created: 2026-10-04
batch: B-03
plan: "[[2026-10-04-b03-first-boss-mark-and-cure]]"
instruction: "[[2026-10-04-b03-first-boss-mark-and-cure-instruction]]"
source_canon:
  - "[[2026-10-04-first-boss-mark-and-cure]]"
  - "[[2026-10-04-thornwake-day-night-tutorial]]"
  - "[[2026-10-03-b00-opening-ending-and-production-resolution]]"
implementation_branch: b03-first-boss-mark-and-cure
base_commit: 15e39eb
---

# B-03 - first boss, Mark I and first cure

## Changed files

- `main.gd` - Antlered Hunger camp action and encounter, boss telegraphs, neutral Shar shell, Mark I, `FIRST THREAD`, the one-cure lock, the Echo gate and cap, no Thornwake ally posts, and B-03 headless checks.
- `.atena/evidence/2026-10-04-b03-first-boss-implementation.md` - this note.

No asset, scene, project setting, canon, spec, plan, or instruction file was changed. No reference board was admitted to `res://`.

## What was implemented

- **Camp action.** From the B-02 safe camp, a panel reads "CAMP ACTION: FACE THE ANTLERED HUNGER - At the Wagon, press F / left shoulder to begin." The new `camp_action` input (F, gamepad left shoulder) starts the encounter only in the safe camp, before Mark I, and only at the Wagon. Nothing starts it automatically.
- **Antlered Hunger.** It is the only combatant (8 health). The encounter runs at night and keeps the B-02 telegraph standard:
  - **Lunge at Lolth:** a 0.8 s wind-up with a "!" and a ring, then the lunge, then a 1.0 s recovery window.
  - **Charge at the Wagon (every third attack):** a 1.2 s wind-up with "CHARGE!", a line to the Wagon, a ring, and the message "ANTLERED HUNGER lowers its antlers at the Wagon!"
  - The boss is drawn larger, with a readable name label.
- **Failure and retry.** Before Mark I, Lolth's death, wagon destruction, or the plagued-ally failure restore the B-01 cave start through the existing defeat card. The boss can then be faced again after the tutorial.
- **Victory.** Defeating the boss enters the Shar shell exactly once, guarded by `antlered_hunger_defeated`. A new run resets the flag.
- **Shar shell.** A dark screen shows only "E / click: continue · Esc / Start: skip". Six internal identifiers (`h02_beat_01` to `h02_beat_06`) are never displayed. Advancing through all beats or skipping both apply Mark I.
- **Legacy comic removed.** The legacy `COMIC_LINES`, `COMIC_PANEL_SOURCES`, storyboard preload, and `draw_comic()` were removed, so the old comic text and concept storyboard are no longer loaded or rendered. The storyboard file itself was not deleted.
- **Mark I.** `apply_mark_one()` applies once. Lolth switches to the drow sheet, her health refreshes, and the cure choice opens.
- **`FIRST THREAD`.** The new `shadow_strike` input (C, gamepad right face button) hits the nearest enemy within 150 px for 2 damage, with a 1.2 s cooldown. Melee (E) and dodge (Shift) are unchanged. Before Mark I it does nothing.
- **Cure choice.** "CHOOSE ONE THALESTRIEL TO CURE" lists all eight Thalestriel by name. `cure_selected_ally()` only works during the cure choice, so exactly one ally can be cured.
  - The chosen ally becomes a non-controllable drow. `ally_records()` now reports each ally's form.
  - The other seven remain plagued elves.
  - In Thornwake, a cure no longer auto-assigns an ally post, and post commands report that posts are unavailable at the cave camp.
- **Wagon.** It stays `stationed` and `travel_locked`. `advance_to_stonehook()` and `enter_stonehook()` remain blocked.
- **Echoes.** In Thornwake, Shadow Echoes start only after the first cure and stop at the Mark II threshold (3). Kills before the cure grant none. Mark II, a second cure, and later effects are unreachable.
- **Reset fixes.**
  - `reset_to_prologue()` now also clears dodge timers, so a fresh cave start carries no dodge cooldown.
  - Combat contact and enemy defeat were extracted into `check_enemy_contact()` and `defeat_enemy()`, so melee and `FIRST THREAD` share one defeat path.

## Validation

All runs used Godot 4.7.2 stable (official Linux x86_64 build, SHA-512 verified against the mirror's list) in a scratch copy of the project.

- **Headless self-test** (`godot --headless --path . -- --self-test`) exited with code 0:
  - `SELF_TEST_B01_PASS`
  - `SELF_TEST_B02_PASS`
  - `SELF_TEST_B03_PASS: camp action starts a telegraphed Antlered Hunger; victory reaches the Shar shell, Mark I, and exactly one cure with capped Echoes and a locked wagon (8 melee hits)`
  - `SELF_TEST_PASS`
- **Negative controls.** Each of these 13 deliberate defects made the self-test fail (exit code 1):
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
- **Real-time input run.** A run at 1280 by 720 under Xvfb drove the slice with real input actions across real frames. All 14 runtime checks passed, covering:
  - skipping the opening with the skip input;
  - the safe camp waiting for the player;
  - the camp action input starting the boss;
  - the lunge and Wagon-charge telegraphs;
  - melee defeating the boss into the Shar shell (5 presses);
  - shell advance and skip applying Mark I;
  - exactly one cure (NIMARA);
  - travel staying locked;
  - the `FIRST THREAD` input striking at range;
  - melee and dodge inputs still working after Mark I;
  - no second cure.
- **Normal runs.** A normal 600-frame OpenGL run at 1280 by 720 exited with code 0 with no script errors. The only errors and warnings came from the container's missing audio device and V-Sync control. A 600-frame headless run exited with code 0 with no errors or warnings.
- **Screenshots** were captured and reviewed for:
  - the safe-camp action;
  - the boss start;
  - the lunge telegraph;
  - the Wagon-charge telegraph;
  - the Shar shell;
  - the cure choice;
  - Mark I with the cure and travel lock;
  - `FIRST THREAD`.

## Known gaps

- **Final presentation.** Final H-02 panels and an approved English H-02 script are still needed. The six shell identifiers are not mapped to H-02 panels.
- **Boss tuning.** All boss and `FIRST THREAD` values are untuned playtest data. With full melee combos, the boss falls to about five presses.
- **Saving after Mark I.** B-00's "safe return to the wagon saves progress" is not implemented. After Mark I, the checkpoint is created only by the cure.
- **After the cure.** The normal day/night cycle resumes in Thornwake, with Briar Hound and Stag of Mire nights as the Echo source. Echoes stop at 3/3, and nothing else unlocks.
- **HUD objective.** After the cure, the objective falls back to the cave-camp text.
- **Art gaps (unchanged).** The pre-Mark elf sprite reads as drow, there is no cave backdrop, enemy sprites draw behind the camp, and the boss label is partly covered by the foreground overlay.
- **Unused file.** The legacy storyboard file remains in `assets/concept-art/comic/` but is no longer referenced.
