---
status: complete-implementation-merged
kind: review-and-plan-change-evidence
created: 2026-10-04
plan: "[[2026-10-04-b05-thornwake-combat-readability]]"
revision: "[[2026-10-04-b05-controls-and-wagon-menu-revision]]"
canonical_decision: "[[2026-10-04-separated-controls-and-wagon-management]]"
pull_request_approved: true
merge_approved: true
pull_request: https://github.com/marizada86/the-first-nine/pull/4
merge_commit: bc7796e0fad33f5d7b773af3eaefc07749ec81b4
merged_feature_head: e5832da604226b33f424d18248b24f0825c568aa
closure_evidence: "[[2026-10-04-b05-documentation-closure]]"
---

## Current closure: B-05 integrated and completed

PR [#4](https://github.com/marizada86/the-first-nine/pull/4) was merged with a regular merge at `bc7796e0fad33f5d7b773af3eaefc07749ec81b4`, from `codex/b05-controls-wagon-inventory` at `e5832da604226b33f424d18248b24f0825c568aa` into `main`. All six PR commits and both feature branches are preserved. The original implementation branch `b05-thornwake-combat-readability` at `4400b59` is historical, not the current integrated delivery.

The owner separately authorized branch publication, PR opening, regular merge, and this documentation closure/publication on main. Initial local-only restrictions describe their original checkpoints; they do not negate those later approvals. Opus's delivered final review reported no blockers on `e5832da`; its reproduced Linux results are reviewer evidence, not fresh Atena results or CI checks.

B-05 is the last completed plan; the active-plan slot is cleared. This closure changes records only. No runtime, art, saved test outputs, canonical gameplay rules or dependencies change; no B-06 or branch deletion is authorized. Parry, balance tuning, higher-Mark progression and disk saves remain deferred. See [[2026-10-04-b05-documentation-closure]] and [[2026-10-04-b05-pull-request]] for verification and approval provenance.

## Historical preparation, implementation and review

The following sections preserve the original checkpoints and their evidence. Any pending-review, local-only, main-unchanged or no-PR/no-merge statement below refers to that stage, not today's closed state. Original implementation values superseded by later controls/geometry corrections remain historical.

# B-05 review and input revision evidence

## Published implementation

The owner authorized publishing the original B-05 implementation. The feature branch was fetched at `4400b59aab49ed2860c5c6369ba79b386a7d2e9a`; main was at `9ea4fc1bbfabd5be50a2d7f334b9b11325b8a77b`. No B-05 PR or merge occurred. Earlier preparation records describing implementation as pending are historical, not the current branch state.

Independent local review used Godot 4.7.2 in a managed review worktree. After a normal Godot editor asset import, the headless self-test exited 0 and printed B-01 through B-05, playtester and full-suite pass markers. The hit, miss, dodge and actual-hurt captures from the branch were inspected.

## Review findings requiring amendment

1. `restart_from_checkpoint()` restores health and clears `hurt_cooldown` but does not clear `player_action`, `player_action_time` or `hurt_flash_time`. Prologue and safe-wagon restores already clear the new visual state. The generic checkpoint path can retain the previous hurt display briefly after health is restored. This is a code-inspection finding; a new regression test must exercise that fallback path.
2. The default Windows combat runner failed while waiting for the second night wave, then accessed an absent Stag dictionary. Its bounded frame wait can expire before the gameplay wave delay elapses. With `--fixed-fps 60`, all nine runtime checks passed with zero failures. The gameplay wave transition passed; the ordinary-speed runner is not reproducible enough. Use elapsed time and stop cleanly on timeout.

The primary checkout remained on main. The local review worktree acquired Godot-generated import metadata changes; these are not gameplay implementation changes and must not be included in a follow-up commit.

## Owner's new request

The owner explicitly specified Space = jump, Shift = dash, E = collect/interact, left-click = attack, and ally management in the wagon menu, then added I = Lolth inventory. This conflicts with the current shared primary binding: E and left-click both call `handle_primary()`, which prioritizes combat before interaction. Q/R currently manage allies directly; M cycles load/recipe instead of opening a menu. At higher prototype Marks, Shift currently changes from dash into sense/anchor behavior. Existing `recovered_load` and capacity functions provide the carried inventory data; a new inventory data model is unnecessary.

Classified as `PLAN_CHANGE_REQUEST` because implementing a wagon interface and independent input dispatch extends the combat-only B-05 scope. The requested design is recorded as approved by the direct user definition. The bounded runtime revision is prepared for one approval before external execution under AGENTS.md; the existing per-plan preference is retained.

Prepared the English canonical decision, revision spec and Opus instruction. No runtime code, assets, tests, project settings or remote history was changed by this preparation. No new implementation, push, PR or merge is claimed.

## Preparation validation

- The required ADD workspace files/directories exist.
- All newly introduced wiki references resolve to local Markdown records. Historical unresolved references elsewhere in plan history were not introduced or changed by this revision.
- `git diff --check` passed. The diff is limited to `.atena/` documentation and plan state; main remains checked out and the runtime is unchanged.
- The active B-05 history and per-plan preference are preserved, with exactly one pending plan change and a visible revision-approval checkpoint. State changes were inspected. A full YAML-parser check was not completed because the bundled Python runtime lacks PyYAML; no dependency was installed.
- No new Godot run is claimed for these documentation-only changes. The existing published implementation's independent validation is recorded above; the revised controls and menus still require implementation and testing.

## Subsequent local execution and owner clarifications

The preparation statements above describe the earlier checkpoint, not the final runtime state. The owner explicitly requested local implementation, then deferred parry to a higher Mark, asked for a clean body-only dash, and requested larger enemy proportions. These IN_PLAN clarifications were recorded without inventing an unlock level or bypassing publication gates.

Local revision on `codex/b05-controls-wagon-inventory` resolves both review findings and implements the revised controls, inventory and wagon interface. Godot 4.7.2 headless suites passed; normal-speed combat passed 9/9 and controls/menu passed 33/33; normal/headless smoke runs passed. Final dash and enemy/menu captures were inspected. Full implementation, recovery history, acceptance results and limitations are in [[2026-10-04-b05-local-controls-inventory-wagon-implementation]].

The owner accepted the local implementation with "tudo validado, vamos continuar" on 2026-10-04. This was IN_PLAN human validation of commit `43ab112`, not by itself publication authority. The owner subsequently explicitly authorized the push of implementation and records to `codex/b05-controls-wagon-inventory`. A normal push published `43ab112` and `bb4a0d4`; the remote first-publication hash was verified as `bb4a0d4830563dfa487409eaab852aefe4ca5d81` and main remained at `9ea4fc1`. Publication reconciliation follows on the same branch. No new gameplay tests are claimed for this operational-record update. Technical review is next; no PR, merge, B-06 or external dispatch is authorized.
