---
status: implementation-merged-owner-authorized-playtest-pending
kind: preparation-evidence
created: 2026-10-05
plan_id: 2026-10-05-b08-stonehook-cliff-harrier
spec: "[[2026-10-05-b08-stonehook-cliff-harrier]]"
instruction: "[[2026-10-05-b08-stonehook-cliff-harrier-instruction]]"
baseline_commit: 4d3c5c1ae5411aaf58e6fd7ae8333e45ecef7ac1
approval_mode: per-plan
approved: 2026-10-05
request_execution_classification: IN_PLAN
implementation_approved: true
engine_rerun: true
documentation_published: true
push_approved: true
pull_request_approved: false
merge_approved: true
dispatch_approved: false
implementation_branch: codex/b08-stonehook-cliff-harrier
implementation_evidence: "[[2026-10-05-b08-stonehook-cliff-harrier-implementation]]"
human_acceptance: pending
implementation_published: true
integration_approved: true
integration_commit: 88d7cfb16e06644d606623aee5ea3d12dfeab32c
integration_evidence: '[[2026-10-05-main-integration]]'
integration_executor: local-atena
---

# B08 Preparation Evidence

The executor prepared this record before any B-08 production change, following the owner's 2026-10-05 message. That message approves the revised scope and selects per-plan approval (option 1).

## Starting Point Verification

- **Local state before preparation:** the checkout was on `codex/b07-stonehook-first-encounter` at `4da953c`, with a clean tree.
- **Fetch:** origin was fetched without overwriting local work. `origin/main` is `4d3c5c1ae5411aaf58e6fd7ae8333e45ecef7ac1`.
- **Ancestry:** `4da953c` (implementation), `523421e` (acceptance records), `2684dac` (PR #7 regular merge, parents `fcc98b6` and `523421e`) and `4d3c5c1` (closure) are all ancestors of `origin/main`. The merged tree equals the `523421e` tree.
- **B-07 closure:** `.atena/state/plan.yaml` had `active_plan: null` and `plan_cursor: complete`. B-07 was `last_completed_plan` with `complete-implementation-merged`, human acceptance and the Windows review receipt [[2026-10-05-b07-windows-review]].
- **Branches:** no B-08 branch existed locally or on origin. `codex/b08-stonehook-cliff-harrier` was created from `origin/main`, without upstream tracking. Local `main` and the B-07 branch were left unchanged.
- **Material read:** the integrated B-07 spec, evidence, implementation note, Windows review receipt and production code.
- **Windows evidence:** those results are Atena's externally reported runs, not executor runs.

## Inspected Evidence

The existing atlas was read in a scratch copy with a headless Godot 4.7.2 probe and the game's alpha >= 0.25 rule. No asset was changed.

| Region | Finding |
| --- | --- |
| Proposed crop `(768, 0, 768, 497)` | Alpha bounds `(37, 8, 613, 488)`: only the bird, wings and claws included, facing right natively |
| Rows 496-497 | Empty |
| Below row 497 | The next cell's creature begins at row 500 |

At the 110 px body height the visible footprint is 138.2 px wide, so the half width is 69.1.

The existing code was also inspected:

- **Targeting.** Melee uses a body-width horizontal reach and a 70 px vertical check around `pos.y`.
- **Crawler bounds.** The B-07 crawler crop has its own `ui_encounter_bounds_scans` counter, which both B-07 validators assert equals 1.
- **Shared fixture.** `reach_expedition_ready_for_test(with_encounter)` resolves the crawler for B-06 suites.

## Preparation Outcome

The Harrier's world position will be its displayed anchor, the ground-enemy anchor raised by its altitude, so grounded reach needs no global change. The Harrier crop gets its own scan counter, keeping the B-07 assertions' meaning. The shared fixture gains a Harrier opt-in, so B-06 and B-07 suites run with the Harrier resolved.

One proposed default is arithmetically incompatible. A dive from 180 cannot reach a standing Lolth, because body reach (113.1) plus maximum dive travel (66) is 179.1. Attack initiation is therefore set to 170 and reported. No blocking gap remains. The plan was activated with `approval_mode: per-plan` before implementation; completed history and the B-07 closure are preserved.

These are preparation checks only. No gameplay result is claimed here.

## Implementation Checkpoint

On 2026-10-05, S-001 through S-003 were executed locally on `codex/b08-stonehook-cliff-harrier` from verified integrated main `4d3c5c1`. Results, tuning adjustments, inspected captures and limitations are in [[2026-10-05-b08-stonehook-cliff-harrier-implementation]]. The plan awaits human review: nothing is pushed, no PR or merge exists, human acceptance is pending and no B-09 work has started. The earlier "in implementation" wording describes the dated pre-implementation checkpoint and is superseded here.

## Main integration on 2026 10 05

The earlier implementation and publication restrictions describe their dated checkpoints. The owner subsequently authorized publication of 052ec6466ee2a8252cf54f6f72ed11f0cc26e045 to codex/b08-stonehook-cliff-harrier, then directly requested combining the project into main and updating it. This authorizes the current normal integration and push, not new gameplay or an external dispatch.

Main now contains the regular merge 88d7cfb16e06644d606623aee5ea3d12dfeab32c, with parents 6e6410e80a49b5c0542aeda9dc4f448f338cf3b3 and 052ec6466ee2a8252cf54f6f72ed11f0cc26e045. A normal push from 4d3c5c1 to 88d7cfb succeeded and GitHub refs were freshly verified. The B-08 feature branch remains at 052ec646; no PR was opened and no branch was deleted.

Fresh combined-build Windows validation and its one approved-name baseline adjustment are recorded in [[2026-10-05-main-integration]]. B-08 passed 34/34 headless and 33/33 real-input checks; the existing regressions, full self-test, smoke runs and eleven faulty controls retained their meaning. Forms passed 196/196. Earlier Linux and Windows review evidence remain separate historical checkpoints; the later integrated tests do not retroactively change them.

The implementation is integrated by explicit owner authority, while balance and itemized human playtest remain pending. No detailed human acceptance is inferred. Existing static-art, overlap, foreground and in-memory-save limitations remain. The approved B-09 images are repository-published offline art only; B-09 gameplay and runtime admission are not started. This handoff is historical, not authority to send further work to an external executor.
