---
status: complete-external-implementation-merged
approval_mode: per-plan
approval_selection: user-explicit-2026-10-04
approved: 2026-10-04
kind: runtime-implementation-plan
created: 2026-10-04
plan_id: 2026-10-04-b02-thornwake-day-night-tutorial
depends_on:
  - "[[2026-10-03-b00-opening-ending-and-production-resolution]]"
  - "[[2026-10-03-b01-opening-cave-instruction]]"
implementation_branch: claude/wonderful-planck-suynnk
---

# B-02 plan - Thornwake day/night tutorial

## Scope

Implement only the pre-boss Thornwake tutorial on top of approved B-01: day salvage, transfer to wagon stock, Wheel Kit repair, a single concrete-enemy night defense, and a return to a safe camp state. Keep all new output in English.

## Non-goals

Do not implement Antlered Hunger, Shar, H-02, Mark I, FIRST THREAD, cure selection, Echo progression, Stonehook access, puller assignment, travelling wagon, Web Anchors, posts, later regions, final comics, art import, art regeneration, a full runtime rebuild, a pull request, merge, or push.

## Proposed decisions requiring approval

1. The Wheel Kit has one explicit tutorial recipe assembled from the existing physical salvage items. Completing it transitions the wagon from `cave_damaged` to `stationed`; it does not unlock travel.
2. The tutorial begins during day. Lolth gathers resources, returns them to the wagon, transfers them to five-slot wagon stock, and crafts the Wheel Kit at the camp.
3. The first night defense spawns only Briar Hounds and Stags of Mire. It telegraphs attacks against the wagon, cannot award Shadow Echoes or a Mark, and returns to camp after a successful defense.
4. B-02 ends after the repaired/stationed wagon and one successful night defense. Antlered Hunger and all Mark-I/cure work belong to B-03.
5. Existing numerical values for day length, wave count, enemy health, wagon damage, and recipe quantities remain data constants for playtesting; they are not new canon.

## Acceptance criteria

- A new run reaches the day-start cave camp through B-01.
- Lolth can gather the specified physical resources, return them, and transfer them to protected wagon stock without exceeding five slots.
- The Wheel Kit recipe is visible in English, consumes only its declared inputs, and changes the wagon to `stationed` without enabling travel.
- Night begins through a clear transition; only Briar Hounds and Stags of Mire threaten the camp and wagon.
- Surviving the defense returns the player to a safe camp state. A pre-Mark-I failure restores the B-01 cave start.
- No enemy kill grants Shadow Echoes, Mark I, cure access, Stonehook travel, or any later feature.
- Godot headless self-test covers the complete B-02 tutorial path, plus a normal visual run at 1280x720.

## Evidence required

An English implementation note must list changed files, canonical constraints used, validation output, known gaps, risks, and the proposed B-03 scope. The external implementation branch must remain unpushed until the user explicitly authorizes a push.

