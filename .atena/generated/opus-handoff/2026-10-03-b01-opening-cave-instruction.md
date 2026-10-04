---
status: prepared-not-dispatched
kind: opus-implementation-instruction
created: 2026-10-03
source_canon: "[[2026-10-03-b00-opening-ending-and-production-resolution]]"
---

# B-01 - opening comic and cave camp

Implement only B-01. Use English for all new code comments, documentation, UI, dialogue and player-facing text. Do not begin B-02 or later work. Do not regenerate, import, or ship any AI reference board. Do not change canon.

## Authoritative constraints

- H-01 is the only current narrative reference for the opening comic. Its prior C-01 counterpart is historical only.
- The playable start is a cave in Thornwake Forest. Lolth begins as an elf. The open, horse-less wagon is cave-damaged, with a broken wheel and splintered wood.
- Exactly eight Thalestriel are visibly plagued at the cave camp. Lolth is the only directly controllable character.
- The wagon is `cave_damaged` and remains `travel_locked`; do not create wagon departure or Stonehook travel.
- The camp contains the open wagon, family relics, fire, stock, and the eight allies. Do not create beds or enclosed wagon rooms.
- H-01 needs an approved English dialogue script before it can be shipped. If no script is supplied, implement only a testable comic-sequence shell with English placeholder identifiers that are not player-facing.
- Current H-01 through H-03 boards are reference-only and must not be admitted into `res://`.
- Extend the current runtime conservatively. Do not undertake a full refactor or rebuild before the jam deadline.

## Deliverables

1. A testable opening-sequence shell that can advance, skip, and return control to the cave start without requiring final comic images or dialogue.
2. A cave-camp start state that exposes the wagon, eight plagued ally records, relic protection, and `travel_locked` state.
3. The existing gameplay uses Lolth's elf state before the first boss.
4. Headless validation covering the opening-to-cave transition, eight allies, wagon damage state, and travel lock.
5. An English implementation note listing exact changed files and deferred items.

## Acceptance tests

- Starting a new run reaches the cave-camp state after the skippable opening shell.
- The wagon is open, horse-less, visibly damaged, and cannot travel.
- Exactly eight allies are tracked as plagued; none is directly controllable.
- No final art board is imported or rendered as a runtime asset.
- Existing gameplay is not silently expanded into B-02, combat, Shar, cures, posts, web crossings, later regions, or ending work.

## Required return

Return only:

- Files changed
- Canon and constraints used
- Validation performed and results
- Remaining gaps
- Risks introduced
- Exact recommendation for B-02

Stop and wait for approval after this return.

