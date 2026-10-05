---
status: review-complete-followup-and-human-review-pending
kind: external-implementation-review
created: 2026-10-04
request_classification: IN_PLAN
approval_mode: per-plan
reviewed_branch: codex/b06-stonehook-foot-expedition
reviewed_head: ccc4fcf69271d88e421e26a81841cf6cce834a37
implementation_commit: 42bddf87b64eafb2046a47b1f2695df3ad9d4075
base_commit: 7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc
external_branch_publication_approved: true
external_branch_publication_verified: true
implementation_on_main: false
human_acceptance: pending
new_push_approved: false
pull_request_approved: false
merge_approved: false
spec: "[[2026-10-04-b06-stonehook-foot-expedition]]"
---

# B-06 Windows Implementation Review

The published B-06 branch was fetched and reviewed at `ccc4fcf`, with parent implementation commit `42bddf8` and base `7e477ba`. The owner authorized this branch publication separately from implementation approval. The remote main remains at `7e477ba`; the implementation has not been merged. Publication statements in the branch's existing records still describe their pre-push checkpoint and need reconciliation before further publication or a PR.

The corridor, ore loop, camera translation, stationary cave and protected progression are implemented within the planned production-file scope. Windows testing confirms the earlier facing failure does not reproduce here. The original route runner does fail on this machine; controlled diagnostics explain its failures without changing production code or lowering assertions. Human playtesting and visual-readability review remain pending. This is not owner acceptance or merge approval.

## Runtime and Isolation

Tests used `D:/Godot/godot.exe`, version `4.7.2.stable.official.ed1daf0bf`, Windows, OpenGL Compatibility at 1280x720, NVIDIA GeForce GTX 1650 with driver 616.92. No fixed-FPS option was used.

A shared, detached temporary clone was checked out at the exact reviewed head:

`C:/Users/gui-m/AppData/Local/Temp/atena-b06-windows-review-d7c0d16bda6c45248efead1ccebcbf5b`

Godot import, all engine runs and diagnostic instrumentation ran only there. The clone's generated import metadata/cache and validation output changed as expected; none was copied into production assets. The original checkout stayed on main. No production code, canon, settings, dependencies, historical evidence, active plan or completed history was edited. Only this review receipt and its fresh evidence directory were added locally. Nothing was pushed, no PR or merge was performed, no branch was deleted and B-07 was not started.

The implementation-record validator passed before engine reruns: 30 resolved links and its saved Linux results matched their stated checkpoint. That is a historical-record check, not a new Windows gameplay pass. It intentionally expects the saved Linux facing failure and must not be used to misclassify fresh Windows results.

## Fresh Windows Results

The original command was:

`node .atena/generated/2026-10-04-b06-validation/run_validation.cjs all`

It exited 1 because the original real-input route case failed. All other cases passed their expected positive or negative outcome, with no project diagnostics.

| Case | Fresh result | Engine exit |
| --- | --- | --- |
| B-06 headless | 30/30 | 0 |
| Original B-06 real-input route | 36/40, fail | 1 |
| Full self-test including B-01 through B-06 and F4 | pass | 0 |
| Combat | 9/9 | 0 |
| Controls and menus | 33/33 | 0 |
| Geometry | 46/46 | 0 |
| Facing headless | 65/65 | 0 |
| Facing rendered | 102/102 | 0 |
| Normal and headless smoke | pass | 0 each |
| Eight logic and two rendering fault controls | all 10 rejected by named checks | 1 each |

The original rendered route failures were:

1. Outward motion continuity/speed bound.
2. Remote M refusal message.
3. Return motion continuity/speed bound.
4. Offscreen Stag fixture requiring Lolth's position and camera to remain identical.

The original result remains saved as failed. Cave-view parity, both sprite-facing translation comparisons, region order, single ore collection/deposit, remote inventory, terminal restore, fixed HUD and the day/night seam checks passed in that same original run. All three cave parity comparisons and both translation comparisons measured zero differing pixels.

## Controlled Diagnostic Findings

The added diagnostic subclass extends the original route runner and calls its checks unchanged. It exists only in the temporary clone and in the review evidence, not the production branch. Two additional temporary runner entries select its diagnostic conditions; the original runner and production files on the published branch remain unchanged.

### Physical Controller Input Interferes With a Keyboard Only Test

The first instrumentation run observed real `InputEventJoypadMotion` events on device 0, right-trigger axis 5, with values around 0.20-0.21. The unchanged bindings classify them as shadow-action presses, producing dashes during a test that injects only walking keys. This explains faster-than-walking steps and overwritten refusal messages. It does not establish whether the physical trigger was being pressed or whether the device needs calibration.

A separate hardware sampler, with no synthetic controller input, observed 30 events over 0.75 seconds: right-trigger minimum 0.203894 and maximum 0.211737; all 30 matched `shadow_action` as pressed. Its command exited 0. The sampler/log are retained separately. An early direct instrumentation invocation lacked the baseline parity fixture after the original runner cleaned it up; that invocation is not an acceptance run. Subsequent named diagnostic runs used the runner's normal baseline setup.

The keyboard-only diagnostic consumed physical joypad events before game dispatch while leaving keyboard/mouse input, InputMap, gameplay and original assertions intact. It reached 39/40, exit 1. Both continuity checks and the remote M refusal then passed. The remaining failed Stag check still observed actual wagon damage to 90.8 integrity and the correct HUD message.

### Six Frames Do Not Guarantee That Lolth Has Stopped

After releasing a walking key, the original helper waits six frames. At this machine's frame rate, the diagnostic measured horizontal velocity still at approximately 217.08 pixels/second after those frames. The Stag fixture records Lolth's position and camera too early; normal deceleration then changes both, making its stationary-position condition fail despite real offscreen wagon damage.

A second diagnostic consumed the same physical joypad events and additionally waited, with a two-second wall-clock timeout, for the existing velocity to reach zero before returning from the helper. The observed extra wait was about 104 milliseconds. It changed no movement code, delta handling, condition, tolerance or damage logic. All the original 40 checks passed, exit 0, including actual Stag windup/damage, unchanged away position/camera, terminal failure and restore.

This 40/40 result belongs to an explicitly adapted diagnostic, not to the unmodified committed runner. It supports the underlying B-06 behavior while showing why the committed validation helper needs a portable follow-up. There is still no clean unmodified 40/40 Windows acceptance run. Controller integration tests must continue receiving their synthetic controller events; a general blanket suppression is not a production fix.

## Code and Visual Review

The production diff is limited to `main.gd` and six proximity checks in `wagon_inventory_ui.gd`; additional files are B-06 tests, results and records. No assets, scenes, settings, dependencies or canon changed. The revised operational state preserves completed-plan history. The inspected departure gate requires genuine boss defeat, Mark I, one cure, repaired wagon and a saved safe camp, without consulting the travel bypass. World position guards remote wagon access; region borders do not reset the camp. Identity-based pickup restore preserves the finite ore. Camera translation composes with reflections and resets before the HUD. No additional production logic defect was established by this review.

Fresh final-diagnostic images were inspected at the transition, foothills, far boundary and night approach. The floor is continuous and HUD elements remain fixed. Two visual issues remain:

- At x=1280, the foreground tree conceals most or all of Lolth at the normal floor position. The implementation note acknowledges border-tree occlusion, but it is significant for player readability.
- At the far right limit, the foothill foreground arch conceals most of Lolth, leaving only a narrow visible portion at the viewport edge. This is additional evidence for reviewing foreground occlusion across the full new corridor, not just the Thornwake seam.

The mirrored-tree echo also remains visible. Human review should decide whether these limitations are acceptable for this playtest or require a bounded rendering follow-up. No new art or rendering fix was made here.

## Evidence and Next Checkpoint

Fresh receipts are under `.atena/generated/2026-10-04-b06-windows-review/`. The 20 original case logs/results are kept, including the failed original route result; the 39/40 and 40/40 diagnostic receipts are distinct. `diagnostic-captures/` and `diagnostic-runtime-metrics.json` come from the final adapted diagnostic, not the original suite. Copied diagnostic code and the temporary runner additions are explicitly review-only. The receipt validator produces a SHA-256 manifest of the saved evidence; this is not a sealed game-dev adapter run or a hardware-performance measurement.

The visual-debugging skill informed controlled scene/camera comparisons and evidence limits. No `.game-dev/adapter.json` exists, so its sealed-adapter workflow was unavailable; nothing was installed. Existing game-owned runners and captures were the fallback. The documentation skill guided this English receipt and separation of original results, diagnostic results and approval facts; no external Page was created.

Recommended follow-up is to make the committed route harness wait for actual stop with a timeout and isolate physical input during its keyboard-only scenario without weakening assertions or disabling synthetic controller regression checks. Review the two foreground-occlusion examples and reconcile the already-authorized branch publication in the B-06 records. Then rerun on Windows and ask the owner to playtest departure, the ore, offscreen survival, return and restore. This recommendation does not authorize production edits, another push, PR, merge or later-region work. B-06 remains under review.
