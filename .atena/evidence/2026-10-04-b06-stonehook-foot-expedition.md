---
status: complete-implementation-merged
kind: planning-evidence
created: 2026-10-04
request_classification: NEW_PLAN
origin: preparation
preparation_approved: true
approval_mode: per-plan
approved: 2026-10-04
approval_source: owner-selected-1-to-approve-the-presented-B06-implementation-scope
request_execution_classification: IN_PLAN
implementation_approved: true
execution_target: opus-5.5
preparation_commit: 0a82ead8384969a11399f20ef3dcf3828734df27
documentation_publication_approved: true
documentation_published: true
delivery_commit: 77ee387d5649a131ae20c5910b2dc7421c76f22f
runtime_changed: true
push_approved: true
dispatch_approved: false
spec: "[[2026-10-04-b06-stonehook-foot-expedition]]"
instruction: "[[2026-10-04-b06-stonehook-foot-expedition-instruction]]"
local_baseline: 2f34635ff5adf735e51a7c144862e7c1bba37bed
gameplay_baseline: 05eac1e7a639e213f39cff81b1e75305727ab4d0
implementation_branch: codex/b06-stonehook-foot-expedition
implementation_base: 7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc
implementation_commit: 42bddf87b64eafb2046a47b1f2695df3ad9d4075
implementation_evidence: "[[2026-10-04-b06-stonehook-foot-expedition-implementation]]"
steps_completed: [S-001, S-002, S-003, S-004]
human_review: accepted
branch_publication_approved: true
branch_published: true
published_commit: ccc4fcf69271d88e421e26a81841cf6cce834a37
publication_authority: owner-authorized-normal-push-of-the-branch-for-review
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
pull_request_approved: true
merge_approved: true
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
---

# B-06 Expedition Planning Evidence

The owner reported "tudo funcionando" after the recommended final Thornwake playtest. That overall human confirmation was recorded locally in `2f34635`, without inventing itemized tests or publishing it. The owner then answered "pode" to preparing the proposed B-06 plan and English Opus prompt. That initial authorization covered preparation only. No active plan existed before this preparation; the enemy-facing correction remains the last completed plan.

## Inspected Sources and Runtime Constraints

Read the ADD contract, persistent state, completed B-04 and B-05 boundaries, current facing/merge receipt, and the approved caravan, continuous-ground, first-cure, control and Stonehook visual decisions. Preserve the newer caravan rule over older first-cure wagon-departure wording.

`main.gd` uses a 1280x720 viewport, x=190 cave anchor, GROUND_Y=555 and a viewport-width movement clamp. `spawn_zone()` resets player position and clears runtime arrays. `enter_stonehook()` requires the wagon travel lock to be bypassed and then instantiates the prototype Stonehook scene. That is not an approved on-foot corridor. The legacy Stonehook branch also enables hazards/rope routes, enemy/boss hooks and progression paths that this proposal must not accidentally expose.

Camp checks and `wagon_inventory_ui.gd` contain x/zone assumptions; rendering, enemy sheet selection, night waves, safe restore and objective text also follow the single current `zone`. Backgrounds and foregrounds fill the screen rather than spanning a connected world. Scoped separation of player region, world/view position and stationary hub state is therefore necessary; removing the travel lock alone is not sufficient.

Existing runtime preloads include the Stonehook route texture and salvage art. No new image, audio, dependency or asset admission is needed for the proposed first corridor. Existing floor movement remains flat; optional rope/hazard mechanics and the full region are deferred. No source or canonical decision is edited during this inspection.

## Proposed Decisions and Preserved Boundaries

The spec proposes one gradual route, one finite ore pickup, a physical return to the cave, continued offscreen camp survival/threat simulation and correct operational rollback. These are bounded technical/playtest defaults, not implemented facts. It preserves one cure, Mark I, Echo cap, dash, inactive parry, protected relics/family, stationary travel-locked wagon and existing in-memory save semantics.

Preparation commit `0a82ead` left the implementation approval unconfigured and pending. The previous integrated playtest did not grant B-06 approval. The subsequent explicit plan approval is recorded below; it is not backdated into the preparation stage.

## Preparation Validation and Delivery Limits

At preparation time, the validator checked required ADD directories, links, exact preservation of the completed-plan/history state, the pending unconfigured approval gate, allowed documentation paths and unchanged runtime/assets/configuration. It is a scoped structural check, not a full YAML parser or new Godot test. Prior machine results and captures remain historical evidence and are not overwritten or represented as B-06 passes.

Files created for preparation are the spec, this evidence, the English instruction and a scoped preparation validator; only the active-plan slot/cursor is updated in persistent state. The English instruction now records approval and authorized repository delivery. An external executor must stop if the acceptance/preparation/approval/delivery records are missing from its checkout, rather than reviewing or implementing an older branch. Future implementation publication and external dispatch still require separate explicit owner authorization.

The `write-page` skill guided descriptive headings, separation of observed facts from proposed defaults and a self-contained English handoff. The established local `.atena/` format and destination are preserved; no external Page is created.

Preparation validation completed with exit 0 and `B06_PREPARATION_PASS`: 14 resolved links, required ADD structure, unconfigured approval/implementation/publication gates, exact previous completed-plan/history preservation and unchanged runtime/assets/settings/canon. Scoped whitespace checks pass. This validates the prepared documents, not the planned corridor or any B-06 gameplay behavior. The old facing closure validator belongs to its closed-plan checkpoint and is not a substitute for the current preparation check.

## Per Plan Approval and Remaining Delivery Gate

On 2026-10-04, the owner selected "1" in response to the presented question approving the B-06 implementation scope and choosing its approval level. This request is IN_PLAN. The selection records `per-plan` approval for the complete bounded S-001 through S-004 scope and B-001 through B-003 batches. No new batch or step approvals are required while that scope remains unchanged. Execution is assigned to Opus 5.5 after delivery, not to local Atena implementation.

At approval commit `77ee387`, the spec, instruction and active plan agreed on `approved-awaiting-external-delivery`, implementation approval and the separate publication/dispatch gates. The validator checked that approval checkpoint rather than the superseded preparation checkpoint. Completed-plan history, previous validation and all gameplay/canon were unchanged. No new implementation branch, B-06 gameplay tests, push, PR, merge or message to Opus had occurred at that stage.

Approval validation completed with exit 0 and `B06_APPROVAL_PASS`: 14 resolved links, required ADD structure, explicit owner approval, pending delivery/publication gates and exact preservation of the previous completed-plan/history state. The changed-file and whitespace checks pass; runtime, assets, settings and canon are unchanged. This is approval-record validation, not execution of any B-06 gameplay acceptance criterion.

## Authorized Documentation Publication

The owner answered "autorizado" to publication of the three local documentation commits on main so Claude could read them. This request is IN_PLAN and covers the bounded documentation delivery and its operational reconciliation, not future implementation publication, PR, merge or messaging.

A fresh fetch confirmed no remote-only commits and exactly three local commits ahead. The scoped approval validator passed before publication. A normal push advanced origin/main from `05eac1e` to `77ee387`; `git ls-remote` confirmed the full remote HEAD as `77ee387d5649a131ae20c5910b2dc7421c76f22f`. The published commits are `2f34635` (owner playtest acceptance), `0a82ead` (B-06 preparation) and `77ee387` (per-plan approval).

The documentation delivery checkpoint is now cleared, with status `approved-awaiting-external-execution`. The executor must read this reconciliation or a later descendant and verify the files/approval before creating its implementation branch. No local B-06 implementation, new engine results, PR, merge, branch deletion or message to Opus occurred. `push_approved: false` continues to protect future implementation publication; the separately authorized documentation push is recorded by the documentation publication fields.

Delivery reconciliation validation passed with exit 0 and `B06_DELIVERY_PASS`: 14 resolved links, required ADD structure, consistent per-plan approval/documentation publication, approval commit present on origin/main, separate future implementation publication gates, exact prior completed-plan/history preservation and unchanged runtime/assets/settings/canon. Scoped whitespace checks pass. These are documentation checks, not B-06 gameplay results.

## Implementation Checkpoint

The assigned executor read this evidence, the spec, the instruction and the active plan from `origin/main` at `7e477ba`, confirmed the per-plan approval and the cleared delivery checkpoint, and created `codex/b06-stonehook-foot-expedition` from that commit. S-001 through S-004 were executed locally as IN_PLAN work without new batch or step approvals. Implementation commit `42bddf8` and the records follow-up are local only.

Fresh engine results, negative controls, captures and limitations are in [[2026-10-04-b06-stonehook-foot-expedition-implementation]]. The preparation, approval and delivery validator under `.atena/generated/2026-10-04-b06-preparation/` checks those earlier documentation checkpoints only; it is superseded at this checkpoint by `.atena/generated/2026-10-04-b06-validation/validate_records.cjs`, and is left unchanged as historical evidence. Status is `implemented-awaiting-review`; human review, implementation publication, PR, merge and dispatch remain pending and unapproved.

## Authorized Branch Publication and Review Follow-up

The owner explicitly authorized a normal push of `codex/b06-stonehook-foot-expedition` for review. Before pushing, the branch was verified at `ccc4fcf`, containing implementation `42bddf8` on base `7e477ba`, with a clean tree. A normal push with upstream created `origin/codex/b06-stonehook-foot-expedition` at `ccc4fcf69271d88e421e26a81841cf6cce834a37`; remote `main` stayed at `7e477ba`. The sections above describe the earlier pre-publication checkpoint and are kept as history.

Atena then reviewed that exact build on Windows (Godot 4.7.2, GTX 1650) and reported: headless B-06 30/30, rendered facing 102/102, and passing combat, menus, geometry, self-tests and all ten faulty controls. The original route runner reached 36/40 there, because a resting physical right trigger (about 0.20–0.21) dashed during the keyboard-only test, and one walk was measured before deceleration finished. Atena also reported Lolth largely hidden by the foreground at x=1280 and near x=2998. These are Atena's Windows results; they were not reproduced here.

The IN_PLAN follow-up commit `d2012a1` (local, not pushed) addresses all three without expanding B-06; see [[2026-10-04-b06-stonehook-foot-expedition-implementation]]. Further push, PR, merge and dispatch remain unauthorized. B-07 was not started.

## Follow-up Publication and Test-Isolation Follow-up

The owner then authorized a normal push of `d2012a1` and `7c781ab`. Before pushing, the branch was verified: `7c781ab` → `d2012a1` → published `ccc4fcf`, exactly two commits ahead and a clean tree. A normal fast-forward moved `origin/codex/b06-stonehook-foot-expedition` from `ccc4fcf` to `7c781ab65d75251af20880cf6e9548d1239be0dd`; remote `main` stayed at `7e477ba`. The earlier publication history above is unchanged.

Atena's official Windows runs of `7c781ab` (Godot 4.7.2, GTX 1650):
- B-06 headless 30/30.
- Rendered route suite 50/51: only the first controller-isolation check failed.
- Menu suite 32/33: only the inactive right-click/parry check failed.
- Combat 9/9, geometry 46/46, facing 65/65 headless and 102/102 rendered, the full self-test and both smoke runs passed.
- All 11 faulty controls were rejected, and all eight readability checks passed and were inspected.

Separate Atena diagnostics, which are not official acceptance runs, traced both failures to physical controller input:
- A `shadow_action` queued before suspension survives it.
- Isolating before the opening skip gave 51/51.
- Filtering physical controller dispatch gave 33/33.

None of these Windows results were reproduced by the executor.

The IN_PLAN test-only follow-up `b446b7b` (local, not pushed) corrects both isolation points without touching production; see [[2026-10-04-b06-stonehook-foot-expedition-implementation]]. Further push, PR and merge remain unauthorized, and B-07 has not been started.

## Isolation Publication and Combat Isolation Follow-up

The owner authorized a normal push of `b446b7b` and `9640881`. Before pushing, the branch was verified: `9640881` contains `b446b7b` and descends from published `7c781ab`, with no remote divergence and a clean tree. A normal fast-forward moved `origin/codex/b06-stonehook-foot-expedition` from `7c781ab` to `9640881e2c56b010fb1be93b3818f22be91d3b9c`; remote `main` stayed at `7e477ba`. The earlier publication history above is unchanged.

Findings supplied by the owner from Atena's Windows validation of `9640881` (native Godot 4.7.2):
- B-06 headless 30/30, rendered route 53/53, menus 33/33, geometry 46/46, facing 65/65 headless and 102/102 rendered.
- The full self-test and both smoke runs passed, and all 12 faulty controls were rejected.
- The full runner still exited 1, because the historical combat validator passed 8/9. The out-of-reach miss kept the enemy at 2 health, with a `strike` pose and a `swing` effect, but the message was "Lolth needs a moment before dodging again."
- A separate reviewer-only diagnostic isolated joypad motion bindings after the game's `_ready` and passed 9/9. Physical device 0 reported a right trigger of about 0.21958, above the 0.2 deadzone.

That diagnostic does not replace the official 8/9 result. Atena's detailed receipt was not available in this checkout, so these findings come from the owner's request and were not reproduced by the executor.

The IN_PLAN test-only combat isolation follow-up is local and unpublished; see [[2026-10-04-b06-stonehook-foot-expedition-implementation]]. Production files are unchanged. Human acceptance remains pending, further push, PR and merge remain unauthorized, and B-07 has not been started.

## Combat Isolation Publication, Windows Review and Human Acceptance

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
