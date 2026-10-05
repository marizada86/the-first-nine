---
status: implemented-published-human-accepted-awaiting-merge
kind: implementation-evidence
created: 2026-10-05
plan_id: 2026-10-05-b07-stonehook-first-encounter
spec: "[[2026-10-05-b07-stonehook-first-encounter]]"
evidence: "[[2026-10-05-b07-stonehook-first-encounter]]"
instruction: "[[2026-10-05-b07-stonehook-first-encounter-instruction]]"
origin: planned
implementation_preceded_spec: false
approval_mode: per-plan
request_execution_classification: IN_PLAN
implementation_approved: true
documentation_published: true
delivery_commit: fcc98b63e1919c54b6df563c8de0c7173a7affcb
delivery_verified: true
implementation_branch: codex/b07-stonehook-first-encounter
implementation_base: fcc98b63e1919c54b6df563c8de0c7173a7affcb
engine_rerun: true
human_acceptance: accepted
push_approved: true
pull_request_approved: true
merge_approved: true
dispatch_approved: false
human_acceptance_date: 2026-10-05
implementation_commit: 4da953cd34469b8024eb2d3831ba7c8ae06cb34a
implementation_published: true
windows_review: "[[2026-10-05-b07-windows-review]]"
---

# B07 First Stonehook Encounter Implementation

Executor record for S-001 to S-003 of [[2026-10-05-b07-stonehook-first-encounter]], following [[2026-10-05-b07-stonehook-first-encounter-instruction]]. All engine results below are the executor's own Linux runs on 2026-10-05. No Windows, CI or human result is claimed. The preceding slice remains as accepted in [[2026-10-05-b06-integrated-human-acceptance]].

## Delivery verification

The checkout started on `main` at `e189184`, with no tracked edits. Origin was fetched without resets. `origin/main` equals the supplied `fcc98b63e1919c54b6df563c8de0c7173a7affcb`, whose parent is `e189184e1928efca8172ce4a9c65996be81c206a`. Local `main` was then fast-forwarded to it, so it holds no local commits of its own. The committed `.atena/generated/2026-10-05-b07-delivery/validate_delivery.cjs` passed (8 package files, 22 resolved links). `codex/b07-stonehook-first-encounter` did not exist locally or remotely. It was created at `fcc98b6`. The package's `publication_snapshot: pre-push` and false publication fields described the earlier checkpoint; the local delivery checkpoint was cleared without another publication commit. That dated delivery checker and the earlier preparation and approval checkers intentionally describe their own checkpoints and are preserved unchanged.

## Implemented behavior

Only `main.gd` changed in production.

- **Encounter.** One actor, `stonehook_scree_crawler_01`, is created on legitimate foothill entry (`x >= 1760` with the B-06 departure gate). It is never created in a new run, the tutorial, an unsecured camp or an F4 Mark override, and works by day and night. The actor lives in its own `scree_crawler` dictionary, not in the cave `shades` list. Cave waves, wave completion, dawn cleanup and enemy clears therefore neither erase nor count it, and offscreen cave attacks keep their real Wagon damage. `zone` stays 0 and `enter_stonehook()` is untouched.
- **Geometry.** The source is the upper-left crawler crop `(0, 0, 768, 480)` of the existing Stonehook atlas; no other cell is drawn. Native aspect is kept and the alpha body is 120 px tall with grounded feet. The crop's alpha bounds `(84, 59, 622, 414)` are scanned once in `_ready` with the existing threshold. They live in a separate `ui_encounter_bounds` cache, so the historical 22-cell cache and its scan counter are unchanged. Melee reach (44 + body half width, 134.1 px) and First Thread both use that body. First Thread keeps its 150 px range, 2 damage and cooldown.
- **Attacks.** The cycle is approach (48/s), locked-direction windup (0.7 s) with a ground strip, arrow and `LUNGE!` label drawn above the foreground, a 0.25 s lunge at 180/s, then 1.0 s recovery. One strike lands at most once, through the existing `hurt_lolth()`. Dash invulnerability and hurt cooldown are honored, and a dash through the lunge spends it. The crawler never targets the Wagon. It ignores Lolth outside the foothills, cancels a windup when she leaves them and keeps its full body inside its patrol span.
- **Rewards.** A credited defeat pays one Shadow Echo once, under the unchanged cap; the defeat and reward flags prevent a second payment. No Mark II, cure, travel or recipe unlock follows. The ore stays independent of the kill.
- **Restoration.**
  - The safe-Wagon snapshot and checkpoint record `activated`, `defeated` and `reward_paid`. Failure restores them together with Echoes and ore, and transient actors are cleared as before.
  - A saved undefeated encounter is re-created once, at initial health, on the next legitimate visit; a saved defeat stays defeated.
  - Ordinary retreat and day changes keep the same actor and its health.
  - F4 deep-copies the live actor, timers and flags. A new run clears every added field.

## Implementation decisions for review

- **Patrol and home position.** At 1280x720 the existing foothill foreground overlay is nearly opaque over the floor band from x≈1800 to 2200 and from 2880 to 3040, measured from the overlay's alpha. There it hid the crawler, and Lolth at the left bound (an existing B-06 limitation). Without editing the foreground (out of scope), the crawler now patrols a clear span, `SCREE_CRAWLER_PATROL = 2400-2860`, inside the foothill region, with home x=2520 instead of the proposed 2340. Lolth therefore stands in the clear whenever a lunge can be triggered from the left. These are scoped changes to the spec's proposed playtest defaults, tested below.
- **"12-health" wording.** The spec's "one 12-health hit per strike" has no counterpart in the 3-health model, where the existing hurt removes 1. Each landed strike calls the existing `hurt_lolth()` once (1 of 3 health); no new damage scale was invented.
- **Lunge contact order.** A rendered run at about 20 fps once missed a standing Lolth, because contact was tested before each frame's motion and the final lunge frame went unchecked. Contact is now tested after the motion. A deterministic 16 fps sub-case in `single_hit_per_strike` fails with the old ordering and passes with the fix.
- **B-06 fixture adaptation.** `reach_expedition_ready_for_test(with_encounter := false)` marks the encounter already resolved (activated and defeated, no Echo paid) before the safe capture. The unchanged B-06 headless, route and runtime suites therefore keep their pre-B-07 meaning; only B-07 checks pass `true`. No historical validator or assertion was edited or weakened.
- **Test robustness.** `ensure_crawler_for_test` lets a fault that erases the actor fail a named assertion (and `section_fixtures_ready`) instead of crashing later sections. The helpers never write into an empty actor.

## Validation

Platform: Linux x64, Godot `4.7.2.stable.official.ed1daf0bf`, Xvfb with Mesa llvmpipe (OpenGL 4.5 compatibility) for rendered cases, 1280x720 and no fixed FPS. Command, run in a scratch copy of the working tree with outputs copied back:

`GODOT=<Godot_v4.7.2-stable_linux.x86_64> XVFB=1 B07_PROJECT=<scratch copy> B07_GIT_CWD=<checkout> node .atena/generated/2026-10-05-b07-validation/run_validation.cjs all`

Logs, `*-result.json` records and captures are in `.atena/generated/2026-10-05-b07-validation/`. Following the B-06 precedent, regression suites keep metrics JSON only, not duplicate PNGs. Environment diagnostics were V-Sync, ALSA and dummy audio only; there were no project diagnostics in any case.

| Case | Exit | Result |
| --- | --- | --- |
| b07-headless | 0 | B07_PASS 24/24 named checks |
| b07-runtime (rendered, real input) | 0 | B07_RUNTIME_PASS 28/28 |
| self-test | 0 | B01-B07, playtester, `SELF_TEST_PASS` (B06 30, B07 24) |
| b06-headless / b06-runtime | 0 / 0 | 30/30 / 53/53, unchanged B-06 scripts |
| combat / combat-noise | 0 / 0 | 9/9 each via the unchanged B-06 isolation wrapper |
| menus | 0 | 33/33, menu isolation pass |
| geometry | 0 | 46/46 via a B-07 output-only wrapper |
| facing-headless | 0 | 65/65 via a B-07 output-only wrapper |
| facing-normal | 1 | 101/102: the known Linux software-OpenGL label/bar difference, reproduced identically on unchanged `fcc98b6` (`facing-normal-baseline-fcc98b6.log`) |
| normal-smoke / headless-smoke | 0 / 0 | 600 frames each |

The runner requires each of the 11 faulty controls to exit 1 with its own named assertion and no script, parse or import error:

| Faulty control | Named assertion |
| --- | --- |
| duplicate spawn | `legit_entry_spawns_one` |
| wrong frame | `geometry_crawler_crop` |
| wrong reach | `reach_matches_body` |
| no warning | `windup_precedes_strike` |
| repeated strike damage | `single_hit_per_strike` |
| cross-region pursuit | `crawler_stays_in_foothills` |
| cave-wave erasure | `crawler_does_not_stall_waves` |
| safe-capture confusion | `safe_capture_with_live_crawler` |
| repeated reward | `reward_once_within_cap` |
| incomplete failure rollback | `failure_rolls_back_together` |
| incomplete F4 restore | `f4_exact_restore` |

All 11 were rejected this way.

The runtime fixture covers the following.

**Controller isolation**
- Joypad bindings are removed right after `_ready` (pulse 0, state `opening`, engine frame 0); the first gameplay frame is engine frame 1.
- Separate 0.21 trigger and 0.35 stick noise neither dashes, queues nor moves Lolth.
- A controller section with restored bindings: X attack hits and the right trigger dashes.

**Real-input play**
- Settled D walks into the foothills create exactly one crawler.
- Left-click: hit inside reach and miss 14 px outside, with no hurt pose.
- C: First Thread hit and miss.
- Shift: a dash spends a lunge without damage.
- An unavoided lunge wounds exactly once.
- A retreat with A from inside a windup takes no damage, and the crawler stays at its bound.
- A return to the cave Wagon makes a safe capture with the live crawler, and a revisit finds the same actor with its health.
- A D/E/A run takes the ore past the live crawler. In this run it cost one hit (2/3 health).
- A credited defeat pays one Echo once, and revisits do not respawn it.

**Measurements**
- Four frozen views (day/night × facing left/right): no changed pixel in the transparent padding, body centered on its world x under a 1410 px view offset, lowest row at the floor, mirror overlap 0.99.
- The windup warning changes 1130 strip and 362 label pixels.
- The crop cache stays at 1 encounter scan and 22 atlas scans.

I inspected all eight captures (`crawler-day-left/right`, `crawler-night-left/right`, `crawler-windup`, `crawler-hit`, `crawler-miss`, `crawler-retreat`). They show only the crawler artwork, without the staff, other creatures or opaque cell. Its feet are grounded and the facing is readable both ways in day and night tint. The health bar is correct, the hit flash and `LUNGE!` warning are visible, and in the retreat frame Lolth is visibly moving away during the windup.

## Acceptance comparison

1. **Legitimate single spawn, locked contexts, oscillation/day persistence:** met, both headless and with real input.
2. **Readable sprite, feet, warning, facing and bar in day/night and both facings; no foreign cell; cached bounds:** met in the Linux captures and metrics, using the clear patrol span. Human visual review is still required.
3. **Hit/miss, First Thread, windup, dash, single hit, no manufactured hurt pose:** met, including the frame-rate fix.
4. **Retreat, no reach into the cave, valid capture, offscreen Stag damage:** met.
5. **One capped Echo, no progression unlock, ore independent:** met.
6. **Rollback together, saved defeat kept, single re-creation, F4 and new-run reset:** met in the headless checks; F4 is checked headless only.
7. **Historical suites keep their intent:** met. The only non-pass is the reproduced Linux facing difference, and no historical file was changed.

Overall acceptance requires human review.

## Limitations and review steps

- Linux software rendering only. Official Windows validation by Atena (`D:/Godot/godot.exe`) and an owner playtest are still needed, including the facing 102/102 check.
- Balance is unreviewed: crawler health, timings, the patrol span, the home x and the one-hit cost of an ore run are playtest defaults.
- Existing B-06 limitations remain:
  - Lolth is still hidden by the foreground at x≈1800-2200 outside combat.
  - Labels overlap at close range: in the hit capture, the crawler's name sits under Lolth's raised arm and swing trail.
  - The Iron Ore prop sits behind the crawler's rear at its home position.
  - Saves remain in memory only.
- There is no new animation art. The crawler is one static frame with facing, tint and procedural warning.
- Recommended review: play with F4 off from a new run through the first cure and expedition. Fight, dash, retreat at night and fail once, comparing against the captures listed above.

## Publication Review and Owner Acceptance

The previously local-only implementation checkpoint is superseded by the verified publication of `4da953cd34469b8024eb2d3831ba7c8ae06cb34a` on `origin/codex/b07-stonehook-first-encounter`. Earlier sections remain dated implementation history.

Fresh Atena Windows review of 4da953c: Godot 4.7.2, GTX 1650, full runner exit 0; B07 24/24 and real-input 28/28; B06 30/30 and 53/53; combat/noise 9/9 each; menus 33/33; geometry 46/46; facing 65/65 and 102/102; self-test and both 600-frame smoke passes; 11 faulty controls genuinely rejected, zero project diagnostics; eight fresh captures inspected.

Owner replied "aceito, borah" after the Windows technical report, accepting B-07 with its listed limitations and explicitly authorizing record publication, PR opening, regular merge, operational closure and B-08 proposal preparation only. No itemized owner playtest or B-08 implementation approval is inferred.

The accepted limitations are static art, unreviewed balance, foreground occlusion, overlapping labels/ore and in-memory saves; F4 encounter restore was headless-tested. No new executor Linux run or CI result is claimed. Opening and merging the PR are authorized but have not occurred at this records checkpoint. B-08 remains an inactive preparation-only proposal.
