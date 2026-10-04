---
status: superseded
kind: game-design-revision
created: 2026-10-02
depends_on:
  - '[[2026-10-02-thalestriel-exodus-game-intent]]'
  - '[[2026-10-02-the-last-nine-vertical-slice]]'
approval_required: true
superseded_by: '[[2026-10-02-caravan-survival-revision]]'
---

# The First Nine — Caravan Survival Revision

## Decision proposed

Lolth is the only directly controlled character. The other eight Thalestriel remain at the caravan and contribute only through one selected passive mission at a time. They are never permanently lost: a failed survival condition returns the run to the latest Shadow Mark checkpoint with all nine restored.

## Intended player feeling

`I need to heal my companions. I need to repair the wagon. We have to keep moving.`

## Core loop

1. At camp, read three visible pressures: Caravan Flame, group condition, and a damaged wagon or route component.
2. As Lolth, enter a short ruin, avoid or defeat simple shadows, and recover visible Kindling, Provisions, or Salvage.
3. Carry one resource home and choose the immediate use: stabilize the group, strengthen the flame, repair the route, or commit a single awakened survivor to a passive mission.
4. A clear repair threshold opens the next route. Resources remain deliberately scarce enough that the player cannot solve every pressure immediately.
5. A depleted critical pressure causes `THE CAMP FALLS`; the latest Shadow Mark checkpoint restores all nine.

## Scope

- Keep the existing three journey sections, HQ, nine Shadow Mark levels, and portal ending.
- Add a visible wagon/route repair state driven by existing `Salvage`; do not add a fifth resource.
- Make group risk legible through the eight survivors at camp, while retaining one lightweight `Provisions`/group-condition system rather than eight independent health simulations.
- Implement three passive missions end-to-end for the jam: provisions, flame efficiency, and route/salvage support. Other awakened roles can reuse one of those effects with distinct text until after the jam.
- Remove direct player control of companions and the `Q` control prompt.

## Non-goals

- No permanent death, companion combat AI, individual inventories, free crafting, deep combat, procedural systems, or new dependencies.
- No lore/name changes in this revision.

## Acceptance criteria

1. Lolth is the only controllable character throughout a complete run.
2. The camp clearly communicates flame, a group-risk state, and wagon/route repair before the player leaves.
3. The player repairs the wagon or route with Salvage at least once to advance.
4. At least one passive mission is assigned at camp and visibly resolves after returning from an area.
5. A loss condition returns all nine to the latest Mark checkpoint.
6. The automated Mark/checkpoint path still passes, and a human playthrough verifies that the full run remains comprehensible and finishes within 8–12 minutes.

## Proposed plan of flight

1. Reconcile the approved intent and vertical-slice spec to state that only Lolth is playable and record the bounded implementation plan.
2. Refactor the Godot state and HUD: remove character-switching, add wagon repair and a legible group-risk display using existing resource state.
3. Place enough distinct resources in each journey section to create a real choice without a soft lock; use Salvage to gate route progression.
4. Replace the current single generic mission with the three bounded passive mission outcomes and show assignment/resolution feedback.
5. Update objectives, tutorial prompts, and README for the revised loop.
6. Run the automated route, conduct a manual end-to-end playthrough, record evidence, compare every acceptance criterion, and reconcile the spec and operational facts.

## Risks to test

- A resource choice must create a recoverable tradeoff, not an unwinnable state.
- Three camp pressures must remain readable at a glance.
- Passive missions must simplify a future decision, not become another menu-management obligation.
