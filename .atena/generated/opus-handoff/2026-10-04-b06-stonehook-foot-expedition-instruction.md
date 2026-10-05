---
status: complete-implementation-merged
kind: external-implementation-instruction
created: 2026-10-04
plan_id: 2026-10-04-b06-stonehook-foot-expedition
spec: "[[2026-10-04-b06-stonehook-foot-expedition]]"
evidence: "[[2026-10-04-b06-stonehook-foot-expedition]]"
approval_mode: per-plan
approved: 2026-10-04
approval_source: owner-selected-1-to-approve-the-presented-B06-implementation-scope
implementation_approved: true
execution_target: opus-5.5
documentation_publication_approved: true
documentation_published: true
delivery_commit: 77ee387d5649a131ae20c5910b2dc7421c76f22f
push_approved: true
pull_request_approved: true
merge_approved: true
dispatch_approved: false
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

# B-06 Stonehook Foot Expedition Instructions for Opus 5.5

Implement only the first reversible on-foot expedition from Thornwake to early Stonehook, using the repository plan as the source of truth. The owner approved the complete bounded implementation scope per plan by selecting option 1 on 2026-10-04 and then authorized documentation publication to main. Repository delivery is recorded below; this instruction has not been sent as an external message. Verify the delivered approval records before editing anything.

## Approval and Delivery Gate

Work in `marizada86/the-first-nine`. Inspect `.atena/state/plan.yaml`, the linked B-06 spec/evidence and this instruction. Require the delivered records to agree on explicit B-06 implementation approval and `per-plan`. Once authorized delivery is recorded and its checkpoint cleared, execute S-001 through S-004 without seeking new batch or step approval within this unchanged scope. If the live records are missing, unconfigured, unapproved or still awaiting delivery, read and report readiness only; do not start. Old B-01 through B-05 approvals, the accepted playtest and a pasted copy of this instruction do not substitute for the delivered B-06 approval records.

Report the exact inspected branch, HEAD and working-tree status. Fetch origin/main without discarding local work. It must contain acceptance `2f34635ff5adf735e51a7c144862e7c1bba37bed`, preparation `0a82ead8384969a11399f20ef3dcf3828734df27` and approval `77ee387d5649a131ae20c5910b2dc7421c76f22f`, plus this delivery reconciliation or a later verified descendant. Those three commits were normally pushed and verified at remote HEAD `77ee387`; gameplay remains from `05eac1e7a639e213f39cff81b1e75305727ab4d0`. Do not require an obsolete exact HEAD or start from the still-pending delivery wording at the initial approval commit. Confirm the listed records exist and the branch contains the accepted facing implementation/merge, preparation, approval and cleared delivery checkpoint. Stop and report missing delivery if required commits or files are absent. Never pretend an older branch contains a newer correction or reconstruct unseen records from this summary.

Use a separate `codex/b06-stonehook-foot-expedition` branch from the verified delivered main after the execution gate is met. Preserve dirty work and all existing branches. No force-push, destructive reset, published-history amend or branch deletion. The documentation push is already authorized and recorded; `push_approved: false` refers to future B-06 implementation publication. Per-plan implementation approval does not authorize that push, PR, merge or external messages.

## Read Before Editing

- `.atena/add.yaml`, applicable `AGENTS.md` instructions and `.atena/state/plan.yaml`.
- `.atena/specs/2026-10-04-b06-stonehook-foot-expedition.md` and `.atena/evidence/2026-10-04-b06-stonehook-foot-expedition.md`.
- `.atena/vault/canon/2026-10-03-caravan-survival-slow-travel.md` and `2026-10-03-caravan-relics-cave-prologue-and-travel.md`.
- `.atena/vault/canon/2026-10-03-continuous-caravan-ground-and-web-gates.md`, `2026-10-04-first-boss-mark-and-cure.md`, `2026-10-04-separated-controls-and-wagon-management.md` and `2026-10-03-minimal-stonehook-visual-direction.md`.
- Completed B-04 safe-wagon spec/evidence, B-05 controls/menu and geometry evidence, enemy-facing correction spec/evidence and `2026-10-04-enemy-facing-pull-request.md`.
- `main.gd`, `wagon_inventory_ui.gd` and the existing isolated combat/menu/geometry/facing validation scripts.

Later approved caravan decisions supersede the older statement that the wagon travels immediately after the first cure. Respect the current stationary cave hub and protected family/relics.

## Implement the Bounded Slice

Follow S-001 through S-004 and B-001 through B-003 in the approved spec. Add only one continuous floor-level corridor and reversible horizontal world/view translation. Proposed playtest spans are the unchanged 0-1280 Thornwake area, a 480-unit transition band and one 1280-unit Stonehook foothill section; keep the cave at x=190 and the existing ground height. Treat dimensions as reported playtest data, not lore.

Separate Lolth's displayed region from the stationary hub and actor-origin context. Do not merely remove `wagon_travel_locked()` or call `spawn_zone()` at a border. Departure requires legitimate Mark I, exactly one cure, repaired wagon and a survivable saved camp. Mark-only F4 overrides must not manufacture entitlement. Keep the return route physically available once away.

Spatially blend existing route/backdrop/foreground art across the connecting band. Do not use scene replacement, position reset, map selection, a loading card or a full-screen temporal dissolve. HUD and all interfaces stay in screen space. Preserve sprite reflection, grounded feet, native Thornwake aspect, shared-outline reach and prepared bounds while composing camera transforms.

Add one stable finite ore pickup, carry it with existing capacity rules and deposit at the actual cave wagon. Border revisits must not respawn loot, enemies or supplies. Audit every remote E/M/UI/save/craft path so camera or region changes cannot create a second camp or unlock ally roles.

Keep clock, Flame, Provisions, existing Thornwake waves, concrete cave attackers and wagon failure/defense active offscreen. Do not freeze or clear the camp at borders, or replace real enemies with invented abstract damage. Restore terminal failure anywhere to the latest valid cave snapshot, preserving Mark I and the selected cure and rolling back unsaved expedition data. Extend safe-wagon/F4/new-run coverage for route/camera/pickup state; never snapshot zero terminal values.

Preserve all current inputs and UI click isolation. No wagon travel, Mark II, second cure, parry, posts/missions, Stone Maw/shrine, axle/brakes crafting, rope teleport, Web Anchors, Hollowroot, new art/audio, dependencies or disk persistence. No new Stonehook combat in this first traversal slice. Allowed production edits are `main.gd` and narrowly necessary guard changes in `wagon_inventory_ui.gd`; all tests/records belong under `.atena/`. Ask for a plan change before any broader architecture or scope expansion.

## Validate and Return

Use the local Godot runtime (`D:/Godot/godot.exe` on Windows) or the available Godot executable in the external environment. Record actual version/platform, commands, exits and diagnostics. Do not edit production files to force a platform match or use a fixed-FPS workaround.

Add B-06 headless and real-input outward/return checks, border-repeat/capacity cases, offscreen Stag damage, terminal rollback at the foothills, exact F4 restore and new-run locks. Include camera-offset combat and UI tests and five transition positions in both day/night at 1280x720. Add genuine targeted negative controls for illegitimate departure, border duplication, remote camp/save access, paused offscreen simulation, lost restore fields and accidental progression unlocks.

Rerun the full self-test and applicable prior combat/menu/geometry/facing suites, writing fresh results to `.atena/generated/2026-10-04-b06-validation/` rather than overwriting committed evidence. Distinguish reproduction from inspected historical results. Preserve the intent of previous assertions; explain any narrow approved boundary adaptation. Do not use `self_test_travel_bypass` as an ordinary gameplay entitlement.

Write `.atena/evidence/2026-10-04-b06-stonehook-foot-expedition-implementation.md` and reconcile the spec/evidence/plan to actual implementation-awaiting-review status. Report: exact branch/base/head, changed files, implemented behavior, tests and actual exits, new captures, unresolved limitations, approval/checkpoint state and the next non-authorizing recommendation. State whether anything was committed or published. Stop for owner review. Do not push, open a PR, merge, delete a branch or start another batch without its required authority.

## Execution Record

The owner directed the assigned executor, in its chat session on 2026-10-05, to read this delivered instruction from the repository. Atena sent no external message, and `dispatch_approved` is unchanged. The executor verified the gate above and implemented the approved scope locally on `codex/b06-stonehook-foot-expedition` (implementation commit `42bddf8`, base `7e477ba`). Results are in [[2026-10-04-b06-stonehook-foot-expedition-implementation]]. Nothing was pushed, and no PR, merge or B-07 work occurred.

## Publication and Follow-up Record

The owner separately authorized the branch push; `origin/codex/b06-stonehook-foot-expedition` was created at `ccc4fcf69271d88e421e26a81841cf6cce834a37`. The reviewed follow-up `d2012a1` is local only. See [[2026-10-04-b06-stonehook-foot-expedition-implementation]].

## Follow-up Publication and Isolation Record

The owner separately authorized publishing `d2012a1` and `7c781ab`; the branch now stands at `7c781ab65d75251af20880cf6e9548d1239be0dd`. The test-only isolation follow-up `b446b7b` is local. See [[2026-10-04-b06-stonehook-foot-expedition-implementation]].

## Isolation Publication and Combat Isolation Record

The owner separately authorized publishing `b446b7b` and `9640881`; the branch stood at `9640881e2c56b010fb1be93b3818f22be91d3b9c` before this follow-up. The test-only combat isolation follow-up is local. See [[2026-10-04-b06-stonehook-foot-expedition-implementation]].

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
