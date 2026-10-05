---
status: implemented-awaiting-human-review
kind: implementation-evidence
created: 2026-10-05
plan_id: 2026-10-05-b08-stonehook-cliff-harrier
spec: "[[2026-10-05-b08-stonehook-cliff-harrier]]"
evidence: "[[2026-10-05-b08-stonehook-cliff-harrier]]"
instruction: "[[2026-10-05-b08-stonehook-cliff-harrier-instruction]]"
origin: planned
implementation_preceded_spec: false
approval_mode: per-plan
request_execution_classification: IN_PLAN
implementation_approved: true
baseline_commit: 4d3c5c1ae5411aaf58e6fd7ae8333e45ecef7ac1
implementation_branch: codex/b08-stonehook-cliff-harrier
engine_rerun: true
human_acceptance: pending
push_approved: false
pull_request_approved: false
merge_approved: false
dispatch_approved: false
---

# B08 Cliff Harrier Implementation

Executor record for S-001 to S-003 of [[2026-10-05-b08-stonehook-cliff-harrier]], following [[2026-10-05-b08-stonehook-cliff-harrier-instruction]]. All engine results below are the executor's own Linux runs on 2026-10-05. The Windows results quoted for B-07 in [[2026-10-05-b07-windows-review]] are Atena's externally reported evidence, not runs by the executor. No Windows, CI or human result is claimed for B-08.

## Starting point verification

The checkout started on `codex/b07-stonehook-first-encounter` at `4da953c` with a clean tree. Origin was fetched without overwriting anything; `origin/main` is `4d3c5c1ae5411aaf58e6fd7ae8333e45ecef7ac1`. The B-07 implementation (`4da953c`), acceptance records (`523421e`), PR #7 regular merge (`2684dac`) and closure (`4d3c5c1`) are all ancestors of it, and the plan state recorded B-07 as complete with no active plan. `codex/b08-stonehook-cliff-harrier` did not exist and was created from `origin/main` with no upstream. Existing branches and local `main` were left untouched.

## Implemented behavior

Only `main.gd` changed in production.

- **Activation.** `stonehook_cliff_harrier_01` is created from the legitimate expedition gate once Lolth first reaches x >= 2600, by day or night. In the real-input run it appeared at Lolth x=2603.5 and never before 2600. It is never created in a new run, the tutorial, an unsecured camp or under an F4 Mark override. Border and threshold oscillation, nightfall and dawn keep both actors and their health.
- **Independent state.** The Harrier lives in its own `cliff_harrier` dictionary with its own `harrier_activated`, `harrier_defeated` and `harrier_reward_paid` flags, separate from the crawler's and from the cave `shades`. Killing either never alters the other.
- **Artwork and geometry.** It uses only the upper-right bird, `Rect2(768, 0, 768, 497)`, at native aspect, with wings and claws. Its alpha bounds `(37, 8, 613, 488)` are scanned once in `_ready` with the existing threshold, into the shared encounter cache but with a separate scan counter. The B-07 crawler counter, the 22-cell atlas cache and their assertions are unchanged. The visible body is 138.2 x 110 px, and the claws hover 30 px above the floor. Its world position is the displayed anchor, so existing targeting follows the displayed bird.
- **Targeting.** Grounded melee and First Thread reach it without a jump. Melee reach is the existing body rule (44 + 69.1 = 113.1) and the 70 px vertical band is unchanged. A raised bird (120 px) is out of reach until it descends. The nearest eligible target is chosen across both actors and the cave threats. First Thread range, damage and cooldown are unchanged and no global reach was enlarged.
- **Flight and attack.**
  - It hovers with a bob of at most 6 px.
  - It approaches at 70, backs off at 45 inside 100 units, and starts a windup at 170 or less.
  - The 0.8 s windup locks the target point and direction and shows a ground strip, a target mark and a `DIVE!` label above the foreground.
  - The 0.3 s dive moves toward the locked point at no more than 220/s, never past it, and total travel never exceeds speed times duration.
  - Recovery lasts 1.2 s.
  - A dive lands at most once, through the existing `hurt_lolth()` (one point). Dash invulnerability and hurt cooldown are honored, and there is no idle contact damage.
- **Bounds.** The body stays inside the clear patrol 2400-2860 (centre limits 2469.1-2790.9). It never follows Lolth into the cave, never attacks the Wagon, and a pending windup or dive is cancelled when Lolth leaves the foothills.
- **Rewards and restoration.**
  - A credited defeat pays one Echo once under the unchanged cap.
  - The safe snapshot and checkpoint save both flag sets with Echoes and ore. Failure rolls unsaved defeats and rewards back together, and saved defeats stay defeated.
  - A saved undefeated actor is recreated once at initial health on its own legitimate re-entry. All four combinations (neither, crawler only, Harrier only, both) are tested.
  - F4 deep-restores both live actors, timers, positions, facings and flags. A new run clears every added field.
- **Coexistence.** Cave waves, wave completion, dawn and the safe-capture scan neither erase nor count either foothill actor. A real Stag still damages the Wagon, ore collection and deposit stay independent of both kills, and an unsafe cave is never made safe.

## Tuning adjustments and decisions for review

- **Attack initiation 170, not 180.** Body reach (113.1) plus the longest dive (220 x 0.3 = 66) is 179.1, so a dive started at 180 could never connect. Windup now begins at 170, giving a 9-unit margin. This was recorded in the spec before implementation.
- **Dive dip 18 px.** During the dive the bird sinks 18 px (30 down to 12) and rises again, so the dive reads as a swoop. This is cosmetic: the bird never touches the floor and stays inside grounded reach. It is an addition beyond the proposed defaults.
- **Dive travel cap.** Each dive step is limited by the time actually left. This guards against a float remainder adding one extra frame (about 3.7 units) beyond speed times duration, so total travel stays within 66. It was added together with a test-fixture fix during the same debugging step, so I did not isolate which of the two cleared an earlier failure of the windup check. A 16 fps sub-case of the single-hit check covers the frame-rate dependency as B-07 did.
- **Home and patrol.** Home 2760 and patrol 2400-2860 were used as proposed. The patrol is nearly all inside the clear foreground span; the foreground still covers x of about 2880-3040, beyond the Harrier's reach.
- **Shared fixture.** `reach_expedition_ready_for_test(with_encounter := false, with_harrier := false)` marks each encounter that is left out as already resolved (activated and defeated, no Echo paid). The unchanged B-06 and B-07 suites therefore keep their original meaning beside the new actor; only B-08 passes `true, true`. No historical validator or assertion was edited or weakened.
- **Test robustness.** The B-08 headless validator reports every expected assertion by name and treats a missing name or an unloadable script as a failure, so a parse or import crash can never count as a rejection (`B08_LOAD_FAIL`). A first run did hang on a parse error; the validator now quits with exit 2 in that case.

## Validation

Platform: Linux x64, Godot `4.7.2.stable.official.ed1daf0bf`, Xvfb with Mesa llvmpipe (OpenGL 4.5 compatibility) for rendered cases, 1280x720, no fixed FPS. Command, run in a scratch copy of the working tree with outputs copied back:

`GODOT=<Godot_v4.7.2-stable_linux.x86_64> XVFB=1 B08_PROJECT=<scratch copy> B08_GIT_CWD=<checkout> node .atena/generated/2026-10-05-b08-validation/run_validation.cjs all`

Logs, `*-result.json` records, metrics and captures are in `.atena/generated/2026-10-05-b08-validation/`. Regression suites keep metrics JSON only, not duplicate PNGs. Environment diagnostics were V-Sync, ALSA and dummy audio only; no case reported a project diagnostic.

| Case | Exit | Result |
| --- | --- | --- |
| b08-headless | 0 | B08_PASS 34/34 named checks |
| b08-runtime (rendered, real input) | 0 | B08_RUNTIME_PASS 33/33 |
| self-test | 0 | B01-B08, playtester, `SELF_TEST_PASS` |
| b07-headless / b07-runtime | 0 / 0 | 24/24 / 28/28, unchanged B-07 scripts |
| b06-headless / b06-runtime | 0 / 0 | 30/30 / 53/53, unchanged B-06 scripts |
| combat / combat-noise | 0 / 0 | 9/9 each via the unchanged B-06 isolation wrapper |
| menus | 0 | 33/33, menu isolation pass |
| geometry | 0 | 46/46 via a B-08 output-only wrapper |
| facing-headless | 0 | 65/65 via a B-08 output-only wrapper |
| facing-normal | 1 | 101/102: the known Linux software-OpenGL label/bar difference, identical on the unchanged `4d3c5c1` build (`facing-normal-baseline-4d3c5c1.log`) |
| normal-smoke / headless-smoke | 0 / 0 | 600 frames each |

The runner requires each faulty control to exit 1 with its own named assertion and no script, parse or import error. All 11 passed:

| Faulty control | Named assertion |
| --- | --- |
| wrong artwork | `harrier_geometry_crop` |
| unreachable flight | `harrier_reachable_in_live_flight` |
| late bounds preparation | `harrier_bounds_ready_before_first_frame` |
| retargeting | `harrier_windup_locks_target` |
| repeated damage | `harrier_single_hit_per_dive` |
| boundary escape | `harrier_stays_in_bounds` |
| shared defeat/reward state | `independent_defeat_and_reward` |
| duplicate reward | `independent_defeat_and_reward` |
| incomplete failure rollback | `save_combo_neither` |
| incomplete F4 restore | `f4_restores_both_exactly` |
| duplicate Harrier spawn | `harrier_activation_at_2600` |

Two controls were first caught only by incidental assertions (unreachable flight, shared defeat state). I strengthened the tests (live-flight reach at eight bob phases, a Harrier-first kill) so that the named assertion catches them, and re-ran.

The headless suite covers activation and locked contexts, oscillation and day changes, the crop and hover limits, grounded melee and First Thread hit and miss, vertical reach, nearest eligible target, both facings, approach and retreat speeds, locked-aim windups, single-hit dives at 60 and 16 fps, dash, idle contact, bounds, cancellation outside the foothills, simultaneous combat, independent rewards under the cap, cave waves with real Stag damage, safe capture, ore, the four saved combinations with unsaved rollback and single re-creation, F4 restoration and new-run reset.

The rendered real-input fixture covers the following.

**Controller isolation**
- Joypad bindings were removed right after `_ready` (pulse 0, state `opening`, engine frame 0); the first gameplay frame was frame 1.
- Separate 0.21 trigger and 0.35 stick noise neither dashed, queued nor moved Lolth.
- With restored bindings, the controller X attack hit the Harrier and the right trigger dashed.

**Real-input play**
- Settled D walks created the crawler near the border and the Harrier only at x>=2600.
- Left-click hit and miss (14 px outside reach) and C First Thread hit and miss on the hovering bird, from the ground under a view offset of about 1500 px.
- A DIVE! warning toward the locked point; walking with D during the windup did not retarget.
- Shift dash spent a dive without damage. An unavoided dive wounded exactly once.
- A simultaneous exchange where both actors struck in the same frame window, one wound each.
- An ore pickup, a safe capture and a deposit with both actors alive.
- A retreat with A from a windup took no damage, and the Harrier stayed at its patrol bound (x=2469.1). The same actor was found on return.
- A real F4 round trip through the panel (open, Mark up, restore) restored both actors exactly.
- Two real credited defeats paid one Echo each.

**Measurements**
- Four frozen views (day/night, both facings): zero changed pixels in the transparent padding, claws at row 524 (expected 525), body centered on its world x, and mirror overlap 0.998.
- The windup warning changed 1897 strip pixels and 266 label pixels.
- The crop caches stayed at 1 crawler scan, 1 Harrier scan and 22 atlas scans.

I inspected the twelve captures (`harrier-day-left/right`, `harrier-night-left/right`, `harrier-windup`, `harrier-hit`, `harrier-miss`, `harrier-retreat`, `harrier-recovery`, `both-actors-day`, `both-actors-night`, `both-actors-fight`). The bird renders cleanly from its own crop with wings and claws, correctly mirrored, with a visible hover gap under it. The windup warning and target mark sit above the foreground, the hit tint is visible, and the flanking frames show Lolth between the Harrier and the crawler.

## Acceptance comparison

1. **One legitimate Harrier at x>=2600; locked contexts; oscillation and days:** met, headless and with real input.
2. **Own crop, wings and claws, native aspect, hover and bob, readable day/night and both facings; bounds cached before gameplay:** met in the Linux captures and metrics; human visual review is still required.
3. **Grounded melee and First Thread hit/miss, vertical reach and nearest target:** met.
4. **Locked-aim warning, dash, single-hit dive, no idle damage, bounds and cancellation:** met.
5. **Independent rewards under the cap, simultaneous combat, cave coexistence, ore:** met.
6. **Four saved combinations, unsaved rollback, F4 restore (headless and real panel input) and new-run reset:** met. New-run reset and the four combinations are headless checks, not rendered.
7. **Historical suites and faulty controls:** met. The only non-pass is the reproduced Linux facing difference; no historical file changed.

Overall acceptance requires human review.

## Limitations and review steps

- Linux software rendering only. Official Windows validation (`D:/Godot/godot.exe`, including rendered facing 102/102) and an owner playtest are still needed.
- Balance is unreviewed: health, timings, the 170 initiation distance, the dive dip, the patrol span and how often the pair damages Lolth in a mixed fight.
- The bird is one static frame: no wing animation, only hover bob, facing, tint and the procedural warning.
- The two actors have no separation logic and can overlap when both close on Lolth (see `both-actors-fight`); their name labels and bars then overlap as well. Existing label overlap with the Iron Ore prop remains.
- Existing B-06 limitations remain: foreground occlusion at the span ends and in-memory saves.
- Suggested review: play with F4 off from a new run through the first cure and expedition. Walk to the ore, fight each actor alone and together, dash a dive, retreat mid-windup, fail once and compare against the captures.
