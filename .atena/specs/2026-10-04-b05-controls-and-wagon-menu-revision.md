---
status: complete-implementation-merged
kind: bounded-plan-change
created: 2026-10-04
request_classification: PLAN_CHANGE_REQUEST
approval_mode: per-plan
approved: 2026-10-04
approval_source: explicit-owner-request-to-implement-locally
parent_plan: "[[2026-10-04-b05-thornwake-combat-readability]]"
canonical_decision: "[[2026-10-04-separated-controls-and-wagon-management]]"
evidence: "[[2026-10-04-b05-controls-and-wagon-menu-review]]"
implementation_instruction: "[[2026-10-04-b05-controls-and-wagon-menu-instruction]]"
implementation_preceded_spec: false
pull_request_approved: true
merge_approved: true
pull_request: https://github.com/marizada86/the-first-nine/pull/4
merge_commit: bc7796e0fad33f5d7b773af3eaefc07749ec81b4
merged_feature_head: e5832da604226b33f424d18248b24f0825c568aa
closure_evidence: "[[2026-10-04-b05-documentation-closure]]"
---

## Current closure: B-05 integrated and completed

PR [#4](https://github.com/marizada86/the-first-nine/pull/4) was merged with a regular merge at `bc7796e0fad33f5d7b773af3eaefc07749ec81b4`, from `codex/b05-controls-wagon-inventory` at `e5832da604226b33f424d18248b24f0825c568aa` into `main`. All six PR commits and both feature branches are preserved. The original implementation branch `b05-thornwake-combat-readability` at `4400b59` is historical, not the current integrated delivery.

The owner separately authorized branch publication, PR opening, regular merge, and this documentation closure/publication on main. Initial local-only restrictions describe their original checkpoints; they do not negate those later approvals. Opus's delivered final review reported no blockers on `e5832da`; its reproduced Linux results are reviewer evidence, not fresh Atena results or CI checks.

B-05 is the last completed plan; the active-plan slot is cleared. This closure changes records only. No runtime, art, saved test outputs, canonical gameplay rules or dependencies change; no B-06 or branch deletion is authorized. Parry, balance tuning, higher-Mark progression and disk saves remain deferred. See [[2026-10-04-b05-documentation-closure]] and [[2026-10-04-b05-pull-request]] for verification and approval provenance.

## Historical preparation, implementation and review

The following sections preserve the original checkpoints and their evidence. Any pending-review, local-only, main-unchanged or no-PR/no-merge statement below refers to that stage, not today's closed state. Original implementation values superseded by later controls/geometry corrections remain historical.

# B-05 revision: independent actions and wagon management

## Scope and authority

The owner requested Space for jump, Shift for dash, E for collection/interaction, left-click for attack, all ally management in the wagon menu, and subsequently I for Lolth's inventory. These design rules are approved by the direct requests and recorded in [[2026-10-04-separated-controls-and-wagon-management]].

This adds input separation and a bounded wagon interface to the previously approved combat-readability batch. The original B-05 implementation is published at `4400b59aab49ed2860c5c6369ba79b386a7d2e9a` on `b05-thornwake-combat-readability`; main remains at `9ea4fc1bbfabd5be50a2d7f334b9b11325b8a77b` at the last verification. Implement on top of the published feature branch, not by replacing the main runtime with an older combat version.

The owner subsequently added right-click parry and explicitly instructed Atena to implement this revision locally, then return to Claude with results and the next step. The later instruction supersedes immediate parry: keep only dash now, introduce parry at a higher Mark, and remove the stray dash graphic. The owner also requested larger enemy proportions. These clarifications/readability corrections are IN_PLAN for the approved local revision, with no new progression unlock. The existing per-plan preference is retained. Publication, PR and merge remain separate gates.

## Runtime changes

1. Split base melee attack and collection/world interaction into independently mapped actions. The attack handler owns melee reach, nearest-target selection, combo damage, strike/miss feedback, and enemy defeat/Echo processing. The interaction handler owns pickups, wagon supply operations, world interactions, and narrative confirmation. E must not attack; left-click must not interact with the world. An attack with no nearby target still shows a swing and does no damage.
2. Preserve Space jump. Bind Shift to the existing short dash at every inspected Mark, without adding abilities or rebalancing its movement, cooldown, or invulnerability. Preserve C for First Thread and F for the existing deliberate boss action.
3. Add a real wagon menu opened by M near the wagon, using the existing camp proximity rule. M away from the wagon displays the return-to-wagon hint. M or Escape closes it. Pause the world while it is open and consume the closing input before normal gameplay resumes, as the current F4 panel already does.
4. Give the menu Supplies and Allies sections. Keep existing load selection, storage and crafting accessible in Supplies; changing M from recipe cycling must not strand those operations. Show all eight Thalestriel and their existing condition/role in Allies. Route the existing select, assign and recall operations through that menu, with mouse buttons and keyboard/controller focus. Remove direct Q/R gameplay bindings and stale hints.
5. Enforce all existing eligibility checks in the menu callbacks as well as disabled buttons. In Thornwake, show the roster but keep posts and missions locked with a readable explanation. Where prototype assignments already exist, retain their current checks and two-post cap. Do not implement pullers or new mission/defense systems merely to fill the interface.
6. Fix the B-05 review finding: clear player action and hurt visual timers on the generic checkpoint restore, just as on prologue and safe-wagon restore. Verify a lethal-hit restore starts with full restored health and no stale hurt effect.
7. Make the existing combat runtime runner wait for wave changes by elapsed time with an explicit timeout, not a small frame count. Report a clear failure and stop before indexing an absent enemy. Update it to use real left mouse input for attacks and E for interactions.
8. Add a separate English Lolth inventory opened anywhere during ordinary journey gameplay with I and closed with I or Escape. Display existing `recovered_load` items, their slot costs, used capacity and total carrying capacity, including an empty-state message. Permit item selection without duplicating, deleting, dropping or consuming items. Storage/crafting remains at the wagon; this panel is not wagon stock. Pause while open, prevent overlapping inventory/wagon/F4 panels, and consume UI/closing input. Do not introduce equipment, item-use rules, or a second inventory data model.
9. Keep right-click inactive and reserve parry for a separately approved higher-Mark slice; no unlock level is chosen here. Render dash with the existing Lolth pose only, suppress its supplementary atlas VFX, and exclude neighboring attack-art contamination from the dash cell while preserving body scale and pivot. Check both elf and drow variants.
10. Increase Thornwake enemy render-cell sizes from 96/96/160 to 160/200/260 pixels for Briar Hound/Stag of Mire/Antlered Hunger. Align visible feet to the ground and labels/health bars above the body. Scale the measured enemy component of melee reach with the new rendering size, retaining Lolth's component. Do not change enemy health, damage, attack timing or contact-damage radius. These are bounded playtest proportions, subject to human review.

## Grounded supplementary bindings

- Preserve A/D and left/right arrows for movement and cure selection.
- Use J as a separate keyboard-only melee alternative, preserving the approved full-keyboard access rule. This does not change E or the requested left-click mapping.
- Controller: left face button for melee, top face button for interaction, bottom face button for jump, right trigger for dash, right face button for First Thread, Menu/Select for the wagon menu. Preserve the left shoulder boss action; retire the old direct ally shortcuts.
- Right-click is reserved for future parry and currently unbound, superseding both immediate parry and the proposed secondary dash alias. Shift/right trigger remain dash. No parry fallback or new binding for prototype higher-Mark sense/anchor powers is introduced in this slice.
- Inside menus, use standard directional/focus navigation and E to confirm. Mouse clicks operate UI controls only. Narrative shells, cure and failure confirmations use E or the controller interaction action; gameplay left-click is no longer overloaded as confirmation.
- Retain F4 and its Mark/time/restore buttons. Prevent overlapping wagon and playtester panels and verify both restore/resume correctly.
- I toggles Lolth inventory. For controller parity, use Menu/Select to open the appropriate management interface: wagon menu near the wagon, inventory away from it; include an Inventory entry in the wagon menu and a near-wagon return action in inventory. Both panels remain available without a keyboard. Keep M as wagon-only keyboard access.

These approved defaults have now been implemented locally; validation and remaining review work are recorded in [[2026-10-04-b05-local-controls-inventory-wagon-implementation]].

## Non-goals

No new art, dependencies, Mark power, enemy, parry, direct companion control, cure, travel, Mark progression, region, puller system, disk save, PR, merge or publication. Existing later-region code remains prototype material. This revision changes access to existing management operations, not their gameplay eligibility.

## Acceptance criteria

1. Real E presses near an enemy do not reduce enemy health. Real left-clicks near a resource or the wagon do not collect, store, craft or trigger world interactions. Real left-clicks in melee reach damage the intended enemy and preserve the three-strike combo and hit/miss visuals.
2. Space jumps and Shift dashes. Dash is still dash when F4 inspects a higher Mark; it does not display false hurt visuals. J and the controller bindings provide separate attack and interaction access.
3. M near the wagon opens the English Supplies/Allies interface; M away from it cannot manage allies. The clock and survival values do not advance while the menu is open. Closing, clicking or switching panels does not leak a gameplay action.
4. All eight allies appear with truthful condition/role. Thornwake management cannot bypass locked posts/missions or cure more allies. Menu callbacks retain the two-post limit and all existing eligibility checks; Q/R no longer assign or recall during gameplay.
5. Supplies can still be selected, stored and crafted through the new menu. The Wheel Kit day/night tutorial, deliberate first boss, Shar shell, first cure, Echo gate and safe-wagon restore still work with the split controls.
6. Every checkpoint restore clears stale action/hurt visuals. Existing B-01 through B-05 and F4 tests pass after migrating tests to independent actions.
7. A normal 1280x720 real-input check passes with wall-clock wave timeouts without requiring fixed FPS. Capture and inspect the menu, hit, miss, dash and real hurt states. Record exact results and remaining tuning limitations in English.
8. I opens Lolth's carried inventory both beside and away from the wagon. Its contents and capacity agree with existing carried state before/after pickup and wagon storage. It never shows wagon stock as carried items or bypasses camp-only operations. Inventory pause, controller access, close/resume and F4 restoration work without input leakage or item duplication.
9. Right-click has no combat or dash effect. Both elf and drow dash captures contain no supplementary atlas overlay or detached attack-art stroke, preserving Lolth's body scale/pivot.
10. Thornwake enemies visibly read at the revised proportions with grounded feet, readable labels and matching melee reach. Hit/miss and genuine enemy-damage tests still pass; no health/damage/contact-radius rebalance is introduced.

## Impacts, gaps, and recovery

- Scope: extends the combat fix with input dispatch, wagon/inventory widgets, menu input consumption, and routing of existing management operations.
- Decisions: the owner explicitly replaced contextual-primary input and external ally hotkeys. Only the specified controls/management rule changes canon.
- Evidence: existing E-driven attack tests no longer prove the new mapping; migrate meaningful combat and progression assertions rather than discarding them.
- Recovery: use ordinary follow-up commits on the feature branch, keep `4400b59` intact, and do not amend or force-push the published history. Retain the reversible F4 snapshot; avoid storing UI Nodes in its script-variable snapshot.
- Checkpoints: the owner approved local implementation by explicit instruction; proceed through implementation/validation/human review. Further pushes, PR and merge retain separate authorization gates.
- BLOCKING gaps: none.
- RESOLVABLE defaults: M wagon access, I carried inventory, J keyboard fallback, ordinary menu focus, Supplies/Allies tabs, paused management, controller access to both panels, and an elapsed-time runtime timeout.
- DEFERRED: higher-Mark parry (unlock level and mechanics undecided), later-region progression and production of unavailable ally roles or higher-Mark powers.

## Plan of flight

1. Record the explicit local execution approval, retaining per-plan mode and the prior publication history.
2. Atena uses the published B-05 runtime as the local implementation base, preserving existing work and original commits.
3. Implement independent inputs, the bounded wagon and Lolth inventory panels, dash cleanup, enemy proportions, and the two review corrections locally. Do not implement parry.
4. Validate real keyboard/mouse input, menu routing, progression regressions, restore behavior and the time-independent runner; inspect normal-rendering captures.
5. Return a concrete local implementation, reconciled records and an English results/next-step handoff for Claude. Publication, PR, merge and sending the handoff externally are not authorized by this revision.

## Local implementation checkpoint

Implemented as local commit `43ab1128f62f164bdcce64d92ea1fe8bd0dfef4c` on `codex/b05-controls-wagon-inventory`, based on original published B-05 commit `4400b59`. Godot 4.7.2 self-tests passed, the revised normal-speed combat runner passed 9/9 and the controls/menu runner passed 33/33. Both dash forms and the three enemy proportions were visually inspected. See [[2026-10-04-b05-local-controls-inventory-wagon-implementation]] for exact evidence and smoke-run results.

On 2026-10-04 the owner stated "tudo validado, vamos continuar", accepting the local implementation at the IN_PLAN human-review checkpoint. No additional specific tests are inferred from that statement. The owner then explicitly authorized publishing implementation and records to `origin/codex/b05-controls-wagon-inventory`. A normal push published `43ab112` and `bb4a0d4`, and remote verification confirmed the first publication at `bb4a0d4830563dfa487409eaab852aefe4ca5d81`. Publication reconciliation follows as an ordinary records commit on that branch, preserving original B-05 history and main. B-05 now awaits technical review. PR, merge and external dispatch remain unapproved. This is not a completion/merge record or authorization to start B-06.

## Approved geometry correction after technical review

Following Claude's read-only review of published `e6b614c`, the owner explicitly authorized the local IN_PLAN correction in [[2026-10-04-b05-enemy-geometry-followup]]. Criterion 10 now uses uniform source aspect and the same current-frame native-alpha outline for both drawing and Thornwake reach, superseding the original separately measured enemy component. Heights and all health/damage/timing/contact-radius rules remain unchanged. Outline scanning is prepared at startup, not on first gameplay draw.

The new correction passes independent geometry 46/46, five faulty-subclass controls, real-input combat 9/9 and controls/menu 33/33, self-tests and both smoke runs. The evidence record with that identifier contains measurements, captures and deferred review observations. Prior acceptance/publication is preserved for its exact commits. The owner subsequently confirmed the corrected proportions with "conferido" and explicitly authorized recording that confirmation and publishing the correction and records. Normal branch publication of `b8823c70c637fdbef9f36e6cf0da0925369faa47` is verified; main is unchanged. Current gate: final technical review. PR, merge and B-06 remain unapproved.
