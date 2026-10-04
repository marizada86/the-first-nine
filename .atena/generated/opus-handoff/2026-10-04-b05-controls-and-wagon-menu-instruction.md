---
status: local-results-prepared-not-dispatched
kind: review-and-next-step-handoff
created: 2026-10-04
batch: B-05
plan: "[[2026-10-04-b05-thornwake-combat-readability]]"
revision: "[[2026-10-04-b05-controls-and-wagon-menu-revision]]"
implementation_evidence: "[[2026-10-04-b05-local-controls-inventory-wagon-implementation]]"
---

# B-05 local follow-up: results and review checkpoint

The owner asked Atena to implement the revised controls and interfaces locally, then prepare results and the next step for Claude. The implementation is already done locally; do not reimplement it from the original shared-primary instruction.

## Source and authority

Local branch: `codex/b05-controls-wagon-inventory`, based on published B-05 commit `4400b59aab49ed2860c5c6369ba79b386a7d2e9a`. The original commit is preserved. Main remains at `9ea4fc1`; no B-05 PR or merge has been performed. This local follow-up has not been pushed or sent to Claude.

If working in another environment, first confirm the owner has delivered the actual follow-up code and records. A fetch of the original B-05 branch does not deliver unpublished local work. Report missing files rather than reconstructing them from this summary. Do not push, open a PR, merge or start B-06 without separate owner authorization.

Read AGENTS.md, `.atena/add.yaml`, `.atena/state/plan.yaml`, the revised spec, the canonical separated-controls decision, and the new local implementation evidence. Earlier B-05 notes preserve the original implementation history; their old bindings are not the current controls.

## Implemented controls and changes

- Space: jump; Shift: dash at every inspected Mark.
- E: collect/interact/confirm; no melee damage.
- Left mouse: melee attack; no world interaction. J is the keyboard attack fallback.
- I: Lolth's carried inventory anywhere during journey gameplay; uses existing carried state, not wagon stock.
- M: Wagon menu near the wagon, with Supplies, Allies and Inventory access. Ally selection/assignment/recall is routed through this menu; direct Q/R bindings are removed. Thornwake posts and missions remain locked.
- Controller: left face attack, top face interaction, bottom face jump, right trigger dash, Menu/Select wagon nearby or inventory away from it. Existing C/right-face First Thread and F/left-shoulder boss action remain.
- Management panels pause the world, consume GUI/closing input, and cannot overlap F4. Wheel Kit storage/crafting still works.
- Right mouse is inactive and reserved for future higher-Mark parry. The owner explicitly deferred immediate parry; no unlock level or timing was chosen.
- Dash uses only Lolth's body pose: supplementary atlas VFX is suppressed and contaminated empty margins of both dash cells are excluded without changing body scale/pivot.
- Thornwake enemy render cells: Briar Hound 160 px, Stag 200 px, boss 260 px. Visible feet are grounded and labels remain above the body. Melee reach scales with the new proportions; enemy health/damage/contact radii are unchanged.
- Generic checkpoint restore now clears stale hurt/action visuals. Combat runner waits use wall-clock timeouts, stop cleanly on missing waves, and attack with actual left mouse events.

## Verified results

Godot 4.7.2 on Windows, normal 1280x720 OpenGL rendering, without fixed FPS:

- B-01 through B-05, F4 and full headless self-test: pass, exit 0.
- Combat real-input runner: 9/9 pass, exit 0.
- Controls/menu real-input runner: 33/33 pass, exit 0, including E/LMB isolation, real Space/J/controller input, pause, item integrity, E-confirmed crafting, cave locks, post cap, F4 restoration and inactive right-click.
- Normal and headless 600-frame smoke runs: exit 0, no script errors or warnings in the saved Godot logs.
- Captures inspected: inventory, wagon supplies/allies, hit/miss/actual hurt, clean elf/drow dash, and all three enemy proportions.

Commands, logs, captures, changed files and limitations are in `.atena/evidence/2026-10-04-b05-local-controls-inventory-wagon-implementation.md` and `.atena/generated/2026-10-04-b05-local-controls-validation/`. Original negative-control evidence is preserved; those 11 mutations were not rerun for this follow-up.

## Next step: review, not a new batch

Once the owner delivers this follow-up, perform a read-only review of the actual diff and evidence. Focus on input consumption and controller equivalence, wagon-only management eligibility, inventory identity/restore, melee reach versus visible contact, and clean dash sampling in both directions/forms. Run the supplied validation if the environment supports Godot. Return concrete findings and remaining human playtest items in English.

The owner should then playtest in Godot: gather/store/craft the Wheel Kit, defend at night, compare larger enemies and melee reach, exercise I/M/F4, and verify the boss/Shar/first-cure/safe-wagon flow. Automatic passes do not constitute human tuning acceptance. Keep B-05 active at this review checkpoint. Prepare any later progression or higher-Mark parry only after a separately approved plan.
