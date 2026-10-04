---
status: approved
kind: asset-production-specification
approved: 2026-10-02
intent: '[[2026-10-02-thalestriel-exodus-game-intent]]'
art_direction: '../../assets/concept-art/ART_DIRECTION.md'
source_decision: 'User approval of the runtime-art plan in this conversation'
---

# The First Nine — Runtime Art Batch 1

## Scope

Replace the drawn placeholders in the vertical slice with a small, readable 2D runtime-art set. Batch 1 prioritizes the prologue/camp, the seven-panel `THE KISS OF SHAR` interlude, and Lolth's playable states. It reuses existing local artwork wherever it can be made fit for runtime without changing the approved lore or art direction.

## Approved operating decisions

- Lolth is the only playable character. The eight Thalestriel are camp silhouettes and role-based passive-mission portraits; no playable survivor sprites are in scope.
- `RECOVERED LOAD` is represented by HUD and pickup imagery, not a character carrying an object in hand.
- The initial asset hierarchy is: camp/HQ/Lolth, then pickups and Shade, then gates/environment/UI, then final transformation polish.
- Lolth uses four economical presentation states: elf prologue, drow marks 1–5, intensified drow marks 6–8, and a full-screen `SHADOW CROWN` finale.
- Existing key art and concept sheets remain references or cinematics unless a derived runtime asset passes the technical contract.

## Technical contract

- Characters must retain their approved relative scale. Every character-bearing generation request declares a `scale_reference` and `target_height_ratio`; visible figure height is measured from feet to crown (excluding transparent padding, VFX, weapons, or raised limbs) against the reference character. A result is accepted only when its measured ratio is within ±5% of the target and its feet share the intended ground/pivot line. Lolth is the default 1.00 baseline unless the approved batch manifest states another reference.
- Runtime is side-view at 1280×720. Gameplay sprites use consistent canvas size, ground pivot, collision-safe silhouette, and transparent background.
- Gameplay frames must be independently named and carry no baked labels, borders, collage background, or ambiguous shared silhouette.
- The player needs idle, run, jump/fall, land, interact/recover, primary attack, shadow action, hurt, and defeat states for elf and drow forms.
- Each resource must communicate its category without text: `Provisions`, `Kindling`, `Salvage`, and `Shadow Echo`.
- The camp needs three visually distinct wagon-repair states. Gates must distinguish `VELVET VEIL`, `NIGHT CHOIR`, `DEEP HUNGER`, and `SPIDER'S PROMISE`.
- UI preserves the approved palette and all player-facing language remains English.
- Each generated or derived asset records source, prompt/parameters when applicable, license/usage status, and AI disclosure requirement before it is considered submission-ready.

## Plan of flight

1. Create a runtime asset manifest from the approved source images and tag each as reference, cinematic candidate, crop source, or missing. For every character-bearing item, record the reference character, intended height ratio, and measurement method.
2. Prepare local crop/normalization requests for the seven HQ panels, camp imagery, elf/drow prototypes, props, and VFX. Do not overwrite source PNGs.
3. Produce or derive the minimum playable set: Lolth's animation states, Shade, four pickups, camp repair states, four gates, zone kits, and HUD/input icons.
4. Integrate a single vertical slice route first; expand only after the visible route is coherent.
5. Validate scale (including the declared character-proportion ratios), transparency, pivots, collisions, readability, performance, input prompts, and a human end-to-end playthrough of the vertical slice.
6. Record provenance, validation evidence, credits, and jam-required AI disclosure; reconcile affected implementation documentation.

## Acceptance criteria

1. The title route shows runtime art for the camp, Lolth, a Shade, pickups, a Mark gate, and the HUD without falling back to those placeholders.
2. The seven HQ panels are independently legible and present the approved English story sequence.
3. Elf and drow Lolth remain readable while moving, jumping, attacking, using shadow action, taking damage, and restarting.
4. Players distinguish all four salvage categories, wagon repair progress, four gates, and the camp's safe/warning state without external instruction.
5. A human playthrough confirms visual legibility and controls; automated checks remain passing.
6. Each admitted asset has provenance and disclosure data sufficient for the jam submission.
7. Every admitted character asset passes its declared scale comparison; no character is admitted on the basis of isolated visual appeal when its relation to the cast is unverified.

## Non-goals

- New lore, survivor names, playable survivor characters, a fourth area, new dependencies, paid provider calls without a separate spend authorization, or final marketing art.
- Treating a source composite or a generated image as game-ready before it is cropped, inspected, integrated, and visually reviewed.

## Impacts and reconciliation

The original vertical-slice text contains pre-revision references to playable awakened survivors. The later approved caravan-survival revision and current implementation supersede that operational scope. This batch follows the revision; the vertical-slice specification must be reconciled when its implementation wording is next updated.

## Evidence to collect

- Asset manifest with file hashes and provenance fields.
- Character scale-reference sheet, declared target ratios, measured result ratios, and pass/fail decisions.
- Crop/normalization and provider receipts, when applicable.
- Runtime screenshots of the integrated route.
- Automated test output and human-playthrough checklist.
- Final credits and AI-disclosure audit.
