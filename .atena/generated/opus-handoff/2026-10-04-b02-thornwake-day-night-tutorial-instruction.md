---
status: prepared-not-dispatched
kind: opus-implementation-instruction
created: 2026-10-04
source_canon: "[[2026-10-04-thornwake-day-night-tutorial]]"
implementation_branch: claude/wonderful-planck-suynnk
---

# B-02 - Thornwake day/night tutorial

Implement only B-02 on top of the latest approved B-01 commits in `claude/wonderful-planck-suynnk`. Use English for all new code comments, documentation, UI, dialogue, reports, and player-facing text. Do not push, open a pull request, merge, or start B-03.

Read before editing:

- `.atena/vault/canon/2026-10-03-b00-opening-ending-and-production-resolution.md`
- `.atena/vault/canon/2026-10-04-thornwake-day-night-tutorial.md`
- `.atena/generated/opus-handoff/2026-10-03-b01-opening-cave-instruction.md`

## Implement

1. Preserve the B-01 neutral opening shell, day-start cave camp, eight plagued allies, open horse-less wagon, protected relics, and travel lock.
2. Add the day tutorial: Lolth gathers physical resources, returns to the cave camp, and transfers them to the protected five-slot wagon stock.
3. Add one explicit English Wheel Kit recipe using those collected physical resources. When crafted, it changes the wagon from `cave_damaged` to `stationed`; it must not unlock travel.
4. Add a clear day-to-night transition, then one camp-defense tutorial using only Briar Hounds and Stags of Mire. Telegraph attacks against the wagon.
5. On defense success, restore a safe camp state. On a pre-Mark-I failure, restore the B-01 cave-start state.
6. Add or extend deterministic headless self-tests and capture a 1280x720 normal-run screenshot of the day and night tutorial states.

## Do not implement

- Antlered Hunger, Shar, H-02, THE KISS OF SHAR, Mark I, FIRST THREAD, cure selection, or Shadow Echo progression.
- Stonehook access, any travelling-wagon behavior, a puller, posts, Web Anchors, later regions, final content, art import, art regeneration, or a full runtime refactor.
- Any player-facing text in Portuguese or any reference board under `res://`.

## Acceptance tests

- The B-01 shell still reaches the day-start cave camp with eight plagued allies and a damaged, travel-locked wagon.
- The player can complete the declared physical-resource loop and craft the Wheel Kit.
- The crafted Wheel Kit changes the wagon to `stationed`, without allowing Stonehook or any wagon travel.
- Only Briar Hounds and Stags of Mire appear in the tutorial defense; neither grants Echoes, a Mark, or cure access.
- The defense success path reaches a safe camp state; every pre-Mark-I failure resets to the B-01 cave start.
- Headless self-test passes and a normal 1280x720 run is free of errors.

## Required return

Return only:

- Files changed
- Canon and constraints used
- Validation performed and results
- Remaining gaps
- Risks introduced
- Exact recommendation for B-03

Stop and wait for approval.

