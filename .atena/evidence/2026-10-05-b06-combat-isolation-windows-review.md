---
status: technical-review-passed-human-accepted-awaiting-record-reconciliation
kind: external-implementation-review
created: 2026-10-05
request_classification: IN_PLAN
approval_mode: per-plan
plan: "[[2026-10-04-b06-stonehook-foot-expedition]]"
prior_review: "[[2026-10-04-b06-isolation-windows-review]]"
reviewed_branch: codex/b06-stonehook-foot-expedition
reviewed_commit: 7de6d6658a2e8b7aea5954320ef29902094d7215
parent_commit: 9640881e2c56b010fb1be93b3818f22be91d3b9c
base_commit: 7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc
combat_follow_up_publication_verified: true
official_windows_runner_exit: 0
implementation_on_main: false
human_acceptance: accepted
human_acceptance_date: 2026-10-05
human_acceptance_source: owner-stated-aprovado-after-Windows-review-and-playtest-recommendation
new_push_approved: false
pull_request_approved: false
merge_approved: false
---

# B06 Combat Isolation Windows Review

The published combat isolation follow-up passes the full official Windows suite. Combat reached 9/9 both normally and under continuous synthetic trigger noise; all 14 faulty controls were rejected. The previous official 8/9 failure at `9640881` remains preserved in the prior receipt and is not rewritten as a pass. Technical review found no new blocker in this test-only commit. The owner subsequently approved this reviewed B06 slice on 2026-10-05. Publication-record reconciliation and separate PR authorization remain pending.

## Reviewed Version and Publication

The fetched branch and fresh scratch HEAD are `7de6d6658a2e8b7aea5954320ef29902094d7215`, directly above `9640881e2c56b010fb1be93b3818f22be91d3b9c`. Remote refs were checked after execution: the feature remains at `7de6d66`; main remains at `7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc`.

The owner explicitly authorized the normal push of this one existing commit. The external executor reports a clean, non-divergent fast-forward; this review independently confirms the current remote refs and parent relationship. No additional push, PR or merge authority is inferred. The feature's records still describe the combat follow-up as local/unpublished because they were written before the authorized push. This receipt establishes the current publication fact without editing those historical feature records or granting a future publication.

## Code Review

`combat_regression.gd` inherits the unchanged historical B05 combat validator. Its `node_added` listener connects to the game node's `ready` signal before the inherited validator adds the game to the tree. After production `_ready` creates the bindings, the wrapper removes only joypad motion events and releases affected actions. It preserves joypad button bindings and every original scenario, assertion, threshold, input sequence and timeout.

The isolation marker checks seven removed motion bindings in these runs, game pulse 0.000 in the opening state, a non-dispatching 0.21 trigger probe matching dash before but not after isolation, and preserved button bindings. The runner requires that marker, exactly nine original passing assertions, the historical success marker, exit 0 and no project diagnostics. Isolation changes only the test process's InputMap, not production settings.

The positive noise case sends a synthetic 0.21 trigger every frame. Missing isolation reproduces a genuine original miss-feedback failure; late isolation fails the timing proof after the first processed frame. All twelve earlier faulty controls are preserved. Production code, UI code, assets, scene, project settings, canon and historical B05 validators are unchanged from `9640881`. Existing foreground rendering is also unchanged; the commit is tests, generated evidence and operational records only.

## Official Windows Results

A new detached scratch clone was used:

`C:/Users/gui-m/AppData/Local/Temp/atena-b06-combat-windows-1791183529100`

Engine: `D:/Godot/godot.exe`, `4.7.2.stable.official.ed1daf0bf`, native Windows x64, OpenGL compatibility at 1280x720, NVIDIA GeForce GTX 1650, driver 616.92. No fixed FPS, controller disconnection, source adaptations or changed assertions were used. Engine import exited 0. The unmodified published command was:

```text
rtk proxy node .atena/generated/2026-10-04-b06-validation/run_validation.cjs all
```

The full runner exited 0. Its 25 freshly generated case records are tagged `win32`, with no project diagnostics, process errors or signals.

| Official case | Result | Actual exit |
| --- | --- | --- |
| B06 headless | 30/30 | 0 |
| Rendered route | 53/53 | 0 |
| Full self-test | B01 through B06, playtester and overall pass | 0 |
| Combat through published wrapper | 9/9, early isolation marker | 0 |
| Combat with continuous 0.21 trigger noise | 9/9, early isolation marker | 0 |
| Menus | 33/33, isolation marker, synthetic controller buttons preserved | 0 |
| Geometry | 46/46 | 0 |
| Facing headless | 65/65 | 0 |
| Facing rendered | 102/102 | 0 |
| Normal and headless 600-frame smoke | Both pass | 0 each |
| Eight logic, three render and three isolation faulty controls | All 14 correctly rejected with named failures | 1 each |

Combat's normal miss retained enemy health 2, strike pose, swing VFX and `Out of reach` feedback. The noise-positive case did the same. Missing isolation failed that original miss check with dodge-cooldown feedback, matching the earlier Windows interference. Late isolation reported pulse 0.142 in the opening state and was rejected despite the inherited combat assertions passing. These are actual negative-test exit codes, not parse failures.

The route retained legitimate departure, fixed cave wagon, ore collection and deposit exactly once, remote interaction guards, ongoing offscreen Stag damage, safe/F4 restore and progression locks. Cave parity and left/right translation each measured zero differing pixels; secured cave parity uses the existing signpost exclusion. All ten title measurements stayed at 827 glyph pixels. Walking settled within the unchanged timeout; maximum measured step ratio was 1.000. The live stale-queue control dashed, the clean boundary neither queued nor dashed, and restored bindings allowed the synthetic trigger again.

The unmodified published `validate_records.cjs` then exited 0. Its structural phase verified 39 resolved links, the ADD contract, exact completed-plan/history preservation and scoped paths. Its saved-result phase accepted the fresh Windows results, including rendered facing 102/102. This is a structural check, not a whole-file YAML-parser claim. Git emitted line-ending conversion warnings for scratch import/output files; these were not Godot project errors, and no tracked production difference was found. Process-only scratch safe-directory configuration was used; no global Git configuration was changed.

## Visual Review and Remaining Limits

Four fresh captures were individually inspected: normal combat hit, noise-positive combat miss, day/left readability at x=1280 and night/left readability at x=2998. The hit/miss feedback is visually consistent with the logged outcomes. Lolth remains visible over foreground geometry; the far-edge image still clips part of her sprite. The other six readability views were checked numerically, not individually re-inspected in this round. Their ratios match the previous Windows review, approximately 0.84 to 0.87 at x=1280 and 0.72 to 0.79 at x=2998. No artistic acceptance is inferred from those measurements.

Human acceptance was pending at the initial technical-review checkpoint and was subsequently supplied by the owner as recorded below. The semitransparent foreground pass, far-edge framing, mirrored seam echo, overlapping salvage labels, untuned balance and in-memory-only saves remain documented limitations, not silently resolved defects. Wrappers filter sticks and triggers, not active physical button presses. Synthetic controller button assertions are preserved; this is not exhaustive physical-controller coverage. The earlier physical trigger measurement remains historical evidence; it was not newly sampled in this round.

## Owner Acceptance

On 2026-10-05 the owner replied `aprovado` after the Windows review report and recommendation for visual/camera playtesting. Classified IN_PLAN, this is overall human acceptance of the reviewed B06 slice at `7de6d66`. No item-by-item playtest results, timings, additional engine runs or independent tested-build hash are inferred. Existing limitations and all historical evidence remain unchanged. This approval is not authorization for a new push, PR, merge, branch deletion, canonical change or B07 work.

## Saved Evidence and Next Checkpoint

Fresh official results, logs, route metrics and captures, positive combat captures, facing/geometry outputs and exact reviewed sources are saved separately under `.atena/generated/2026-10-05-b06-combat-isolation-windows-review/`. Previous review artifacts are untouched. The Linux baseline-facing log included there is a historical fixture, not a fresh Windows run. The snapshot-specific receipt validator checks exact source identities, all 25 results, expected faulty detections, links and SHA256 hashes. It does not claim CI, sealed GPU benchmarking or performance acceptance.

The game-visual-debugging skill guided comparable captures and measurement boundaries. The project has no `.game-dev/adapter.json`, so the existing game-owned runners were used without installing an adapter. The write-page skill guided the self-contained English local evidence and separation of historical, fresh and human-review facts. Established `.atena/` format and destination were preserved; no external Page was created.

With overall human acceptance now recorded, recommend documentary reconciliation of publication at `7de6d66`, these Windows results and the owner's acceptance on the feature branch before requesting a PR. Any new publication requires separate approval. The original main checkout and its active-plan record remain unchanged because the feature is still external and unmerged. This acceptance update changes only the local receipt and its verification/hash metadata; it does not rerun or rewrite engine evidence. No production edit, commit, push, PR, merge, deletion, external message or B07 work was performed during this review or acceptance reconciliation.
