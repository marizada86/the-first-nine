---
status: complete-implementation-merged
kind: preparation-and-implementation-evidence
created: 2026-10-04
request_classification: NEW_PLAN
spec: "[[2026-10-04-enemy-facing-correction]]"
baseline_commit: 39cd7d3d46a8afb3894889920e0840cbae573e7b
runtime_changed: true
implementation_approved: true
approval_mode: per-plan
approval_source: explicit-owner-selection-1
implementation_branch: codex/enemy-facing-correction
implementation_commit: e7812e6ac969e899292a6c0c4845769ccaba2404
human_validation_accepted: true
human_validation_date: 2026-10-04
human_validation_source: owner-stated-aprovado
push_approved: true
published: true
first_published_commit: 523960b3b3c83832edabda8298de76e767828c43
publication_authority: explicit-owner-branch-push-and-records-authorization
pull_request_approved: true
pull_request: https://github.com/marizada86/the-first-nine/pull/5
pull_request_opening_head: edb5623d2609152c7df5dffffe10a34e6f3e2ba0
pull_request_head: fb565d0c430a8df3b0a12bd233c8a4109466f6a0
pull_request_receipt: "[[2026-10-04-enemy-facing-pull-request]]"
additional_record_push_approved: true
merge_approved: true
merge_commit: 7049063358132aac6d85aa69c0f06ae53efa98da
closure_record_publication_approved: false
---

# Enemy direction diagnosis

## Preparation checkpoint (historical)

The owner's report is consistent with the inspected production code and source artwork.

- `spawn_enemy()` (main.gd:2222) initializes position/AI/attack direction but no persistent visual facing.
- `update_enemies()` (2243) computes direction and signed speed, and updates horizontal position. The generic retreat behavior can use a negative speed, so target direction alone is not always movement direction.
- `update_thornwake_attacker()` (2292) uses a committed attack_dir for strike movement; rendering currently ignores it.
- `enemy_draw_geometry()` (2821) preserves native aspect and centers the visible alpha body.
- `draw_shades()` (2834) draws every source cell directly, without horizontal transform/flip. This is the missing visual direction mapping.
- Inspected local PNGs: `assets/runtime_v2/enemies/thornwake/briar-hound-core-v1.png`, `stag-of-mire-core-v1.png`, `antlered-hunger-core-v1.png`. All four cells of each sheet face right.
- Lolth's existing `draw_player_sprite()` has a scoped reflection/reset; it demonstrates a project-local drawing pattern, not an enemy fix already implemented.

Read ADD contract/state, completed B-05 geometry spec/evidence and relevant source. Main was clean and synced at the baseline before preparation; B-05 is last completed with active_plan null. Preparation creates a new pending corrective plan without changing gameplay or reopening completed history.

The game-visual-debugging skill guided adapter discovery, controlled capture planning and evidence boundaries. No `.game-dev/adapter.json` or game-dev command is available. The planned fallback is existing Godot-owned assertions/captures; no installation, project scenario, fresh engine run, GPU measurement or sealed evidence is claimed during this inspection.

Only the bounded spec, this preparation evidence and the pending plan state are written. No implementation, commit, push, PR, merge or B-06. Previous approvals are historical; owner approval selection for this plan is pending.

## Approved local execution and changes

The owner selected option 1 on 2026-10-04, approving the complete local correction per plan. Classified IN_PLAN. A separate local branch, `codex/enemy-facing-correction`, was created from `39cd7d3`; existing branches/receipts were not replaced. This does not authorize publication, PR or merge.

Only production file `main.gd` changes: enemy spawn adds persistent facing; generic movement records actual signed displacement (including retreat); Thornwake windup/strike uses committed attack_dir; stationary recovery and defeated enemies retain orientation. Legacy dictionaries without the new key use their committed attack direction or initial target as a fallback. `draw_enemy_sprite()` mirrors around the centered body anchor and explicitly resets the drawing transform before names, life bars and later scene drawing.

Frame selection, native source assets, uniform scale, shared alpha-outline geometry, melee reach, contact radius, health/damage, AI movement/attack timing and controls are unchanged. No atlas image was edited. Safe-wagon restoration still clears enemies; F4's deep snapshot preserves their added facing key.

## Fresh validation results

Runs use `D:/Godot/godot.exe` 4.7.2 on Windows. Normal captures use 1280x720 OpenGL Compatibility on the local GTX 1650. `run_validation.cjs` captures actual child-process exit codes and diagnostics with a 60-second case limit and separate output directories; successful final logs contain no script errors/warnings. Original B-05 logs, images and result files remain unchanged.

Evidence directory: `.atena/generated/2026-10-04-enemy-facing-validation/`.

- `node .atena/generated/2026-10-04-enemy-facing-validation/run_validation.cjs facing-headless facing-normal`: 65/65 headless and 102/102 normal checks, exit 0. Spawn/left/right/reversal, committed windup/strike with target crossing, recovery/defeat, zero motion, generic negative-speed retreat, compatibility fallback, F4 state and safe-wagon cleanup are checked.
- All 12 Thornwake frames (3 species x 4 frames) retain geometry/feet/shared reach and pass left-vs-right raster reflection checks. Independent source alpha >= 0.25 widths bracket melee hit/miss on both sides. Labels/bars remain unmirrored, and a subsequent test-only world marker verifies transform reset.
- Paired production overviews differ in 87,911 sprite-region pixels and zero pixels outside the union of enemy destination rectangles. This verifies unchanged Lolth, HUD, wagon and background in the frozen scene, not merely the fixture.
- `...run_validation.cjs negative-no_update negative-no_mirror negative-leaked_transform`: all three deliberately faulty test-only subclasses rejected, exit 1 with targeted failures and no script error. Missing direction update: 8 failures; missing sprite reflection: 12; missing transform reset: 21. These are new controls, not reruns of all earlier B-05 mutations.
- `...run_validation.cjs geometry combat menus self-test normal-smoke headless-smoke`: each exits 0. Independent geometry 46/46; real-input combat 9/9; controls/menus 33/33; B-01 through B-05, F4 and full self-test pass; both normal/headless smoke runs complete 600 frames. The old geometry oracle is extended only in a validation wrapper with a new output directory.
- Startup cache remains 22 cells; facing/frame/render/attack checks add zero gameplay alpha scans. No performance optimization or GPU timing claim is made.
- `node .atena/generated/2026-10-04-enemy-facing-validation/validate_records.cjs`: `FACING_RECORDS_PASS` and `FACING_RESULTS_PASS`, including 5 relevant links, ADD contract, per-plan approval/review/publication gates, exact B-05 completed-history preservation, scoped paths, unchanged combat/geometry functions and all final process/metric results. Whole-file YAML parsing remains unavailable without a new dependency; structural checks are not represented as a parser pass. Native engine logs retain their final blank lines; the complete staged whitespace check disables only blank-at-EOF warnings for this invocation, without changing Git configuration or rewriting evidence.

## Inspected captures and skill fallback

Inspected `overview-left.png` and `overview-right.png`: Hound, Stag and boss visibly reverse orientation while remaining grounded and centered. Names, health bars, Lolth and the cave scene stay in place. Six isolated idle-pose left/right captures are also retained; all 12 pose pairs are numerically checked without producing a large screenshot gallery.

The game-visual-debugging skill guided controlled paired capture, fault isolation and separation of measurements from visual inspection. No `.game-dev/adapter.json` or game-dev CLI exists. These are native Godot-owned tests/captures, not sealed harness bundles, semantic GPU attachments or hardware profiling. No adapter/dependency was installed.

## Preliminary test corrections and provenance

An initial sandbox-only self-test printed passing suites but also sandbox log/certificate-access diagnostics; it is not the clean acceptance run. Final tests use the authorized local process boundary and explicit workspace log files. A preliminary harness parse issue (Variant string inference) and typed-array assignment were corrected in the test script, not production behavior. One early boundary check incorrectly used idle Hound width even after selecting its close pose; it was replaced by independent per-frame native-alpha boundaries. A full-scene comparison initially classified a single subpixel sprite-edge sample by pixel origin; using the actual pixel center resolves it without enlarging the allowed regions or relaxing the difference threshold. Only successful final results are acceptance evidence; these preliminary failures are not concealed as passes.

## Review and publication boundary

At implementation commit `e7812e6ac969e899292a6c0c4845769ccaba2404`, S-001 through S-003 were complete locally and human review was pending. The owner then stated "aprovado" on 2026-10-04, accepting that exact local correction. Classified IN_PLAN. This acceptance does not imply any additional detailed playtest results or approval to publish.

At acceptance commit `523960b3b3c83832edabda8298de76e767828c43`, status was `implemented-human-validated-awaiting-publication-authorization`. The owner subsequently authorized the branch push and records, without PR or merge. Publication-reconciliation commit `edb5623` recorded status `implemented-human-validated-published-awaiting-pr-authorization`. That was the checkpoint before the later separate PR approval recorded below. B-05 remains last completed with its history unchanged; B-06 is not started. Operational follow-ups change only records and their validator. Saved runtime results, source code and captures are unchanged; no new engine run is claimed. The original correction commit is preserved without amend.

At the publication-reconciliation checkpoint, no PR, merge, remote dispatch or branch deletion was approved/performed. The later PR-only approval does not authorize merge, remote dispatch or branch deletion. The original source PNGs, canonical design and previous evidence remain unchanged. Deferred balance/contact-radius tuning, UI crowding, parry/higher Marks and disk persistence remain deferred. Visual verification covers all 12 Thornwake poses; generic movement/fallback tests do not claim complete visual validation of later prototype-region art.

## Authorized branch publication

The owner explicitly answered "autorizado" to publication of `codex/enemy-facing-correction` with correction and records, without opening a PR or merging. Classified IN_PLAN publication authorization, separate from the earlier per-plan execution and human acceptance.

A normal upstream push created `origin/codex/enemy-facing-correction` at `523960b3b3c83832edabda8298de76e767828c43`, preserving implementation `e7812e6ac969e899292a6c0c4845769ccaba2404` and acceptance `523960b`. Remote refs confirmed main remained `39cd7d3d46a8afb3894889920e0840cbae573e7b`. No amend, force-push or branch deletion. This publication reconciliation is a normal documentation follow-up on the same authorized branch, not a runtime change or fresh engine test.

## Separately authorized PR creation

Publication reconciliation was pushed as `edb5623d2609152c7df5dffffe10a34e6f3e2ba0`. A subsequent read-only readiness check confirmed main at `39cd7d3`, clean branch tracking, current main as an ancestor, preserved completed history and no existing correction PR.

The owner explicitly answered "autorizo" to opening the PR with an English description and without merging. Classified IN_PLAN, separate from implementation, acceptance and branch-push approvals. PR #5 was opened and attached to this chat: https://github.com/marizada86/the-first-nine/pull/5. Its verified head remains `edb5623` and base remains `39cd7d3`; state is open, merged is false, mergeability is clean and auto-merge is null. GitHub reports zero check runs and zero commit statuses (combined status pending, not a failing check).

At the opening-receipt checkpoint, status was `pull-request-open-awaiting-merge-authorization`; receipt `fb565d0` was not yet pushed. Only saved-result/operational checks were revalidated, with no new Godot run or new human-test claim. The subsequent separate publication and merge approval is recorded below.

## Authorized receipt publication and regular merge

The owner answered "autorizados" to publishing `fb565d0` and merging PR #5. Classified IN_PLAN. A fresh fetch confirmed clean branch tracking with exactly that documentation-only commit ahead; the existing scoped validator passed before publication. A normal push moved the feature branch from `edb5623` to `fb565d0c430a8df3b0a12bd233c8a4109466f6a0`, without amend or force-push. Only five record/validator files changed in that commit; runtime and saved evidence were unchanged.

GitHub confirmed the new head, clean mergeability, four commits and 62 changed files (+1660 / -6). Final pre-merge head had zero check runs and zero statuses; no CI pass is inferred. A regular merge was requested with expected head `fb565d0` and returned `7049063358132aac6d85aa69c0f06ae53efa98da`. GitHub subsequently confirmed closed/merged true at `2026-10-04T22:56:52Z`.

After fetching, local main was safely fast-forwarded to the merge. Its parents are prior main `39cd7d3d46a8afb3894889920e0840cbae573e7b` and final PR head `fb565d0`. The merged tree is identical to that head; all four correction commits remain ancestors. Remote main matches the merge, and `codex/enemy-facing-correction` is preserved at `fb565d0`. No branch deletion or other remote changes.

Local status is now `complete-implementation-merged`. Spec, receipt, plan state and their validator are reconciled locally; prior B-05 moves unchanged to the first history entry, older history is preserved, and active_plan is null with cursor complete. Exact facts are in [[2026-10-04-enemy-facing-pull-request]]. This documentation closure is unpushed and separately gated; no new engine test, source change, art, dependency, dispatch, balance change or B-06.
