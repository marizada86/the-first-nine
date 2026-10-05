---
status: review-complete-validation-follow-up-and-human-review-pending
kind: external-implementation-review
created: 2026-10-04
request_classification: IN_PLAN
approval_mode: per-plan
plan: "[[2026-10-04-b06-stonehook-foot-expedition]]"
prior_review: "[[2026-10-04-b06-windows-review]]"
reviewed_branch: codex/b06-stonehook-foot-expedition
reviewed_commit: 7c781ab65d75251af20880cf6e9548d1239be0dd
follow_up_commit: d2012a1412f52d3066e4eff1216cfa9d57490acd
base_commit: 7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc
follow_up_publication_verified: true
implementation_on_main: false
human_acceptance: pending
new_push_approved: false
pull_request_approved: false
merge_approved: false
---

# B06 Follow Up Windows Review

The published follow-up improves traversal and Lolth's foreground visibility, but its unmodified Windows validation is not fully passing. The route suite returned 50/51 and the menu suite 32/33. Separate diagnostics reached 51/51 and 33/33 with earlier keyboard isolation and filtering of physical controller dispatch respectively. These diagnostics do not replace the failed official results. A narrow test-harness follow-up and human acceptance are recommended before a PR.

## Verified Checkout and Publication

The fetched feature HEAD is `7c781ab65d75251af20880cf6e9548d1239be0dd`, with parent `d2012a1412f52d3066e4eff1216cfa9d57490acd`, then `ccc4fcf69271d88e421e26a81841cf6cce834a37`, implementation `42bddf87b64eafb2046a47b1f2695df3ad9d4075` and base `7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc`. The owner authorized publication of the two follow-up commits. Remote refs were checked again at the end: the feature remains `7c781ab` and main remains `7e477ba`.

The feature records were written before the latest push, so `follow_up_published: false` and their local-only descriptions are now historical rather than current publication facts. This receipt verifies the latest publication without granting future push authority. The feature records still need a separately authorized reconciliation. Their own structural validator passed 33 links, contract checks, exact completed-history preservation and saved Linux results before diagnostic work.

The original local checkout stayed on main at `7e477ba`. Its active-plan record was not rewritten to imply that the feature implementation is integrated. This receipt and its generated outputs are local review artifacts, not a commit or publication.

## Windows Execution

Execution used a new detached shared clone, not the main checkout:

`C:/Users/gui-m/AppData/Local/Temp/atena-b06-followup-windows-ad732e923be54a078a0479175f04c8e5`

Godot was `D:/Godot/godot.exe`, version `4.7.2.stable.official.ed1daf0bf`. Rendered tests used native Windows x64, OpenGL compatibility, 1280x720, NVIDIA GeForce GTX 1650, driver 616.92. No fixed FPS, production-input threshold, controller-device setting, production file or committed test assertion was changed.

The published command was run from the scratch project:

```text
rtk proxy node .atena/generated/2026-10-04-b06-validation/run_validation.cjs all
```

The overall runner exited 1. All 21 per-case records are tagged `win32`; no case reported project diagnostics. Initial sandboxed editor preparation emitted permission errors for Godot user-data/configuration directories. Preparation was rerun with the necessary local execution permission and exited 0; this was an environment preparation issue, not an acceptance run. Git's exact temporary-copy ownership exception was process-scoped, with no global configuration edit.

| Official Windows case | Actual result | Exit |
| --- | --- | --- |
| B06 headless | 30/30 | 0 |
| B06 rendered route | 50/51; initial controller-isolation check failed | 1 |
| Full self-test | B01 through B06, playtester and overall pass | 0 |
| Combat | 9/9 | 0 |
| Menus | 32/33; inactive right-click/parry check failed | 1 |
| Geometry | 46/46 | 0 |
| Headless enemy facing | 65/65 | 0 |
| Rendered enemy facing | 102/102 | 0 |
| Normal and headless 600-frame smoke | Both pass | 0 each |
| Eight logic fault controls | All rejected with named failures | 1 each |
| Three render fault controls | All rejected with named failures | 1 each |

The known Linux software-renderer facing difference did not reproduce on Windows. No acceptance threshold was relaxed to achieve 102/102.

The official route's outward and return movement, ore collection/deposit, remote hub restrictions, offscreen Stag damage, defeat/restore and camera-offset combat all passed. Every walk reached a real stopped state, with 21 measured deceleration frames on this run and maximum step ratios of 1.000. Cave parity in day, night and secured scenarios, and left/right translation identity, each measured zero differing pixels. The secured parity comparison preserves its existing exclusion for the newly added route signpost. Ten transition captures retained fixed HUD title pixels.

## Input Isolation Findings

The official failure was:

`B06RT FAIL controller bindings are suspended for the keyboard-only route section (resting trigger 0.21 ignored)`

The committed runner instantiates the game, waits a frame and skips the opening before suspending joypad bindings. The game queues `shadow_action` in `ui_gameplay_requests` and processes that queue separately. Removing bindings and releasing Input actions does not clear a request already queued while the opening was being skipped.

A review-only probe exercised both isolation boundaries and a deterministic queued-event counterexample. A late natural trial happened to pass, showing the timing dependence. Early isolation also passed. Injecting a 0.21 trigger just before late isolation produced `requests=["shadow_action"]`; the queue remained after suspension despite `Input.is_action_pressed("shadow_action") == false`, and the subsequent observation saw a dash. This directly establishes the stale-request mechanism. It does not prove the exact event timing of the earlier official failure, whose queue was not instrumented.

`windows_runtime_early_isolation.gd` inherits all 51 original checks and moves suspension before the Escape skip. Its idempotent suspension preserves the bindings for the original restoration check. The separate diagnostic runner returned 51/51, exit 0. The published route result remains 50/51, exit 1; it was not overwritten.

The official menu failure was:

`LOCAL FAIL right-click parry remains reserved and inactive`

An attached controller can still dispatch dashes during this unisolated older suite. In a review-only subclass, physical joypad dispatch was consumed while the original synthetic button dispatch was explicitly preserved and flushed. All 33 original checks then passed, including controller inventory, Wagon access, attacks, collection and inactive right-click. This supports input interference rather than demonstrating an implemented parry or a new production regression. It is a diagnostic result, not an unmodified menu-suite pass or proof that all possible input interactions are covered.

The isolation probe intentionally returns exit 0 after printing its counterexample verdicts; its `2/3` total is not an acceptance pass. Diagnostic setup mistakes (one missing GDScript type annotation and initial filter attempts that also blocked synthetic menu events) were corrected before the retained final diagnostic runs. Those preliminary attempts are not counted as accepted validations. Production code and official suite outputs stayed unchanged.

## Foreground Visibility

All eight official readability checks passed. Atena individually inspected all eight fresh Windows PNGs: x=1280 and x=2998, day/night, facing left/right. Lolth is visibly drawn in front of the previously occluding tree and ruins arch. This fixes the observed disappearance in these poses, with the intended semitransparent appearance; it is not human acceptance of final art or an exhaustive check of every animated pose.

| Position | Day right | Day left | Night right | Night left |
| --- | --- | --- | --- | --- |
| x=1280 | 0.848 | 0.867 | 0.838 | 0.847 |
| x=2998 | 0.718 | 0.752 | 0.736 | 0.792 |

Values are the measured visibility ratio against the same frame without foreground overlays, not subjective quality ratings. Removing the readability pass failed all eight checks, with ratios 0.06 to 0.21. The new pass is confined to the named spans while the route is open; its scope check, cave parity and transform tests passed.

The partial sprite clipping at the far screen edge remains. The original mirrored seam echo, overlapping salvage labels, in-memory save limitation, camera/tuning decisions and deferred later progression remain unchanged. No second cure, Mark II, wagon travel, parry, new Stonehook combat, new art, audio or dependency was admitted.

## Evidence and Boundaries

Fresh results are retained under `.atena/generated/2026-10-04-b06-followup-windows-review/`, separate from both the earlier Windows review and committed Linux evidence. The root contains the official per-case JSON/logs and `runtime-metrics.json`; `captures/` contains 32 images from the official positive Windows route run, including the eight visually inspected images. The copied `facing-normal-baseline-7e477ba.log` is the committed historical Linux fixture, not a fresh Windows baseline test. The render-fault paths no longer save captures, so they do not overwrite the official positive images.

`diagnostics/` contains the review-only sources, final logs and separate early-isolation result/metrics. These diagnostics exist only in the scratch copy and review output directory. They are not production changes or delivery of a fix. The review validator records source identity, exact result expectations, ADD links and file hashes in `review-manifest.json`. It validates the review receipt, not a clean all-suite acceptance pass, a whole-file YAML parse, CI or a sealed GPU benchmark.

The game-visual-debugging skill guided equivalent captures and measurement boundaries. No `.game-dev/adapter.json` exists, so its sealed adapter workflow was unavailable; existing game-owned Godot runners were used without installation. The write-page skill guided this standalone English local review and separation of findings, diagnostics and recommendations. Established `.atena/` format and destination take precedence; no external Page was created.

## Recommended Follow Up

Before a PR, return a narrow IN_PLAN validation follow-up to Claude: suspend keyboard-test controller bindings before the first journey frame, preserve restored synthetic-controller checks, and protect the menu regression's keyboard/mouse sections from physical device dispatch without disabling its synthetic controller assertions. Keep the original assertions, timeouts, negative controls, ordinary game bindings, device settings and production thresholds intact. Include a fault/control that detects a stale queued dash at the isolation boundary. Reconcile the latest authorized publication at `7c781ab` and distinguish the two official Windows failures from passing diagnostics.

No additional production visibility change is established as necessary by this review. The owner still needs to accept the semitransparent readability choice and camera framing. Revalidate the actual corrected published suite on Windows rather than treating the local diagnostic subclasses as delivery.

This recommendation grants no new code execution to Atena, push, PR, merge, branch deletion or B07 authority. No commit, push, PR or merge was performed. Main's tracked files and prior review artifacts are unchanged; only the separate local review receipt and its generated evidence were added.
