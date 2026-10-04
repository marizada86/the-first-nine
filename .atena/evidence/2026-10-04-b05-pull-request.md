---
status: complete-implementation-merged
kind: pull-request-receipt
created: 2026-10-04
batch: B-05
request_classification: IN_PLAN
approval_mode: per-plan
plan: "[[2026-10-04-b05-thornwake-combat-readability]]"
geometry_evidence: "[[2026-10-04-b05-enemy-geometry-followup]]"
pull_request: https://github.com/marizada86/the-first-nine/pull/4
pull_request_approved: true
merge_approved: true
merge_commit: bc7796e0fad33f5d7b773af3eaefc07749ec81b4
receipt_publication_approved: true
closure_evidence: "[[2026-10-04-b05-documentation-closure]]"
---

# B-05 pull request receipt

Current state: PR #4 merged and B-05 completed. The owner separately approved documentation closure and main publication. Sections below preserve opening/merge checkpoints; their restrictions and reference heads are historical. See [[2026-10-04-b05-documentation-closure]].

The owner explicitly authorized opening the B-05 PR from `codex/b05-controls-wagon-inventory` into `main`, without merge. Classified IN_PLAN under the active per-plan B-05 plan. This authorization is not approval for merging, auto-merge, branch deletion, another push or B-06.

## Opening verification (historical)

- PR #4: open, not draft, not merged. Attached to the current Codex chat.
- Title: `B-05: combat readability, controls, Wagon inventory and enemy geometry`.
- Base: `main`, `9ea4fc1bbfabd5be50a2d7f334b9b11325b8a77b`.
- Head: `codex/b05-controls-wagon-inventory`, `e5832da604226b33f424d18248b24f0825c568aa`.
- Six commits retained: `4400b59`, `43ab112`, `bb4a0d4`, `e6b614c`, `b8823c7`, `e5832da`.
- 86 changed files, +2935/-169. Runtime, ADD records, validation scripts and committed screenshots/logs are included; the PR is not only the geometry correction.
- Local `git merge-tree --write-tree` returned success without conflicts. This creates only diagnostic Git objects, not a branch merge. GitHub's post-creation metadata reports mergeable=true.
- CI: 0 check runs (GitHub API), 0 commit statuses and 0 PR-triggered workflow runs. These are not successful CI results. Validation remains the committed Windows tests and reviewer-reported Linux reproduction.
- Creation/get-info metadata confirms merged=false. GitHub's generated `merge_commit_sha` while the PR is open is a test-merge object, not evidence of an actual merge.

The English description includes the original B-05 and revised controls/menu/dash/geometry scope, validation provenance, owner acceptance, deferred balance/Mark/UI work, in-memory saves and the PR-only authorization boundary.

## Delivered technical review

The owner's supplied final Opus report reviewed exactly `e5832da` and reported no blockers, clean hypothetical merge compatibility, Linux Godot 4.7.2 reproduction of 46/46 geometry, five rejected fault subclasses, 9/9 combat, 33/33 controls/menus, self-tests and both 600-frame smoke runs. It measured approximately 607 ms headless / 965 ms normal startup preparation, zero added scans, and pose-dependent Stag reach. These remain attributed reviewer results, not new Atena engine runs or GitHub CI.

The report identifies record clarity work for closure: distinguish original versus current implementation branches/commits, label original local-only authority as historical after later publication approvals, and reconcile older status fields. This receipt and the active plan record the new PR facts without pretending that the historical notes were authored after the PR. Full B-05 completion/closure remains pending merge and its separately authorized reconciliation.

## Opening receipt reconciliation (historical)

Only this receipt, the active plan's operational facts and the operational record validator change locally. No runtime, art, canonical rule, test log or metric changes; no new engine results are claimed. A local records commit preserves the receipt without pushing it into the already-reviewed PR. PR head remains `e5832da`; local receipt publication requires separate authority or inclusion in a later authorized closure. Existing feature branches are retained, main is unchanged and B-05 stays active. No auto-merge, merge, branch deletion or B-06 is performed.

## Subsequent authorized regular merge (historical integration checkpoint)

After the opening receipt was saved locally as `f0ee44f36a1ed4ef47463d4c198b25fb927ef201`, the owner explicitly authorized a normal merge preserving the six commits and branches. Classified IN_PLAN. This later authorization supersedes the PR description's original creation-time no-merge boundary only for PR #4; it does not approve branch deletion, B-06 or a documentation push/closure.

GitHub merged PR #4 with method `merge`, guarded by expected head `e5832da604226b33f424d18248b24f0825c568aa`. Verified result: `bc7796e0fad33f5d7b773af3eaefc07749ec81b4`, with parents `9ea4fc1bbfabd5be50a2d7f334b9b11325b8a77b` and `e5832da604226b33f424d18248b24f0825c568aa`. Post-merge metadata confirms state=closed, merged=true and that exact merge SHA.

Remote `main` and both local main references are now `bc7796e`, confirmed by fetch/`ls-remote`. Git ancestry checks confirm all six PR commits remain reachable from main. The merged tree is identical to `e5832da` (zero diff), so no extra runtime or file-content change was introduced by the merge. No new engine-test run is claimed.

Remote branches are preserved: `codex/b05-controls-wagon-inventory` at `e5832da` and `b05-thornwake-combat-readability` at `4400b59`. The current local feature branch retains the unpushed PR receipt and this later operational update; no local work was overwritten and no receipt commit was silently included in the PR.

B-05 remains active as `merged-awaiting-documentation-closure`, with B-04 still the last completed plan until the separately authorized closure. Main still contains the pre-PR record state from `e5832da`; the local receipt records the newer facts. Only this receipt, active-plan facts and operational validator change locally, in an ordinary unpushed records commit. No auto-merge, branch deletion, further push, full documentation closure or B-06 is performed.

## Authorized documentation closure

The owner explicitly authorized closing B-05, correcting Opus's record-clarity findings, and publishing records only on main. B-05 is now the last completed plan, with no active plan and no B-06. The implementation branch/current reviewed head are `codex/b05-controls-wagon-inventory` / `e5832da`; the original branch/`4400b59` are preserved as history. Initial local-only restrictions are reconciled with later approval stages.

Receipt contents are recovered into this main closure from local receipt commits `f0ee44f36a1ed4ef47463d4c198b25fb927ef201` and `3b37c9f5e24b15ddb98fccd9963c9e04c9f7fcde`. Those two commits remain on the local feature branch; they are not represented as PR commits or silently cherry-picked. Their feature branch and all remote feature refs remain preserved. This closure does not alter the game or claim a fresh engine/CI run.
