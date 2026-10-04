---
status: complete-implementation-merged
kind: documentation-closure-evidence
created: 2026-10-04
batch: B-05
request_classification: IN_PLAN
approval_mode: per-plan
plan: "[[2026-10-04-b05-thornwake-combat-readability]]"
pull_request_receipt: "[[2026-10-04-b05-pull-request]]"
documentation_closure_approved: true
documentation_publication_approved: true
pull_request: https://github.com/marizada86/the-first-nine/pull/4
merge_commit: bc7796e0fad33f5d7b773af3eaefc07749ec81b4
merged_feature_head: e5832da604226b33f424d18248b24f0825c568aa
runtime_changed: false
b06_started: false
---

# B-05 documentation closure

## Scope and authority

The owner explicitly authorized closing B-05, correcting the record inconsistencies identified in the delivered Opus review, and publishing documentation only on main. Classified IN_PLAN under the approved per-plan B-05 scope. This is reconciliation of an approved implementation, not a post-hoc gameplay specification or a new canonical decision.

Publication, PR opening, regular merge and documentation closure had separate owner approvals. Initial local-only restrictions are retained as historical stages, not current prohibitions. No game changes, assets, dependencies, permission changes, tuning, branch deletion or B-06 execution are included.

## Integrated delivery and preserved history

- PR [#4](https://github.com/marizada86/the-first-nine/pull/4) was regularly merged as `bc7796e0fad33f5d7b773af3eaefc07749ec81b4`.
- Merge parents: previous main `9ea4fc1bbfabd5be50a2d7f334b9b11325b8a77b` and reviewed feature head `e5832da604226b33f424d18248b24f0825c568aa`.
- Current integrated implementation branch/head: `codex/b05-controls-wagon-inventory` / `e5832da`. Original implementation branch/head: `b05-thornwake-combat-readability` / `4400b59`.
- All six PR commits remain ancestors of main: `4400b59`, `43ab112`, `bb4a0d4`, `e6b614c`, `b8823c7`, `e5832da`. The merge tree is identical to the reviewed feature tree.
- Both remote feature branches are preserved. The local codex feature branch also preserves receipt commits `f0ee44f36a1ed4ef47463d4c198b25fb927ef201` and `3b37c9f5e24b15ddb98fccd9963c9e04c9f7fcde`. Their receipt contents are included in this closure without rewriting/cherry-picking their history or claiming they were part of the PR.
- B-05 is the latest completed plan; B-04 is promoted to the top of completed-plan history. The previous 28 history entries remain byte-for-byte equivalent after line-ending normalization and in the same order; the history now has 29 entries.
- `active_plan: null`; `plan_cursor: complete`. Other state sections remain unchanged except the already-approved B-05 revision's completed status.

## Records reconciled

B-05 original/revision/geometry specs and evidence now show `complete-implementation-merged`, with PR and merge metadata. Current operational branch/head are separated from original implementation facts. Historical preparation, implementation, acceptance, publication, validation and known limitations are preserved under explicit historical headings.

The two English handoffs are archived, not pending instructions. The controls canon receives an implementation-status/provenance update only; its approved rules are unchanged. The receipt and this closure evidence are included on main. The record validator checks completed-state invariants and exact history preservation instead of the obsolete active-review gate.

## Validation and evidence provenance

Closure checks use the local Node record validator, Git history/tree checks and whitespace/documentation-only boundaries. They check the ADD contract, relevant wiki links, status/approval invariants, exact prior history, preserved branch receipts and the absence of gameplay changes. No dependency is installed. A general YAML parser is unavailable in this bundled environment; structural/invariant checks are not described as a full YAML parse.

Saved Windows Godot 4.7.2 evidence remains unchanged: full B-01 through B-05/F4/self-tests, 9/9 actual-input combat, 33/33 controls/menus, 46/46 geometry, five deliberately faulty subclasses rejected, and normal/headless 600-frame smoke results. The validator rechecks these saved results and diagnostics; it does not rerun the engine.

The delivered Opus report on `e5832da` reported no blockers and Linux Godot 4.7.2 reproduction of those suites. Those remain reviewer-reported results, not new Atena runs or CI. No CI is configured: opening-time verification found zero check runs/statuses/PR workflow runs; no CI pass is inferred. Original eleven B-05 mutation controls remain historical and are not claimed as rerun.

## Acceptance, recovery and next step

Completed local closure checks: `ADD_RECORDS_PASS` (contract, 98 relevant record/completed-plan links, completed/merged facts, 29 preserved history entries and scoped records-only boundary) and `GEOMETRY_RECORDS_PASS` (saved 46-check/five-fault evidence and successful process exits). `git diff --check` passed. Exact prior-history comparison, six-commit ancestry, equal merge/feature trees and preservation of both feature branches/local receipt commits passed. No engine run or full YAML parse was performed for this documentation-only closure. Git's sandbox ignore-access/line-ending notices are not game diagnostics or a test failure.

Acceptance for this closure: correctly recorded merge/publication authority; completed B-05 and no active plan; 29 preserved ordered history entries; relevant links resolve; no conflict markers/whitespace errors; no changes outside scoped ADD records; original feature branches and local receipts remain recoverable.

Publication is one ordinary documentation-only commit on main after `bc7796e`, using a normal push, not amend or force-push. Its exact hash is reported after creation instead of embedding a self-referential hash. If recovery is required, use a separately authorized corrective/revert commit; do not reset or delete preserved history.

Deferred items remain visible: higher-Mark parry (right-click currently inactive), balance and pose-dependent reach/contact-radius tuning, approved inventory pause, prototype higher-Mark Shift abilities, cosmetic HUD/resource overlap, further progression and disk persistence. Saves remain in memory only. A later bounded balance/feel playtest may be planned with separate approval; it is not authorization to implement B-06.
