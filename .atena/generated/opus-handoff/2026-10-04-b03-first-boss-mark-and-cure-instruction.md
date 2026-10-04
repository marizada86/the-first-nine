---
status: prepared-not-dispatched
kind: opus-implementation-instruction
created: 2026-10-04
source_canon: "[[2026-10-04-first-boss-mark-and-cure]]"
---

# B-03 - Antlered Hunger, Mark I and first cure

Implement only B-03 from an up-to-date `main` that includes the merged B-01/B-02 implementation and the B-00/B-02 operational records. Create a new local work branch if needed. Use English for all new comments, documentation, UI, reports, and player-facing text. Do not push, open a pull request, merge, or start B-04.

Read before editing:

- `.atena/vault/canon/2026-10-03-b00-opening-ending-and-production-resolution.md`
- `.atena/vault/canon/2026-10-04-thornwake-day-night-tutorial.md`
- `.atena/vault/canon/2026-10-04-first-boss-mark-and-cure.md`
- `.atena/generated/opus-handoff/2026-10-04-b02-thornwake-day-night-tutorial-instruction.md`
- `.atena/specs/2026-10-04-b03-first-boss-mark-and-cure.md`

## Implement

1. From B-02 safe camp, offer one deliberate English camp action that begins Antlered Hunger. The boss must not start automatically.
2. Implement the Antlered Hunger encounter using legible telegraphs. On failure before Mark I, restore the B-01 cave start; on defeat, proceed once to the Shar shell.
3. Replace the existing first-boss comic hand-off with a neutral, skippable shell. Do not render H-02 art or reuse old `COMIC_LINES` text.
4. After the shell, grant Mark I once. Switch Lolth from elf to drow and add `FIRST THREAD` as a short-range shadow strike alongside melee and dodge.
5. Present all eight named plagued Thalestriel in a cure-choice interface. Require exactly one selection; the chosen ally becomes a non-controllable drow, the other seven remain plagued.
6. Begin Shadow Echo collection only after the cure. Cap it at the next Mark threshold; do not grant Mark II, a second cure, travel, or later abilities.
7. Leave the wagon `stationed` and `travel_locked`. Preserve all B-01/B-02 behavior.
8. Extend deterministic headless tests and capture normal 1280x720 evidence for the boss, the neutral shell, Mark I, and cure selection.

## Do not implement

- Final H-02 dialogue, H-02 art, H-03 content, THE KISS OF SHAR as a player-facing item, Mark II or higher, Stonehook, travel, pullers, ally posts, Web Anchors, later regions, art import, art regeneration, or a full runtime refactor.
- Any player-facing Portuguese text.

## Acceptance tests

- The B-02 safe camp is preserved and the boss starts only through the explicit camp action.
- Antlered Hunger defeat reaches a neutral skippable shell; no old comic text or board is rendered.
- Mark I applies exactly once, switches Lolth to drow, and enables FIRST THREAD while melee and dodge still work.
- Exactly one of the eight named allies is cured and remains non-controllable; seven remain plagued.
- Echoes are zero before the cure, begin after it, and cannot grant Mark II.
- The wagon remains stationed and travel-locked; no Stonehook path becomes available.
- Headless self-test and normal run complete with no errors.

## Required return

Return only:

- Files changed
- Canon and constraints used
- Validation performed and results
- Remaining gaps
- Risks introduced
- Exact recommendation for B-04

Stop and wait for approval.

