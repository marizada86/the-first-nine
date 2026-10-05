---
status: approved-design-interview
kind: opening-camp-care-and-progression-decision
created: 2026-10-05
approval_source: explicit-owner-interview-answers
implementation_approved: false
execution_target: local-atena
related_spec: "[[2026-10-05-b09-opening-cave-care-and-continuous-journey]]"
evidence: "[[2026-10-05-b09-opening-cave-care-and-continuous-journey]]"
---

# Opening cave care and continuous journey

The owner clarified the intended opening, individual care, cave defense and progression in the interview of 2026-10-05. These design decisions are accepted; implementation, asset production, admission and publication are not authorized by this record. Development continues with Atena in this workspace, without further Opus dispatch.

## Opening and world

A responsive initial menu leads to the opening comic, displayed one panel per screen, then to playable life inside the cave. The damaged, horse-less family wagon and its relics are inside the cave, not stationed in an exposed forest clearing. Exactly eight plagued elves lie on the ground there. Lolth starts as an elf.

The initial guided presentation introduces the wagon and patients. The player can then leave without fully repairing the wagon, because needed supplies are outside. The exterior shows the cave entrance as a recognizable return landmark. The journey is manually authored, has a defined ending, and feels continuous through horizontal movement and gradual transitions. It is not procedural or literally endless. Existing continuous, flat wagon-route rules remain binding.

The guided introduction pauses time and patient deterioration. Once exploration is released, time and deterioration continue even while Lolth is away. Menus and comics pause the world.

## Individual treatment and definitive cure

Each of the eight elves has an individual condition. Their starting conditions differ, but none is in immediate danger during the guided introduction. Exact starting values and deterioration rates are playtest data, not canon.

Medicines are prepared at the wagon. In the wagon's ally menu, the player selects a patient and applies a dose, consuming the prepared medicine. A dose restores part of that patient's health but does not remove the plague. Failure of a patient ends the attempt and restores a checkpoint; no family member is permanently lost.

After the first boss, the Shar comic grants Mark I and transforms Lolth into a drow. The Mark's power is acquired immediately. Each legitimately earned Mark from I through VIII grants one free transformation of a selected plagued elf into a drow. The player performs that transformation at the wagon through the ally menu, without supplying medicine or treatment ingredients. Definitive plague cure and temporary medical treatment are separate actions. Mark IX is the ending, not a ninth ally cure.

The accepted story and English wand name remain those of [[2026-10-03-hq-narrative-revision]] and [[2026-10-03-b00-opening-ending-and-production-resolution]].

## Night defense

Only at night, concrete monsters approach the cave entrance. The player receives an approach warning and can intercept and kill them. Each monster that reaches the entrance enters the cave and attacks the wagon. Wagon integrity reaching zero ends the attempt and restores the checkpoint.

There is no five-monster allowance, six-monster instant defeat or absence timer. Those interview proposals were superseded by the owner's final instruction. A visible threat warning may show the actual threats, but a count is not a loss trigger.

## Supplies and checkpoints

Common supplies renew at dawn at fixed authored gathering points, not each time the player crosses a boundary. Important unique items and rewards remain unique.

Safe returns to the wagon update the operational checkpoint from the beginning, including before Mark I. Failure does not force another viewing of the opening comic or replay a completed introduction. The current in-memory save boundary remains; disk persistence needs separate work.

## Reconciliation boundaries

This revision supersedes only conflicting details of the pre-Mark-I restart rule in [[2026-10-03-b00-opening-ending-and-production-resolution]], the immediate first-cure interface and camp-start boss handoff in [[2026-10-04-first-boss-mark-and-cure]], and collective-only patient treatment in the current prototype. It preserves the eight names, narrative bargain, no permanent family loss, controls, family relics, four-cure wagon-travel prerequisites and later traversal constraints.

Final comic panels, a genuine cave interior, the exterior entrance and resting patient sprites require production and runtime admission decisions. Existing storyboard sheets are references, not automatically admitted game assets. The B-08 implementation and its Windows technical review remain separate from owner acceptance and integration.
