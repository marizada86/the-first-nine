---
status: complete-art-human-accepted
kind: bounded-game-art-production
created: 2026-10-05
origin: planned
implementation_preceded_spec: false
request_classification: PLAN_DEVIATION
approval_mode: per-plan
implementation_approved: true
production_approved: true
approved: 2026-10-05
approval_source: Owner replied 1 to the presented 30-image production scope and approval-mode selection.
approval_record: "[[2026-10-05-b09-opening-art-production-approval]]"
production_route: built-in-imagegen-local-package
production_route_accepted: true
production_route_source: Owner selected option 1 to produce missing assets here instead of supplying final assets.
runtime_admission_approved: false
parent_spec: "[[2026-10-05-b09-opening-cave-care-and-continuous-journey]]"
evidence: "[[2026-10-05-b09-opening-art-production]]"
blocking_gaps: []
push_approved: false
merge_approved: false
dispatch_approved: false
naming_revision: 2026-10-05-nolf-xiar-naming
---

# Opening comics cave and resting patients production

## Current execution checkpoint

All thirty selected art targets are generated, normalized, technically checked and human accepted. The package includes twenty comic panels, two cave environments and eight resting patients, produced in forty-four built-in image calls within the three-attempt ceiling. After accepting the five revised ending panels, the owner replied "aprovado" to the remaining twenty-five images on 2026-10-05. package-acceptance-v1.json records the exact selected versions and hashes. The production plan is closed as offline artwork only. Earlier queued and pending-review wording below describes previous checkpoints. No runtime admission, B-08 acceptance/integration or B-09 gameplay approval is inferred.

Naming amended on 2026-10-05 by the owner's explicit instruction: Nolf, Xiar and Xiar's kiss. Historical record IDs and asset paths retain their original names.


Produce a bounded package of 30 final-art candidates for the accepted opening revision. The owner first chose production here and subsequently approved the presented scope per plan. Production is authorized but queued behind the executing Nolf visual plan; runtime admission and interruption of that plan remain unauthorized.

## Sources and visual continuity

Use [[2026-10-05-opening-cave-care-and-continuous-journey]], [[2026-10-03-hq-narrative-revision]], [[2026-10-03-b00-opening-ending-and-production-resolution]], [[2026-10-03-minimal-character-visual-direction]] and [[m-06-production-grid]]. Existing H-01/H-02/H-03 boards provide narrative composition references only. Do not reproduce H-02 nudity or H-03's covered wagon.

Match the established lateral dark-fantasy pixel-art language: readable silhouettes, large pixel clusters, short character palettes, cool cave shadows and sparse amber fire. Match the existing patient identities and elf/drow distinction, not arbitrary new clothing or props. All figures remain clothed; humanoid sprites retain opaque trousers through the boots. The single family wagon is open and horse-less, with the relics preserved. No family member is permanently lost during gameplay.

Inspect actual source images before using them in generation. Reuse local project references through the built-in image tool, not external providers or copied designs. The final comic may depict the already established completed transformation, but does not redesign Mark IX, produce a new playable skin or supersede the separate Nolf III/V/VII plan.

## Deliverables

| Batch | Items | Count | Contract |
| --- | --- | ---: | --- |
| ART-001 | H-01 panels 01 through 09 | 9 | Elf-only city, council, departure, attacks, disasters, plague and arrival with exactly eight survivors |
| ART-002 | H-02 panels 01 through 06 | 6 | Xiar's arrival, previous-plane memories, bargain, Mark, drow transformation and wand handoff |
| ART-003 | H-03 panels 01 through 05 | 5 | Completed transformation, portal, united crossing, Golden City of Dreams and collective wand custody |
| ART-004 | Cave interior and exterior entrance | 2 | Separate reusable environment images, no baked actors, wagon, fire, UI or labels |
| ART-005 | Aelira, Vaelun, Nimara, Thaviel, Ilyren, Orisya, Soreth and Luraen resting poses | 8 | One genuinely lying, fully clothed plagued elf per transparent image; not a rotated standing sprite |
| ART-006 | Package checks, text and contact sheets | 0 new generated images | English panel script, source/prompt manifest, hashes, measurement and attempt receipts, review sheets |

The 9/6/5 panel counts come from the earlier reference contracts and are proposed as the final reader sequence. Each panel is generated as its own image, not cut from a multi-panel storyboard. The package contains 30 accepted images at most; rejected attempts remain clearly separate. Maximum three generation attempts per item means at most 90 built-in generation calls, not a promise that every item will pass.

## Technical contract

Comic and environment targets are landscape 16:9 PNG masters, nominally 1920 by 1080, with a 1280 by 720 local review. Preserve important content inside a safe inset and leave a clear lower caption area. Record actual generator dimensions; if necessary, use a non-destructive, aspect-preserving normalization with an inspected crop. Never stretch a subject or claim requested dimensions as delivered dimensions without measuring them.

Keep English captions and dialogue outside the bitmap in a panel-indexed text file. No baked text, speech balloons, logos or watermarks. The future game reader supplies the text and controls. This plan can produce local review layouts, not alter the runtime reader.

The cave interior reserves a straight continuous floor and legible positions for one wagon, fire and eight patients placed separately by the future renderer. The exterior entrance matches its rock/root silhouette and connects to the established Thornwake route. Do not bake time-of-day lighting that prevents a coherent day/night presentation. This package does not add terrain geometry, collisions, transitions or a second wagon.

Resting patients use transparent PNGs and a proposed common 64 by 64 logical cell with a recorded ground-contact pivot and nearest-neighbour preview. Anchor identity to the curated M-03 lineup and confirmed name mapping, then compare anatomical crown-to-heel length to the measured common Nolf body baseline at ratio 1.00, within five percent. A recumbent bounding-box height is not a standing-height measurement. Record the measurement landmarks and exclusions; if pose perspective prevents a reliable body measurement, mark the item as an exception rather than claiming a scale pass. Keep bedding or ground shadows separate from the body measurement.

Before producing ART-005, the measurement contract and name-to-reference mapping must be verifiable. Missing or ambiguous individual mapping blocks that item, not permission to invent a costume. Inspect all eight together for identity, consistent body scale and distinct genuine resting poses. One static pose per patient is included; no breathing animation, cured replacement or combat cycle is included.

## English panel text proposal

These lines are a proposed rendering of approved story beats, not new lore. Generation approval includes this bounded text proposal; substantial story changes require a separate decision. H-01 retains explicit Eol blame in every panel that shows Nolf. Exactly eight final survivors are shown together with her in its last panel.

| Panel | Image beat | Caption or dialogue |
| --- | --- | --- |
| H01-01 | Crowded Golden City, only elves; no identifiable Nolf | The Golden City could no longer shelter all its people. |
| H01-02 | Elven council; no identifiable Nolf | The great families would leave, each seeking a new home for the elves. |
| H01-03 | Thalestriel departure, more than one hundred elves and open relic wagon | Nolf: Eol, damn you. You have driven us from our home. |
| H01-04 | Creature attack on the travelling family | Nolf: Curse you, Eol! Must your creatures hunt us too? |
| H01-05 | Hostile attackers, family protecting the relic wagon | Nolf: Damn you, Eol. Every road becomes another trap. |
| H01-06 | Natural disaster strikes the caravan | Nolf: Eol, you bastard! Even the land turns against us. |
| H01-07 | Plague takes hold; Nolf remains unaffected | Nolf: Curse you, Eol. Now you send sickness after them. |
| H01-08 | Most of the caravan lost, non-graphic mourning | Nolf: Damn you, Eol. I will not leave the others behind. |
| H01-09 | Damaged wagon and exactly eight plagued elves lying inside the cave, with Nolf | Nolf: Curse you, Eol. We are still here, and we stay together. |
| H02-01 | Xiar appears after Antlered Hunger is defeated | Xiar: Every calamity reaches your family. None touches you. Who are you? |
| H02-02 | Nolf's former godhood presented as a memory, not a new divine identity design | Nolf: I remember another plane. There, I was a goddess. |
| H02-03 | Nolf offers the memories; Xiar accepts | Nolf: Take those memories. Give me a path to power and divinity here. Xiar: Agreed. |
| H02-04 | Xiar applies the Shadow Mark with her wand | Xiar: Receive the Shadow Mark. |
| H02-05 | Fully clothed elf-to-drow transformation | The bargain remade Nolf as a drow. |
| H02-06 | Wand handed to Nolf, restrained shadow-creature command cue | Xiar: XIAR'S KISS is yours. Its bearer can command all shadow creatures. |
| H03-01 | Nolf completes her established final transformation | Nolf's transformation was complete. |
| H03-02 | Portal opens to the Dream Plane | She opened a passage to the Dream Plane. |
| H03-03 | Nolf and exactly eight drows cross with the open wagon and relics | All nine crossed together. No one, and no relic, was left behind. |
| H03-04 | All nine remain together in the Golden City of Dreams | In the Golden City of Dreams, they found their home. |
| H03-05 | Nolf leaves the wand in the eight drows' collective custody and stays with them | XIAR'S KISS remained in the eight drows' care. Nolf remained with them. |

The illustrative memory in H02-02 must not invent an unapproved costume, temple, named god or former-plane history. Use an abstract recollection. H-03 production does not prove or unlock a normal full playthrough to Mark IX.

## Plan of flight and approval

The selected mode is per-plan, recorded in [[2026-10-05-b09-opening-art-production-approval]]. Preserve the executing Nolf visual plan and queue this package behind its completion unless the owner explicitly authorizes a different route and the active plan is durably suspended. Approval of a queued package does not authorize concurrent execution or changing the active slot.

Prepare one validated JSON manifest per image batch, with named asset IDs, prompts, inspected references, versioned destinations, checks and maximum attempts. Only after approval may a manifest claim approved or plan-approved status. Its approval record must explicitly name ART-001 through ART-005; ART-006 is the bounded packaging step. No draft manifest is executable.

Generate one image per built-in call, inspect each candidate and retry only its failed requirements. Save versioned candidates and receipts under .atena/generated/2026-10-05-b09-opening-art-production/. Never overwrite source references or save approved candidates into assets/ as part of this production-only package. Use ART-001 through ART-006 as per-batch checkpoints; use stable item IDs as per-step checkpoints if selected.

## Acceptance validation and evidence

Validate ADD paths, manifest contracts and links before generation. Inspect each image for the declared single subject/panel, narrative continuity, correct elf/drow stage, clothing, family count where applicable, open wagon, correct wand and no forbidden text. For patients, verify real alpha, body proportions, ground contact, identity and 1280 by 720 legibility. Inspect contact sheets for cross-panel character consistency and cave entrance continuity.

Record all attempts, exact prompts, references, dimensions, hashes, measured proportions, provider provenance, AI disclosure and exceptions. Technical candidate acceptance is not owner visual acceptance or runtime admission. Failed items cannot be admitted; complete the other approved items and report exceptions. No engine-test claim arises from image review.

## Non goals impacts and recovery

No runtime code, imports, scene redesign, new Nolf skins, Mark powers, enemies, animation cycles, dependencies, paid-provider jobs, disk saves, commit, push, PR, merge, external handoff or publication. Asset generation uses the available built-in tool; do not switch to an API/CLI fallback without fresh authorization.

This changes only the proposed production route and future candidate storage. Source assets, canon, patient names, active Nolf plan and existing validation evidence remain intact. Keep original references and rejected candidates versioned; recover by dropping references to a new candidate, not resetting or deleting owner work.

After owner acceptance of the produced package, prepare a separate bounded B-09 runtime admission/implementation approval. B-08 human acceptance and authorized integration remain prerequisites to that code work, not to offline art preparation. Reconcile actual production facts and do not mark B-09 implemented from asset production alone.
