---
status: analysis-complete-production-not-started
kind: local-character-art-and-animation-audit
created: 2026-10-05
request_classification: NEW_DIRECT_REQUEST
origin: direct-read-only-analysis
implementation_preceded_spec: false
related_spec: '[[2026-10-05-lolth-three-transformations]]'
---

# Lolth: existing skins and animation analysis

The owner requested analysis of existing Lolth skins and production of three transformations unlocked at Marks III, V and VII. Read-only analysis preceded the new planned spec. No image generation, canonical change or runtime implementation has occurred. This record reconciles that analysis without inventing prior execution or approval.

## Operational state

The local `.atena/state/plan.yaml` has `active_plan: null`, `plan_cursor: complete` and no suspension. B-08 remains a separate deferred/prepared request, not an active execution plan in this workspace. This request therefore does not suspend or replace B-08. Existing local changes and review checkouts were observed and preserved. The recorded RTK availability decision already exists in `add.yaml`; no installation or configuration was attempted.

## Files inspected visually

- `assets/runtime_v2/characters/lolth/lolth-elf-core-sheet-v1.png`
- `assets/runtime_v2/characters/lolth/lolth-drow-core-sheet-v1.png`
- `.atena/generated/2026-10-03-p6-individual-character-sprite-masters/lolth-drow-master-v1.png`
- `assets/concept-art/characters/lolth-eight-mark-transformations-v2.png`
- `assets/concept-art/characters/lolth-mark-evolution-v1.png`
- `assets/art/characters/lolth-drow-intensified-motion-runtime-sheet-v1.png`
- `assets/art/characters/lolth-drow-intensified-aerial-runtime-sheet-v1.png`

These are selected representative sources, not a claim that every historical Lolth image was reviewed. Other elf/drow action, locomotion and aerial sheet versions were located in the inventory.

## Findings

1. Current rendering preloads only the two runtime_v2 core sheets (`main.gd:36`). `lolth_form()` returns elf for Mark 0 and drow for every other Mark (`main.gd:1946`). There are no distinct active skins at 3, 5 or 7.
2. Each active sheet is sampled as a 3-by-3 pose board. `player_sprite_frame()` (`main.gd:4148`) maps idle, two movement poses, strike, dodge, collect, rising air, falling air and hurt. Movement alternates at eight selections per second; the other states select one pose each. These are economical pose substitutions, not complete cycles for all actions.
3. The elf and drow core sheets preserve white hair, pointed ears, dark clothing, boots and a trailing mantle. Drow adds violet accents, sharper shoulders and a head ornament. The simpler approved P6 drow reference uses fewer costume masses and better matches the minimalist direction.
4. The intensified historical sheets use ornate pale armour, gold trim and pictorial shading. They are not selected by the current renderer. Their existence does not prove that an intensified transformation or animation is implemented.
5. The old evolution boards offer useful silhouette progression: shoulder armour, web framing, articulated spider-like appendages and a later arachnid body. Their exposed legs, fine ornament, large web backgrounds and painting-like treatment conflict with the current clothing/minimalist production rules. Use progression ideas, not direct crops.
6. Current dodge rendering has a crop workaround because a neighbouring attack spills into its cell. New atlases require clean cell boundaries, enough safe area for hair/appendages/VFX and stable pivots in both directions.
7. The renderer uses a 200-pixel destination cell height. This is not a measured anatomical body height and is not the canonical 24–40 logical-pixel art target. New art must separately preserve body proportions, logical pixel readability and current camera/collision behaviour.

## Authoritative constraints

- [[2026-10-03-minimal-character-visual-direction]]: silhouette first, large pixel clusters, short palette, identity and baseline 1.00; new candidates isolated until technical admission approval.
- [[2026-10-03-full-trousers-character-skin-rule]]: opaque, continuous trousers from waist to boots in every humanoid pose.
- [[2026-10-02-lolth-mark-rpg-adaptation]]: III = BLACK PULSE, V = NIGHT CHOIR, VII = SPIDER'S PROMISE, IX = SHADOW CROWN.
- [[2026-10-03-b00-opening-ending-and-production-resolution]]: III keeps BLACK PULSE and the first Web Anchor; VII has advanced anchors; later progression remains prototype work. English production output is required.
- [[2026-10-04-first-boss-mark-and-cure]]: Mark I already transforms elf Lolth into drow; the requested stages are additional evolutions.

## Recommended direction

Maintain the recognizable humanoid body and hair throughout the three stages. III adds compact shadow armour and a radial pulse gesture; V adds four folded spectral spider appendages and an echo gesture; VII adds eight spectral spider appendages with a readable open/retract web gesture. Appendages are visual manifestations, not wings or flight powers. The complete final spider transformation remains Mark IX lore and outside this production scope.

This is a proposal, not a canonical decision. Distinct stage silhouettes and real frame sequences should be reviewed together before admission. No visual similarity claim is based on an engine run: no Godot validation was required or performed for this read-only analysis.

## Preparation validation

The local validation command completed successfully: all eight required ADD contract entries exist and all nine wiki-link occurrences across this analysis and its proposed spec resolve to local canonical, spec or evidence files. Only the two new preparation documents were written; plan state, canon, existing assets and runtime files were not edited. Production approval and approval-mode selection remain pending.
