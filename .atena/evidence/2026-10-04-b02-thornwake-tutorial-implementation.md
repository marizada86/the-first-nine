---
status: implemented-awaiting-review
kind: implementation-note
created: 2026-10-04
batch: B-02
plan: "[[2026-10-04-b02-thornwake-day-night-tutorial]]"
instruction: "[[2026-10-04-b02-thornwake-day-night-tutorial-instruction]]"
source_canon:
  - "[[2026-10-04-thornwake-day-night-tutorial]]"
  - "[[2026-10-03-b00-opening-ending-and-production-resolution]]"
implementation_branch: claude/wonderful-planck-suynnk
---

# B-02 - Thornwake day/night tutorial

## Changed files

- `main.gd` - tutorial phases, Wheel Kit repair, nightfall transition, telegraphed Briar Hound and Stag of Mire attacks, safe-camp return, tutorial HUD, and B-02 headless checks.
- `.atena/evidence/2026-10-04-b02-thornwake-tutorial-implementation.md` - this note.

No asset, scene, project setting, canon, spec, or plan file was changed. No reference board was imported into `res://`. The B-02 records were read from `origin/main` (`c3832d4`); `main` was not merged into the implementation branch.

## What was implemented

- **Tutorial phases.** `tutorial_phase` moves through `day_salvage`, `dusk`, `night_defense`, and `safe_camp`. Before Mark I in Thornwake, `advance_world_clock()` follows these phases instead of the 105-second day timer, so night never starts before the repair.
- **Day salvage loop.** Lolth gathers the existing physical pickups, carries them in RECOVERED LOAD, returns to the Wagon, and stores them in the five-slot Wagon stock.
- **Wheel Kit recipe.** During the day phase, the camp menu shows only the Wheel Kit: `1 WOOD, 1 ROPE, 1 SALVAGE`. A recipe panel shows those inputs and how many are in Wagon stock. The HUD objective tells the player what to do next. Crafting consumes only the declared inputs.
- **Wagon state.** `wagon_condition()` returns `stationed` once a Wheel Kit is crafted, otherwise `cave_damaged`. In Thornwake, the wagon sprite uses the repaired panel when stationed. The `WAGON REPAIR n/3` label is hidden in Thornwake. `wagon_travel_locked()` still always returns `true`.
- **Nightfall.** Crafting the Wheel Kit starts a four-second dusk. A "NIGHT FALLS ON THE CAVE CAMP" banner appears and the scene darkens gradually before the first wave.
- **Night defense.** The defense has two waves only: one Briar Hound, then one Stag of Mire. The Antlered Hunger wave is no longer spawned; it belongs to B-03.
- **Telegraphed attacks.** Thornwake Briar Hounds and Stags of Mire approach, wind up, strike, and recover.
  - Stags wind up for 0.9 s before charging the Wagon. The charge shows a "CHARGE!" label, a line to the Wagon, a ring, and a message.
  - Hounds wind up for 0.55 s before lunging at Lolth, with a "!" warning.
  - Telegraphs are drawn above the camp so they stay readable.
- **Safe camp.** Clearing both waves, or reaching dawn, calls `complete_tutorial_defense()`. It clears enemies, restores day, heals Lolth, renews pickups, and holds the camp in daylight.
- **No progression.** Kills before Mark I grant no Shadow Echoes. `try_advance_from_camp()` no longer starts THE KISS OF SHAR, Mark I, or cures from Thornwake. Stonehook entry stays locked.
- **Failures.** Before Mark I, Lolth's death, wagon destruction, and the plagued-ally failure (provisions reaching zero) all restore the B-01 cave start. The survival checks moved into `check_survival_failures()` so they can be tested.
- **Bug fix.** The Stag of Mire sprite lookup compared against the wrong letter case, so stags rendered as Briar Hounds. It now matches `STAG OF MIRE`.
- **Self-test.** `run_thornwake_tutorial_self_test()` covers the full B-02 path and prints `SELF_TEST_B02_PASS` or `SELF_TEST_B02_FAIL`. The overall `SELF_TEST_PASS` requires it.
- **Existing self-test updates.**
  - The wagon-failure check now requires a telegraph before the stag's hit.
  - The prototype Mark I and cure regression now calls `start_comic()` directly, and it checks first that the tutorial never starts Shar.

## Validation

All runs used Godot 4.7.2 stable (official Linux x86_64 build, SHA-512 matching the mirror's `SHA512-SUMS.txt`) in a scratch copy of the project.

- `godot --headless --path . -- --self-test` exited with code 0:
  - `SELF_TEST_B01_PASS: opening shell reaches the day-start cave camp with eight plagued allies and a damaged, travel-locked wagon`
  - `SELF_TEST_B02_PASS: day salvage, Wheel Kit repair, nightfall, telegraphed defense, safe camp, and pre-Mark-I resets are ready`
  - `SELF_TEST_PASS: Thornwake, Stonehook, and Hollowroot combat, cures, web crossing, checkpoints, and chapter transitions are ready`
- Each of these deliberate defects made the B-02 test fail (exit code 1):
  - the Wheel Kit never stations the wagon;
  - a 0.4 s stag wind-up;
  - no hound wind-up;
  - a third night wave;
  - the day timer driving nightfall;
  - kills granting Shadow Echoes;
  - the camp starting THE KISS OF SHAR.
- A normal 600-frame run at 1280 by 720 (OpenGL under Xvfb) exited with code 0 and no script errors. The only errors and warnings came from the container's missing audio device and V-Sync control.
- A 600-frame headless run exited with code 0 with no errors or warnings.
- A real-time scripted run reached `safe_camp` with the wagon `stationed`, 0 Shadow Echoes, and Mark 0.
- Four 1280 by 720 screenshots were captured and reviewed: the day recipe state, the nightfall banner, the night defense with a stag charge telegraph, and the safe camp.

## Deferred items

- Antlered Hunger, Shar, H-02, THE KISS OF SHAR, Mark I, FIRST THREAD, cure selection, and Shadow Echo progression (B-03).
- What happens in Thornwake after the safe camp. The camp stays in daylight with no further nights until B-03 defines the boss trigger.
- The other existing recipes (Cataplasm, Brazier, Axle & Brakes) return to the camp menu after the Wheel Kit. They are unchanged prototype behavior.
- The art gaps already recorded: the elf sprite reads as a drow, there is no cave backdrop, and the day backdrop is dark.
- The existing draw order places enemy sprites behind the camp fire and wagon. Telegraphs are drawn above them, but a stag at the Wagon is partly hidden.
- Mapping the opening-shell beats to the nine H-01 panels.
