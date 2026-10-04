---
status: implemented-published-awaiting-review
approval_mode: per-plan
approval_selection: user-explicit-2026-10-04
approved: 2026-10-04
kind: runtime-implementation-plan
created: 2026-10-04
plan_id: 2026-10-04-b03-first-boss-mark-and-cure
depends_on:
  - "[[2026-10-03-b00-opening-ending-and-production-resolution]]"
  - "[[2026-10-04-thornwake-day-night-tutorial]]"
implementation_branch: b03-first-boss-mark-and-cure
planned_branch: claude/wonderful-planck-suynnk
implementation_base: 15e39eb
implementation_commit: ac091fa
implementation_evidence: "[[2026-10-04-b03-first-boss-implementation]]"
published_commit: 4ac235960b52643562bd8f36036b21d5269ba3ef
branch_publication_approved: true
pull_request_approved: false
merge_approved: false
---

# B-03 plan - first boss, Mark I and first cure

## Scope

Implement the post-B-02 Thornwake hand-off: player-initiated Antlered Hunger encounter, boss defeat, neutral/ skippable Shar sequence shell, Mark I, `FIRST THREAD`, and a choice to cure exactly one Thalestriel. Keep all new output in English.

## Non-goals

Do not use H-02 artwork or the old comic lines; do not generate final dialogue, import art, regenerate art, implement Mark II or higher, enable travel, unlock Stonehook, add a puller, ally posts, Web Anchors, later regions, H-03, a runtime rebuild, a pull request, merge, or push.

## Proposed decisions requiring approval

1. After B-02 safe camp, the player explicitly starts the boss encounter through a single English camp action. The encounter uses Antlered Hunger only and preserves B-02's telegraph standard.
2. Boss defeat plays a neutral, skippable Shar hand-off shell with no final dialogue or reference-board art. It conveys no new player-facing lore beyond the approved sequence identifiers.
3. Mark I turns Lolth from elf to drow and adds `FIRST THREAD`: a short-range shadow strike that supplements melee and dodge.
4. The cure UI lists all eight plagued Thalestriel and requires exactly one choice. The selected ally becomes a non-controllable drow; the wagon remains `stationed` and `travel_locked`.
5. Shadow Echoes start after the first cure, as canon requires, but are collected only up to the next Mark threshold. Mark II, its abilities, cure, and travel effects remain unavailable until a later approved batch.

## Acceptance criteria

- The safe camp offers a clear English trigger for Antlered Hunger and does not start the boss automatically.
- Antlered Hunger is defeatable through the existing base melee and dodge, using legible telegraphs.
- The Shar shell is skippable, has no old contradictory comic text, and admits no H-02 reference board to runtime.
- After the shell, Mark I applies once; Lolth uses the drow state and `FIRST THREAD` works without replacing melee or dodge.
- The player cures exactly one of the eight named allies. That ally is non-controllable, and the remaining seven stay plagued.
- Shadow Echoes begin only after the cure and cannot grant Mark II in B-03.
- Stonehook and all wagon travel remain blocked; the wagon stays `stationed`.
- Deterministic headless tests cover the complete hand-off, a boss failure/reset, a skipped Shar shell, one cure, Echo gating, and the travel lock. A normal 1280x720 visual run is error-free.

## Preconditions

- The B-02 reconciliation files currently local must be pushed to `main` before Claude reads B-03 records.
- The feature branch must incorporate `main`'s B-00/B-02 records without losing the merged B-01/B-02 implementation history.

## Evidence required

An English implementation note must list exact changed files, canon used, test output, known gaps, risks, and a B-04 recommendation. The branch remains unpushed until the user explicitly authorizes it.

## Implementation status

- **Status:** implemented and published to its branch, awaiting human review. The user provisionally accepted the implementation pending the ADD record reconciliation.
- **Publication:** the project owner approved branch publication. `b03-first-boss-mark-and-cure` was pushed to `origin` at `4ac235960b52643562bd8f36036b21d5269ba3ef`, and a documentation-only follow-up commit was pushed to the same branch. A pull request and a merge are not approved and have not been performed. `main` is unchanged.
- **Branch:** the work is on the local branch `b03-first-boss-mark-and-cure`, created from `origin/main` at `15e39eb`. The planned branch `claude/wonderful-planck-suynnk` was not used, because its pull request had already been merged.
- **Commit:** the original implementation commit was `ac091fa`. The record reconciliation was amended into it, producing the published commit `4ac235960b52643562bd8f36036b21d5269ba3ef`.
- **Preconditions:** both were satisfied before implementation. `origin/main` at `15e39eb` contains the merged B-01/B-02 implementation and the B-00/B-02/B-03 records.
- **Evidence:** `[[2026-10-04-b03-first-boss-mark-and-cure]]` and the implementation note `[[2026-10-04-b03-first-boss-implementation]]`.
