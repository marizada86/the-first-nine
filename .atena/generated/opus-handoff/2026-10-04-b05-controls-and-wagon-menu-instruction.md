---
status: archived-merged-b05-instruction
kind: review-and-next-step-handoff
created: 2026-10-04
batch: B-05
plan: "[[2026-10-04-b05-thornwake-combat-readability]]"
revision: "[[2026-10-04-b05-controls-and-wagon-menu-revision]]"
implementation_evidence: "[[2026-10-04-b05-local-controls-inventory-wagon-implementation]]"
closure_evidence: "[[2026-10-04-b05-documentation-closure]]"
merge_commit: bc7796e0fad33f5d7b773af3eaefc07749ec81b4
---

## Archived instruction — do not execute as a new request

B-05 was merged through PR #4 and is completed. This instruction is retained as historical handoff evidence, not an outstanding execution gate or authority for B-06. The owner separately authorized closure/publication of records only; no new external dispatch is performed. See [[2026-10-04-b05-documentation-closure]].

# B-05 local follow-up: results and review checkpoint

The owner asked Atena to implement the revised controls and interfaces locally, then prepare results and the next step for Claude. The implementation is already done locally; do not reimplement it from the original shared-primary instruction.

## Latest correction: published and owner-validated

Claude's delivered read-only review of `e6b614c` has been addressed within the owner-approved local geometry scope. Read [[2026-10-04-b05-enemy-geometry-followup]] (spec and evidence): Stag aspect is preserved, Thornwake melee shares the current-frame drawn outline, and 22 outlines are prepared before gameplay. Geometry 46/46, five isolated faulty-subclass detections, combat 9/9, menus 33/33, all self-tests and both 600-frame smoke runs pass. Final normal preparation is 645.064 ms; tested gameplay adds zero scans. No fixed damage/timing/contact-radius change, new parry, inventory pause change or higher-Mark binding was introduced.

Required correction commit: `b8823c70c637fdbef9f36e6cf0da0925369faa47`. The owner confirmed the requested visual-review checkpoint with "conferido" and explicitly authorized publishing the correction plus acceptance/publication records. A normal push to `origin/codex/b05-controls-wagon-inventory` is verified at `b8823c7`; main remains `9ea4fc1`. Acceptance/publication reconciliation follows in an ordinary records commit on this branch. Fetch and report the exact reviewed HEAD, ensuring it contains `b8823c7` and the current records. Do not treat `e6b614c` as the corrected version. If unavailable, stop and report missing delivery rather than review older code. Earlier acceptance of `43ab112` remains valid; do not request duplicate human approval based on old local-only notes. This handoff authorizes no edits, further push, PR, merge, direct external dispatch or B-06. The source/controls/results sections below preserve the prior published revision's history.

## Source and authority

Published branch: `origin/codex/b05-controls-wagon-inventory`, based on original B-05 commit `4400b59aab49ed2860c5c6369ba79b386a7d2e9a`. The original commit is preserved. Main remains at `9ea4fc1`; no B-05 PR or merge has been performed. The owner authorized publication of implementation and records on 2026-10-04. First publication was verified at `bb4a0d4830563dfa487409eaab852aefe4ca5d81`; publication reconciliation follows normally on this branch. Atena has not directly dispatched this handoff to Claude.

Implementation commit: `43ab1128f62f164bdcce64d92ea1fe8bd0dfef4c`. On 2026-10-04 the owner accepted it with "tudo validado, vamos continuar", recorded in `bb4a0d4`. Human validation and branch publication are accepted. Do not ask the owner to approve them again merely because older notes described those gates as pending. PR and merge remain separate pending authorizations.

If working in another environment, fetch and inspect `origin/codex/b05-controls-wagon-inventory`, not just the older `b05-thornwake-combat-readability` branch. Preserve existing work, report the exact inspected HEAD, and confirm it contains `43ab112` and `bb4a0d4` plus the publication reconciliation. Report missing files rather than reconstructing them from this summary. This is a read-only review handoff: do not edit, push, open a PR, merge or start B-06 without separate owner authorization.

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

Human validation has already been accepted; do not reset it to pending. A technical review may still report a concrete new regression or limitation, but do not invent additional human test results. Keep B-05 active at the appropriate publication/PR/merge checkpoint rather than marking it merged or automatically starting B-06. Prepare any later progression or higher-Mark parry only after a separately approved plan.

Apply the latest published-correction checkpoint above. The owner has now independently confirmed that change and authorized its publication, so resume the read-only final B-05 review after verifying delivery. Run checks in an isolated scratch copy to avoid overwriting committed evidence; the supplied Windows process wrapper uses `D:/Godot/godot.exe`, so other environments should use the available Godot executable without modifying production files to force success. Clearly distinguish reproduced results from inspected historical Windows evidence. Deferred findings are explicit: unchanged contact-damage balance, approved inventory pause, orphaned prototype higher-Mark Shift powers, cosmetic HUD crowding, and identical no-VFX dash comparators. Do not silently implement these as part of a review. Report readiness for a separately authorized PR and recommend a next bounded planning step; do not open the PR, merge or start B-06.
