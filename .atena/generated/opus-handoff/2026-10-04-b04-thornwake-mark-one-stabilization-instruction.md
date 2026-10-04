---
status: approved-awaiting-dispatch
kind: external-implementation-instruction
created: 2026-10-04
batch: B-04
plan: "[[2026-10-04-b04-thornwake-mark-one-stabilization]]"
---

# B-04 — Mark I Thornwake stabilization

## Start state

Work from an up-to-date `main` that contains the completed B-03 merge and the B-04 records. Create a new local B-04 feature branch. Do not push, open a pull request, merge, publish, change dependencies, or delete files.

Read before editing:

- `vault/canon/2026-10-03-b00-opening-ending-and-production-resolution.md`
- `vault/canon/2026-10-04-first-boss-mark-and-cure.md`
- `specs/2026-10-04-b04-thornwake-mark-one-stabilization.md`
- `evidence/2026-10-04-b03-first-boss-implementation.md`
- `state/plan.yaml`

## Implement only this slice

1. After the mandatory first cure, show the English objective: `Return to the Wagon to secure the camp.`
2. When Lolth returns within the existing Wagon interaction area, capture an in-memory safe-wagon operational state and confirm it in English.
3. After securing the camp, show one clear English objective:
   - before the cap: `The Wagon is secure. Gather Shadow Echoes in Thornwake: X/3.`
   - at the cap: `The Wagon is secure. No deeper Mark can awaken in Thornwake.`
4. On a failure after Mark I and after this safe return, restore the most recent safe-wagon operational state. Preserve narrative progression: Mark I and the selected first cure remain intact. Before that safe return, retain the existing cure-checkpoint fallback.
5. Preserve B-01 pre-Mark-I failure behavior: it restores the cave-camp start.
6. Keep Echoes unavailable before the cure and capped at 3/3 after it. Mark II must remain unreachable.
7. Tune Antlered Hunger and `FIRST THREAD` only as documented playtest values. Preserve base melee, dodge, legible telegraphs, the stationary and travel-locked Wagon, and all B-03 content boundaries.

## Do not implement

Do not enable travel, Stonehook, Mark II or later Marks, another cure, ally posts, pullers, Web Anchors, maps, H-02/H-03 runtime content, art generation/admission, new dependencies, or persistence to disk.

## Validation

Extend deterministic self-tests for: pre-Mark-I reset, the first cure, safe-wagon capture, post-Mark-I failure and restore, preserved cure/Mark I, Echo gating/cap, and travel lock. Add negative controls for missing capture, stale operational restoration, loss of narrative progression, early Echoes, cap overflow, and an unlocked Wagon. Run a normal 1280×720 visual check and report exact results, changed files, known gaps, and a non-authorizing next recommendation.
