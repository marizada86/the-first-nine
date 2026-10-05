---
status: technical-review-passed-owner-accepted
kind: windows-review-evidence
created: 2026-10-05
plan_id: 2026-10-05-b07-stonehook-first-encounter
spec: "[[2026-10-05-b07-stonehook-first-encounter]]"
reviewed_commit: 4da953cd34469b8024eb2d3831ba7c8ae06cb34a
implementation_base: fcc98b63e1919c54b6df563c8de0c7173a7affcb
request_execution_classification: IN_PLAN
engine_rerun: true
human_acceptance: accepted
publication_of_this_receipt: authorized-awaiting-push
---

# B07 Windows Technical Review

Fresh Windows validation of the published Scree Crawler implementation passed on 2026-10-05. These results were reproduced by Atena and are separate from the executor's Linux evidence. They do not record owner playtesting, human acceptance, PR authorization or merge authorization.

## Checkout and Execution

The fetched feature reference is `origin/codex/b07-stonehook-first-encounter` at `4da953cd34469b8024eb2d3831ba7c8ae06cb34a`. The owner checkout remains on `main` at `fcc98b63e1919c54b6df563c8de0c7173a7affcb`, retaining its B08 deferred-request edit and untracked evidence. No gameplay file in the owner checkout changed.

Tests ran in the detached isolated clone `.atena/generated/2026-10-05-b07-windows-review/checkout/`, at the exact feature commit. Runtime import was performed before validation. An initial sandboxed editor import reported blocked editor data/config/cache access; the subsequent authorized import outside the sandbox exited 0 without those errors. The import attempt is not counted as a successful gameplay test.

Environment: native Windows x64, Godot `4.7.2.stable.official.ed1daf0bf`, OpenGL compatibility, 1280x720, NVIDIA GeForce GTX 1650, driver 616.92. No fixed-FPS option was supplied.

Full command, run from the isolated clone:

`rtk proxy node .atena/generated/2026-10-05-b07-validation/run_validation.cjs all`

The runner exited 0. All 24 case JSON files identify `win32`, pass their expected outcome and contain zero project diagnostics. Raw Windows logs, results, metrics and captures remain under the isolated clone's `.atena/generated/2026-10-05-b07-validation/`. The published Linux evidence in the owner repository was not overwritten.

## Results

| Check | Fresh Windows result |
| --- | --- |
| B07 headless | 24/24, exit 0 |
| B07 real-input runtime | 28/28, exit 0 |
| Full self-test | B01 through B07 and playtester pass, exit 0 |
| B06 headless and route runtime | 30/30 and 53/53, exit 0 |
| Combat and continuous trigger-noise combat | 9/9 each, exit 0 |
| Inventory and wagon menus | 33/33, exit 0 |
| Geometry | 46/46, exit 0 |
| Facing headless and rendered | 65/65 and 102/102, exit 0 |
| Rendered and headless smoke | 600 frames each, exit 0 |
| Eleven faulty controls | All genuinely rejected with exit 1 and their required named assertions; no script/import crashes |

The unchanged implementation-checkpoint `validate_records.cjs` subsequently exited 0: 32 resolved links, preserved completed history, scoped changes and saved Windows outcomes checked. Its dated publication gates describe the pre-push implementation record, not the separately verified publication fact. No historical checker was modified.

## Code and Capture Review

Reviewed the new encounter path, spawn guards, separate cave/foothill actor storage, shared combat targeting, fixed sprite crop and startup bounds, warning and lunge handling, one-time reward, safe/checkpoint restoration and reset. The B06 fixture's resolved crawler default is confined to test setup; B07 explicitly requests a live encounter. It does not alter normal progression.

Inspected all eight fresh Windows crawler captures: day and night, both facings, windup, hit, miss and retreat. The crawler uses only its own artwork, keeps natural proportions and grounded feet, mirrors correctly, and shows a visible warning and hit feedback. Existing close-range name overlap and the ore behind the creature remain visible. Capture inspection is not an owner playtest or a sealed game-dev adapter run; this repository has no `.game-dev/adapter.json`.

No technical blocker was found in this review. Proposed home x=2340 was moved to x=2520 with patrol 2400-2860 to avoid the existing foreground occlusion. A landed lunge uses the existing one-point hurt in Lolth's three-health model, rather than the proposal's incompatible twelve-health wording. These are reported implementation tuning choices for owner acceptance, not newly approved canon.

## Remaining Decisions

Owner acceptance and authorized PR, merge and operational closure are still pending. Balance is unreviewed, saves remain in memory, art is static, foreground and label limitations persist, and F4 exact encounter restore is headless-tested rather than a fresh rendered F4 input case. No CI result is claimed.

B08 remains an inactive proposal. Before its approval, reconcile the proposed ten-health strike to the existing one-point hurt model, reassess placement against this crawler's actual patrol, and retain independent actor/reward restoration. Its execution target remains the external cloud session. No B08 implementation, publication, active-plan replacement, commit, PR or merge occurred during this review.

## Subsequent Owner Acceptance and Integration Authority

On 2026-10-05, Owner replied "aceito, borah" after the Windows technical report, accepting B-07 with its listed limitations and explicitly authorizing record publication, PR opening, regular merge, operational closure and B-08 proposal preparation only. No itemized owner playtest or B-08 implementation approval is inferred. The earlier remaining-decision section describes the technical-review checkpoint before that acceptance. PR opening, merge and closure remain pending at this publication checkpoint. Raw Windows evidence stays owner-local; only this review receipt is delivered externally.
