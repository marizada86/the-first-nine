---
status: implementation-merged-owner-authorized-playtest-pending
kind: external-implementation-instruction
created: 2026-10-05
plan_id: 2026-10-05-b08-stonehook-cliff-harrier
spec: "[[2026-10-05-b08-stonehook-cliff-harrier]]"
evidence: "[[2026-10-05-b08-stonehook-cliff-harrier]]"
approval_mode: per-plan
approved: 2026-10-05
implementation_approved: true
execution_target: cloud-executor
baseline_commit: 4d3c5c1ae5411aaf58e6fd7ae8333e45ecef7ac1
implementation_branch: codex/b08-stonehook-cliff-harrier
documentation_published: true
push_approved: true
pull_request_approved: false
merge_approved: true
dispatch_approved: false
implementation_evidence: "[[2026-10-05-b08-stonehook-cliff-harrier-implementation]]"
human_acceptance: pending
implementation_published: true
integration_approved: true
integration_commit: 88d7cfb16e06644d606623aee5ea3d12dfeab32c
integration_evidence: '[[2026-10-05-main-integration]]'
integration_executor: local-atena
---

# B08 Stonehook Cliff Harrier Instructions

This record transcribes the owner's 2026-10-05 B-08 implementation message, which approved the revised scope with per-plan approval (option 1). It is written by the executor before implementation, as the message requires. Use it together with [[2026-10-05-b08-stonehook-cliff-harrier]].

## Starting Point

Work in `marizada86/the-first-nine` on `codex/b08-stonehook-cliff-harrier`, created from verified integrated main `4d3c5c1ae5411aaf58e6fd7ae8333e45ecef7ac1`. B-07 is complete:

- implementation `4da953c`;
- acceptance records `523421e`;
- PR #7 regular merge `2684dac`;
- closure `4d3c5c1`.

The owner-local B-08 drafts are unpublished and not required. Preserve existing branches and work. Stop on unexpected divergence or conflicting active work.

## Implementation Rules

Implement S-001 to S-003 as specified, with these rules:

- **Files.** Only `main.gd` may change in production. Tests, captures and records go under `.atena/`.
- **Reuse.** Follow the B-07 conventions with minimal change.
- **Defaults.** Report and validate any tuning adjustment.
- **Earlier suites.** Keep the B-07 and B-06 meaning intact: their fixtures run with the Harrier resolved, as B-06 did with the crawler. Explain any regression wrapper. Never weaken a protected assertion or edit a historical validator or saved result.

## Validation Required

Add fresh headless and real-input tests for:

- activation;
- grounded hit/miss and nearest eligible target;
- vertical reach;
- both facings and camera offsets;
- the warning, locked aim, dash and single-hit strikes;
- bounds and simultaneous combat;
- all four save combinations;
- unsaved rollback;
- F4 restore through real input;
- new-run reset and independent ore handling.

Also run the B-07 and B-06/core regressions, the full self-test and both 600-frame smoke runs.

Reject genuine faulty controls for wrong artwork, unreachable flight, late bounds preparation, retargeting, repeated damage, boundary escape, shared defeat/reward state, duplicate rewards and incomplete restoration. A parser or import crash is not a rejection.

Inspect captures of day/night, both facings, warning/strike/recovery and both actors together. Record the engine version, platform, commands, exits and limitations, and keep Linux results apart from reported Windows evidence.

## Return

Reconcile the spec, evidence, this instruction and the active plan truthfully, without marking B-08 complete. A local implementation commit is allowed after validation. Do not:

- push or open a PR;
- merge or delete branches;
- message other tasks;
- start B-09.

Return five English sections: checkout and changed files; implemented behavior and tuning; validation and captures; limitations and review steps; exact commit/branch and approval/publication state. Then stop for owner review.

## Implementation Checkpoint

On 2026-10-05, S-001 through S-003 were executed locally on `codex/b08-stonehook-cliff-harrier` from verified integrated main `4d3c5c1`. Results, tuning adjustments, inspected captures and limitations are in [[2026-10-05-b08-stonehook-cliff-harrier-implementation]]. The plan awaits human review: nothing is pushed, no PR or merge exists, human acceptance is pending and no B-09 work has started. The earlier "in implementation" wording describes the dated pre-implementation checkpoint and is superseded here.

## Main integration on 2026 10 05

The earlier implementation and publication restrictions describe their dated checkpoints. The owner subsequently authorized publication of 052ec6466ee2a8252cf54f6f72ed11f0cc26e045 to codex/b08-stonehook-cliff-harrier, then directly requested combining the project into main and updating it. This authorizes the current normal integration and push, not new gameplay or an external dispatch.

Main now contains the regular merge 88d7cfb16e06644d606623aee5ea3d12dfeab32c, with parents 6e6410e80a49b5c0542aeda9dc4f448f338cf3b3 and 052ec6466ee2a8252cf54f6f72ed11f0cc26e045. A normal push from 4d3c5c1 to 88d7cfb succeeded and GitHub refs were freshly verified. The B-08 feature branch remains at 052ec646; no PR was opened and no branch was deleted.

Fresh combined-build Windows validation and its one approved-name baseline adjustment are recorded in [[2026-10-05-main-integration]]. B-08 passed 34/34 headless and 33/33 real-input checks; the existing regressions, full self-test, smoke runs and eleven faulty controls retained their meaning. Forms passed 196/196. Earlier Linux and Windows review evidence remain separate historical checkpoints; the later integrated tests do not retroactively change them.

The implementation is integrated by explicit owner authority, while balance and itemized human playtest remain pending. No detailed human acceptance is inferred. Existing static-art, overlap, foreground and in-memory-save limitations remain. The approved B-09 images are repository-published offline art only; B-09 gameplay and runtime admission are not started. This handoff is historical, not authority to send further work to an external executor.
