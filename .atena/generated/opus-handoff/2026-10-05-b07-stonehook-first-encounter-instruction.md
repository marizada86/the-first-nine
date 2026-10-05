---
status: implemented-published-human-accepted-awaiting-merge
kind: external-implementation-instruction
created: 2026-10-05
plan_id: 2026-10-05-b07-stonehook-first-encounter
spec: "[[2026-10-05-b07-stonehook-first-encounter]]"
evidence: "[[2026-10-05-b07-stonehook-first-encounter]]"
approval_mode: per-plan
approved: 2026-10-05
implementation_approved: true
execution_target: opus-5.5
baseline_commit: e189184e1928efca8172ce4a9c65996be81c206a
proposed_implementation_branch: codex/b07-stonehook-first-encounter
documentation_publication_approved: true
documentation_publication_source: owner-authorized-one-documentation-commit-and-normal-push-to-main
publication_snapshot: delivered-and-verified
documentation_published: true
delivery_commit: fcc98b63e1919c54b6df563c8de0c7173a7affcb
delivery_verified: true
implementation_branch: codex/b07-stonehook-first-encounter
implementation_base: fcc98b63e1919c54b6df563c8de0c7173a7affcb
implementation_evidence: "[[2026-10-05-b07-stonehook-first-encounter-implementation]]"
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

# B07 First Stonehook Encounter Instructions for Opus 5.5

Implement only the approved first Scree Crawler encounter in the existing Stonehook foothills. The owner selected option 1 on 2026-10-05, approving the presented B-07 scope per plan. No runtime implementation, publication or external dispatch has occurred while preparing this instruction. Follow the repository specification rather than reconstructing missing records from conversation summaries.

## Delivery and Checkout Gate

Work in `marizada86/the-first-nine`. On 2026-10-05, the owner authorized one documentation commit and normal push to main of this package and the integrated B-06 acceptance receipt. These records are written before that push; they do not assert its success. Do not begin from a pasted instruction alone or an older checkout without the approved records. Wait for the owner's explicit handoff supplying the verified published commit after authorized publication.

Inspect the branch, exact HEAD, staged and unstaged changes before synchronization. Preserve local work. Fetch `origin/main` without destructive resets. Verify that `e189184e1928efca8172ce4a9c65996be81c206a` is its ancestor, B-06 is the latest completed plan, and the delivered B-07 spec, evidence, instruction and active plan agree on explicit implementation approval and `per-plan`.

At delivery, the live records must have `documentation_publication_approved: true`. That authority applied to the owner's document push only and does not authorize you to push anything. The owner must supply the published document commit or a later verified descendant. Confirm that commit is on fetched `origin/main` and read its actual files. `publication_snapshot: pre-push` and `documentation_published: false` describe when these records were written, not a requirement for another receipt commit. Do not require a commit to contain its own hash. When owner-authorized delivery is independently verified from the fetched records and commit, report the delivery proof and clear the local document-delivery checkpoint before execution. Do not infer delivery merely from file names or a stale `origin/main`. Missing, inconsistent or still unauthorized records require a readiness report and a stop.

Use a separate `codex/b07-stonehook-first-encounter` branch from verified delivered main. If it exists, inspect its ancestry and work before reusing it; never reset or overwrite it. Report exact base and HEAD. Do not change main, discard unrelated work, amend published history, force-push, delete branches or install dependencies. Implementation approval covers the local scoped work, not its publication or a PR/merge.

## Read Before Editing

- Applicable `AGENTS.md`, `.atena/add.yaml` and `.atena/state/plan.yaml`.
- `.atena/specs/2026-10-05-b07-stonehook-first-encounter.md`, `.atena/evidence/2026-10-05-b07-stonehook-first-encounter.md` and this instruction.
- `.atena/evidence/2026-10-05-b06-integrated-human-acceptance.md` and the completed B-06 spec and implementation evidence.
- Canon: `2026-10-03-caravan-survival-slow-travel.md`, `2026-10-03-continuous-caravan-ground-and-web-gates.md`, `2026-10-04-first-boss-mark-and-cure.md` and `2026-10-04-separated-controls-and-wagon-management.md` under `.atena/vault/canon/`.
- `main.gd`, the runtime migration manifest and existing B-06 regression fixtures and runner under `.atena/generated/2026-10-04-b06-validation/`.

Owner-local Windows review logs may not be in the cloud checkout. Distinguish recorded external results from your own reproductions. Do not require those unpushed files or invent their contents. Preserve all historical validators and saved results. The older B-06 closure/preparation validators enforce their dated checkpoints; they are not supposed to pass unchanged when a new B-07 plan is active. The B-07 preparation/approval checks likewise describe earlier states and use an unpushed owner-local preservation manifest; they are not cloud execution prerequisites. The new document-delivery checker under `.atena/generated/2026-10-05-b07-delivery/` checks this published package without that local manifest. Use a new scoped B-07 implementation records validator rather than weakening historical checks.

## Implement the Approved Slice

Follow S-001 through S-003 in the B-07 specification without additional batch approvals. Add one finite, stable `stonehook_scree_crawler_01` at the proposed x=2340, after legitimate foothill entry, available day and night. Preserve the legitimate departure gate and keep `zone == 0` as the cave hub. Never enable the prototype `enter_stonehook()` scene, shrine, Stone Maw or later progression.

Select the actual crawler artwork by stable identity. Inspect the existing atlas and proposed (0, 0, 768, 480) source crop; do not alternate between unrelated creatures as animation frames. Use the existing sprite with facing, hit tint and procedural windup/lunge/recovery feedback. Preserve aspect ratio and grounded feet, prepare bounds before the first gameplay frame and use the same visible body in targeting and reach. Preserve unrelated Thornwake/prototype geometry. If this requires an asset binary edit, stop for a plan-change decision rather than generating or editing art.

Give the crawler readable warning, a locked strike direction, one hit per strike, recovery and counterplay through the existing dash. It never attacks the wagon, damages through the regional boundary or follows Lolth out of the foothills. Cancel a pending strike on retreat. Preserve live health across ordinary visits and keep the ore accessible without a mandatory kill. Numerical defaults in the spec are playtest data; report any scoped adjustment and test it.

Audit every cave-global enemy scan/clear and completion path. Crawler life must not stall cave night waves or block a valid cave safe capture, and cave waves must not erase the crawler. Real offscreen cave attacks, wagon damage, terminal checks and return access remain active. Never treat camera/displayed region as a second camp or freeze simulation for convenience.

Defeat pays at most one Echo under the unchanged cap. Save encounter activation/defeat/reward flags consistently with saved Echoes and ore. Failure rolls back unsaved defeat and reward together; preserve transient clearing, with one initial-health re-creation on a later foothill visit if the saved encounter was undefeated. Saved defeat stays defeated. Ordinary retreat does not reset health. F4 restoration deep-restores the live actor and timers exactly; a new run clears all added state.

Only `main.gd` is an allowed production edit. New validation, captures and records belong under `.atena/`. Preserve controls, menus, right-click inactivity, Mark I, one cure, fixed wagon and family, existing in-memory save rules and B-06 limitations. No boss, Mark II, second cure, wagon travel, parry, new enemies, missions/posts, axle/brakes progression, web/rope mechanics, later regions, new assets/audio, dependencies or disk saves. Obtain a plan change before expanding scope or altering another production file.

## Validate Without Weakening Earlier Tests

Add a headless B-07 self-test, a real-input runtime fixture, negative controls and a runner in `.atena/generated/2026-10-05-b07-validation/`. Cover every acceptance criterion, including repeated visits/days, geometry/facing, hit/miss/First Thread, windup/dash/single hit, retreat/bounds, cave-wave coexistence and safe capture, reward cap, ore, failure rollback, F4 exact restore and new-run reset.

Keep keyboard-only controller isolation before the first gameplay frame and prove its timing. Run trigger-noise checks separately and retain a genuine controller-input section. Use settled movement measurements. Run the unchanged historical combat/menu/geometry/facing fixtures where applicable and the existing B-06 route checks. New actor integration may require a separately explained B-07 wrapper around an old boundary assertion; do not silently remove a check, alter historical files or report an old B-06 count as a fresh B-07 result. Explicitly document intentional assertion adaptations and preserve their protected behavior.

Reject genuine faulty controls for duplicate spawn, wrong creature frame, wrong reach, no warning, repeated strike damage, cross-region pursuit, cave-wave erasure, safe-capture confusion, repeated reward, incomplete failure rollback and incomplete F4 restore. A parser/import crash is not a successful negative-control rejection. Record named failures and actual nonzero process exits.

Use Godot 4.7.2 when available and record the actual platform, executable/version, commands, exits and warnings. On owner-local Windows use `D:/Godot/godot.exe`; that path is not assumed in cloud Linux. Do not install a runtime or dependency without authorization. Run full self-tests plus rendered and headless 600-frame smoke checks. Capture 1280x720 day/night, both facings, windup, hit, miss and retreat. Inspect the captures; numerical checks alone do not establish clean sprite rendering. Keep your Linux results separate from Atena's future official Windows validation, including known platform-specific facing differences. No CI result is inferred.

## Reconcile and Return for Review

Write `.atena/evidence/2026-10-05-b07-stonehook-first-encounter-implementation.md`. Update the B-07 spec, evidence, instruction and active plan to the actual implementation-awaiting-review checkpoint, with completed steps, tested behaviors, evidence links and limitations. Preserve B-06 and all completed history unchanged. Do not mark the plan complete or infer human acceptance from self-tests.

Return exactly these sections in English:

1. Checkout and changes: exact branch/base/HEAD, changed files, working-tree state and any local commits.
2. Implemented behavior: encounter, geometry, attacks, cave coexistence, rewards and restoration.
3. Validation: actual commands, version/platform, exits, assertion results, faulty controls, logs and inspected captures; distinguish new runs from historical evidence.
4. Remaining limitations and review steps: failed/unverified criteria, human tuning and proposed owner-local tests.
5. Approval and publication state: implementation awaiting review, nothing pushed, no PR/merge, no later batch started and a non-authorizing next recommendation.

Stop for the owner's review. Do not push, open or merge a PR, send external messages, delete branches or begin B-08. Automatic hooks and tool-generated publication links are not owner authorization.

## Delivery Verification and Implementation Checkpoint

On 2026-10-05, the owner supplied the published documentation commit `fcc98b63e1919c54b6df563c8de0c7173a7affcb` and the explicit implementation handoff. The executor fetched origin and verified that commit as `origin/main`, a direct child of `e189184`; the committed delivery checker passed. The local delivery checkpoint was then cleared. The earlier `pre-push` snapshot and false publication field describe the dated pre-push checkpoint and are superseded here, not rewritten. S-001 through S-003 were executed locally on `codex/b07-stonehook-first-encounter` from that commit. Results, implementation decisions and limitations are in [[2026-10-05-b07-stonehook-first-encounter-implementation]]. The plan awaits human review: nothing is pushed, no PR or merge exists, human acceptance is pending and no B-08 work has started.

## Publication Review and Owner Acceptance

The previously local-only implementation checkpoint is superseded by the verified publication of `4da953cd34469b8024eb2d3831ba7c8ae06cb34a` on `origin/codex/b07-stonehook-first-encounter`. Earlier sections remain dated implementation history.

Fresh Atena Windows review of 4da953c: Godot 4.7.2, GTX 1650, full runner exit 0; B07 24/24 and real-input 28/28; B06 30/30 and 53/53; combat/noise 9/9 each; menus 33/33; geometry 46/46; facing 65/65 and 102/102; self-test and both 600-frame smoke passes; 11 faulty controls genuinely rejected, zero project diagnostics; eight fresh captures inspected.

Owner replied "aceito, borah" after the Windows technical report, accepting B-07 with its listed limitations and explicitly authorizing record publication, PR opening, regular merge, operational closure and B-08 proposal preparation only. No itemized owner playtest or B-08 implementation approval is inferred.

The accepted limitations are static art, unreviewed balance, foreground occlusion, overlapping labels/ore and in-memory saves; F4 encounter restore was headless-tested. No new executor Linux run or CI result is claimed. Opening and merging the PR are authorized but have not occurred at this records checkpoint. B-08 remains an inactive preparation-only proposal.
