---
status: complete-implementation-merged
kind: bounded-runtime-plan
created: 2026-10-04
plan_id: 2026-10-04-b06-stonehook-foot-expedition
origin: planned
implementation_preceded_spec: false
request_classification: NEW_PLAN
preparation_approved: true
preparation_authority: owner-stated-pode-to-plan-and-English-Opus-prompt
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
push_approved: true
pull_request_approved: true
merge_approved: true
dispatch_approved: false
local_baseline: 2f34635ff5adf735e51a7c144862e7c1bba37bed
gameplay_baseline: 05eac1e7a639e213f39cff81b1e75305727ab4d0
proposed_implementation_branch: codex/b06-stonehook-foot-expedition
evidence: "[[2026-10-04-b06-stonehook-foot-expedition]]"
instruction: "[[2026-10-04-b06-stonehook-foot-expedition-instruction]]"
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

# B-06 First Stonehook Foot Expedition

B-06 defines the first reversible expedition from the cave to early Stonehook. Lolth walks through a connected route, collects one regional resource and returns to the same wagon. The wagon, relics and eight family members remain at the cave. The owner approved this bounded implementation scope per plan by selecting option 1 on 2026-10-04, then explicitly authorized publication of the three documentation commits. They are verified on remote main at `77ee387`. Execution is assigned to Opus 5.5 after it verifies the delivered records; no local implementation or external message has occurred.

## Authoritative Sources and Existing State

Use [[2026-10-03-caravan-survival-slow-travel]], [[2026-10-03-caravan-relics-cave-prologue-and-travel]], [[2026-10-03-continuous-caravan-ground-and-web-gates]], [[2026-10-04-first-boss-mark-and-cure]] and [[2026-10-04-separated-controls-and-wagon-management]]. Later approved caravan decisions supersede the older statement that the wagon departs after the first cure. Early Stonehook must be reached on foot, not by moving the wagon or selecting another map.

The current game has a 1280x720 screen, a fixed player clamp and prototype region switches that clear arrays and reset player position. `enter_stonehook()` is blocked by the wagon travel lock. The existing Stonehook branch includes a relocated camp, hazards, rope teleport routes, boss and Mark-II paths. Enabling that branch wholesale would violate this scope. Completed B-01 through B-05 and the facing correction remain accepted; the owner reports the integrated Thornwake slice functioning. No new per-item human results are inferred.

## Proposed Scope and Technical Impact

Implement a bounded continuous route using existing runtime backgrounds, ground, Lolth, pickup and camp assets. Distinguish Lolth's world position and displayed region from the cave hub's fixed position and state. Add the minimum horizontal world-to-view translation necessary for the route; do not replace the scene architecture, install dependencies or generalize all later regions.

Keep Thornwake's existing start, tutorial, boss and first-cure sequence. Outward access becomes available only after legitimate Mark I, exactly one cure, repaired wagon and a previously captured survivable safe-wagon state. Mere F4 Mark changes, old completion buttons and the test-only travel bypass must not grant ordinary expedition access. Gate departure, not return: an already-away player must always be able to walk back while the run is active.

Proposed playtest geometry, not lore: retain the original Thornwake world span 0-1280 and cave anchor at x=190; add a 480-unit transition band from x=1280 to x=1760 and one 1280-unit foothill span ending at x=3040. Keep the main floor at the existing GROUND_Y=555. Camera translation is zero for the original cave/tutorial view. Expose route dimensions as named data; adjustment is permitted only within this one-corridor scope and must be reported and tested. No automatic teleport, full-screen temporal fade, loading card or region reset occurs at the border.

The transition spatially blends existing backgrounds and foregrounds so vegetation thins, rock increases and the palette cools. Do not use a full-screen dissolve between discrete scenes as a substitute. HUD, inventory, wagon UI and F4 panel stay in screen coordinates. Compose world translation with the existing sprite reflections and explicitly restore drawing context. Preserve grounded feet, native Thornwake proportions, shared-outline reach, hit feedback and cached bounds.

Place one finite, one-slot `IRON ORE` pickup on the accessible foothill floor, using the existing salvage art and `metal` item type. Give pickups stable identities. Revisiting the border must not recreate collected resources, duplicate carried items or refill the camp. The pickup can be carried back and deposited through the existing E/menu workflow; full inventory or wagon stock must retain the item and show the existing capacity feedback. The regional resource is a small proof of the expedition loop, not an unlock for axle/brakes or later progression.

## Camp Simulation and Restoration

The cave remains the only wagon interaction and checkpoint location. Camera position or the displayed Stonehook label must not enable remote deposit, crafting, ally management or safe capture. In particular, replace or guard assumptions such as `player.x < 305` and `zone != 0` where necessary; do not create a second camp in Stonehook. I still opens Lolth's carried inventory away from the wagon.

The world clock, Flame and Provisions retain their current rules. Existing Thornwake night waves, concrete attackers, wagon damage/defense and failure checks continue while Lolth is offscreen. Do not pause the camp, clear its enemies when crossing, replace enemies with abstract offscreen damage or run the same wave twice. Enemy behavior and rendering must use the enemy's originating region rather than incorrectly treating every actor as belonging to Lolth's displayed region. Existing UI pause and F4 pause behavior remain unchanged.

On death or terminal camp failure anywhere on the route, restore the last valid cave snapshot with Mark I and the same chosen cure. Never capture at zero Flame, Provisions, health or integrity. Extend operational snapshot coverage to the route, camera and regional pickup state so restoring cannot duplicate ore or mix pre/post-return data. Before a safe deposit/save, failure loses unsaved expedition loot as part of operational rollback; after a valid safe return, the saved stock and pickup state agree. Existing enemy-clear-on-restore behavior stays unchanged.

F4 restoration must deep-restore the added route fields, world position, camera, pickup identities and original camp/snapshot data. Debug Mark overrides remain inspection only. A new run resets every expedition field and again blocks departure until legitimate first-cure milestones.

## Non Goals and Protected Behavior

Do not enable wagon travel, pullers, additional cures, Mark II or later Marks, parry, posts/missions, the Stone Maw encounter/shrine, axle/brakes crafting, rope-route teleportation, Web Anchors, Hollowroot, new art/audio, atlas admission, equipment, disk saves or Attraction tuning. No new Stonehook combat is introduced in this traversal slice; the established cave threats remain active. Future Stonehook combat requires another approved scope.

Preserve A/D and controller movement, Space jump, Shift dash, E interaction, left-click/J attack, I inventory, wagon-menu ally management and C/its controller equivalent for First Thread. Right-click stays inactive. Preserve UI click consumption, existing pause policy, combat values, relic protection and the eight-member family. No canon file changes. Ambient-audio transition remains deferred because this batch admits no new audio assets or dependencies.

Allowed production files are `main.gd` and, only for necessary proximity/context guards, `wagon_inventory_ui.gd`. Evidence, tests and operational records belong under `.atena/`. Existing assets, `project.godot`, `main.tscn`, dependency/configuration files and unrelated completed records are not implementation targets. A broader architectural change requires a plan change and approval first.

## Acceptance Criteria

1. A new game, pre-boss state, uncured Mark I and debug-only Mark I cannot leave the original Thornwake bounds. Legitimate first cure plus safe return enables the on-foot departure without unlocking wagon travel.
2. Real movement input traverses the full route in both directions with no reset, jump in world position, floor gap or region-selection screen. At least five transition positions are captured at 1280x720 in day and night; the gradient and fixed screen-space HUD are readable.
3. The wagon and family have one fixed cave anchor before, during and after departure. Their state is unchanged merely by crossing. Remote E/M/UI requests cannot deposit, craft, assign allies or capture a safe snapshot.
4. Ore can be collected once, retained across ordinary border revisits and deposited once on return. Capacity handling is preserved. Safe snapshot rollback/recapture keeps pickup identity and stock consistent.
5. Clock and survival continue offscreen. An existing Stag actually damages the fixed cave wagon while Lolth is in the foothills; terminal failure restores the cave snapshot with Mark I and the chosen cure intact.
6. F4 exact restoration and new-run reset cover all new route data. Border oscillation cannot replenish enemies, loot or survival meters.
7. Reaching the far route limit, accumulating capped Echoes, interacting with old region controls or using ordinary camp UI never enables Stone Maw, Mark II, a second cure, parry, travel, posts or later regions. Thornwake Echoes remain capped at 3/3 in this slice.
8. Existing self-tests, real-input combat/menu checks and facing/geometry checks retain their intent. No production test bypass or weakened assertion is used to conceal a regression. Every changed assertion must explain the narrow B-06 boundary it supersedes.

## Gaps and Grounded Defaults

BLOCKING design gaps: none for this scope. Approval selection, explicit plan approval and authorized repository delivery are satisfied. The executor must still verify the exact delivered records before editing; this is a gate, not an implementation result.

RESOLVABLE defaults are the short route geometry, legitimate departure gate, one stable ore pickup, persistent camp simulation, spatial visual blend and return-to-cave failure semantics above. They are technical/playtest choices approved within this plan, not new canon. The existing preloads supply visual assets; no generated reference is silently admitted.

DEFERRED work includes full Stonehook combat, material progression, Mark II, higher powers, audio, later-region terrain, permanent save files and broader tuning. If the executor finds the bounded camp/route separation impossible without a broader rewrite or new design choice, stop with a PLAN_CHANGE_REQUEST rather than silently changing scope.

## Plan of Flight and Approval Checkpoints

- S-001 in B-001: implement legitimate departure, one continuous corridor and scoped world-to-view translation; preserve the fixed cave anchor and original tutorial view.
- S-002 in B-002: add the stable ore/return loop and audit remote camp guards, offscreen camp simulation and all protected progression paths.
- S-003 in B-002: extend safe-wagon and F4 operational restoration plus new-run reset for route state.
- S-004 in B-003: run positive/negative, real-input, rendered and regression checks; write English implementation evidence and stop for human review.

Stable batches are B-001 Route and Rendering, B-002 Camp and State, B-003 Validation and Evidence. The owner selected `per-plan`: one approval covers S-001 through S-004 and all three batches for Opus 5.5, without new batch/step approvals inside this unchanged scope. All implementation steps remain pending external execution. Plan approval explicitly covers the bounded coordinate/context change described above, not a general architecture rewrite. Documentation publication is authorized and verified; future implementation push, PR, merge, external dispatch and dependency gates remain separate.

## Validation and Evidence

Use `D:/Godot/godot.exe` for Windows; an external environment may use its available Godot executable without editing production files or claiming Windows reproduction. Record actual version, commands, exit codes, diagnostics and platform. Use wall-clock timeouts, not a fixed-FPS workaround.

Add isolated B-06 headless checks and a real-input outward/return runner. Include targeted faulty controls for bypassed departure prerequisites, border respawn/ore duplication, remote wagon/snapshot access, paused offscreen camp, lost route rollback/F4 fields and accidental Mark-II/travel unlock. Each faulty control must fail a named assertion with a genuine nonzero exit, not merely a parse error. Include camera-offset combat/UI tests and frozen captures demonstrating that sprite reflection and HUD transforms remain correct.

Run the full existing self-test, 9-check combat and 33-check menu runners, independent 46-check geometry and 65/102-check facing suites where applicable; distinguish reruns from historical evidence and document justified fixture adaptations for the new coordinate context. Preserve prior committed logs/captures and write new output under `.atena/generated/2026-10-04-b06-validation/`. Perform normal/headless smoke runs and report limitations without claiming CI, performance profiling or disk persistence.

Write `.atena/evidence/2026-10-04-b06-stonehook-foot-expedition-implementation.md` only after actual execution. Reconcile the spec, evidence and plan cursor to the real implemented/review state; do not mark merged/complete while implementation or human review is pending.

## Recovery and Delivery

Use a codex-prefixed feature branch from the verified current approved baseline, preserving local work and all existing branches. Normal corrective commits are the recovery path; no destructive resets, force-pushes or amending published history. Acceptance `2f34635`, preparation `0a82ead` and approval `77ee387` were normally pushed to origin/main after explicit owner authorization; the remote HEAD was verified as `77ee387d5649a131ae20c5910b2dc7421c76f22f`. This documentation reconciliation accompanies that authorized delivery. Use the delivered reconciliation or a later verified descendant, not the obsolete pending-delivery records at the initial approval commit. A missing commit or record is a delivery blocker: do not reconstruct an unseen spec from a pasted summary.

The English handoff is available through the authorized repository delivery but has not been sent as a message. It tells Opus to check the live approval mode, exact repository state and delivery before editing. No runtime, art, implementation branch publication or external message is performed during this documentation delivery. `push_approved: false` refers to future B-06 implementation publication, not the completed documentation push.

## Implementation Checkpoint

The assigned executor verified the delivered records on `origin/main` at `7e477ba` (acceptance `2f34635`, preparation `0a82ead`, approval `77ee387` and the delivery reconciliation), then executed S-001 through S-004 under the unchanged per-plan approval on the local branch `codex/b06-stonehook-foot-expedition`. Request classification: IN_PLAN. Implementation commit `42bddf8` changes `main.gd`, narrow wagon-proximity guards in `wagon_inventory_ui.gd` and validation artifacts under `.atena/generated/2026-10-04-b06-validation/`. No asset, scene, project setting, canon or dependency changed.

The implemented geometry, gate, camera, blended route art, finite ore, offscreen camp, restoration and validation results are recorded in [[2026-10-04-b06-stonehook-foot-expedition-implementation]]. The B-06 headless checks (30/30), the rendered real-input runner (40/40), the full self-test, the combat (9/9), menu (33/33), geometry (46/46) and headless facing (65/65) suites pass on Linux. All ten faulty controls are rejected. The rendered facing suite reports the same single pre-existing 101/102 difference on this Linux software renderer as the unchanged `7e477ba` baseline; it is left recorded as a failure, not adapted.

Status is `implemented-awaiting-review`, at checkpoint `owner-review-of-local-implementation`. Human review is pending. Implementation push, PR, merge and dispatch remain unapproved and were not performed. B-07 was not started.

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
