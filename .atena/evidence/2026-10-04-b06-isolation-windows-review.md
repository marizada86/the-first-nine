---
status: review-complete-combat-validation-follow-up-and-human-review-pending
kind: external-implementation-review
created: 2026-10-04
request_classification: IN_PLAN
approval_mode: per-plan
plan: "[[2026-10-04-b06-stonehook-foot-expedition]]"
prior_review: "[[2026-10-04-b06-followup-windows-review]]"
reviewed_branch: codex/b06-stonehook-foot-expedition
reviewed_commit: 9640881e2c56b010fb1be93b3818f22be91d3b9c
isolation_commit: b446b7b507d6a5faa8fb2ac9d28197da34887e99
base_commit: 7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc
isolation_publication_verified: true
implementation_on_main: false
human_acceptance: pending
new_push_approved: false
pull_request_approved: false
merge_approved: false
---

# B06 Test Isolation Windows Review

The published route and menu isolation corrections work on Windows: the official suites reached 53/53 and 33/33 without local adaptations. The full published runner still exited 1 because the older keyboard/mouse combat suite, which has no controller isolation, returned 8/9. A separate motion-isolated diagnostic reached 9/9 with unchanged assertions. Recommend one narrow combat-runner isolation follow-up before treating the full validation as passing or opening a PR.

## Verified Version and Scope

The fetched feature HEAD is `9640881e2c56b010fb1be93b3818f22be91d3b9c`, containing test commit `b446b7b507d6a5faa8fb2ac9d28197da34887e99` above `7c781ab65d75251af20880cf6e9548d1239be0dd`. Remote refs were checked again after execution: the feature remains `9640881`, and main remains `7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc`. Publication of these two commits was authorized by the owner; no future push, PR or merge approval is inferred.

The latest commits change tests, generated evidence and B06 records only. `main.gd`, `wagon_inventory_ui.gd`, assets, project settings, scene, canon and the historical menu/combat validators are unchanged relative to `7c781ab`. Production action deadzones, device settings, gameplay, movement bounds, existing faulty controls and foreground readability are preserved.

The route test suspends joypad bindings immediately after the game node's `_ready`, before its first frame. Suspension preserves its saved bindings across repeated calls. A deterministic boundary check requires a 0.21 trigger neither to queue nor perform a dash. A separate live control demonstrates that a dash queued before late suspension still fires, and a named `late_isolation` faulty mode must fail. The restored binding counts and synthetic trigger dash are checked.

`menus_regression.gd` extends the existing 33-check validator and removes only joypad motion bindings when the game emits `ready`. Its button bindings and synthetic controller assertions are preserved. The runner requires both the isolation marker and 33/33, rather than accepting a wrapper that silently fails to apply.

## Official Windows Execution

All engine tests ran in a new detached scratch clone at:

`C:/Users/gui-m/AppData/Local/Temp/atena-b06-isolation-windows-414395a9dc6e44f3b4d602d3d4f41608`

Engine: `D:/Godot/godot.exe`, `4.7.2.stable.official.ed1daf0bf`. Platform: native Windows x64, OpenGL compatibility, 1280x720, NVIDIA GeForce GTX 1650, driver 616.92. No fixed FPS or diagnostic adaptation was used for the published suite:

```text
rtk proxy node .atena/generated/2026-10-04-b06-validation/run_validation.cjs all
```

The full runner exited 1. Each of its 22 case records is freshly tagged `win32`, with no project diagnostics, process-launch errors or signals.

| Official case | Result | Exit |
| --- | --- | --- |
| B06 headless | 30/30 | 0 |
| B06 rendered route | 53/53 | 0 |
| Full self-test | B01 through B06, playtester and overall pass | 0 |
| Combat | 8/9; miss feedback assertion failed | 1 |
| Menus via published wrapper | 33/33; seven motion bindings removed, synthetic buttons kept | 0 |
| Geometry | 46/46 | 0 |
| Headless facing | 65/65 | 0 |
| Rendered facing | 102/102 | 0 |
| Normal and headless 600-frame smoke | Both pass | 0 each |
| Eight logic, three render and one isolation faulty controls | All 12 rejected with named failures | 1 each |

The official route passed its stale-queue live control, clean isolation boundary and complete binding restoration checks. Every walk settled with zero velocity within the existing timeout (21 deceleration frames here); all motion bounds, floor and context checks passed. Ore collection/deposit, fixed hub, remote access guards, offscreen Stag damage, defeat/restore and camera-offset combat passed. Cave parity and left/right translation identity each measured zero differing pixels; secured cave parity retains its existing route-signpost exclusion.

The `late_isolation` faulty case failed the exact boundary assertion and exited 1. The eight readability cases passed, and removing the readability pass failed all eight. The Linux software-renderer facing difference did not reproduce on Windows.

The original records validator passed its structural phase (36 resolved links, ADD contract, exact prior completed-history preservation and scoped files), then failed its saved-results phase at the genuinely failed combat case. No check was bypassed. An earlier invocation rejected the reviewer-created import log placed at the scratch root; that log was moved into the permitted generated-output directory before rerunning. This was reviewer output placement, not an implementation defect. Engine import itself exited 0.

## Remaining Combat Test Interference

The official failure was:

`RUNTIME FAIL attack at 161 px misses the stag (2 -> 2) with a distinct swing`

At that observation, the enemy's health remained 2, Lolth's pose was `strike`, and VFX was `swing`. The failing predicate was the feedback message: it read `Lolth needs a moment before dodging again.` instead of starting with `Out of reach`. The same official log contains extra dash/cooldown feedback around unrelated attacks. The production combat implementation and historical test are unchanged from the previously reviewed build.

A review-only subclass inherited the nine original checks, scenarios, input presses and bounds. It removed the seven joypad motion bindings after `_ready` and before the first frame, without editing game code or the historical validator. This separate diagnostic returned 9/9 and exit 0. Its miss observation retained enemy health 2, strike pose, swing VFX and `Out of reach` feedback.

During that diagnostic, Godot reported connected joypad device 0 and raw right-trigger value `0.21958068013191`. This is above the unchanged action deadzone of 0.2. The observation and isolated pass support physical-controller interference as the cause of this test failure, rather than establishing an attack-damage regression. They do not establish why the physical trigger had that value, and do not justify changing device settings or production thresholds.

The official 8/9 result is retained separately. The diagnostic 9/9 does not make the full published runner pass and is not delivery of a fix.

## Visual Review and Limitations

Fresh readability ratios match the previous Windows observations (about 0.84 to 0.87 at x=1280 and 0.72 to 0.79 at x=2998). Four fresh captures were individually viewed: day/left at 1280, night/right at 1280, day/right at 2998 and night/left at 2998. Lolth remains visible in front of the foreground. The other four readability captures were checked numerically, not individually re-inspected in this round. All eight were visually inspected in the earlier review of byte-identical production rendering.

The semitransparent appearance, partial sprite clipping at the far screen edge, mirrored seam echo, untuned route/camera, overlapping salvage labels and in-memory save limitation remain documented. Human acceptance is still pending. The menu wrapper filters motion but not physical buttons; active button presses during testing can still interfere. Passing synthetic input checks are not exhaustive physical-controller coverage.

## Evidence and Recommendation

Fresh official results, metrics, 32 positive route images, reviewed test sources, and the separate combat diagnostic are under `.atena/generated/2026-10-04-b06-isolation-windows-review/`. The copied Linux baseline-facing log is a historical fixture, not a fresh Windows baseline test. Fault runs do not write over the positive captures. The local review validator records exact source identities, expected passes and the retained official failure, ADD links and SHA256 hashes. It verifies the receipt, not all-suite acceptance, CI, a whole-file YAML parse or a sealed GPU benchmark.

The game-visual-debugging skill guided comparable captures and measurement limits. Its sealed adapter workflow was unavailable because the project has no `.game-dev/adapter.json`; existing game-owned runners were used without installing anything. The write-page skill guided this self-contained English local record, especially separation of official failures from diagnostics. Established `.atena/` format and destination were preserved; no external Page was created.

Recommend a test-only combat wrapper, using early motion isolation as in the menu wrapper, while preserving all nine combat assertions and the historical validator/evidence. Reconcile authorized publication at `9640881`, rerun the full actual suite, and then obtain human acceptance of the visual/camera limitations. The stale latest-publication fields in the feature records reflect their pre-push checkpoint; this receipt verifies the push without granting new publication authority.

No production fix is established as necessary by this review. The original main checkout and its active-plan record remain unchanged because the implementation is still external and unmerged. Only this new local receipt and its generated evidence were added; previous review artifacts are preserved. No commit, push, PR, merge, deletion, external message or B07 work was performed. The recommendation grants no additional execution or publication authority.
