---
status: pull-request-open-awaiting-merge-authorization
kind: authorized-pull-request-receipt
created: 2026-10-04
request_classification: IN_PLAN
approval_mode: per-plan
spec: "[[2026-10-04-enemy-facing-correction]]"
implementation_evidence: "[[2026-10-04-enemy-facing-correction]]"
pull_request: https://github.com/marizada86/the-first-nine/pull/5
pull_request_approved: true
additional_record_push_approved: false
merge_approved: false
---

# Enemy-facing correction PR receipt

## Authority

The owner explicitly answered "autorizo" to opening `codex/enemy-facing-correction` into main, with an English description and no merge. This is IN_PLAN PR-only authorization, not an extension of the previous branch-push approval. No merge, auto-merge, branch deletion, additional record publication, external dispatch or B-06.

## Verified remote facts

- PR: https://github.com/marizada86/the-first-nine/pull/5.
- Title: Fix enemy sprite facing during movement and attacks.
- Created: `2026-10-04T22:48:14Z`.
- State: open, not draft, not merged; auto-merge is null.
- Base: main at `39cd7d3d46a8afb3894889920e0840cbae573e7b`.
- Head: `codex/enemy-facing-correction` at `edb5623d2609152c7df5dffffe10a34e6f3e2ba0`.
- Commits: `e7812e6`, `523960b`, `edb5623`, preserved without amend/force-push.
- Diff: 61 files, +1577 / -6. Only `main.gd` changes production code; the rest are bounded records and validation artifacts.
- GitHub follow-up metadata: mergeable true, mergeable_state clean. Current main is also an ancestor of the correction head in the local read-only check.
- Check runs: 0. Commit statuses: 0; combined status pending because no status has reported. This is not an automatic test pass.
- The PR is attached to this chat. No reviewer assignment, branch deletion, auto-merge or merge was performed.

The creation connector's initial normalized snapshot reported mergeable false. A subsequent direct GitHub metadata read confirmed mergeable true and clean; the initial snapshot alone is not treated as a reproduced conflict or proof of its cause.

## Validation and local reconciliation boundary

The English description distinguishes recorded Godot implementation results from this PR operation: 65/65 headless, 102/102 rendered, three intentionally faulty controls rejected, geometry 46/46, real-input combat 9/9, menus 33/33, full self-tests and two smoke runs. No engine tests were rerun when opening this PR.

Spec, evidence, active-plan state and the operational validator are reconciled locally, with saved-result and link/contract checks only. Completed B-05 history, source, art, runtime test results and existing captures remain unchanged. This receipt is not pushed; it does not change the PR's approved three-commit head. The active plan remains at the separate merge-authority checkpoint.

Local operational validation exits 0 with `FACING_RECORDS_PASS` (12 resolved links, exact completed-history preservation, bounded paths and unchanged combat/geometry functions) and `FACING_RESULTS_PASS` (checks the already saved process results, not fresh engine execution). The scoped whitespace check passes. YAML checks remain structural only, not a whole-file parser claim.
