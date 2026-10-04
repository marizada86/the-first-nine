---
status: implemented-awaiting-review
kind: implementation-note
created: 2026-10-04
revised: 2026-10-04
batch: B-01
instruction: "[[2026-10-03-b01-opening-cave-instruction]]"
source_canon: "[[2026-10-03-b00-opening-ending-and-production-resolution]]"
origin: direct-execution
implementation_preceded_spec: false
---

# B-01 - opening shell and cave camp

## Changed files

- `main.gd` - opening shell state, cave-camp state record and HUD objective, wagon condition and travel lock, travel-lock enforcement inside `enter_stonehook()`, day-first cave start, Lolth form helper, skip input, and B-01 headless checks.
- `.atena/evidence/2026-10-04-b01-opening-cave-camp.md` - this note.

No asset, scene, project setting, canon, or plan file was changed. No H-01, H-02, or H-03 board was imported into `res://`.

## What was implemented

- `start_new_run()` prepares the cave-camp start and then shows the opening shell (`state == "opening"`).
- The shell walks six internal beat identifiers in `H01_SHELL_BEATS`, taken from the H-01 canon beats. They are never displayed. Primary action advances; the `skip` action (Escape / gamepad Start) skips. Both end in `finish_opening()`, which restores the cave-camp start.
- While the shell is active, no gameplay simulation runs and the world is not drawn. The shell displays only the game title and control hints. It shows no beat or panel count, no comic art, and no story text.
- The H-01 reference board has nine panels, but no approved panel order or English script exists. The six internal identifiers are not mapped to panels. That mapping is deferred to the approved script.
- The cave start begins at day (`clock_seconds = 0.0`) with no active enemies or waves. B-01 adds no night-defense gameplay. The pre-existing day/night loop is unchanged.
- `cave_camp_state()` exposes: location `thornwake_cave`, Lolth form, the controllable list (`LOLTH` only), the wagon record (open, no horse, no beds, no enclosed rooms, condition, travel state, repair, integrity), family relics (present and protected), fire, stock count, and eight ally records.
- `ally_records()` derives each Thalestriel's `plagued` or `cured` condition from `cured_allies`. Every record is `controllable: false`.
- `wagon_condition()` always returns `cave_damaged`. B-01 defines no repair threshold and no condition transition.
- `wagon_travel_locked()` always returns `true`.
- `enter_stonehook()` refuses while `wagon_travel_locked()` is true. `advance_to_stonehook()` only calls it. The single exception is `self_test_travel_bypass`, which only `run_self_test()` sets and clears around one call, so the prototype later-region checks still run. The Stonehook body itself is unchanged.
- After the first cure in Thornwake, the run stays in the cave camp (`state == "journey"`, zone 0) instead of opening the `thornwake_complete` travel screen.
- `try_advance_from_camp()` returns early in Thornwake once Mark I is owned. This stops a second Kiss of Shar sequence now that the run stays in Thornwake after the first cure.
- `lolth_form()` returns `elf` before Mark I and `drow` after. `draw_player()` uses it.
- In Thornwake, the camp label reads `THE CAVE CAMP`, and a status line shows `WAGON: CAVE DAMAGED · TRAVEL LOCKED`.
- The Thornwake HUD objective now reads "Gather supplies, return them to the Wagon, and protect the cave camp." It no longer promises Stonehook travel.
- `run_opening_cave_self_test()` runs first inside `--self-test`. It prints `SELF_TEST_B01_PASS` or `SELF_TEST_B01_FAIL`, and the overall `SELF_TEST_PASS` requires it.
- The existing self-test now reaches its first night through a real `update_clock()` nightfall transition. It also checks that the first cure keeps the run at the cave camp, that Stonehook travel is refused through both `advance_to_stonehook()` and a direct `enter_stonehook()` call, and that Mark I is not granted twice.

## Validation

- Godot 4.7.2 stable (official Linux x86_64 build from the SourceForge mirror of the Godot releases, SHA-512 matching the mirror's `SHA512-SUMS.txt`) ran in a scratch copy of the project, outside the repository.
- `godot --headless --import --path .` completed with exit code 0.
- `godot --headless --path . -- --self-test` exited with code 0 and printed:
  - `SELF_TEST_B01_PASS: opening shell reaches the day-start cave camp with eight plagued allies and a damaged, travel-locked wagon`
  - `SELF_TEST_PASS: Thornwake, Stonehook, and Hollowroot combat, cures, web crossing, checkpoints, and chapter transitions are ready`
- Negative controls:
  - With `wagon_travel_locked()` forced to `false`, the B-01 test failed (`SELF_TEST_B01_FAIL`, exit code 1).
  - With the lock check removed from `enter_stonehook()`, the B-01 test failed on its travel check (`travel=false`, exit code 1).
- The pre-B-01 `main.gd` (commit `9a3362b`) also passes its own self-test on 4.7.2.
- A normal 300-frame headless run exited with code 0 and no script errors.
- Xvfb screenshots of the opening shell (title and control hints only) and the cave start (new objective, `WAGON: CAVE DAMAGED · TRAVEL LOCKED`) were captured and reviewed at 1280 by 720 after the final amendment.
- The first B-01 commit (`e22afe1`) failed to parse in Godot 4.7.2 because of a type-inference error. That error is fixed in this revision.

## Deferred items

- Final H-01 panels, an approved English H-01 dialogue script, and the mapping of shell beats to the nine H-01 panels.
- Cave-specific backdrop. Thornwake still uses the dark Ashen Way backdrop, even by day.
- Day-first tutorial content and pacing.
- Wagon repair behavior, including the existing Wheel Kit increments and `WAGON REPAIR n/3` label, and any condition change away from `cave_damaged`.
- The existing night waves and the Mark progression after Mark I in Thornwake.
- Relic interactions. Relics exist only as a protected camp record.
- Travel unlock (Mark IV, four cures, repaired wagon, assigned puller), puller assignment, and Lolth's on-foot routes.
- The `thornwake_complete` state and screen are now unreachable but remain in code.
- The existing `THE KISS OF SHAR` comic uses pre-H-02 lines and a concept-art storyboard.
- `lolth-elf-core-sheet-v1.png` renders Lolth with grey skin and white hair, which reads as drow, so the elf state is not visually distinct.
