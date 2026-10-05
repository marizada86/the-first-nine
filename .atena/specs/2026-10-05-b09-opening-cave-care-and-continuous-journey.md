---
status: prepared-art-accepted-awaiting-b08-and-implementation-approval
kind: proposed-runtime-revision
created: 2026-10-05
plan_id: 2026-10-05-b09-opening-cave-care-and-continuous-journey
origin: planned
implementation_preceded_spec: false
request_classification: PLAN_CHANGE_REQUEST
current_plan_relationship: PLAN_DEVIATION
approval_mode: unconfigured
implementation_approved: false
execution_target: local-atena
canonical_decision: "[[2026-10-05-opening-cave-care-and-continuous-journey]]"
evidence: "[[2026-10-05-b09-opening-cave-care-and-continuous-journey]]"
depends_on: "[[2026-10-05-b08-stonehook-cliff-harrier]]"
push_approved: false
pull_request_approved: false
merge_approved: false
dispatch_approved: false
blocking_gaps: []
production_route_accepted: true
production_spec: "[[2026-10-05-b09-opening-art-production]]"
production_approved: true
production_approval_mode: per-plan
naming_revision: 2026-10-05-nolf-xiar-naming
---

# Opening cave tutorial and individual care revision

## Current dependencies

On 2026-10-05 the owner accepted all thirty selected images from [[2026-10-05-b09-opening-art-production]]. That offline plan is complete. The Nolf intermediate visual plan is also complete and human accepted. Earlier queued or active-visual wording below describes preparation history. B-08 still has a passing Windows technical receipt but awaits owner acceptance and authorized integration; local main remains 4d3c5c1, with owner edits preserved. No new remote-state claim is made. Gameplay approval mode remains unconfigured and implementation_approved remains false. Artwork acceptance does not authorize admission or this gameplay revision.

Naming amended on 2026-10-05 by the owner's explicit instruction: Nolf, Xiar and Xiar's kiss. Historical record IDs and asset paths retain their original names.


Implement the owner's accepted interview rules as a tested revision of the existing game, retaining the reviewed Stonehook encounters. This is a proposed B-09 gameplay plan, not active work and not approval to replace B-08. The owner approved the bounded art package per plan, queued behind the active visual plan. Later gameplay implementation still requires its own scope and approval-mode decision.

## Evidence and baseline

The owner checkout is on main at 4d3c5c1, with unpublished preparation and review records that must be preserved. Published B-08 is 052ec6466ee2a8252cf54f6f72ed11f0cc26e045 on codex/b08-stonehook-cliff-harrier. Its Windows review passed all 26 cases, including B-08 34/34 and real-input 33/33. Human acceptance, publication reconciliation, PR, merge and closure are not complete.

The implementation base will be the verified integrated descendant of B-08, after those separately authorized gates. Do not implement on the older main or silently overwrite the owner's local records.

During preparation, the owner state acquired a concurrently approved executing [[2026-10-05-lolth-three-transformations]] plan. Relative to that active visual plan, this gameplay revision is a pending PLAN_DEVIATION. Preserve its active slot, approval and B-001 cursor. B-09 is not a replacement or an authorized suspension; activation requires that plan's completion or an explicitly authorized route change.

Static inspection found that H01_SHELL_BEATS has six entries, while draw_opening displays the same title for each. The opening reads the primary action, but left-click is bound to attack even though its caption advertises click to continue. This supports the reported apparent nonresponse; it is not a reproduced diagnosis of every possible focus or debounce issue.

## Scope

Separate initial menu confirmation from comic navigation. One valid press or click starts exactly once; each comic action advances one visible panel. Show readable English controls and panel progress. Skip ends the current comic without duplicating gameplay, rewards or Mark acquisition. The same click must not become an attack on the next screen.

Create a genuine cave interior with the wagon, fire, relics and eight resting patients. Provide a visible exterior entrance and a reversible continuous passage into the first outdoor route. Keep the main floor flat and preserve gradual authored transitions to later regions. Do not fake the cave with a text label over the unchanged forest.

Teach carried inventory, wagon storage, medicine preparation, selecting and treating a patient, and wagon repair in short guided steps. Freeze the introduction; release exploration without a repair prerequisite. Introduce definitive Mark cure only after the Xiar encounter.

Add health and plague state keyed by the eight existing ally identities. Give them distinct, safe initial conditions. Prepared medicine restores only the selected patient, consumes exactly one dose and never cures the plague. A legitimately earned Mark credit transforms one eligible patient at the wagon without ingredients. Track earned and spent credits so callbacks, revisits, skips, restores and F4 overrides cannot create duplicate or unearned transformations.

At night, concrete enemies approach the entrance, trigger a warning, cross the entrance and then attack the wagon. Nolf can intercept them anywhere they are legitimately reachable. Count each actor once; do not spawn an unrelated monster directly among the patients. Preserve readable telegraphs and dash counterplay. Do not implement an instant loss at six enemies. Patient failure, Nolf failure and wagon destruction restore a valid checkpoint.

Renew common gathering points once at dawn. Use persistent harvest-cycle identities so boundary oscillation cannot duplicate pickups. Do not renew unique ore, boss rewards or encounter Echo payouts. Safe wagon returns work before and after Mark I and save care, repairs, medicine, inventory, world time, harvest cycles, tutorial completion, boss/story flags and transformation credits consistently.

Prepare and integrate the three comic sequences using one panel per screen and final approved English text. H-01 precedes cave play; H-02 follows the first outdoor boss; H-03 belongs to legitimate Mark IX completion. H-03 reader and assets may be tested with a controlled fixture; that is not proof that the currently bounded game permits a normal full playthrough to Mark IX.

## Non goals

No procedural terrain, new regions or bosses, higher-Mark combat powers, parry, ally control, follower AI, wagon travel unlock, missions/posts unlock, dependency installation, paid provider jobs, disk saves, release export or broad engine reconstruction. Existing locks remain unless an interviewed rule explicitly replaces them. No further Opus handoff.

Do not reuse whole storyboard boards as comic screens, rotate standing elves to claim genuine resting poses, import unreviewed art, or weaken tests to hide unintended regressions.

## Acceptance criteria

1. A single keyboard, mouse or equivalent controller confirmation starts; a held input does not skip panels, start twice or attack on entry.
2. All three comics show one panel per screen with readable English text, navigation and skip. Mark/reward/story effects happen exactly once.
3. The initial playable wagon is visibly inside the cave with exactly eight named, resting plagued elves. The exterior visibly shows the same cave entrance; outward and return travel have no region-selection screen.
4. Guided presentation pauses time and deterioration. Exploration advances both offscreen; menus and comics pause both. Leaving does not require a completed repair.
5. Medicine preparation and treatment are separate. One dose restores one selected patient's health; the other seven and plague status stay unchanged. Initial severity differs without immediate introductory failure.
6. Each legitimate Mark I-VIII offers exactly one free ally transformation at the wagon. No resource cost, double cure, F4 credit, remote cure or ninth patient exists.
7. Only night generates cave invasions. Warning precedes arrival; each arriving monster enters and attacks the wagon. Killing it prevents further attacks. No monster-count or absence-time loss exists.
8. A safe pre-Mark-I return saves progress. Failure restores all required medical, narrative, inventory, encounter and harvest state, without repeating completed HQ/tutorial or producing resources and credits.
9. Common nodes renew once at dawn; revisits do not renew them. Unique items and rewards stay unique through multiple days and restores.
10. B-08 crawler and Harrier behavior, facing, independent rewards and restoration remain intact. Historical checks that encode superseded opening, spatial or restart contracts are preserved as historical files and explicitly mapped to fresh checks for the accepted revision.
11. Fresh Windows input, state, rendering, regression and faulty-control tests pass. Owner review is still required for readability and balance.

## Impacts and recovery

This changes location presentation, tutorial gates, patient state, the pre-Mark-I checkpoint boundary and first-cure timing. It is not an enemy-only patch. Existing scene-specific snapshots and fixture coordinates need migration and deliberate test coverage. The collective GROUP display must not misrepresent individual patients or create an obsolete second plague-failure rule.

Use a dedicated codex/b09-opening-cave-care branch only after verifying the accepted base and preserving owner-local work. Implement incrementally; do not replace main.gd wholesale. Retain old assets and historical validators. New result paths must not overwrite earlier platform evidence. Commit/push/merge remain separately authorized.

## Gaps and defaults

RESOLVED ART-001: the owner selected production here instead of supplying final assets and subsequently approved [[2026-10-05-b09-opening-art-production]] per plan. It bounds 30 images, English text and validation. Generation is authorized but queued behind the active visual plan; no art has been produced at this checkpoint. Earlier H-01/H-02/H-03 approvals were reference-only. H-02 cannot ship unchanged because of explicit nudity; H-03 cannot ship unchanged because of the covered wagon, as recorded in the approved B-00 production boundary. Runtime admission remains a later gate.

Execution prerequisite B08-ACCEPTANCE: the reviewed B-08 is not human accepted or integrated. Resolve it separately; this draft cannot close or replace that plan.

Execution prerequisite ACTIVE-VISUAL-PLAN: preserve the executing Nolf transformation plan. Finish it or obtain an explicit routing decision before activating B-09; preparation here does not authorize interruption.

RESOLVABLE: reuse existing medicine-recipe ingredients where compatible; represent prepared doses as inventory items; choose configurable health, deterioration, dose strength, invasion delay and gathering yields before implementation tests. These are recorded playtest values, not lore. Use the existing eight names. Renew ordinary resources at dawn and leave unique rewards unchanged.

DEFERRED: full later-region progression to Mark IX, disk persistence, final balance, travel/puller mechanics and unrelated known visual debt. Preparing/testing H-03 is not permission to unlock all later progression.

## Plan of flight

B-001 Controls and comic reader: separate menu and reader, correct input routing and display progress.
B-002 Cave and guided tutorial: genuine interior, entrance, resting patients and reversible authored route.
B-003 Individual care: patient conditions, prepared medicine and separate Mark transformation credits.
B-004 Night invasion: warning, concrete entrance crossings, wagon attacks and failure rules.
B-005 Supplies and checkpoints: dawn renewal, safe pre-Mark-I saves and consistent restoration.
B-006 Comic integration and validation: approved panels/text, exact-once events and complete Windows regression review.

Art production and admission are prerequisites to the affected batches, not actions authorized by this draft. Do not claim visual acceptance from a placeholder. Each implementation batch produces evidence and can be recovered independently.

## Approval and reconciliation

ART-001 is resolved and the presented production package has per-plan approval. Do not request that same approval again. Request B-09 gameplay approval-mode selection once its base and asset-admission conditions are met. Neither B-08 nor art-production approval configures this gameplay plan. A selected mode does not bypass asset-admission, dependency, publication or merge gates.

On completion, reconcile the new interview decision against only the superseded rules, append dated evidence, preserve the B-08 history and record actual validation and owner acceptance. This preparation writes documentation only; no runtime, asset generation, import, commit, push or merge.
