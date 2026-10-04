---
status: implemented-awaiting-review
kind: implementation-note
created: 2026-10-04
batch: B-01
instruction: "[[2026-10-03-b01-opening-cave-instruction]]"
source_canon: "[[2026-10-03-b00-opening-ending-and-production-resolution]]"
origin: direct-execution
implementation_preceded_spec: false
---

# B-01 - opening shell and cave camp

## Changed files

- `main.gd` - opening shell state, cave-camp state record, wagon condition and travel lock, Lolth form helper, skip input, and B-01 headless checks.
- `.atena/evidence/2026-10-04-b01-opening-cave-camp.md` - this note.

No asset, scene, project setting, canon, or plan file was changed. No H-01, H-02, or H-03 board was imported into `res://`.

## What was implemented

- `start_new_run()` prepares the cave-camp start and then shows the opening shell (`state == "opening"`).
- The shell walks six non-player-facing beat identifiers in `H01_SHELL_BEATS`, taken from the H-01 canon beats. Primary action advances; the new `skip` action (Escape / gamepad Start) skips. Both end in `finish_opening()`, which restores the cave-camp start.
- While the shell is active, no gameplay simulation runs and the world is not drawn. The shell displays only the game title, a beat counter, and control hints. It shows no comic art and no story text.
- `cave_camp_state()` exposes: location `thornwake_cave`, Lolth form, the controllable list (`LOLTH` only), the wagon record (open, no horse, no beds, no enclosed rooms, condition, travel state, repair, integrity), family relics (present and protected), fire, stock count, and eight ally records.
- `ally_records()` derives each Thalestriel's `plagued` or `cured` condition from `cured_allies`. Every record is `controllable: false`.
- `wagon_condition()` returns `cave_damaged` until wagon repair reaches `WAGON_REPAIR_MAX` (3), then `stationed`.
- `wagon_travel_locked()` always returns `true`. No runtime path can unlock travel yet.
- `lolth_form()` returns `elf` before Mark I and `drow` after. `draw_player()` now uses it.
- In Thornwake, the camp label reads `THE CAVE CAMP` and a status line shows the wagon condition and `TRAVEL LOCKED`. The cave-start message reads `THORNWAKE CAVE CAMP`.
- `run_opening_cave_self_test()` runs first inside `--self-test`. It prints `SELF_TEST_B01_PASS` or `SELF_TEST_B01_FAIL`, and its result is required for the overall `SELF_TEST_PASS`.

## Validation

- `gdparse` (gdtoolkit 4.5.0) parses `main.gd` without errors before and after the change.
- Godot is not available in the cloud session, so the headless self-test was not executed. Run it locally with:
  `D:\Godot\godot.exe --headless --path . -- --self-test`

## Deferred items

- Final H-01 panels and an approved English H-01 dialogue script.
- Cave-specific backdrop. Thornwake still uses the existing Ashen Way backdrop.
- Day-first tutorial pacing. The cave start still begins at nightfall, as before.
- Relic interactions. Relics exist only as a protected camp record.
- Travel unlock (Mark IV, four cures, repaired wagon, assigned puller) and puller assignment.
- The existing post-cure transition to Stonehook, which conflicts with B-00 canon. It was not changed in B-01.
- The existing `THE KISS OF SHAR` comic, which uses pre-H-02 lines and a concept-art storyboard. It was not changed in B-01.
