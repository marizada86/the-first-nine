---
status: implemented-awaiting-review
kind: implementation-note
created: 2026-10-05
batch: B-06
plan: "[[2026-10-04-b06-stonehook-foot-expedition]]"
planning_evidence: "[[2026-10-04-b06-stonehook-foot-expedition]]"
instruction: "[[2026-10-04-b06-stonehook-foot-expedition-instruction]]"
source_canon:
  - "[[2026-10-03-caravan-survival-slow-travel]]"
  - "[[2026-10-03-caravan-relics-cave-prologue-and-travel]]"
  - "[[2026-10-03-continuous-caravan-ground-and-web-gates]]"
  - "[[2026-10-04-first-boss-mark-and-cure]]"
  - "[[2026-10-04-separated-controls-and-wagon-management]]"
  - "[[2026-10-03-minimal-stonehook-visual-direction]]"
origin: planned
implementation_preceded_spec: false
approval_mode: per-plan
request_execution_classification: IN_PLAN
implementation_branch: codex/b06-stonehook-foot-expedition
base_commit: 7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc
implementation_commit: 42bddf87b64eafb2046a47b1f2695df3ad9d4075
steps_completed: [S-001, S-002, S-003, S-004]
batches_completed: [B-001, B-002, B-003]
human_review: pending
push_approved: false
pull_request_approved: false
merge_approved: false
published: false
---

# B-06 - first on-foot Stonehook expedition

## Checkout and approval verification

- `origin/main` was fetched from `9ea4fc1` to `7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc`. It contains:
  - acceptance `2f34635ff5adf735e51a7c144862e7c1bba37bed`;
  - preparation `0a82ead8384969a11399f20ef3dcf3828734df27`;
  - approval `77ee387d5649a131ae20c5910b2dc7421c76f22f`;
  - the delivery reconciliation `7e477ba`;
  - the accepted gameplay at `05eac1e7a639e213f39cff81b1e75305727ab4d0`.
- The spec, planning evidence, instruction and `.atena/state/plan.yaml` agreed on:
  - explicit `per-plan` implementation approval;
  - the cleared documentation-delivery checkpoint (`external-execution-ready-after-checkout-verification`);
  - separate, unapproved implementation push, PR, merge and dispatch gates.
- The working tree was clean. The local branch `codex/b06-stonehook-foot-expedition` was created from `7e477ba`. All existing branches were preserved.
- The owner directed this executor in the chat session to read the delivered instruction from the repository. No external message was sent by Atena.
- Request classification: IN_PLAN. S-001 to S-004 were executed under the single per-plan approval, without new batch or step approvals and without changing scope.

## Changed files

Commit `42bddf8` contains:

- `main.gd`: route data, departure gate, camera, region display, blended route art, the ore pickup, identity-based pickup restore, region-confined enemies, the wagon-proximity helper, and the B-06 self-test.
- `wagon_inventory_ui.gd`: six guard changes only. Every `player.x >= 305` / `< 305` test now calls `game.at_wagon()`.
- `.atena/generated/2026-10-04-b06-validation/`: the validators, fault subclasses, runner, logs, results, metrics and captures listed below.

This records commit adds:

- this note;
- the reconciliation of the spec, planning evidence, instruction and plan state;
- `.atena/generated/2026-10-04-b06-validation/validate_records.cjs`.

Nothing else changed: no asset, scene, `project.godot`, canon, dependency or configuration file. No reference board was admitted, and nothing is written to disk at runtime.

## Implemented behavior

### S-001: route and rendering

- **Route data.** The spans are named constants, not lore:

  | Constant | Value |
  | --- | --- |
  | `ROUTE_THORNWAKE_END_X` | 1280 |
  | `ROUTE_TRANSITION_WIDTH` | 480 |
  | `ROUTE_FOOTHILLS_START_X` | 1760 |
  | `ROUTE_FOOTHILLS_WIDTH` | 1280 |
  | `ROUTE_END_X` | 3040 |

  The cave anchor stays at x=190 and the floor stays at `GROUND_Y=555`. The floor is flat for the whole route, with no platforms, gaps or vertical requirement.
- **Departure gate.** `expedition_departure_allowed()` requires:
  - state `journey` in the cave hub;
  - no active playtester session;
  - the real `antlered_hunger_defeated` flag;
  - Mark I exactly (`THORNWAKE_MARK_CAP`);
  - exactly one cure;
  - Wagon condition `stationed`;
  - a captured safe-wagon state (`camp_secured` and a non-empty snapshot).

  F4 Mark overrides already clear the safe state and also make `playtester_active` true, so they cannot manufacture entitlement. `self_test_travel_bypass` is not consulted.
- **Return is never gated.** `move_player()` clamps east to `max(route_east_limit_x(), player.x)`. If the gate closes while Lolth is away (for example, during an F4 override), she can still walk west but cannot go further east.
- **Closed-path message.** After Mark I, pushing against the closed Thornwake edge shows "The eastern path opens only after the first cure and a secured camp.", throttled to once every 3 seconds. The pre-Mark tutorial is unchanged.
- **Separate contexts.** `zone` stays 0, the hub and simulation context, for the whole expedition. `lolth_region()` and `displayed_region_name()` derive Lolth's displayed region from her world x:
  - `THORNWAKE FOREST` below 1280;
  - `STONEHOOK APPROACH` from 1280 to 1760;
  - `STONEHOOK FOOTHILLS` from 1760.

  The HUD shows the displayed region. Nothing calls `spawn_zone()` at a border, the Wagon stays `travel_locked`, and `enter_stonehook()` is unchanged.
- **Camera.**
  - `camera_x` follows a screen-space dead zone from x=360 to x=920.
  - It is clamped to 0 unless departure is allowed or Lolth is already beyond the Thornwake player limit. The original cave and tutorial view therefore always has a zero offset.
  - `CAMERA_GLIDE_SPEED` (2400 px/s) only smooths a change in the camera clamp, for example when the gate closes during an F4 override. Ordinary walking stays locked to the dead zone.
  - `spawn_zone()` snaps the camera, so every restore, restart and new run returns to the cave view.
- **Drawing.**
  - All world layers draw under one `draw_set_transform(world_draw_origin())`, then the transform resets to identity before the HUD, cure, shell, banner and defeat overlays.
  - Enemy and Lolth reflections add the world origin to their mirror translation and reset to the world transform, not to identity. The Mark VFX uses the world transform.
  - The time-of-day tint covers the visible view at any camera position.
- **Route art.** The transition uses only existing preloads, blended spatially rather than with a temporal dissolve.
  - **Backdrop.** Ashen Way to the Stonehook continuous route.
  - **Ground.** The Thornwake continuous ground to the Stonehook band of `ZONE_GROUND_BANDS_RUNTIME`.
  - **Foreground.** The Ashen Way overlay to the Stonehook panel of `RUINS_FOREGROUND_OVERLAYS`.

  How the blend is drawn:
  - Each side is mirrored at its own seam, so the Thornwake art meets x=1280 and the Stonehook art meets x=1760 without a cut.
  - The opaque backdrop and ground cross-fade over the whole 480-unit band, using per-vertex alpha on a textured quad.
  - The frame-like foreground overlays fade within `ROUTE_OVERLAY_FADE_WIDTH` (160) at each seam, so their edge trees do not double across the band.
- **Signposts.** Once the path is open, two world-space signs are drawn after the foreground: "STONEHOOK FOOTHILLS >" (with "On foot. The Wagon stays in the cave.") near the Thornwake edge, and "< THE CAVE CAMP" at the foothills start.

### S-002: camp, resources and guards

- **Pickup identities.** Every Thornwake pickup now has a stable `id`.
- **The ore.** One finite `IRON ORE` (`id: stonehook_iron_ore_01`, type `metal`, 1 slot, `renewable: false`) lies on the floor at x=2620, using the existing salvage art.
  - It is collected with E under the existing carried-capacity rule.
  - With a full load it stays in the world with the existing "RECOVERED LOAD is full" feedback.
  - It is stored with E or the menu only at the cave Wagon. With full stock it stays carried, with the existing "WAGON STOCK is full" feedback.
  - Dawn renewal skips it. It unlocks nothing: AXLE & BRAKES stays locked in the cave UI and needs two metal and a tool.
- **Wagon guard audit.** `at_wagon()` (world x < `WAGON_INTERACT_MAX_X` = 305) replaces every former literal check:

  | Location | Former check | Now |
  | --- | --- | --- |
  | `main.gd` `_input` (controller menu) | `player.x >= 305` | `not at_wagon()` |
  | `main.gd` `handle_primary` (store / craft) | `player.x < 305` | `at_wagon()` |
  | `main.gd` `open_camp_menu` | `player.x >= 305` | `not at_wagon()` |
  | `main.gd` `is_at_safe_wagon` (capture) | `player.x >= 305` | `not at_wagon()` |
  | `main.gd` `use_camp_action` | `player.x >= 305` | `not at_wagon()` |
  | `main.gd` `cycle_post_ally`, `toggle_selected_post` | `player.x >= 305` | `not at_wagon()` |
  | `main.gd` `select_mission`, `assign_mission` | `player.x >= 305` | `not at_wagon()` |
  | `wagon_inventory_ui.gd` `open_window` | `player.x >= 305` | `not game.at_wagon()` |
  | `wagon_inventory_ui.gd` `show_inventory` | `player.x < 305` | `game.at_wagon()` |
  | `wagon_inventory_ui.gd` `store_load`, `craft_recipe` | `player.x < 305` | `game.at_wagon()` |
  | `wagon_inventory_ui.gd` `manage_ally`, `select_mission` | `player.x >= 305` / `< 305` | `game.at_wagon()` |

  - **Why remote access is impossible.** Proximity is world x, so the foothills (x ≥ 1280) cannot satisfy it. The camera never enters any interaction.
  - **Zone locks still hold.** The `zone == 0` / `zone != 0` checks stay correct because `zone` remains the cave hub during the expedition. Posts, missions and AXLE & BRAKES therefore stay locked, and no second camp exists.
  - **Inventory.** I still opens Lolth's carried inventory anywhere.
- **Offscreen camp.** These keep their existing rules wherever Lolth is: the clock, Flame and Provisions drain, the Thornwake night waves, wagon damage and defense, the "WAGON UNDER ATTACK" notice, and every failure check. Nothing is frozen, cleared or replaced at a border.
- **Region-confined enemies.**
  - Enemies record `origin_zone`. `enemy_region_limits()` keeps Thornwake attackers inside 70 to 1210. These are the same numeric limits as the former `VIEW.x - 70` clamp, so prototype regions are unchanged and legacy dictionaries fall back to `zone`.
  - A Briar Hound hunting Lolth waits at the Thornwake edge. It never follows her into Stonehook, so this slice adds no new Stonehook combat.
  - Enemy sheet selection still uses the hub context, so cave attackers keep their Thornwake art.

### S-003: restoration

- **Snapshot.** `capture_safe_wagon_state()` also stores `pickup_taken`, keyed by pickup id. `restore_safe_wagon_state()` restores identified pickups by id, falling back to the old index array for any pickup without an id.
- **Restore position.** The restore returns Lolth to the cave camp spawn (x=330) through `spawn_zone()`. The view returns to its zero cave offset. Camera and position are not operational progress, so they are reset rather than replayed.
- **Terminal failure anywhere.** Death, Wagon destruction, Flame or Provisions at zero restore the latest valid cave snapshot. Mark I and the chosen cure stay.
  - Before a safe return, the unsaved ore rolls back: it reappears in the foothills and is not carried.
  - After a safe return, stock, load and pickup state agree.
  - Existing enemy clearing on restore is unchanged.
  - The B-04 survivability guard still prevents capturing a terminal camp.
- **F4.** The playtester snapshot already deep-copies every script variable outside the `playtester_` and `ui_` prefixes. It therefore covers `camera_x`, `route_closed_notice`, Lolth's world position, `salvage` with ore identity and state, load, stock and the safe snapshot. No exclusion was added.
- **New run.** `reset_to_prologue()` → `spawn_zone()` recreates the ore and Thornwake pickups, snaps the camera to 0 and clears the safe state. Departure is blocked again until the legitimate milestones.

## Validation (S-004)

- **Environment.**
  - Godot `4.7.2.stable.official.ed1daf0bf`, the official Linux x86_64 build, SHA-512 verified earlier in this project.
  - Linux 6.18 container. Rendered cases ran under Xvfb (`xvfb-run -a -s "-screen 0 1280x720x24"`) at 1280×720 with `--rendering-method gl_compatibility` on the software OpenGL driver.
  - All runs used a scratch copy of the project, with no fixed-FPS option and wall-clock timeouts.
  - Windows `D:/Godot/godot.exe` was not available, and no Windows or GPU reproduction is claimed.
- **Command.**

  ```
  GODOT=<godot> B06_PROJECT=<copy> XVFB=1 node .atena/generated/2026-10-04-b06-validation/run_validation.cjs all
  ```
- **Runner.** The runner records each process's real exit code, its diagnostics (each classified together with its following `at:` source line) and a per-case `*-result.json`.
- **Allowed diagnostics.** The only diagnostics in any case come from the container's missing audio device and V-Sync control: the ALSA `ERR_CANT_OPEN` error in `drivers/alsa/audio_driver_alsa.cpp`, "All audio drivers failed" and "Could not set V-Sync mode". No project script error or warning appeared.

### Results

| Case | Exit | Result |
| --- | --- | --- |
| `b06-headless` | 0 | `B06_PASS: 30/30 checks` |
| `b06-runtime` (rendered, real input) | 0 | `B06_RUNTIME_PASS: 40/40 checks` |
| `self-test` | 0 | B01 to B06, PLAYTESTER and `SELF_TEST_PASS` (B06: 30 checks) |
| `combat` (B-05 runner, rerun) | 0 | 9/9 `RUNTIME PASS`, `B05_RUNTIME_PASS` |
| `menus` (B-05 runner, rerun) | 0 | `LOCAL_CONTROLS_PASS: 33/33 checks` |
| `geometry` (B-05 oracle, rerun via wrapper) | 0 | `GEOMETRY_PASS: 46/46 checks`, 22 prepared cells |
| `facing-headless` (rerun via wrapper) | 0 | `FACING_PASS: 65/65 checks` |
| `facing-normal` (rerun via wrapper) | 1 | `FACING_FAIL: 101/102`, pre-existing in this environment (see below) |
| `normal-smoke` (600 frames, 1280×720) | 0 | no project diagnostics |
| `headless-smoke` (600 frames) | 0 | no project diagnostics |

**The 30 headless checks** (`stonehook_expedition_checks()`):

- **Departure gate.** The route stays closed for a new run, before the boss, for Mark I without a cure, for a cure without a secured camp, and for a debug-only F4 Mark I.
  - Each blocked case walks with real movement physics and stays at or below x=1238 with a zero camera.
  - A legitimate first cure plus a safe return opens it.
- **Outward walk.**
  - No step is larger than one frame of walking.
  - The camera stays at zero inside the cave window and reaches 1760 at the end.
  - The regions read thornwake → approach → foothills, on the same floor and in the same zone.
- **Fixed hub.** Wagon, family, relics, stock and anchor are unchanged, and nothing is captured on the way.
- **Remote access.** From the foothills: no store or craft through E; neither M nor `open_window` opens the Wagon menu; direct menu callbacks do nothing; no safe capture. I still opens the inventory.
- **Ore.**
  - With a full load the ore stays in the world.
  - It is collected once and never twice.
  - Three border oscillations do not respawn loot or enemies or refill survival.
- **Rollback and deposit.**
  - Provisions failing in the foothills roll back the unsaved ore to the cave snapshot.
  - The return captures a consistent snapshot. A full stock keeps the ore carried, and the deposit happens once.
  - A recapture includes the ore in stock, and a later failure keeps exactly one copy.
- **Offscreen camp.**
  - Nightfall spawns the Thornwake wave while Lolth is away, and the clock, Flame and Provisions advance.
  - The Hound stays inside its origin span and never touches Lolth.
  - A concrete Stag winds up and damages the fixed Wagon. Its destruction restores the cave snapshot with Mark I and the cure.
- **F4.** An override closes departure but lets Lolth walk back and stops further eastward travel. The restore is exact for position, camera, pickups, load, stock, safe snapshot and clock.
- **No unlock.** At the far end, capped Echoes, the camp action, E and the old travel calls unlock nothing.
- **Combat.** Melee and First Thread hit by world position under a nonzero offset.
- **New run.** A new run resets every route field and closes the path again.

**The 40 rendered checks** (`validate_b06_runtime.gd`):

- **Cave-view parity.** The day tutorial, the tutorial night with a wave, and the secured post-cure camp with Lolth at x=900 were each rendered with the B-06 build and with the pre-B-06 `main.gd` from `7e477ba`, written into the run copy only.
  - All three match exactly: 0 differing pixels.
  - The secured case excludes only the new signpost rectangle. It also confirms the signpost is the only difference there.
- **Translation fixture.**
  - Lolth, Hound and Stag (with names and bars) were drawn at view offsets 0 and 1000, both right- and left-facing. The two renders are pixel-identical, with 0 differing pixels in each facing.
  - A world-space marker drawn after the reflected sprites, and a screen-space marker after the reset, stay in place.
- **Real-input route run.** Real D, A, E, M, I, Esc, left-click and C events across real frames:
  - **Outward.** From the secured cave to x=2998 in 298 frames: monotonic, every step within `290 × frame time`, camera steps within the glide bound, zone 0, journey state, floor height constant. The camera stays at zero inside the cave window, and the regions read in order. The hub is unchanged.
  - **Ore and UI.** E collects the ore and a second E finds nothing. M is refused away from the Wagon. I opens the inventory and pauses the clock, and Esc closes it. Left-click swings with no world effect.
  - **Return.** A walks back the whole route with the same continuity checks, and the camera returns to 0. Arrival captures a snapshot that contains the carried ore, and E deposits it once.
- **Offscreen Stag (real frames).** With Lolth at x≈2300 at night, one Stag placed where it begins its charge telegraphs and damages the Wagon. Lolth's position and the camera do not change, and the clock advances. At 1 integrity the next hit reaches the defeat card. Real E restores the cave snapshot with Mark I, the cure and one ore.
- **Combat and UI under an offset.** With a 256 px offset near the Thornwake border, left-click melee and real C (First Thread) hit by world position. M still cannot open the Wagon there.
- **Frozen captures.**
  - Five transition positions (x = 1000, 1280, 1520, 1760, 2400) in both day and night, at the expected offsets (80, 360, 600, 840, 1480).
  - The HUD title glyph count is identical (827) in all ten captures.
  - The seams show no cut. The column difference is 0.0006 at x=1280 (typical 0.0131) and 0.0023 at x=1760 (typical 0.0161).

### Negative controls

Every faulty test-only subclass was rejected with a nonzero exit, named detections and no project diagnostics. Two of them are render-fixture faults.

| Fault | Exit | Detected by |
| --- | --- | --- |
| `bypass_departure`: Mark I alone opens the route | 1 | `uncured_mark_blocked`, `unsecured_blocked`, `debug_mark_blocked`, `f4_override_gate` |
| `border_respawn`: the border re-creates the ore | 1 | `border_no_respawn` and 5 dependent ore-consistency checks |
| `remote_wagon`: proximity measured from the displayed region's start | 1 | `remote_wagon_blocked`, `remote_no_capture`, `border_no_respawn`, `foothill_rollback` |
| `paused_offscreen`: clock and attackers freeze while away | 1 | `offscreen_clock_runs`, `enemy_keeps_origin`, `offscreen_stag_damage`, `offscreen_terminal_restore` |
| `lost_route_restore`: restore keeps the failed expedition's position, view and pickups | 1 | `foothill_rollback` and 6 dependent checks |
| `lost_f4_fields`: F4 snapshot omits position, camera and pickups | 1 | `f4_exact_restore` |
| `progression_unlock`: capped Echoes in the foothills awaken Mark II | 1 | `no_progression_unlock`, `camera_offset_combat` |
| `new_run_keeps_route`: a new run keeps camera and ore state | 1 | `new_run_resets` |
| `leaked_camera_transform` (render): enemy reflection resets to identity | 1 | translation identity (41,882 differing pixels) and marker checks |
| `unshifted_reflection` (render): Lolth's reflection ignores the camera | 1 | left-facing translation identity (13,777 differing pixels) |

### The facing-normal result is pre-existing, not a B-06 regression

- **The failing check.** The rendered facing suite fails exactly one check: `ANTLERED HUNGER frame 1 labels/bars stay unmirrored`, a region difference below 0.0001. The other 101 checks pass, including all reflection, overview and outside-pixel checks.
- **Reproduced on the baseline.** The same suite was rerun three times against the unchanged `7e477ba` `main.gd` and `wagon_inventory_ui.gd` in the same environment. Every run failed only that check: 101/102, exit 1. `facing-normal-baseline-7e477ba.log` keeps one of these runs.
- **Repeatable on B-06.** Three B-06 runs gave the identical result.
- **Cause.** It is a property of this Xvfb software-OpenGL rasterizer against that very tight threshold. The committed Windows GTX 1650 result was 102/102. No facing assertion or threshold was changed, and the case stays recorded as `FAIL` in `facing-normal-result.json`.

### Reruns and fixture adaptations

- **No earlier assertion was edited.**
- **Wrapped suites.** The geometry and facing suites run through `geometry_regression.gd` and `facing_regression.gd`. These only redirect output into `regressions/` so committed B-05 and facing evidence is never overwritten.
  - `validate_facing.gd` loads its render fixture from its output directory, so an identical copy sits at `regressions/facing/render_fixture.gd`.
- **Direct runs.** The combat and menu runners use their existing `OUT` variable.
- **What is committed.** Regression images stayed in the scratch copy. Only their logs, results and metrics are committed.
- **Reproduced versus historical.** All B-05 and facing runs above are fresh reproductions on Linux. The committed historical results in their own directories are unchanged and are not counted here.

### Preliminary harness corrections (not acceptance runs)

- **Type inference.** The first B-06 self-test run failed to parse because `var menu_closed := not ui_management.is_open()` inferred a Variant. It now has an explicit `bool` type.
- **Missing copy tool.** `rsync` is missing in the container, so the first project copy did not happen and one headless import ran in the repository. It only touched the git-ignored `.godot/` cache, and `git status` showed no other change. Copies now use `tar`.
- **Frame ordering in the runner.** The first rendered run reported 38/40. The two continuity checks failed because `await process_frame` resumes before that frame's `_process`. Comparing each observed step with that same frame's delta was therefore off by one frame. The bound now uses the larger of the two adjacent frame times. The game was not changed for this; the final trace shows every step at exactly the walking speed bound (ratio 1.000).
- **Diagnostic classification.** The ALSA error line was first counted as a project diagnostic, because only its `at:` line names the ALSA driver. Diagnostics are now classified together with that source line.
- **Visual corrections from capture review.** The first full-band foreground mirror doubled the Ashen Way edge tree and hid Lolth near x=1280–1460. The overlay fade was shortened to 160 px per seam. The first signpost text overlapped the KINDLING and WHEEL SALVAGE labels, so the signs were raised above the pickup labels and drawn after the foreground. Both changes came before the final runs above.

## Captures inspected

All are 1280×720, in `.atena/generated/2026-10-04-b06-validation/`:

- `transition-{day,night}-{1000,1280,1520,1760,2400}.png`
- `seam-1280.png`, `seam-1760.png`
- `route-cave-secured.png`, `route-far-end.png`, `route-returned-deposit.png`
- `foothills-inventory.png`, `camera-offset-melee.png`
- `offscreen-stag-damage-night.png`, `offscreen-defeat.png`
- `parity-{day,night,secured}.png`
- `translation-{left,right}-offset-1000.png`

What the inspection showed:

- **Transition.** Vegetation and the forest backdrop give way to rock, ruins and a cooler mountain palette across the band. The floor line is continuous, and Lolth's feet stay on the floor.
- **Screen-space elements.** The HUD, inventory panel and playtester button stay in screen space.
- **Labels.** The signs are readable and do not overlap the pickup labels.
- **Offscreen damage.** The offscreen Stag hit shows in the HUD message ("STAG OF MIRE strikes the Wagon. Integrity: 91%.") while Lolth is in the foothills.

## Acceptance criteria

1. **Departure gate.** A new game, the pre-boss state, uncured Mark I and debug-only Mark I stay within x ≤ 1238 with a zero offset. A legitimate cure plus a safe return opens the route on foot, and the Wagon stays `travel_locked`. Met.
2. **Continuous traversal.** Real D and A input crossed the full route in both directions without a reset, a position jump, a floor gap or a region screen. Five positions were captured in day and night at 1280×720, the HUD stayed fixed and the seams had no cut. Met.
3. **Fixed hub.** There is one cave anchor before, during and after the expedition, and its state is unchanged by crossing. Remote E, M, menu callbacks and capture are blocked. Met.
4. **Ore.** Collected once, retained across border revisits and deposited once. Load and stock capacity feedback are preserved. Rollback and recapture keep identity and stock consistent. Met.
5. **Offscreen camp.** The clock and survival continue offscreen. A concrete Stag damages the fixed Wagon while Lolth is in the foothills, and terminal failure restores the cave snapshot with Mark I and the cure. Met.
6. **F4 and new run.** F4 restore is exact for the route fields, and a new run resets them. Border oscillation does not refill enemies, loot or meters. Met.
7. **No unlock.** The far end, capped Echoes (3/3), old travel calls and the camp UI unlock nothing: no Stone Maw, Mark II, second cure, parry, travel, posts or later region. Met.
8. **Prior suites.** The earlier self-tests and the real-input combat, menu, geometry and headless facing suites pass without edits or weakened assertions. The single rendered facing difference is pre-existing in this environment, reproduced on the baseline, and left failing rather than adapted. Met, with that environment note.

## Known limitations

- **Mirrored seams.** Mirroring hides each seam but produces a visible symmetric echo of the Ashen Way backdrop's edge tree inside the band. Final route art should replace this.
- **Foreground occlusion.** Lolth passes behind the existing Ashen Way foreground tree near the Thornwake edge. This occlusion already existed at x≈1100–1238; the 160 px seam fade extends it slightly past 1280.
- **Wagon left behind.** Once departure is open, the dead-zone camera starts to scroll while Lolth is still in Thornwake east of x=920, by up to 360 px at the border, and the cave Wagon leaves the view while she is in the band or the foothills. Offscreen camp danger is reported only through the existing HUD message and the WAGON meter.
- **Hound at the border.** A Briar Hound that hunts Lolth at night waits at the Thornwake edge (x≤1210) until she returns.
- **Restore position.** As in B-04, restores place Lolth at the standard camp spawn, not at her capture position. Snapshots stay in memory only.
- **Pickup labels.** The overlapping WHEEL SALVAGE and BRAZIER SALVAGE labels are pre-existing.
- **Platform.** Validation is Linux, Xvfb and software OpenGL only. There are no Windows, GPU, performance or CI results. A human playtest of feel, camera and readability is pending.
- **Tuning.** The route spans, ore position, camera window and fade widths are untuned playtest data.

## Approval, checkpoint and publication state

- **Plan state.** Per-plan approval covered S-001 to S-004, and all four are complete locally. The plan is now `implemented-awaiting-review` at checkpoint `owner-review-of-local-implementation`.
- **Local commits only.** Implementation commit `42bddf8` and the records commit that adds this note are on the local branch `codex/b06-stonehook-foot-expedition`, based on `7e477ba`.
- **Not done.** No push, pull request, merge, branch deletion, amend of published history, force-push, external message or B-07 work. `push_approved`, `pull_request_approved`, `merge_approved` and `dispatch_approved` remain false.

## Next recommendation (non-authorizing)

This recommendation authorizes nothing. Each step needs the owner's separate approval.

1. Review the local diff and captures.
2. Run a short Windows playtest of the expedition with `D:/Godot/godot.exe`: departure, the walk out, the ore, an offscreen night, the return and deposit.
3. Rerun `run_validation.cjs all` on Windows to reproduce these results on the original platform, including whether the rendered facing suite returns to 102/102 there.

Publication, a PR, a merge or further Stonehook content each need that separate owner approval.
