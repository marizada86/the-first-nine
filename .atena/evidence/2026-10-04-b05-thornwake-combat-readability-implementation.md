---
status: implemented-awaiting-human-review
kind: implementation-note
created: 2026-10-04
batch: B-05
plan: "[[2026-10-04-b05-thornwake-combat-readability]]"
instruction: "[[2026-10-04-b05-thornwake-combat-readability-instruction]]"
implementation_branch: b05-thornwake-combat-readability
base_commit: 9ea4fc1bbfabd5be50a2d7f334b9b11325b8a77b
implementation_push_approved: false
pull_request_approved: false
merge_approved: false
---

# B-05 - Thornwake melee damage and animation readability

## Starting point

`origin/main` was fetched and verified at `9ea4fc1bbfabd5be50a2d7f334b9b11325b8a77b` ("docs: record B-05 source publication and Opus readiness"). It contains the F4 playtester source `4ef349b` and the B-05 approval `a31c12c`. The local branch `b05-thornwake-combat-readability` was created from that commit.

## Reproduction before the fix

A real-input runner under Xvfb at 1280 by 720 reproduced the issue on the unmodified `main.gd`. It used OpenGL rendering and Godot 4.7.2, and sent real key and mouse events through `Input.parse_input_event`. The run:

1. skipped the opening with Escape;
2. opened F4 and clicked **Next night**;
3. walked right with D toward the Briar Hound;
4. pressed E.

Logged values, from the second, regenerated run:

| Moment | Gap to hound | Hound health | Lolth health | Pose | Hurt overlay | Message |
| --- | --- | --- | --- | --- | --- | --- |
| E pressed | 63 px | 1 | 3.0 | walk | no | - |
| 2 frames later | 55 px | 1 | 3.0 | idle | no | "Stand near a resource, enemy, or the Wagon..." |
| 8 frames later, hound lunge lands | 23 px | 1 | 2.0 | hurt | yes | "Lolth is wounded." |
| Attack at 45 px | - | 1 -> 0 | - | strike | yes (from the earlier real hit) | wave cleared |

A clean dodge with no enemy contact on the same code gave: Lolth 3.0 -> 3.0, VFX kind `dodge`, `hurt_cooldown` 0.30, hurt pose shown, and the pink hurt circle shown.

Capture: `.atena/generated/2026-10-04-b05-combat-validation/b05-before-fix-miss-then-hurt.png`.

**Measured sprite bodies.** Opaque columns were measured in the actual sprite cells, scaled to their drawn size:

- Lolth idle: 73-90 px wide, so her half-body is about 40 px.
- Briar Hound: about 83 px.
- Stag of Mire: about 105 px.
- Antlered Hunger, drawn at 160 px: about 146 px.

A hound therefore visibly touches Lolth at a center gap of about 82 px, but the old hit test required a center distance under `INTERACT_RADIUS` (56 px).

## Root causes

1. **Reach mismatch.** `handle_primary()` damaged only enemies within 56 px of Lolth's center, while the drawn bodies touch at about 82 px. Attacks at visible contact (55-80 px) missed.
2. **Silent miss.** A miss showed no pose and no effect, only an unrelated interaction message, so an attack looked as if it had not happened.
3. **Real hit read as attack failure.** The hound's telegraphed lunge then genuinely struck Lolth (3.0 -> 2.0), so the hurt pose followed the "attack". This damage was legitimate and is preserved.
4. **Dodge drawn as hurt.** `perform_dodge()` set `hurt_cooldown` for invulnerability and emitted the VFX kind `dodge`. `draw_player()` only recognized `dash`, so it fell through to the hurt pose and drew the pink hurt circle from `hurt_cooldown`. `draw_mark_vfx()` likewise drew the strike cell for a dodge.

## Changes (`main.gd`)

- **Melee reach matches visible contact.** A strike lands when the horizontal center gap is within Lolth's half-body (44 px) plus the target's measured half-body: Briar Hound 42 px (total 86), Stag of Mire 52 px (96), Antlered Hunger 73 px (117), and 42 px by default. The vertical gap must be within 70 px. These are measured playtest values in `MELEE_*` constants.
- **Targeting.** `find_melee_target()` picks the nearest live enemy in reach, and Lolth turns to face it.
- **Unchanged.** Contact damage (35 px), the three-strike combo (1, 1, 2), telegraphs, enemy damage, and the defeat and Echo rules.
- **Distinct miss.** When no enemy is in reach but one is within 220 px, the attack plays the strike pose with a faint swing effect in front of Lolth. It shows "Out of reach — step closer to strike the `<ENEMY>`.", resets the combo, and deals no damage. A hit instead shows the strike effect at the enemy, a short enemy flash, the health drop, and the existing staggered or defeated messages.
- **Separate pose states.** `player_pose()` follows the most recent player action: `strike` (0.28 s), `dodge` (0.30 s), `collect`, or `hurt` (0.45 s). Otherwise it falls back to air, walk, or idle.
  - `perform_dodge()` now emits the `dash` VFX and the dodge pose.
  - `hurt_cooldown` still provides invulnerability but no longer drives visuals.
  - `player_hurt_visible()` and the pink circle use `hurt_flash_time`, which is set only when Lolth actually loses health.
  - When a real enemy strike lands after an attack, the enemy damage and flash remain, and Lolth shows the hurt pose and overlay. Both outcomes stay readable, and legitimate damage is never hidden.
- **FIRST THREAD** also sets the strike pose and enemy flash. Pickups set the collect pose.
- **Resets.** New runs and safe-wagon restores clear the new pose and flash timers. The F4 playtester snapshot includes them automatically as script variables.

No asset, scene, project setting, canon, dependency, or later-region content was changed. No new art was added.

## Validation

Godot 4.7.2 stable, official Linux x86_64 build, in a scratch copy of the project.

- **Headless self-test.** `godot --headless --path . -- --self-test` exited 0 with no script errors or warnings, and printed `SELF_TEST_B01_PASS`, `SELF_TEST_B02_PASS`, `SELF_TEST_B03_PASS (... 12 melee hits)`, `SELF_TEST_B04_PASS`, `SELF_TEST_B05_PASS`, `SELF_TEST_PLAYTESTER_PASS`, and `SELF_TEST_PASS`.
- **`run_combat_readability_self_test()` (B-05) checks:**
  - a hit at an 80 px gap (hound 3 -> 2) that faces the target, flashes it, and grants no Echo before Mark I;
  - a miss at 100 px (hound 3 -> 3) with the swing effect and "Out of reach" message;
  - the nearest target winning when two enemies are in reach;
  - the preserved 1, 1, 2 combo (10 -> 6);
  - a dodge with the dodge pose, `dash` VFX, no hurt overlay, and no health loss, which also blocks contact;
  - real damage (-1 health) showing the hurt pose and overlay;
  - an attack and a real strike in the same frame both resolving (enemy -1, Lolth -1, hurt pose and overlay, enemy flash);
  - a real-reach hound kill advancing the night wave to the Stag of Mire with 0 Echoes.
- **Negative controls.** Each of these 11 deliberate defects made the self-test fail (exit code 1):
  - the old 56 px reach;
  - unlimited reach;
  - the old `dodge` VFX kind;
  - hurt visuals driven by `hurt_cooldown`;
  - a dodge showing the hurt pose;
  - real damage showing no hurt;
  - a miss without the swing;
  - a hit without the enemy flash;
  - the first enemy chosen instead of the nearest;
  - no turn toward the target;
  - hurt hidden by a later pose.
- **Real-input runner.** `.atena/generated/2026-10-04-b05-combat-validation/validate_b05_combat.gd`, run at 1280 by 720 with OpenGL under Xvfb, exited 0 with `B05_RUNTIME_PASS: 0 failures`. Its 9 checks:
  - F4 **Next night** spawns a Briar Hound.
  - A dodge shows the dodge pose and dash effect with no hurt (Lolth 3.0 -> 3.0).
  - An attack pressed at a 66 px visible-contact gap damages the hound (1 -> 0); Lolth 3.0 -> 3.0.
  - The defeated hound grants no Echo before Mark I.
  - The night wave advances to the Stag of Mire (wave 2).
  - An attack at 127 px misses the stag (2 -> 2) with the swing and "Out of reach" message.
  - Real presses defeat the stag in 2 presses and clear the tutorial night to the safe camp.
  - A real hound strike lowers Lolth (3.0 -> 2.0) and shows the hurt pose and overlay.
  - The F4 playtester restore returns to the original run.
- **Existing playtester runner.** `.atena/generated/2026-10-04-playtester-validation/validate_playtester.gd` still exits 0 with `PLAYTESTER_RUNTIME_PASS`.
- **Normal runs.** A 600-frame OpenGL run at 1280 by 720 exited 0 with no script errors. The only messages came from the container's missing audio device and V-Sync control. A 600-frame headless run exited 0 with no errors or warnings.
- **Inspected captures** in `.atena/generated/2026-10-04-b05-combat-validation/`:
  - `b05-hit.png`: the strike pose and hound defeat effect.
  - `b05-miss.png`: the strike pose, faint swing, "Out of reach" message, and stag health bar unchanged.
  - `b05-dodge.png`: the dodge crouch with the blue dash streak and no pink overlay.
  - `b05-hurt.png`: the hurt pose with the pink overlay after a real strike, with the Vigor bar reduced.

## Known limitations

- **Untuned values.** The reach values are measured from the current sprites. They need a human playtest and must be re-measured if the sprites change.
- **Faint miss swing.** The swing is drawn at 45% opacity. The "Out of reach" message and the unchanged health bar carry most of the distinction.
- **Boss reach.** The larger boss reach (117 px) makes the Antlered Hunger slightly easier to hit than in B-04. No other boss values changed.
- **Unchanged visuals.** Enemy sprites still draw behind the camp fire and Wagon. The elf sprite still reads as drow.
- **Debug-only F4.** F4 remains debug-only, and no release export was produced.

## Historical approval state at original implementation

Implemented locally on `b05-thornwake-combat-readability` and awaiting human review. Implementation push, pull request, and merge are not approved and have not been performed.

## Subsequent publication and local follow-up

The owner subsequently authorized the original implementation push, published as `4400b59aab49ed2860c5c6369ba79b386a7d2e9a`. No B-05 PR or merge has occurred. The approval statement above records the earlier implementation checkpoint, not current publication state.

The owner then approved independent inputs, Lolth inventory and wagon management, with later clarifications deferring parry and requesting clean dash and larger Thornwake enemies. The follow-up is implemented on `codex/b05-controls-wagon-inventory`, based on the published original commit. Updated reach, mappings, restore corrections, real-input runner and inspected final captures are in [[2026-10-04-b05-local-controls-inventory-wagon-implementation]]. The earlier reach values, E attack events and blue dash streak describe the original implementation and are superseded by that follow-up. On 2026-10-04 the owner accepted commit `43ab112` with "tudo validado, vamos continuar", then explicitly authorized publishing implementation and records. A normal push was verified at `bb4a0d4` on `origin/codex/b05-controls-wagon-inventory`; publication reconciliation follows on the same branch. B-05 remains active awaiting technical review; no PR or merge is approved or performed.
