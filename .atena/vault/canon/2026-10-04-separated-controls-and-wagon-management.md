---
status: approved-design-decision
kind: input-and-interface-decision
created: 2026-10-04
approval_source: direct-user-control-definition
related_controls: "[[2026-10-02-cross-input-controls]]"
related_plan: "[[2026-10-04-b05-thornwake-combat-readability]]"
implementation_status: complete-implementation-merged
---

# Separate combat, interaction, and wagon management

The owner explicitly defined the following controls on 2026-10-04:

| Input | Gameplay action |
| --- | --- |
| Space | Jump |
| Shift | Dash |
| E | Collect / interact |
| Left mouse button | Base melee attack |
| Right mouse button | Reserved for future higher-Mark parry; inactive now |
| I | Lolth inventory |

Attack and interaction are separate gameplay actions. E must not perform melee damage; left-click must not collect resources, store supplies, craft, or trigger world interactions. A left-click consumed by an interface button must not also attack in the world.

Shift remains the dash input. A higher Mark must not silently change Shift into a different shadow ability.

The owner then added I for Lolth's inventory. It presents her carried items, separate from the wagon stock and ally management. This does not authorize a new equipment, loot, or consumption system.

The owner initially assigned right-click to parry and requested local implementation before returning to Claude with the results. The later instruction supersedes immediate parry implementation: keep only dash for now and introduce parry at a higher Mark. Right-click is reserved and inactive in this slice, not a dash alias. The required Mark and future parry timing remain deferred; do not invent an unlock level.

The owner also requested removal of the stray graphic in the dash pose and larger enemy proportions relative to Lolth. These are rendering/readability corrections using existing art, not new combat powers or lore changes.

All ally management belongs in the wagon menu. Selecting allies and assigning or recalling existing roles must not require standalone Q/R gameplay shortcuts. This is an interface decision, not authorization to unlock roles, cures, travel, regions, or direct companion control.

The older contextual-primary rule in [[2026-10-02-cross-input-controls]] is superseded by this separation. The requirement for equivalent keyboard, keyboard/mouse, and controller access remains. The implementation plan must specify an independent keyboard attack fallback and controller equivalents.

The exact wagon-menu layout and supplementary bindings belong to the implementation specification. Existing Thornwake role locks and the two-post limit remain authoritative. All new player-facing labels and records are English.

Local implementation and validation are recorded in [[2026-10-04-b05-local-controls-inventory-wagon-implementation]]. Branch publication, PR #4 and regular merge were separately authorized and performed; documentation closure/publication was separately authorized. See [[2026-10-04-b05-documentation-closure]]. This updates implementation metadata only, not the approved design decision.
