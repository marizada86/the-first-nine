---
status: complete-implementation-merged
kind: authorized-pull-request-receipt
created: 2026-10-04
request_classification: IN_PLAN
approval_mode: per-plan
spec: "[[2026-10-04-enemy-facing-correction]]"
implementation_evidence: "[[2026-10-04-enemy-facing-correction]]"
pull_request: https://github.com/marizada86/the-first-nine/pull/5
pull_request_approved: true
additional_record_push_approved: true
merge_approved: true
merge_commit: 7049063358132aac6d85aa69c0f06ae53efa98da
closure_record_publication_approved: true
closure_record_published: true
closure_record_commit: c230975c3ead74ccf4f7844c6e93e51697bed1ca
---

# Enemy-facing correction PR receipt

## Opening authority (historical)

The owner explicitly answered "autorizo" to opening `codex/enemy-facing-correction` into main, with an English description and no merge. This is IN_PLAN PR-only authorization, not an extension of the previous branch-push approval. No merge, auto-merge, branch deletion, additional record publication, external dispatch or B-06.

## Verified opening facts (historical)

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

At this opening checkpoint, spec, evidence, active-plan state and the operational validator were reconciled locally, with saved-result and link/contract checks only. Completed B-05 history, source, art, runtime test results and existing captures remained unchanged. Receipt `fb565d0` was not yet pushed and the active plan awaited separate merge authority. Its subsequent publication and merge are recorded below.

Local operational validation exits 0 with `FACING_RECORDS_PASS` (12 resolved links, exact completed-history preservation, bounded paths and unchanged combat/geometry functions) and `FACING_RESULTS_PASS` (checks the already saved process results, not fresh engine execution). The scoped whitespace check passes. YAML checks remain structural only, not a whole-file parser claim.

## Authorized publication and verified merge

The owner subsequently answered "autorizados" to both pending actions: publishing the local receipt and merging PR #5. Classified IN_PLAN. The earlier restrictions above describe the opening checkpoint, not this later approval. This does not authorize a further closure push, deletion, external dispatch or B-06.

- Receipt commit `fb565d0c430a8df3b0a12bd233c8a4109466f6a0` was normally pushed to the same feature branch.
- Final PR head: `fb565d0`; four commits, 62 changed files, +1660 / -6. The extra commit changes only records and their validator.
- Final pre-merge GitHub metadata: mergeable true, mergeable_state clean; zero check runs, zero statuses and combined status pending. No automatic test pass inferred.
- Regular merge used expected head `fb565d0`, preserving commits `e7812e6`, `523960b`, `edb5623` and `fb565d0`.
- Merge commit: `7049063358132aac6d85aa69c0f06ae53efa98da`.
- Parents: `39cd7d3d46a8afb3894889920e0840cbae573e7b` and `fb565d0c430a8df3b0a12bd233c8a4109466f6a0`.
- GitHub state: closed and merged, at `2026-10-04T22:56:52Z`.
- Remote main verified at the merge; local main safely fast-forwarded to it. The merged tree is identical to the final PR head.
- Feature branch preserved at `fb565d0`. No amend, force-push, auto-merge or deletion.

At documentary closure `c230975`, the plan was completed locally, with prior B-05 preserved as the first history entry and active_plan cleared. Closure records initially remained local and unpushed. Validation checked merge ancestry/tree equality, saved results, record links and exact prior-history preservation; no new engine execution or detailed human tests were claimed.

The closure validator passes with 12 resolved links and the unchanged saved runtime results. Its first closure-history comparison rejected the required newline separating the newly moved B-05 entry from the older list. The assertion now requires exactly that single new separator and byte-equivalent normalized older content; no older entry or acceptance result was changed to pass the check. Scoped whitespace checks pass. YAML checks remain structural, not a full parser pass.

## Separately authorized closure publication

The owner answered "autorizado" to publishing closure `c230975c3ead74ccf4f7844c6e93e51697bed1ca`. A fresh fetch and scoped record/saved-result checks confirmed the one-commit, documentation-only boundary. Normal push published it on main, preserving its parent merge `7049063`; remote main was verified at `c230975` and the feature branch remained `fb565d0`.

This documentary publication reconciliation records that completed action under the same bounded closure authorization. It changes only the four operational documents and their validator, without amending the published closure or touching source, art, captures, saved test results or older history. No new engine run, new PR, merge, branch deletion, dispatch, dependency or B-06. The plan stays complete with active_plan null and cursor complete; this approval does not authorize unrelated future publication.

## Owner-reported integrated playtest acceptance

After closure publication, the owner asked for the next step. The recommended final Godot playtest covered combat/facing/dash, separate controls and menus, day/night/defense/boss/Mark I/first cure, and failure restoration. The owner then replied "tudo funcionando" on 2026-10-04. This is overall human acceptance of the reported functioning slice, not a detailed per-item test log, performance measurement or authorization for new implementation/publication. No fresh engine execution is claimed.

The local workspace is at `05eac1e7a639e213f39cff81b1e75305727ab4d0` when recording this confirmation; the owner did not separately specify the tested-build hash. Preserve the earlier implementation acceptance and machine results. The plan remains completed and active_plan remains null. This receipt update stays local, without push.

A read-only canon check confirms the next broader progression direction: Lolth reaches early Stonehook on foot before four cures, while the repaired wagon and family remain at the cave hub; wagon travel stays locked until its approved conditions are met. Preparing a bounded B-06 proposal for that first expedition/return is a recommendation only. No B-06 spec, execution, Mark II, parry, new art or disk persistence is authorized or started by the playtest confirmation.
