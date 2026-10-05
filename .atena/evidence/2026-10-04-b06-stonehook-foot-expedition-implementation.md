---
status: complete-implementation-merged
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
human_review: accepted
push_approved: true
pull_request_approved: true
merge_approved: true
published: true
branch_publication_approved: true
published_commit: ccc4fcf69271d88e421e26a81841cf6cce834a37
follow_up_commit: d2012a1412f52d3066e4eff1216cfa9d57490acd
follow_up_published: true
latest_published_commit: 7de6d6658a2e8b7aea5954320ef29902094d7215
isolation_follow_up_commit: b446b7b507d6a5faa8fb2ac9d28197da34887e99
isolation_follow_up_published: true
combat_isolation_follow_up: published-test-only
combat_isolation_follow_up_commit: 7de6d6658a2e8b7aea5954320ef29902094d7215
combat_isolation_follow_up_published: true
combat_isolation_publication_source: owner-separately-authorized-normal-push-fast-forward-9640881-to-7de6d66
human_acceptance: accepted
human_acceptance_date: 2026-10-05
human_acceptance_scope: overall-owner-aprovado-of-the-reviewed-B06-slice-at-7de6d66
windows_review_7de6d66: atena-external-review-2026-10-05-not-reproduced-by-executor
reconciliation_documentation_push_authority: owner-authorized-one-normal-documentation-commit-and-push-on-this-branch-only-separate-from-the-completed-implementation-publication
pull_request_state: merged
pull_request: https://github.com/marizada86/the-first-nine/pull/6
pull_request_number: 6
pull_request_head: cc87e1c3d88c837e16aca8f39bf7f0870f5b1246
pull_request_base: 7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc
merge_commit: e304badbbd15c6ce2bd93b114006dd26c0c7391e
merge_parents: [7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc, cc87e1c3d88c837e16aca8f39bf7f0870f5b1246]
preserved_commits: [42bddf8, ccc4fcf, d2012a1, 7c781ab, b446b7b, 9640881, 7de6d66, cc87e1c]
feature_branch_preserved: true
merge_verified: true
standing_publication_authority: none
closure_record_publication_approved: true
dispatch_approved: false
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

## Authorized branch publication

The sections above record the state at records commit `ccc4fcf`, before publication, and are kept unchanged as history.

- **Authority.** The owner explicitly authorized a normal push of `codex/b06-stonehook-foot-expedition` to origin for review. It did not authorize a push to `main`, an amend, a force-push, a PR, a merge, branch deletion or B-07.
- **Pre-push check.** The branch held implementation `42bddf8` and records `ccc4fcf` on base `7e477ba`, with a clean tree. The branch did not exist on origin, and remote `main` was `7e477ba`.
- **Push.** A normal `git push -u` created `origin/codex/b06-stonehook-foot-expedition` at `ccc4fcf69271d88e421e26a81841cf6cce834a37`, confirmed with `git ls-remote`. Remote `main` stayed at `7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc`.

## Review follow-up (`d2012a1`, local)

### Atena's Windows review of `ccc4fcf`

Atena ran this exact build on Windows with Godot 4.7.2 and a GTX 1650. These results are Atena's, not reproduced here:

- Headless B-06: 30/30. Rendered facing: 102/102. Combat, menus, geometry, self-tests and all ten faulty controls passed.
- The original route runner reached 36/40. Physical right-trigger values of about 0.20–0.21 from an attached controller dashed during the keyboard-only test. That affected the movement bounds and the closed-path refusal messages.
- With physical controller events filtered, it reached 39/40. The remaining Stag check recorded Lolth's position before deceleration ended: velocity was still about 217 px/s after the six fixed settle frames.
- Waiting for an actual zero velocity with a timeout gave 40/40, with the same assertions and unchanged production code.
- Lolth was largely hidden by the foreground at x=1280 and at the far-right limit near x=2998.

Request classification: IN_PLAN follow-up for validation portability, corridor visibility and publication records. B-06 scope did not expand.

### Changes

- **Controller isolation (test only).** `validate_b06_runtime.gd` suspends every joypad button and motion binding in its own process's `InputMap` for the keyboard-only route section, releases the affected actions, and restores the bindings afterwards.
  - Why a resting trigger dashed: `ensure_action()` adds actions with the default 0.2 deadzone, so a resting trigger at 0.21 presses `shadow_action`. The new metric `restored_trigger_021_dashes: true` records this with the bindings restored.
  - Device settings, production thresholds, `setup_input_actions()` and normal gameplay controls are unchanged.
  - Two new checks: a simulated 0.21 resting-trigger event is ignored while the bindings are suspended; after the restore, both bindings are back and a synthetic right trigger dashes again.
  - The synthetic controller checks in the menu suite are untouched and still pass.
- **Real stop (test only).** After releasing a movement key, `hold_until()` measures every frame until `velocity.x` is exactly zero, under a 3-second wall-clock timeout. A walk counts as done only when its condition holds after a real stop, so each assertion that used `done` now also requires the stop.
  - The continuity bounds also cover the deceleration frames. No assertion, movement bound, faulty control or baseline comparison was removed or loosened, and FPS is not forced.
  - In this Linux run, deceleration took 5–6 frames, which is why the fixed six-frame wait passed here and not on faster Windows frames.
- **Foreground readability (production, `main.gd`).** `draw_foreground_readability()` runs after `draw_foreground_overlay()` and redraws Lolth's existing pose sprite and name label at alpha `FOREGROUND_READABILITY_ALPHA` (0.72), in front of the frame overlays. It applies only:
  - while the route is open (`camera_limit_x() > 0`);
  - inside `FOREGROUND_READABILITY_SPANS`: world x 980–1460 (the Ashen Way edge tree and its seam fade) and 2700–3040 (the Stonehook ruins arch);
  - with 120-unit ramps at the inner span edges, so the effect has no pop.

  How it is drawn:
  - The pose selection moved unchanged into `player_sprite_frame()`, shared by both passes.
  - `draw_player_sprite()` gained an optional `tint` (default white). It keeps the same reflection and world-origin reset; the test-only `unshifted_reflection` fault was updated to the new signature with its intent unchanged.
  - No asset, overlay art, draw order of other layers, camera or floor changed. The closed route, the cave view, x=900 with the route open and the unoccluded foothills draw nothing extra, and cave-view parity with the pre-B-06 build stays at 0 differing pixels in all three scenarios.
- **Readability measurement (test only).** For each problem location, day and night, and each facing, the runner measures Lolth's on-screen difference with the foreground drawn. It divides that by the same difference with the foreground omitted, using the test-only `readability_fixture.gd`. The check requires at least 0.5.
  - The new faulty control `no_foreground_readability` (the pass removed, as in `ccc4fcf`) is rejected at all eight locations.
- **Evidence capture correction.** In `ccc4fcf`, the render-fault runs ran after the real runner and wrote to the same filenames. The committed `translation-left-offset-1000.png` and `translation-right-offset-1000.png` there therefore show faulty-fixture output, not the real build.
  - The real pixel metrics (0 differing pixels) and pass verdicts in that run were correct; only the saved images were replaced.
  - The earlier "Captures inspected" list also included those two images, which were not individually viewed. Faulty runs now never write evidence captures, and both images are regenerated from the real build.
- **Platform tagging.** Every `*-result.json` now records OS, architecture, Godot version, display mode and the reported render device. The records validator accepts rendered facing at 102/102 on any platform. It accepts the single known `ANTLERED HUNGER frame 1 labels/bars stay unmirrored` difference only on Linux with software OpenGL, where it reproduces on the unchanged `7e477ba` baseline.

### Follow-up validation (Linux)

Platform:
- Godot `4.7.2.stable.official.ed1daf0bf`, Linux x86_64 container.
- Rendered cases under Xvfb at 1280×720, `gl_compatibility`, device "Mesa llvmpipe (LLVM 20.1.2)".
- A scratch project copy, with no fixed FPS and wall-clock timeouts.

Command (same as before, now with one extra faulty control):

```
GODOT=<godot> B06_PROJECT=<copy> XVFB=1 node .atena/generated/2026-10-04-b06-validation/run_validation.cjs all
```

| Case | Exit | Result |
| --- | --- | --- |
| `b06-headless` | 0 | `B06_PASS: 30/30 checks` |
| `b06-runtime` | 0 | `B06_RUNTIME_PASS: 51/51 checks` (the 40 earlier checks + 2 controller-isolation + 9 readability) |
| `self-test` | 0 | B01 to B06, PLAYTESTER and `SELF_TEST_PASS` |
| `combat` | 0 | 9/9, `B05_RUNTIME_PASS` |
| `menus` | 0 | `LOCAL_CONTROLS_PASS: 33/33 checks` |
| `geometry` | 0 | `GEOMETRY_PASS: 46/46 checks` |
| `facing-headless` | 0 | `FACING_PASS: 65/65 checks` |
| `facing-normal` | 1 | 101/102, the known Linux software-OpenGL difference only |
| `normal-smoke`, `headless-smoke` | 0 | no project diagnostics |
| 8 logic faults and 3 render faults | 1 each | all rejected with named detections and no project diagnostics |

- **Walks.** Every walk settled with real zero velocity (5–6 frames) within the timeout. Each stayed monotonic, within `290 × frame time` per step, and in zone 0 on the floor.
- **Parity.** Cave-view parity and translation identity: 0 differing pixels.
- **Readability ratios** (visibility relative to unoccluded), against 0.06–0.21 with the pass removed:

  | Location | Day, right | Day, left | Night, right | Night, left |
  | --- | --- | --- | --- | --- |
  | x=1280 | 0.85 | 0.86 | 0.84 | 0.85 |
  | x=2998 | 0.72 | 0.75 | 0.73 | 0.79 |

- **Windows.** No Windows run was performed here. Atena's 102/102 rendered-facing and 40/40 diagnostic route results above are reported, not reproduced.

### New captures

All are in `.atena/generated/2026-10-04-b06-validation/`:

- `readability-{day,night}-{1280,2998}-{right,left}.png`: eight captures, each checked numerically. `readability-day-1280-left`, `readability-day-2998-right` and `readability-night-2998-left` were inspected visually; Lolth reads in front of the edge tree and the ruins arch.
- `translation-left-offset-1000.png` was inspected visually and is regenerated from the real build: Lolth, Hound, Stag, labels and bars, with both markers in place.
- The parity, route, `transition-*` and `seam-*` captures were regenerated by this run and checked numerically, not re-inspected one by one.

### Remaining limitations

- **Ghost appearance.** In the two spans Lolth appears semi-transparently in front of the overlay rather than behind it. This is a deliberate readability choice, not a final art solution.
- **Far-limit framing.** At the far limit (x=2998) Lolth stands at screen x≈1238, 42 px from the edge, as at the original Thornwake edge. Her right side is partly clipped by the screen.
- **Physical controller case.** Linux has no physical controller attached here, so the controller-isolation fix is exercised with synthetic events. The physical-trigger case is Atena's Windows observation.
- **Earlier limitations.** All earlier limitations still apply: the mirrored seam echo, offscreen danger reported only through the HUD, the Hound waiting at the border, the restore position, Linux-only reproduction here, and untuned values.

### State

- **Plan state.** `implemented-branch-published-follow-up-awaiting-review`, checkpoint `owner-review-of-follow-up-corrections`.
- **Published.** `ccc4fcf` is published on `origin/codex/b06-stonehook-foot-expedition`.
- **Local only.** Follow-up `d2012a1` and the records commit that adds this section were not pushed.
- **Not authorized.** Further push, PR, merge and dispatch remain unauthorized, and B-07 has not been started.

## Follow-up publication (`d2012a1`, `7c781ab`)

The sections above record the state before this publication and are kept unchanged as history.

- **Authority.** The owner explicitly authorized a normal push of `d2012a1` and `7c781ab` to `origin/codex/b06-stonehook-foot-expedition`. This did not cover an amend, a force-push, a change to `main`, a PR, a merge, branch deletion or B-07.
- **Pre-push check.** On the correct branch, `7c781ab` → `d2012a1` → `ccc4fcf` (the remote head), exactly two commits ahead, nothing remote-only and a clean tree.
- **Push.** A normal fast-forward moved the branch from `ccc4fcf` to `7c781ab65d75251af20880cf6e9548d1239be0dd`, confirmed with `git ls-remote`. Remote `main` stayed at `7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc`.

## Test-isolation follow-up (`b446b7b`, local)

### Atena's Windows review of `7c781ab`

**Official runs** (Godot 4.7.2, NVIDIA GTX 1650), reported by Atena and not reproduced here:

| Suite | Result |
| --- | --- |
| B-06 headless | 30/30 |
| Rendered route suite | 50/51: only the controller-isolation check failed |
| Menu suite | 32/33: only "right-click parry remains reserved and inactive" failed |
| Combat | 9/9 |
| Geometry | 46/46 |
| Facing | 65/65 headless, 102/102 rendered |
| Full self-test and both smoke runs | pass |
| 11 faulty controls | all rejected |
| 8 readability checks | all passed; Atena also inspected all eight captures visually |

**Separate Atena diagnostics**, which are not official acceptance runs:

1. Suspending controller bindings after the opening skip is too late. A `shadow_action` already in `ui_gameplay_requests` survives both the binding removal and the action release. A deterministic 0.21-trigger counterexample confirmed this.
2. Starting isolation before the opening skip gave 51/51, with every original assertion kept.
3. Filtering physical controller dispatch, while keeping synthetic controller-button dispatch, gave 33/33 in the menu suite.

Request classification: IN_PLAN, test-input isolation and publication-record reconciliation only. No production gameplay change was authorized and none was made. `main.gd` and `wagon_inventory_ui.gd` are byte-identical to `7c781ab`. The accepted foreground readability implementation is unchanged.

### Changes (test-only)

- **Route isolation starts before the first journey frame.** `start_route_game()` suspends every joypad binding immediately after `add_child()`. That is after the game's `_ready()` defines the production bindings, and before any frame runs. It used to happen after the opening skip.
- **Idempotent suspension.** `suspend_joypad_bindings()` merges into the saved set instead of clearing it. A second call during the route start keeps every binding saved by the first. A new check compares all joypad binding counts before suspension with those after `restore_joypad_bindings()`.
- **Deterministic boundary check.** `boundary_trigger()` pauses gameplay processing for one dispatch and sends a 0.21 right trigger. It then records whether `shadow_action` reached `ui_gameplay_requests`, and resumes and records whether Lolth dashed.
  - The route-start check requires: suspension active, nothing queued, no dash, and the journey state reached.
  - It replaces the earlier "resting trigger ignored" check, which tested after the boundary.
- **Live control in the official run.** A separate game instance, with live bindings and suspension applied only after the queueing, must queue and dash: `queued: true`, `dashed: true`. This proves the boundary check can detect the stale-queue failure. All bindings are then restored.
- **New faulty control.** `B06_ISOLATION_FAULT=late_isolation` runs the route start with the published ordering: isolation after the first journey frame and after a boundary trigger. It is rejected with exit 1 and the named failure "controller isolation starts before the first journey frame: a 0.21 trigger at the boundary neither queues nor performs a dash".
- **Menu suite wrapper.** `menus_regression.gd` extends the historical `validate_controls_and_menus.gd` without modifying it or its evidence.
  - It removes only joypad motion bindings (sticks and triggers, 7 in this run) from the test process's `InputMap`. This happens when the game node emits `ready`: after `_ready()` defines the bindings, before its first frame.
  - The suite sends only synthetic controller buttons (Back, X, Y), and their bindings stay in place, so all synthetic controller checks still exercise production bindings.
  - The wrapper prints `MENU_ISOLATION PASS` when applied, and `LOCAL FAIL` if not. The runner requires both `LOCAL_CONTROLS_PASS: 33/33` and `MENU_ISOLATION PASS`.
- **Unchanged.** Production controls, the 0.2 action deadzone, device settings, movement bounds, wall-clock timeouts, baseline comparisons and every existing faulty control.

### Validation (Linux, isolated copy)

- **Platform.** Godot `4.7.2.stable.official.ed1daf0bf`, Linux x86_64. Rendered cases under Xvfb at 1280×720, `gl_compatibility`, device "Mesa llvmpipe (LLVM 20.1.2)".
- **Setup.** A scratch project copy with freshly copied production files and validators, and cleared output directories. No fixed FPS.
- **Command.**

  ```
  GODOT=<godot> B06_PROJECT=<copy> XVFB=1 node .atena/generated/2026-10-04-b06-validation/run_validation.cjs all
  ```

| Case | Exit | Result |
| --- | --- | --- |
| `b06-headless` | 0 | `B06_PASS: 30/30 checks` |
| `b06-runtime` | 0 | `B06_RUNTIME_PASS: 53/53 checks` (51 earlier + the live control + repeated-suspension restore; the boundary check replaces the earlier isolation check) |
| `self-test` | 0 | B01 to B06, PLAYTESTER and `SELF_TEST_PASS` |
| `combat` | 0 | 9/9, `B05_RUNTIME_PASS` |
| `menus` (via `menus_regression.gd`) | 0 | `MENU_ISOLATION PASS` (7 motion bindings removed, button bindings kept) and `LOCAL_CONTROLS_PASS: 33/33 checks` |
| `geometry` | 0 | `GEOMETRY_PASS: 46/46 checks` |
| `facing-headless` | 0 | `FACING_PASS: 65/65 checks` |
| `facing-normal` | 1 | 101/102, the known Linux software-OpenGL difference only |
| `normal-smoke`, `headless-smoke` | 0 | no project diagnostics |
| 8 logic, 3 render and 1 isolation faulty controls | 1 each | all 12 rejected with named detections and no project diagnostics |

- **Metrics.**
  - `isolation_control`: queued true, dashed true.
  - `isolation_boundary`: queued false, dashed false.
  - `restored_trigger_021_dashes`: true. With bindings restored, 0.21 still passes the 0.2 deadzone, as recorded before.
- **Captures unchanged.** Readability ratios, parity, translation and transition results are unchanged from the previous follow-up. Faulty runs write no captures.
- **Diagnostics.** The only diagnostics are the container's missing audio device and V-Sync control.

### Remaining limitations

- **No physical controller here.** Linux has none attached, so both isolation fixes are exercised with synthetic events. Their effect on Atena's physical controller still needs an official Windows run.
- **What the menu wrapper filters.** It filters controller motion (sticks and triggers), not physical controller buttons. A physical button held down during the run could still interfere; a resting controller produces no button events.
- **Readability, not yet accepted by a human.** The semi-transparent Lolth in the two foreground spans and the clipping at the far edge (x=2998, 42 px from the screen border) remain documented limitations pending human acceptance.
- **Earlier limitations.** All the limitations listed earlier still apply.

### State

- **Plan state.** `implemented-branch-published-isolation-follow-up-awaiting-review`, checkpoint `owner-review-of-test-isolation-follow-up`.
- **Published.** `origin/codex/b06-stonehook-foot-expedition` is at `7c781ab`.
- **Local only.** Isolation follow-up `b446b7b` and the records commit that adds this section were not pushed.
- **Not authorized.** Further push, PR, merge and dispatch, and B-07 has not been started.

## Isolation publication (`b446b7b`, `9640881`)

The sections above record the state before this publication and are kept unchanged as history.

- **Authority.** The owner explicitly authorized a normal push of `b446b7b` and `9640881`. This did not cover an amend, a force-push, a change to `main`, a PR, a merge, branch deletion or B-07.
- **Pre-push check.** On the correct branch with a clean tree. `9640881` contains `b446b7b` and descends from `7c781ab`; the remote was still at `7c781ab`, with no remote-only commits.
- **Push.** A normal fast-forward moved the branch from `7c781ab` to `9640881e2c56b010fb1be93b3818f22be91d3b9c`, confirmed with `git ls-remote`. Remote `main` stayed at `7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc`.

## Combat isolation follow-up (local, test-only)

### Atena's Windows findings for `9640881`

These findings come from the owner's request. Atena's receipt `.atena/evidence/2026-10-04-b06-isolation-windows-review.md` is not in this checkout or its history, so it was not read; nothing here was reproduced by the executor.

**Official runs** (native Windows, Godot 4.7.2):

| Suite | Result |
| --- | --- |
| B-06 headless | 30/30 |
| Rendered route | 53/53 |
| Menus | 33/33 |
| Geometry | 46/46 |
| Facing | 65/65 headless, 102/102 rendered |
| Full self-test and both 600-frame smoke runs | pass |
| 12 faulty controls | all rejected |
| Historical combat validator | **8/9**, so the full runner exited 1 |

The failed combat check was the out-of-reach miss:
- Enemy health stayed at 2, Lolth's pose was `strike` and the effect was `swing`.
- The message was "Lolth needs a moment before dodging again." instead of starting with "Out of reach".

**Reviewer-only diagnostic** (not an acceptance run): it kept all nine original combat assertions and isolated joypad motion bindings immediately after the game node's `_ready`. It passed 9/9. During it, physical device 0 reported a right trigger of about 0.21958, above the unchanged 0.2 deadzone.

This points to physical-controller interference, not to a combat defect. The diagnostic does not replace the official 8/9 result.

Request classification: IN_PLAN, a narrowly scoped test-only combat isolation follow-up. No production gameplay change was authorized and none was made. `main.gd`, `wagon_inventory_ui.gd`, assets, scenes, project settings, canon, action deadzones, device settings and the historical B-05 validators are byte-identical to `9640881`. The foreground readability implementation and its documented limitations are unchanged.

### Changes (test-only)

- **`combat_regression.gd`.** It extends the unchanged historical `validate_b05_combat.gd`, following the published `menus_regression.gd` pattern.
  - **When it runs.** On the game node's `ready` signal, which is emitted synchronously inside `add_child()` after `_ready()` defines the production bindings, and before the validator's first `await process_frame`.
  - **What it removes.** Every joypad motion binding (sticks and triggers, 7 in these runs) from the test process's `InputMap`, releasing each affected action. Button bindings are kept.
  - **What it preserves.** The original nine scenarios, assertions, thresholds, input sequence and timeouts are inherited unchanged.
- **Proof that it runs before gameplay.** The wrapper's `COMBAT_ISOLATION` marker passes only when all of these hold:
  - the game's `pulse` is exactly 0. `main.gd` advances `pulse` on every processed gameplay frame, so this proves no gameplay frame has run;
  - the game state is `opening`;
  - a non-dispatching probe (`InputMap.event_is_action` on a 0.21 right-trigger event) matched `shadow_action` before isolation and no longer matches after it;
  - the button bindings (Shadow strike B, Attack X, Primary Y) are still present.

  If any condition fails, the marker reports `FAIL` and the run's failure count increases, so the process exits 1.
- **Runner.** The official `combat` case now runs the wrapper. It requires all of these:
  - exit 0;
  - `COMBAT_ISOLATION PASS`;
  - `B05_RUNTIME_PASS: 0 failures`;
  - exactly nine `RUNTIME PASS` lines;
  - no failure markers or project diagnostics.
- **Deterministic interference check and controls.** All three cases below send a synthetic 0.21 right-trigger event on every frame, emulating the reported physical trigger.
  - **`combat-noise` (positive):** the corrected wrapper must still pass 9/9.
  - **`combat-negative-missing_isolation`:** no isolation. It must fail genuine original combat assertions.
  - **`combat-negative-late_isolation`:** isolation applied only after the game's first processed frame. The timing proof must reject it.
- **Unchanged.** All 12 earlier faulty controls (8 logic, 3 render and the route `late_isolation`) and every other case are unchanged. Fault cases write into `regressions/combat-faults`, separate from the positive `regressions/combat` and `regressions/combat-noise` outputs, so they cannot overwrite positive captures.

### Validation (Linux, isolated copy)

- **Platform.** Godot `4.7.2.stable.official.ed1daf0bf`, Linux x86_64 container. Rendered cases under Xvfb at 1280×720, `gl_compatibility`, device "Mesa llvmpipe (LLVM 20.1.2)". No physical controller is attached.
- **Setup.** A fresh scratch project copy with byte-identical production files and cleared output directories. No fixed FPS.
- **Command.**

  ```
  GODOT=<godot> B06_PROJECT=<copy> XVFB=1 node .atena/generated/2026-10-04-b06-validation/run_validation.cjs all
  ```

| Case | Exit | Result |
| --- | --- | --- |
| `b06-headless` | 0 | `B06_PASS: 30/30 checks` |
| `b06-runtime` | 0 | `B06_RUNTIME_PASS: 53/53 checks` |
| `self-test` | 0 | B01 to B06, PLAYTESTER and `SELF_TEST_PASS` |
| `combat` (wrapper) | 0 | `COMBAT_ISOLATION PASS` (7 motion bindings removed; pulse 0.000, state `opening`; probe matched before, not after; buttons kept), 9 `RUNTIME PASS`, `B05_RUNTIME_PASS: 0 failures` |
| `combat-noise` | 0 | same marker, 9/9 under a 0.21 trigger every frame |
| `menus` (wrapper) | 0 | `MENU_ISOLATION PASS`, `LOCAL_CONTROLS_PASS: 33/33 checks` |
| `geometry` | 0 | `GEOMETRY_PASS: 46/46 checks` |
| `facing-headless` | 0 | `FACING_PASS: 65/65 checks` |
| `facing-normal` | 1 | 101/102, the known Linux software-OpenGL difference |
| `normal-smoke`, `headless-smoke` | 0 | 600 frames, no project diagnostics |
| 8 logic, 3 render and 1 route-isolation faulty controls | 1 each | all rejected, as before |
| `combat-negative-missing_isolation` | 1 | rejected: "RUNTIME FAIL attack at 196 px misses the stag (2 -> 2) with a distinct swing", the same out-of-reach miss check Atena saw fail on Windows |
| `combat-negative-late_isolation` | 1 | rejected: `COMBAT_ISOLATION FAIL` (pulse 0.143 at isolation, after the first processed frame) |

- **Totals.** 14 faulty controls rejected; every positive case passed except the known rendered-facing difference.
- **Missing-isolation variance.** The number of original checks this control breaks depends on how frame timing meets the dash cooldown. A development run before the final suite broke two checks: the contact hit and the out-of-reach miss. The final run broke only the out-of-reach miss. The runner requires at least one genuine original-assertion failure.
- **Rendered facing on Linux.** It stays 101/102 with exit 1 here: the single `ANTLERED HUNGER frame 1 labels/bars stay unmirrored` difference, also reproduced on the unchanged `7e477ba` baseline in this environment. The full runner therefore exits 1 on Linux for this platform-specific reason. The records validator accepts it only from Linux software OpenGL. No 102/102 result is claimed here; the Windows 102/102 is Atena's.
- **Diagnostics.** The only ones are the container's missing audio device and V-Sync control.

### Remaining limitations

- **No physical controller here.** Both combat isolation checks use synthetic trigger events. Whether the wrapper resolves the physical Windows interference needs Atena's official Windows run.
- **Buttons are not filtered.** The wrapper, like the menu wrapper, filters only controller motion; a physical controller button held during a run could still interfere.
- **Pending human acceptance.** The foreground readability appearance (semi-transparent Lolth in two spans), the far-edge clipping at x=2998, the mirrored seam echo and the other earlier camera and visual limitations all remain as documented.

### State

_Historical checkpoint (as of `9640881`, before `7de6d66` was published and reviewed); superseded by the final section below._

- **Plan state.** `implemented-branch-published-combat-isolation-follow-up-awaiting-review`, checkpoint `owner-review-of-combat-isolation-follow-up`.
- **Published.** `origin/codex/b06-stonehook-foot-expedition` was at `9640881e2c56b010fb1be93b3818f22be91d3b9c` when this section was written.
- **Local only.** This follow-up is a single local commit (wrapper, runner, fresh results and these records) and was not pushed.
- **Pending and not authorized.** Human acceptance is pending. Further push, PR, merge and dispatch remain unauthorized, and B-07 has not been started.

## Combat isolation publication, Windows review and human acceptance

**Publication.** The owner separately authorized a normal push of `7de6d66`. The feature branch `codex/b06-stonehook-foot-expedition` was fast-forwarded from `9640881` to `7de6d6658a2e8b7aea5954320ef29902094d7215`, and Atena independently confirmed the resulting remote refs. Remote `main` stayed at `7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc`. The "local" and "unpublished" wording about the combat isolation follow-up in the sections above is a dated historical checkpoint from before this publication (as of `9640881`, 2026-10-04/05); it is preserved, not rewritten.

**Official Windows review of `7de6d66` (2026-10-05).** Atena's official Windows review of `7de6d66`, performed on 2026-10-05 (external; not runs reproduced by the executor): Godot `4.7.2.stable.official.ed1daf0bf`, native Windows x64, OpenGL compatibility, 1280x720, GTX 1650, NVIDIA driver 616.92. The full official runner exited 0. B-06 headless 30/30; rendered route 53/53; combat 9/9 normally and 9/9 under continuous synthetic trigger noise; menus 33/33; geometry 46/46; facing 65/65 headless and 102/102 rendered; the full self-test and both 600-frame smoke runs passed. All 14 faulty controls were rejected with genuine exit 1 and named failures. All 25 case records were fresh Windows results, without project diagnostics or process errors. The published records validator exited 0, verifying 39 links, scoped files, preserved completed history and saved results. These are Atena's external results, supplied in the owner's request for this reconciliation. Atena's owner-local receipt `.atena/evidence/2026-10-05-b06-combat-isolation-windows-review.md` is not present in this checkout; the executor did not read it and did not copy its logs or captures. The earlier Linux results and the historical Windows combat failure at `9640881` (official combat 8/9, full runner exit 1) stay as recorded and are not overwritten by these later successes.

**Human acceptance (2026-10-05).** After Atena's Windows report and visual/camera playtest recommendation, the owner replied `aprovado`. This records overall human acceptance of the reviewed B-06 slice at `7de6d66`. No item-by-item playtest results, timings, additional engine runs or independently verified tested-build hash are inferred. All documented limitations remain: Lolth transparency in the foreground spans, far-edge clipping at x=2998, the mirrored seam echo, camera and balance tuning, overlapping labels and in-memory saves.

**State.** `implemented-published-human-accepted-awaiting-pr`: implemented, published, human accepted, awaiting a pull request. B-06 stays active; it is not merged or complete, and the plan is not cleared. `pull_request_approved`, `merge_approved` and `dispatch_approved` remain false, and B-07 has not been started.

**Documentation authorization.** The owner separately authorized one normal documentation commit and push of these operational records on this branch only. It is distinct from the completed implementation publication above. A PR, merge and any later publication remain unauthorized. The outcome of that push is reported in the executor's response, not recorded here.

## Closure: PR #6 Merged and B-06 Complete

**Pull request and merge.** The owner authorized opening only the B-06 pull request (IN_PLAN), and PR [#6](https://github.com/marizada86/the-first-nine/pull/6) was opened from `codex/b06-stonehook-foot-expedition` at `cc87e1c3d88c837e16aca8f39bf7f0870f5b1246` into `main` at `7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc`: 8 commits, 116 changed files, +4341 / -59. GitHub reported it mergeable and clean, with no reviews, comments, check runs or commit statuses. The owner then separately authorized a regular merge. It used a merge commit, not squash or rebase, with the expected head `cc87e1c3d88c837e16aca8f39bf7f0870f5b1246`, and the feature branch was kept.

- **Merge commit:** `e304badbbd15c6ce2bd93b114006dd26c0c7391e`, merged at 2026-10-05T10:37:46Z. Parents: `7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc` (previous `main`) and `cc87e1c3d88c837e16aca8f39bf7f0870f5b1246` (the PR head).
- **Verified after the merge:** remote `main` equals the merge commit; the merged tree (`0065a0d7258519fa94e77c80e22c5f4428cb8aeb`) is identical to the reviewed PR head's tree; all eight commits remain ancestors of `main`; remote `codex/b06-stonehook-foot-expedition` stays at `cc87e1c3d88c837e16aca8f39bf7f0870f5b1246`.
- **Preserved commits:** `42bddf8`, `ccc4fcf`, `d2012a1`, `7c781ab`, `b446b7b`, `9640881`, `7de6d66`, `cc87e1c`.
- **No CI claim.** The repository has no configured CI. The pull request had zero check runs and zero commit statuses before the merge, and no CI result is inferred. No new engine run was made for the PR, the merge or this closure.

**Validation distinctions, unchanged.** Atena's official Windows validation of `7de6d66` (full runner exit 0; B-06 route 53/53; combat 9/9 normally and with trigger noise; menus 33/33; geometry 46/46; facing 65/65 headless and 102/102 rendered; self-test and smoke runs passed; 14 faulty controls rejected) is external and was not reproduced by the executor. The executor's Linux/Xvfb software-OpenGL runs are separate: rendered facing there stays at 101/102, the known platform-specific difference that also reproduces on the unchanged pre-B-06 baseline. Human acceptance remains the owner's overall `aprovado` of 2026-10-05 for the reviewed slice at `7de6d66`; no item-by-item results are inferred.

**Limitations kept.** This closure fixes none of them and adds no new engine evidence: Lolth's semi-transparency in the two foreground spans, her clipping at the far edge (x=2998), the mirrored seam echo, camera and balance tuning, overlapping pickup labels, and in-memory-only saves (no disk persistence).

**Superseded checkpoints.** The "awaiting a pull request", "B-06 stays active" and "not merged" wording in the sections above is a dated historical checkpoint, preserved and not rewritten. Publication history and the Windows and Linux records above are unchanged.

**Documentary closure.** The owner authorized one documentation-only commit directly above `e304badbbd15c6ce2bd93b114006dd26c0c7391e` on `main`. It changes only operational records and adds a scoped closure validator. It touches no gameplay, asset, canon, dependency, engine test or saved engine result. Its own hash and push outcome are reported in the executor's response and are not recorded here.

**State.** `complete-implementation-merged`: B-06 is the latest completed plan, there is no active plan and the plan cursor is `complete`. B-06 added no standing push, merge or dispatch authority; `dispatch_approved` stays false.

**Next recommendation (non-authorizing).** This authorizes no work. If the owner wants to continue, a short human playtest of the merged B-01 to B-06 loop could decide whether to address the recorded visual or camera limitations, and could scope a bounded proposal for the next Stonehook step. Any B-07 needs its own proposal, approval selection and approval. B-07 has not been started.
