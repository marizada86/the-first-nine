---
kind: generated-asset-provenance
generated: 2026-10-02
spec: '[[2026-10-02-runtime-art-batch-1]]'
generator: built-in-imagegen
disclosure: required-before-submission
---

# Runtime Art Batch 1 — Generation Record 01

## Admitted outputs

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/characters/lolth-drow-runtime-sheet-v1.png` | `1FC73BAB6820FC7C4D945FDA4F688E2EB0ECBA93E134B44DB8600F532A536889` | `exec-0c4524af-8b4d-4a3d-a654-ce3e3a2fc155.png` | 1224×1285, 32-bit ARGB, transparent corner samples. Candidate 3×3 sprite sheet. |
| `assets/art/characters/lolth-elf-runtime-sheet-v1.png` | `9737CCD8914CE65BD77551578ECE36C5F0D5B3E5C9AE5AB4E395610C9797A069` | `exec-3f57711f-9430-4714-a96c-9f711c0f425a.png` | 1536×1024, 32-bit ARGB, transparent corner samples. Candidate 3×3 sprite sheet. |

The original generated files remain in the generator output directory. The workspace copies are new versioned assets; no previous source PNG was overwritten.

## Drow prompt

```text
Use case: stylized-concept
Asset type: production-ready 2D side-view game character sprite sheet, transparent PNG
Primary request: Create an original nine-pose sprite sheet for Lolth in her awakened drow form for The First Nine. Arrange exactly 3 columns by 3 rows, generous even spacing, all full-body figures sharing the same ground baseline and scale. Poses, reading left-to-right, top-to-bottom: idle; run; jump/fall; land; recover/interact; primary shadow strike; Velvet Veil dash; hurt; defeat.
Subject: a powerful adult female drow, pale blue-gray skin, very long silver-white hair, long ears, bone-white segmented chitin armor grown like ritual armor, asymmetrical dark violet fabric and web motifs, subtle antique-gold relic detail. Her silhouette must remain legible at gameplay scale.
Style/medium: original polished painterly 2D game-sprite illustration, simplified clean silhouette and crisp edges, not photorealistic, designed to be cropped into individual frames.
Color palette: bone white, silver, bruised violet, charcoal, tiny antique gold.
Constraints: genuinely transparent background; no scenery, no ground plane, no shadows, no frame borders, no text, no labels, no logos, no watermark; no extra characters; no weapons or held salvage item; no cropped limbs; preserve the exact same character design, facing direction, and body proportion in every frame.
```

## Elf prompt

```text
Use case: stylized-concept
Asset type: production-ready 2D side-view game character sprite sheet, transparent PNG
Primary request: Create an original nine-pose sprite sheet for Lolth before the First Thread, in her elf form, for The First Nine. Arrange exactly 3 columns by 3 rows, generous even spacing, all full-body figures sharing the same ground baseline and scale. Poses, reading left-to-right, top-to-bottom: idle; run; jump/fall; land; recover/interact; primary physical strike; evade; hurt; defeat.
Subject: a physically strong adult elf woman, warm pale skin, very long pale blonde hair, long ears, travel-worn ivory tunic, dark blue-charcoal cloak, practical bronze leather armor and boots. This is the pre-pact form: absolutely no drow skin, no chitin armor, no shadow magic, no webs.
Style/medium: original polished painterly 2D game-sprite illustration, simplified clean silhouette and crisp edges, not photorealistic, designed to be cropped into individual frames.
Color palette: warm ivory, muted gold, blue-charcoal, worn bronze.
Constraints: genuinely transparent background; no scenery, no ground plane, no shadows, no frame borders, no text, no labels, no logos, no watermark; no extra characters; no weapons or held salvage item; no cropped limbs; preserve the exact same character design, facing direction, and body proportion in every frame.
```

## Rejected derivative

`exec-0a2a9c51-599f-4640-995e-f2fc4e67459b.png` attempted a background-only edit of the elf sheet. It did not visibly improve the selected original and is not admitted to the workspace.

## Generation Record 02 — enemy and pickups

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/enemies/shade-runtime-sheet-v1.png` | `608450B5FD53DC532FB32994144C92E1A45FC717920AD41E9A7092AE85A70F7E` | `exec-1b6cd516-e96f-416f-9045-a852e8192963.png` | 1536×1024, 32-bit ARGB, transparent corner samples. Candidate 2×2 sheet. |
| `assets/art/items/salvage-pickups-runtime-sheet-v1.png` | `A8E55A0E96416BA8D4F0C0156C0B5F390D213FC974AC246D1EF8AECB54837712` | `exec-cb90effc-a072-4981-a75c-2f79347a68be.png` | 1226×1283, 32-bit ARGB, transparent corner samples. Candidate 2×2 sheet. |

### Shade prompt

```text
Use case: stylized-concept
Asset type: production-ready 2D side-view game enemy sprite sheet, transparent PNG
Primary request: Create an original 2 by 2 sprite sheet for a single enemy called a Shade in The First Nine. Four equal cells, same ground baseline and scale: idle floating silhouette; lunge attack; struck/dissolving; defeated fading into a Shadow Echo.
Subject: an uncanny humanoid wraith made only of charcoal smoke, bruised violet shadow and trailing web-like wisps, with one small cold-violet core glow. It must be visually distinct from Lolth and readable at small gameplay scale.
Style/medium: polished painterly 2D game-sprite illustration with a simple strong silhouette, crisp edges, designed to be cropped into independent frames.
Color palette: violet-black, charcoal, a restrained pale-violet glow; no gold.
Constraints: genuinely transparent background; no scenery, no ground plane, no cast shadow, no text, no labels, no frame borders, no logos, no watermark; no extra creatures, no weapons, no cropped parts.
```

### Pickup prompt

```text
Use case: stylized-concept
Asset type: production-ready 2D game pickup sprite sheet, transparent PNG
Primary request: Create an original 2 by 2 sprite sheet with exactly four equal, separated pickup props for The First Nine. Reading left-to-right, top-to-bottom: Provisions, Kindling, Salvage, Shadow Echo. Each prop fills its cell, is immediately distinguishable by silhouette, and has modest empty padding.
Subject details: Provisions are a small cloth bundle of herbs, bread and a waterskin; Kindling is a tied bundle of dry wood with a tiny amber lantern; Salvage is a broken brass-and-wood wagon fitting with chain and repair tool; Shadow Echo is a violet-black memory ember trapped in a small thorn-and-web loop.
Style/medium: original polished painterly game item sprites, crisp readable silhouettes, not photorealistic.
Color palette: Provisions muted green/ivory, Kindling warm amber/brown, Salvage tarnished brass/wood, Shadow Echo violet-black; preserve the dark-fantasy warm-gold-versus-cold-blue direction.
Constraints: genuinely transparent background; no text, no labels, no icon frames, no UI border, no scenery, no cast shadows, no logos, no watermark; no characters; each item must stay wholly inside its own grid cell.
```

## Generation Record 03 — progression and environments

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/camp/wagon-repair-states-runtime-v1.png` | `CFBE59F94FA787FBD17D2223960DD6DB9A281A3B8462DE9C27C82019B94E39BC` | `exec-706db1ee-ad23-41a3-a186-2b0bc955a296.png` | 2172×724, 32-bit ARGB, transparent corner samples. Candidate 3-state row. |
| `assets/art/gates/mark-gates-runtime-sheet-v1.png` | `0D0CE36C03886EC5CEA739E475F9FBBEF3CF3D48E90C449498923BBCBEC18D80` | `exec-34b1960f-e1a9-4105-ac10-9cf7f6dbde3c.png` | 1536×1024, 32-bit ARGB, transparent corner samples. Candidate 2×2 grid. |
| `assets/art/environment/veil-ruins-backdrop-runtime-v1.png` | `2D01AF68789E3CEA9F237E4A5EF1BBE0010F5D8599E10E0D40D685E8603F9D34` | `exec-2db693f6-2a4c-46fb-aa83-3cfbd3e7bf52.png` | Generated backdrop, integrated in zone 1. |
| `assets/art/environment/last-threshold-backdrop-runtime-v1.png` | `8941F87377CCE089029B02644EC001714EFBBA596F05FEF4AA2D4208C9BDB31F` | `exec-a4e0dd98-28b5-49e5-b09d-f1862af7330b.png` | Generated backdrop, integrated in zone 2. |

### Wagon prompt

```text
Create an original 3-column by 1-row progression sheet showing the exact same side-view refugee caravan wagon at three repair stages for The First Nine: left cell badly damaged and unsafe; center cell partly repaired; right cell fully repaired and reliable. Every wagon must share one fixed scale, camera angle, ground baseline, and silhouette bounds. Compact wooden covered wagon with torn ivory canvas, dark blue hanging cloth, tarnished antique-gold thorn-and-web fittings, sturdy wheels, practical rope and patched wood. No people, flame, campfire, or supplies. Polished painterly 2D game prop art with clear readable silhouette. Genuinely transparent background; no scenery, ground plane, cast shadow, text, labels, borders, logos, or watermark.
```

### Gate prompt

```text
Create an original 2 by 2 sprite sheet of four distinct side-view traversal gates for The First Nine: a violet veil passage for Velvet Veil; a hidden echo-revealing thorn screen for Night Choir; a breakable ruined bulwark for Deep Hunger; a web-anchor crossing point for Spider's Promise. Original polished painterly 2D game prop art, clear small-scale silhouette, cold blue-black ruins, charcoal, bruised violet shadow, bone-white web and small antique-gold details. Genuinely transparent background; no characters, scenery, floor, cast shadows, text, labels, UI frames, logos, watermark, or borrowed fantasy symbols.
```

### Environment prompts

```text
VEIL RUINS: Original wide side-scrolling background for cold blue-black ancient elven ruins, broken elevated arches, collapsed bridges, distant moonlit towers and pale mist, with restrained violet shadow echoes. Polished painterly 16:9 dark-fantasy backdrop; low-detail lower third for gameplay platforms and collectibles. No camp, portal, characters, enemies, text, HUD, logos, watermark, or borrowed fantasy symbols.

THE LAST THRESHOLD: Original wide side-scrolling background for a vast fractured threshold over cold blue ruins, monumental broken arches and a distant pale-gold horizon suggesting the Dream Plane beyond, with violet-black shadow at the edges. Polished painterly 16:9 backdrop; low-detail lower third for gameplay platforms and collectibles. No characters, enemies, portal, text, HUD, logos, watermark, or borrowed fantasy symbols.
```

## Generation Record 04 — HUD status icons

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/ui/hud-status-icons-runtime-v1.png` | `244AF6B448ED109988D26A2C15343CF97E235B7F3F712704648F1B91C2FB50DE` | `exec-eaf35618-6fb6-438c-ae42-d73151108384.png` | Generated 2×2 transparent icon grid, imported and integrated into all four HUD meters. |

```text
Create an original 2 by 2 grid of four compact status icons for The First Nine: Vigor; Caravan Flame; Group Condition; Wagon Repair. Vigor is a pale ivory heart protected by a small violet chitin arc; Flame is a warm antique-gold ember in a compact iron brazier; Group is nine linked ivory/gold figures under a sheltering web; Repair is a wooden wagon wheel with a brass repair brace. Polished painted dark-fantasy UI icons, crisp controlled edges, readable against a blue-black HUD panel. Genuinely transparent background; no text, letters, numbers, labels, borders, UI cards, cast shadows, logos, watermark, or extra symbols; each icon fully contained in its own equal grid cell.
```

## Generation Record 05 — atmosphere and action effects

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/environment/ruins-foreground-overlays-runtime-v1.png` | `2C8B044D331BB48DE7A5078DF90192AB41AFFBEF75BAB90506E984D426485A47` | `exec-86af2bed-28ce-4315-8bb9-bd2bcce61b60.png` | 1983×793, 32-bit ARGB, transparent corner and centre samples. Two-panel foreground overlay. |
| `assets/art/vfx/shadow-actions-runtime-sheet-v1.png` | `AED00D1BBAF35DBC081847C67EFC2AEAC3E75AE888B74C7DB7A232CAA02B3092` | `exec-fe5d4692-3ec8-4b39-aabe-663f98520478.png` | 1536×1024, 32-bit ARGB, transparent corner and centre samples. Four-cell action-effect sheet. |

The original generated files remain in the generator output directory. The workspace copies are new versioned assets; no prior asset was overwritten.

### Foreground-overlay prompt

```text
Production 2D game art asset, transparent PNG sprite sheet. Exactly two equally wide landscape panels side by side in one image, each panel separated only by transparent spacing. Panel 1: cold blue-black VEIL RUINS foreground framing—broken stone arch fragments, black root silhouettes, low rubble and a few restrained violet shadow wisps only around bottom and extreme edges. Panel 2: THE LAST THRESHOLD foreground framing—jagged broken threshold stones, sparse pale-ivory dream mist, dark violet void tendrils at the lower corners. Preserve large transparent central areas. This is a parallax foreground overlay for a 16:9 game scene: no backdrop sky, no floor surface, no collision platforms, no characters, no UI, no text, no borders, no labels, no checkerboard. Painterly dark-fantasy storybook style, readable at gameplay scale, subdued contrast so it frames rather than obscures play.
```

### Shadow-action VFX prompt

```text
Production 2D game art asset, transparent PNG sprite sheet. Exactly four equal cells in a clean 2 by 2 grid, with transparent space separating the cells. A dark fantasy shadow-action VFX sheet for The First Nine, no characters. Top-left: quiet violet-black floating shadow motes. Top-right: sharp crescent shadow strike arc, pale violet edge. Bottom-left: Velvet Veil dash trail, flowing violet charcoal ribbons. Bottom-right: Shadow Echo gate/reveal burst, web-like violet energy and faint pale-gold sparks. Each cell isolated with generous transparent padding. No text, letters, logos, icons, UI, borders, ground, background, checkerboard. Painterly but crisp, high readability at small game scale, compatible with blue-black ruins and violet shadow magic.
```

## Generation Record 06 — character and Shade motion

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/characters/lolth-elf-motion-runtime-sheet-v1.png` | `407FAF623460A5D111D49C020E9AB0CC20D5563423FE40EBDFDE67382518B1E7` | `exec-c2100b2d-dcc8-4ca6-91e2-1d8947ceb81f.png` | 1327×1185, 32-bit ARGB, transparent corner and centre samples. Four-cell elf grounded-motion sheet. |
| `assets/art/characters/lolth-drow-motion-runtime-sheet-v1.png` | `AA414A4FCBB658FF3E9709334C81E23DD96DC67527977B75374CD15B7D4833B1` | `exec-6a4bbf51-17d7-4e05-adca-05d5618408c3.png` | 1536×1024, 32-bit ARGB, transparent corner and centre samples. Four-cell drow grounded-motion sheet. |
| `assets/art/enemies/shade-motion-runtime-sheet-v1.png` | `DAE0E4E9302E0EA30FDC5D6F22E03F7D2198312893293DA01C8C14AF4B4161BA` | `exec-073be594-b1c6-4d36-bc67-43fadd7533c6.png` | 1227×1282, 32-bit ARGB, transparent corner and centre samples. Four-cell Shade-motion sheet. |

The original generated files remain in the generator output directory. The workspace copies are new versioned assets; no prior asset was overwritten.

### Elf-motion prompt

```text
Create an original compact 2 by 2 animation sheet for Lolth in her original elf form for The First Nine. Exactly four equal cells with generous transparent separation, all full-body figures sharing one ground baseline, scale, facing direction, silhouette bounds, and costume design. Reading left-to-right, top-to-bottom: calm idle breathing frame A; calm idle breathing frame B; running stride A; running stride B. Subject: strong adult elf woman with warm pale skin, very long pale-blonde hair, long ears, travel-worn ivory tunic, dark blue-charcoal cloak, practical worn bronze leather armor and boots. Pre-pact only: no drow skin, chitin armor, shadow magic, webs, weapons, held items, or extra characters. Original polished painterly 2D game sprite illustration, simplified readable silhouette and crisp edges, compatible with a dark-fantasy side-scroller. Genuinely transparent background; no scenery, floor, cast shadow, text, labels, frames, UI, logos, watermark, cropped limbs, or checkerboard.
```

### Drow-motion prompt

```text
Create an original compact 2 by 2 animation sheet for Lolth in her awakened drow form for The First Nine. Exactly four equal cells with generous transparent separation, all full-body figures sharing one ground baseline, scale, facing direction, silhouette bounds, and costume design. Reading left-to-right, top-to-bottom: poised idle breathing frame A; poised idle breathing frame B; running stride A; running stride B. Subject: powerful adult female drow, pale blue-gray skin, very long silver-white hair, long ears, bone-white segmented chitin ritual armor, asymmetrical charcoal and dark-violet fabric with restrained web motifs and tiny antique-gold relic detail. No weapon or held item; make the silhouette legible at gameplay scale. Original polished painterly 2D game sprite illustration, simplified readable silhouette and crisp edges, compatible with a dark-fantasy side-scroller. Genuinely transparent background; no scenery, floor, cast shadow, text, labels, frames, UI, logos, watermark, cropped limbs, or checkerboard.
```

### Shade-motion prompt

```text
Create an original 2 by 2 sprite sheet for a single Shade enemy in The First Nine. Exactly four equal, isolated cells with transparent separation. Reading left-to-right, top-to-bottom: hover idle frame A; hover idle frame B; lunge motion; struck dissolving toward a Shadow Echo. The two idle frames preserve the same silhouette and differ only by a small floating drift. Subject: uncanny humanoid wraith formed from charcoal smoke and trailing web-like bruised-violet shadow wisps, one small cold-violet core glow, visibly distinct from Lolth. Polished painterly 2D game enemy sprite illustration with simple strong silhouette and crisp edges, readable at small gameplay scale. Genuinely transparent background; no scenery, ground, cast shadow, text, labels, UI, logos, watermark, extra creatures, weapons, cropped parts, borders, or checkerboard.
```

## Generation Record 07 — camp state and action prompts

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/ui/camp-status-emblems-runtime-v1.png` | `0A42D45F9111890ACF04BAC7785464E800ECE92157D792C485627D6AD6720E7B` | `exec-6f95706f-d35f-465d-8450-53cff49fb679.png` | 1774×887, 32-bit ARGB, transparent corner and centre samples. Two-cell camp-status emblem row. |
| `assets/art/ui/action-prompts-runtime-sheet-v1.png` | `37D8FC0BACE40603FDE2A43B65C0C7737F6C48068331034D683567F525F9B16A` | `exec-2e6aac8f-6b6f-4541-9ba7-d2d6bf69a9df.png` | 1254×1254, 32-bit ARGB, transparent corner and centre samples. Four-cell action-prompt grid. |

The original generated files remain in the generator output directory. The workspace copies are new versioned assets; no prior asset was overwritten.

### Camp-status prompt

```text
Create exactly two compact equal square emblems side by side for The First Nine. Left cell: a safe, resilient caravan status—warm antique-gold brazier flame sheltered by a small ivory web and a subtle wagon-wheel ring. Right cell: a threatened caravan status—dim ember inside a charcoal broken ring with a restrained bruised-violet crack and one red-violet warning glint. The two emblems share size, centered composition, and a readable silhouette at 36 pixels. Polished painted dark-fantasy UI prop art, crisp controlled edges, compatible with a cold blue-black game world. Genuinely transparent background; no words, letters, numbers, labels, banners, UI cards, borders, cast shadows, scenery, characters, logos, watermark, or checkerboard.
```

### Action-prompt prompt

```text
Create exactly four compact equal square action icons in a clean 2 by 2 grid for The First Nine. Reading left-to-right, top-to-bottom: Move—four small ivory directional chevrons around a tiny compass point; Jump—an ivory boot or upward arc; Primary action—an antique-gold open hand sending a simple short strike spark; Shadow action—a violet-black hand or crescent releasing web-like shadow ribbons. Keep every icon centered with generous transparent padding and immediately readable at 22 pixels. Polished painterly dark-fantasy UI icons with crisp controlled edges, designed for a blue-black HUD panel. Genuinely transparent background; no text, keyboard letters, controller letters, numbers, labels, borders, UI cards, scenery, cast shadows, logos, watermark, or checkerboard.
```

## Generation Record 08 — traversal surfaces

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/environment/traversal-platforms-runtime-sheet-v1.png` | `705BEE567A1C5BDDC18E20747EE1364D22C437F1BB9F066A23D368AAF137A35B` | `exec-8c93070d-6a2f-4774-ade9-86db62543998.png` | 2172×724, 32-bit ARGB, transparent corner sample. Three-panel platform sheet. Alpha bounds per panel were measured before integration; the runtime crops y=250–520 to exclude transparent vertical padding. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Traversal-surface prompt

```text
Create exactly three equally wide horizontal platform-surface panels side by side in one image, with transparent separation only between panels. Each panel is a seamless-looking low-profile ledge segment designed to be stretched horizontally into a 20–28 pixel high gameplay platform. Panel 1: ASHEN WAY, dark charcoal earth and worn timber braces with a restrained antique-gold edge. Panel 2: VEIL RUINS, cold blue-black ancient elven stone, chipped blocks, faint pale mist and one restrained violet seam. Panel 3: THE LAST THRESHOLD, pale ivory fractured dream-stone, dark violet void hairline and tiny web-like inlay. Every panel fills its own cell horizontally and vertically with a clear walkable top edge and a shallow structural face; no tall props, trees, arches, background scenery, or loose floating rocks. Polished painterly 2D dark-fantasy environment prop art with crisp readable edges at gameplay scale. Genuinely transparent background; no text, letters, labels, UI, characters, enemies, items, logos, watermark, borders, cast shadows, or checkerboard.
```

## Generation Record 09 — zone ground bands

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/environment/zone-ground-bands-runtime-sheet-v1.png` | `437AC53DCDFC56995BDBB0ABFE47569370B6CD39857D3AAB55F10ED5E7BCF2A8` | `exec-85c3869e-0ab1-4b85-81c9-85d82337ed58.png` | 1983×793, 32-bit ARGB, transparent corner sample. Three-panel ground-band sheet. Alpha bounds were measured before integration; runtime crops y=350–793 to remove transparent upper padding. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Zone-ground-band prompt

```text
Create exactly three equally wide ground-band panels side by side in one image, each intended to fill the bottom 160 pixels of a 1280×720 game view. Each panel fills its cell vertically with visual material from a crisp walkable top edge down into a dark lower mass; no transparent vertical padding inside panels. Panel 1: ASHEN WAY — compact charcoal earth, worn dark timber, small antique-gold flecks, sparse ash marks. Panel 2: VEIL RUINS — cold blue-black broken masonry ground, low collapsed stone texture, faint violet fissure glow. Panel 3: THE LAST THRESHOLD — pale fractured dream-stone embedded in charcoal shadow, subtle violet void seams and restrained ivory web inlay. Horizontal terrain material only, flat readable top edge, continuous and stretch-friendly. Keep the upper 15 percent of each panel visually calm so it can meet gameplay collision and platform surfaces; denser material beneath. No tall props, trees, arches, characters, pickups, foreground framing, or scenery. Polished painterly 2D dark-fantasy environment art, controlled contrast for play readability. Genuinely transparent background outside the three panels only; no text, letters, labels, UI, logos, watermark, border frames, cast shadows, checkerboard, or extra objects.
```

## Derived integration 10 — The Kiss of Shar

No new image bytes were generated. `assets/concept-art/comic/the-kiss-of-shar-storyboard-v1.png` remains unchanged (`4C3A88DFB5FA063634B3B3324A440E68937F9A45DF5C8D701C96520E9F5F6013`). Runtime reads its seven measured portrait regions in this order: `Rect2(2,0,267,941)`, `Rect2(272,0,238,941)`, `Rect2(513,0,210,941)`, `Rect2(726,0,222,941)`, `Rect2(950,0,224,941)`, `Rect2(1176,0,225,941)`, and `Rect2(1403,0,267,941)`.

The regions are rendered at their native aspect ratio in the existing seven-step interlude. The existing English `COMIC_LINES` remain code-rendered, so captions are not baked into artwork.

## Derived integration 11 — end-card key art

No new image bytes were generated. The existing 16:9 key-art sources remain unchanged:

| Runtime state | Workspace source | SHA-256 | Use |
| --- | --- | --- | --- |
| Victory | `assets/concept-art/key-art/shadow-crown-drow-body-shadow-form-v1.png` | `CF7005F98F9E18951002D5FAFA73007169C533AE7E30D0891252331588FAA8B0` | Full-view victory backdrop beneath a contrast overlay. |
| Defeat | `assets/concept-art/key-art/the-last-camp-elven-survivors-v2.png` | `650DF3709779CBF74139CA6F76F8EADF15B8EACC94EE3ACF4299BC8BD1EAB6FA` | Full-view defeat backdrop beneath a contrast overlay. |

The title, subtitle, and continue prompt remain code-rendered. The art does not replace any gameplay asset or alter final-state conditions.

## Derived integration 12 — camp survivor portraits

No new image bytes were generated. `assets/concept-art/characters/first-drows-portrait-sheet-v1.png` remains unchanged (`D0FEBE22C0DA1E4D575170EB641E1F4B15A22FF0CA1D785C143097D7B7A0E3D6`). Its 1536×1024 4×2 layout gives each survivor one 384×512 cell. Runtime takes a head-and-shoulders crop from each cell: x=`cell_x + 70`, y=`cell_y + 18`, width=245, height=230, and draws it as a 26×32 camp medallion.

The medallion border follows the existing provisions-based camp state: ivory when the group is safe, muted rose when a Thalestriel is at risk. This is presentation only; survivor names, roles, mission assignment, and gameplay state are unchanged.

## Generation Record 13 — Mark progression seals

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/ui/mark-progression-seals-runtime-v1.png` | `988E87E8282669DFCCD9543B9FC48CAC20514C317091EC6B0D541CD7F85C2B8E` | `exec-b3ca2501-77c9-4bac-a03f-2bd58ce730a4.png` | 1254×1254, 32-bit ARGB, transparent corner sample. Nine-cell 3×3 Mark-seal sheet. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Mark-seal prompt

```text
Create exactly nine equal compact icon cells in a clean 3 by 3 grid for The First Nine. Reading left-to-right, top-to-bottom, create one original nonverbal sigil for each existing Mark: First Thread — single ivory thread loop around a violet spark; Velvet Veil — a soft violet veil crescent; Black Pulse — a dark orb with one pale pulse ring; Gloam Spine — a narrow thorned charcoal spine; Night Choir — three echo arcs with small cold-violet motes; Deep Hunger — a shadow maw suggested by webbed negative space; Spider's Promise — a precise ivory web-anchor knot; Heart of the Web — an ivory heart held inside a violet web; Shadow Crown — a small thorned crown wrapped in black-violet shadow. Each icon must be centered, distinct in silhouette, and readable at 28 pixels. Polished painted dark-fantasy UI sigils with crisp controlled edges, designed for a blue-black HUD panel. Genuinely transparent background; no words, letters, numbers, labels, borders, UI cards, scenery, characters, logos, watermark, borrowed fantasy symbols, or checkerboard.
```

## Generation Record 14 — passive-mission emblems

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/ui/passive-mission-emblems-runtime-v1.png` | `D1CE2F0480B3F33A11DE79BDE0E189F9F775993718D0B3D2EA7197E2C4D30376` | `exec-3284e110-9a11-4a1f-8a10-074ad59095e0.png` | 2172×724, 32-bit ARGB, transparent corner sample. Three-cell passive-mission emblem row. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Passive-mission-emblem prompt

```text
Create exactly three equal compact square emblems side by side for The First Nine. Left cell: SEARCH THE BRUSH — a tied sprig of pale herbs with a small ivory compass needle, representing provisions. Center cell: TEND THE FLAME — a warm antique-gold ember protected inside a compact iron brazier, representing caravan flame. Right cell: RECOVER DEBRIS — a tarnished brass wagon brace with a small repair tool and chain link, representing route repair. Each icon must be centered, distinct in silhouette, and readable at 24 pixels. Polished painted dark-fantasy UI icons with crisp controlled edges, designed for a blue-black HUD panel. Genuinely transparent background; no words, letters, numbers, labels, borders, UI cards, scenery, characters, logos, watermark, or checkerboard.
```

## Generation Record 15 — Dream Gate

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/gates/dream-gate-runtime-v1.png` | `9E2199B27727243B0AEBB328613FB4780D3C599C0F669B42282B2FC5C04F60A8` | `exec-6b245021-ddd8-40a3-8535-f9a6480b0ca6.png` | 1145×1374, transparent sampled background; portrait final-gate prop. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Dream-Gate prompt

```text
Use case: production-ready 2D side-view game prop. Create one freestanding Dream Gate for the game The First Nine: a tall broken gothic threshold arch in aged ivory stone and antique gold, viewed straight-on in a subtle side-scrolling platformer perspective. The open center is filled with a luminous, restrained dream vortex of pale gold and cold violet. Add only a few violet-black web strands clinging to the outside edges, a small anchored rocky base, and a single readable silhouette. Mood: solemn, sacred, uncanny, final destination; warm gold is hope, violet-black is shadow. Polished painterly fantasy game asset with clean silhouettes and limited fine detail. Compose the complete gate centered in a tall portrait frame, with breathing room around it so it can be placed at approximately 200 by 240 pixels. Genuine transparent background, including outside the gate and below its base. No characters, no text, no labels, no UI, no frame, no landscape, no floor plane, no cast shadow extending outside the base, no watermark.
```

Godot imported the asset successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Generation Record 28 — Lolth elf aerial sheet

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/characters/lolth-elf-aerial-runtime-sheet-v1.png` | `EF0AEF4454EC33D24E70A8FEA578FB0382BDB1CA87DC2C8A8853581A395A8AE4` | `exec-bd7ad2c7-b2d4-4359-964c-70fff1c10505.png` | 1240×1269, 32-bit ARGB, 2×2 elf aerial sheet. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Lolth-elf-aerial prompt

```text
Use case: stylized-concept
Asset type: production-ready 2D side-scrolling game aerial-movement sprite sheet for The First Nine
Primary request: Create exactly four equal full-body cells in a strict 2 by 2 grid of the same original elven wanderer protagonist before her shadow awakening: warm pale-olive skin, long ash-blonde hair, worn charcoal-and-umber travel coat, muted ivory scarf, modest antique-brass buckles, and a small staff wrapped with pale thread. Reading order: top-left ascending jump pose leaning slightly forward toward screen-right; top-right apex pose with hair and scarf briefly weightless; bottom-left descending/fall pose with legs prepared to land; bottom-right soft landing/recovery pose. Every cell must be clearly the same side-view character with a shared invisible ground baseline, whole figure visible, and generous transparent padding. The poses must be readable at 100 by 200 pixels.
Scene/backdrop: none; genuine transparent background
Style/medium: polished painterly dark-fantasy 2D game sprite art consistent with existing Lolth runtime art
Lighting/mood: grounded survivor resolve; warm ivory and antique brass, without awakened magic
Color palette: charcoal, umber, muted ivory, pale olive, antique brass
Constraints: no crop, no floor, no cast shadow outside the feet, equal cells, transparent gutters, no overlap between cells, no other characters
Avoid: text, letters, labels, numbers, UI, borders, frames, checkerboard, logos, watermark, purple glow, black smoke, photorealism, borrowed game characters.
```

An edit pass removed color-fringe artifacts while preserving the four-cell layout and all character/pose invariants. The runtime now selects this sheet only while the pre-awakening Lolth is airborne. The jump force, gravity, landing, collisions, inputs, and progression rules are unchanged.

Godot imported the asset successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Generation Record 27 — Lolth drow aerial sheet

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/characters/lolth-drow-aerial-runtime-sheet-v1.png` | `AAEBBED756E2C9B4E12EF11B8D91AA20EA2B3A89B43E3539E82967C2B2A84C05` | `exec-78c468e7-a069-49d4-a387-bd4be9463270.png` | 1240×1269, 32-bit ARGB, 2×2 drow aerial sheet. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Lolth-drow-aerial prompt

```text
Use case: stylized-concept
Asset type: production-ready 2D side-scrolling game aerial-movement sprite sheet for The First Nine
Primary request: Create exactly four equal full-body cells in a strict 2 by 2 grid of the same original awakened female drow protagonist, Lolth: charcoal skin, long white hair, dark violet-black layered travel robes, restrained antique-gold trim, one delicate web-thread focus. Reading order: top-left ascending jump pose leaning slightly forward toward screen-right; top-right apex pose with robes and hair briefly weightless; bottom-left descending/fall pose with legs prepared to land; bottom-right soft landing/recovery pose. Every cell must be clearly the same side-view character with a shared invisible ground baseline, whole figure visible, and generous transparent padding. The poses must be readable at 100 by 200 pixels.
Scene/backdrop: none; genuine transparent background
Style/medium: polished painterly dark-fantasy 2D game sprite art consistent with existing Lolth runtime art
Lighting/mood: restrained cold violet shadow magic, solemn agile survivor
Color palette: charcoal skin, ivory hair, violet-black robes, muted plum, antique-gold details
Constraints: no crop, no floor, no cast shadow outside the feet, equal cells, transparent gutters, no overlap between cells, no other characters
Avoid: text, letters, labels, numbers, UI, borders, frames, checkerboard, logos, watermark, weapon changes, exaggerated glow, photorealism, borrowed game characters.
```

After awakening, the runtime chooses the upper aerial poses while vertical velocity is upward or near the apex and the lower poses while it is falling. This changes only drawn imagery; jump force, gravity, landing, collisions, inputs, and progression remain unchanged.

Godot imported the asset successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Generation Record 26 — Action-feedback VFX sheet v2

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/vfx/shadow-actions-runtime-sheet-v2.png` | `DAFDFF65F949E45B164505CE8E91777D2C79794035FADD38C6A16879FDED8B86` | `exec-6d5f5e1b-d00c-4f89-bb90-c3487d9172a0.png` | 1536×1024, transparent sampled background; equal 2×2 action-feedback sheet. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Action-feedback-v2 prompt

```text
Use case: stylized-concept. Asset type: production-ready 2D side-scrolling game action-feedback sprite sheet for the game The First Nine. Create exactly four equally sized, clearly isolated visual-effect cells arranged in a strict 2 by 2 grid with transparent background and generous blank transparent gutters. No text, no UI, no logos, no frames, no checkerboard, no characters, no weapons. Each cell is a painterly dark-fantasy effect, dense and very readable at small in-game sizes. Top-left: First Thread strike impact, a compact sharp violet-black web-thread starburst slash impact. Top-right: collection feedback, compact warm ivory and pale-gold rising thread sparks with one restrained violet mote. Bottom-left: Velvet Veil dash, a horizontal violet-black trailing ribbon/afterimage, clearly directional left-to-right. Bottom-right: Night Choir sense or gate response, a compact violet echo ring with fine web arcs and a small broken-arch aperture / shadow fracture in its center. Palette: deep plum, ink black, muted violet, pale gold, ivory. Cohesive polished hand-painted 2D game art, edges should fade naturally into real transparency. Do not let effects touch across cells; preserve transparent padding around every effect.
```

The runtime maps the cells in reading order to the existing strike, collection, dash, and sense/gate feedback kinds. The effects are presentation-only; their triggers, duration, positions, input, collisions, rewards, and progression rules are unchanged.

Godot imported the asset successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Generation Record 25 — Lolth drow dash sheet

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/characters/lolth-drow-dash-runtime-sheet-v1.png` | `C6695B1FC0420B01DB2EB070E97BB987FED6DA00DB45501A48FF7803383A6D5E` | `exec-8919aacc-b059-4fa8-9bb8-5992bb759dca.png` | 1774×887, transparent sampled background; equal two-cell dash sheet. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Lolth-drow-dash prompt

```text
Use case: stylized-concept
Asset type: production-ready 2D side-scrolling game dash-motion sheet for The First Nine
Primary request: Create exactly two equal full-body cells side by side in one horizontal row of the same original drow wanderer protagonist Lolth: charcoal skin, long white hair, dark violet-black layered travel robes, restrained antique-gold trim, and a delicate web-thread focus. Left cell: low forward dash launch toward screen-right, body compressed and one leading step, cloak beginning to trail. Right cell: extended fast dash stride toward screen-right, white hair and cloak swept behind her, slim violet-black web-thread ribbons trailing but no large energy burst. Same character, outfit, side-view camera, shared invisible ground baseline, and consistent scale in both cells. Readable at 100 by 200 pixels.
Scene/backdrop: none; genuine transparent background
Style/medium: polished painterly dark-fantasy 2D game sprite art, crisp silhouette
Lighting/mood: focused, swift, controlled shadow power
Color palette: charcoal, violet-black, ivory hair, tiny antique gold
Constraints: exactly two equal cells, no overlap, no crop, no floor, no cast shadow beyond feet, no characters besides Lolth
Avoid: text, letters, labels, numbers, UI, borders, frames, checkerboard, logos, watermark, glowing trail effects, photorealism, borrowed game characters.
```

Godot imported the asset successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Generation Record 24 — Pickup sheet v2

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/items/salvage-pickups-runtime-sheet-v2.png` | `C64780D28AA8D3B760A3A97E423AA480DE894742198D873D5F45B152071FFE0B` | `exec-dd1dda54-6ffb-4a0c-af75-aa4d86df93c8.png` | 1374×1145, transparent sampled background; equal 2×2 pickup sheet. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Pickup-sheet-v2 prompt

```text
Use case: stylized-concept
Asset type: production-ready 2D side-scrolling game pickup sheet for The First Nine
Primary request: Create exactly four equal isolated pickup cells in a clean 2 by 2 grid, each centered with transparent margins and readable at 72 pixels. Reading order: top-left PROVISIONS — a tied bundle of pale herbs, a small wrapped ration, and an ivory cloth strip; top-right KINDLING — three dry dark twigs tied with cord around one warm orange ember; bottom-left SALVAGE — a tarnished brass wagon brace, compact chain link, and small iron repair plate; bottom-right SHADOW ECHO — a contained floating cold-violet smoke mote with a small black web-thread spiral. Each pickup must be distinct in silhouette yet have consistent scale and polish.
Scene/backdrop: none; genuine transparent background
Style/medium: polished painterly dark-fantasy 2D game props, crisp controlled edge silhouettes
Lighting/mood: practical survivor resources; only the Echo is uncanny
Color palette: muted ivory and olive, charcoal, antique brass, warm ember orange, cold violet-black
Constraints: exactly four equal cells, no overlap, no crop, no floor, no cast shadow beyond the object, no characters
Avoid: text, letters, labels, numbers, UI, borders, frames, checkerboard, logos, watermark, duplicate objects, photorealism, borrowed game icons.
```

Godot imported the asset successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Generation Record 23 — Ashen Way backdrop

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/environment/ashen-way-backdrop-runtime-v1.png` | `DD976616F50C99D53CDA4D52CB5784A9FF7CBAFE98C9936BD0D8FD1987FD2587` | `exec-666c30b3-1735-4fdf-9674-30f96ad73f6b.png` | 1672×941, 24-bit RGB opaque landscape backdrop. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Ashen-Way-backdrop prompt

```text
Use case: stylized-concept
Asset type: wide 2D side-scrolling game backdrop for the Ashen Way zone in The First Nine
Primary request: A 16:9 polished painterly dark-fantasy background, viewed broadside from a side-scrolling platformer. An exhausted charcoal roadside after a distant fire: a low uneven ash ridge along only the bottom 15 percent, sparse dead silhouettes and snapped sign posts far in the distance, faint smoke columns, a dim cold-violet night sky, and a partially eclipsed muted amber moon in the upper-right. Add extremely subtle tiny gold embers, but keep the central lower half calm and low-contrast for the player, pickups, caravan, and platforms. No foreground objects close to the camera.
Scene/backdrop: complete opaque scenic background, no transparency
Style/medium: polished painterly 2D dark-fantasy environment art
Lighting/mood: quiet aftermath, lonely road, fragile warm hope against blue-black ash
Color palette: charcoal, blue-black, desaturated violet, ash gray, muted amber, tiny antique gold
Composition/framing: wide 16:9; moon upper-right; open central playing space; ground horizon low
Constraints: no characters, no wagon, no campfire, no enemies, no props in the central play area, no text or UI
Avoid: borders, frames, checkerboard, logos, watermark, cityscape, modern structures, bright daylight, dense fog, close-up trees, photorealism.
```

Godot imported the asset successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Generation Record 22 — Ashen Way foreground overlay

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/environment/ashen-way-foreground-overlay-runtime-v1.png` | `467442ED23CF35A2EC711F9D8CD0B9B14F8CE01DC4F34A706C47104C9BF9DA74` | `exec-96c77b60-fa7b-42fa-9a4c-64b16f19ba26.png` | 1672×941, transparent sampled background; wide peripheral zone-0 overlay. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Ashen-Way-foreground prompt

```text
Use case: stylized-concept
Asset type: production-ready 2D side-scrolling game foreground overlay for the Ashen Way zone in The First Nine
Primary request: Create one wide 16:9 transparent foreground framing layer only. Put sparse dark ash-coated grass tufts, snapped charcoal stakes, a torn muted-ivory caravan ribbon, and two or three extremely thin violet-black web threads strictly around the far left edge, far right edge, and lower corners. Add a few tiny pale-amber ember specks near the bottom edge. Keep the entire central 70 percent of the image and all upper middle area empty and fully transparent for gameplay. The layer should feel like an exhausted roadside after a fire, not a full scene.
Scene/backdrop: none; genuine transparent background
Style/medium: polished painterly dark-fantasy 2D environment overlay
Lighting/mood: dim blue-black ash, restrained warm ember notes, lonely but readable
Color palette: charcoal, desaturated blue-black, ash gray, muted ivory, tiny pale amber and violet-black accents
Constraints: peripheral decoration only, no solid background, no horizon, no floor band, no large opaque region, no characters, no props at center, no text
Avoid: UI, labels, borders, frames, checkerboard, logos, watermark, buildings, trees, sky, mountains, full-screen fog, vignette, photorealism.
```

Godot imported the asset successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Generation Record 21 — Wagon repair states v2

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/camp/wagon-repair-states-runtime-v2.png` | `4E2F7E3B3AF2CCF6368BA69C48EBFED866E7D8F3F5835EFB51B39CEA97325B33` | `exec-6d5949c7-b9ca-428f-9f26-cb45b781ea0d.png` | 1774×887, transparent sampled background; three-cell wagon repair-state row. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Wagon-repair-states-v2 prompt

```text
Use case: stylized-concept
Asset type: production-ready 2D side-scrolling game caravan repair-state sheet for The First Nine
Primary request: Create exactly three equal isolated side-view cells in one horizontal row of the same compact refugee wagon, facing screen-right, with dark timber, weathered canvas, two visible wheels, brass fittings, and a few muted ivory cloth strips. Left cell: broken state, one wheel cracked, axle sagging, torn canvas, visibly stranded but still recognizable. Center cell: partial repair, sound replacement brace and patched wheel but still some torn canvas and lashings. Right cell: road-ready repaired wagon, both wheels sound, canvas patched, brass brace secure, a subtle warm-gold lantern under the canopy. Keep the exact same vehicle silhouette, angle, size, and shared baseline in all three cells. Readable at 250 by 150 pixels.
Scene/backdrop: none; genuine transparent background
Style/medium: polished painterly dark-fantasy 2D prop art
Lighting/mood: exhausted caravan becoming hopeful, warm gold only on final repaired details
Color palette: charcoal wood, aged brown canvas, iron black, antique brass, muted ivory
Constraints: three equal cells, no overlap, no crop, no floor plane, no cast shadow extending beyond wheels, no people or animals
Avoid: text, letters, labels, numbers, UI, borders, frames, checkerboard, logos, watermark, modern vehicle parts, photorealism, borrowed game props.
```

Godot imported the asset successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Generation Record 20 — Caravan flame states

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/camp/caravan-flame-runtime-states-v1.png` | `20C1AF89330F0D347E58A564E7412679C8C75FC833A18A0B7D3C54D93ADDCDC1` | `exec-4492b68e-daeb-4e4f-b884-5fe0dbe24898.png` | 1881×836, transparent sampled background; three-cell caravan-flame state row. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Caravan-flame-states prompt

```text
Use case: stylized-concept
Asset type: production-ready 2D side-scrolling game camp-fire state sheet for The First Nine
Primary request: Create exactly three equal isolated cell props side by side in one horizontal row, each showing the same compact wrought-iron travel brazier on a few dark stones. Left cell: low dangerous ember, only a small dull orange coal glow and two weak sparks. Center cell: stable camp flame, a moderate warm-gold flame with soft orange core. Right cell: strong protected flame, a lively golden flame with restrained ivory highlights and a few rising sparks. Same brazier, same camera angle, same centered baseline in all cells. It must be readable at about 112 by 132 pixels.
Scene/backdrop: none; genuinely transparent background
Style/medium: polished painterly dark-fantasy 2D game prop
Lighting/mood: warm safety against blue-black night, progressively hopeful from left to right
Color palette: black iron, warm amber, gold, ivory, restrained ember red
Constraints: three equal cells, no overlap between cells, no crop, no floor plane or extended cast shadow, no characters
Avoid: text, letters, labels, numbers, UI, borders, frames, checkerboard, logos, watermark, torches, candles, photorealism, borrowed game props.
```

Godot imported the asset successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Generation Record 19 — Interactive Mark gates v2

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/gates/mark-gates-runtime-sheet-v2.png` | `061C1DA03C741B509807B24C07782403C5221326FDE8CDDB0E3FFE6EDC45C9BE` | `exec-972e5bdc-17d5-4040-a452-b457aa4703d8.png` | 1254×1254, transparent sampled background; equal 2×2 interactive-gate sheet. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Interactive-Mark-gates-v2 prompt

```text
Use case: stylized-concept
Asset type: production-ready 2D side-scrolling game gate-prop sheet for The First Nine
Primary request: Create exactly four equal isolated gothic blocking-prop cells in a clean 2 by 2 grid, front-facing with a subtle side-scroller perspective, each centered with transparent margins. Top-left: ECHO VEIL gate, a broken blue-black stone threshold covered by a thin translucent cold-violet veil and three tiny echo motes. Top-right: BROKEN BULWARK gate, a cracked dark basalt barricade with a restrained shadow-maw fissure through its center. Bottom-left: WEB ANCHOR gate, a narrow ivory-and-charcoal ruined arch pinned by a precise violet-black web knot. Bottom-right: neutral collapsed ruin threshold for an unused transition cell, no magic symbol. These are solid environmental blockers, not doors one walks through; all must read cleanly at 100 pixels.
Scene/backdrop: none; genuine transparent background
Style/medium: polished painterly dark-fantasy 2D game props, compact silhouette
Lighting/mood: solemn ruins, cold-violet shadow, subtle antique-gold edge accents
Color palette: blue-black, charcoal, cold violet, limited ivory and antique gold
Constraints: exactly four equal cells, one prop per cell, no overlap, no crop, no floor plane, no extended cast shadow
Avoid: text, letters, labels, numbers, UI, borders, frames, checkerboard, characters, logos, watermark, duplicate gates, photorealism, borrowed game symbols.
```

Godot imported the asset successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Generation Record 18 — Lolth elf action sheet

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/characters/lolth-elf-action-runtime-sheet-v1.png` | `623AF900B398F01AC40D164F2A8402B4D9F90D1AA43E15A71EB00093F12FF8DB` | `exec-3837d0b3-9825-4ccc-b260-6563b30bbd15.png` | 887×1774, transparent sampled background; equal 2×2 pre-awakening strike sheet. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Lolth-elf-action prompt

```text
Use case: stylized-concept
Asset type: production-ready 2D side-scrolling game character action sheet for The First Nine
Primary request: Create exactly four equal full-body cells in a clean 2 by 2 grid of the same original elven wanderer protagonist before her shadow awakening: warm pale-olive skin, long ash-blonde hair, worn charcoal-and-umber travel coat, muted ivory scarf, modest antique-brass buckles, and a small staff wrapped with pale thread. Reading order: top-left ready stance immediately before a close strike; top-right committed forward staff slash toward screen-right with one restrained pale-gold thread glint; bottom-left recovery stance after the strike; bottom-right guarded idle combat stance. Keep the same character, costume, camera distance, and side-view orientation in every cell. Full figure centered on a shared invisible baseline with generous transparent margins.
Scene/backdrop: none; genuine transparent background
Style/medium: polished painterly dark-fantasy 2D game sprite art, clean readable silhouette at 100 by 200 pixels
Lighting/mood: grounded survivor resolve; warm ivory and antique brass, no awakened violet magic
Color palette: charcoal, umber, muted ivory, pale olive, antique brass
Constraints: no crop, no floor, no cast shadow outside feet, equal cells, no overlap across cells, no additional characters
Avoid: text, letters, labels, numbers, UI, borders, frames, checkerboard, logos, watermark, purple glow, black smoke, photorealism, borrowed game characters.
```

Godot imported the asset successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Generation Record 17 — Lolth drow action sheet

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/characters/lolth-drow-action-runtime-sheet-v1.png` | `802802EBEC2AAB6EA3BEFE44D52BB64F46BA2F4DCFB0E0FB9CE6711CA0B44A87` | `exec-5d2eaeae-cfc8-4d5b-9c9b-434b42b08068.png` | 1230×1278, transparent sampled background; equal 2×2 post-awakening strike sheet. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Lolth-drow-action prompt

```text
Use case: stylized-concept
Asset type: production-ready 2D side-scrolling game character action sheet for The First Nine
Primary request: Create exactly four equal full-body cells in a clean 2 by 2 grid of the same original female drow wanderer protagonist, Lolth: charcoal skin, long white hair, dark violet-black layered travel robes, subtle antique-gold trim, and a delicate web-thread focus in one hand. Reading order: top-left ready stance immediately before a melee shadow strike; top-right committed forward slash toward screen-right with a short controlled violet-black thread arc; bottom-left recovery stance after the strike; bottom-right a guarded idle combat stance. Keep the exact same character, costume, camera distance, and side-view orientation in all cells. The full figure is centered, grounded at a shared invisible baseline, and has generous transparent margins.
Scene/backdrop: none; genuine transparent background
Style/medium: polished painterly dark-fantasy 2D game sprite art, clean readable silhouette at 100 by 200 pixels
Lighting/mood: restrained cold violet shadow magic, solemn heroic tension
Color palette: charcoal, muted violet-black, ivory hair, antique-gold accents
Constraints: no crop, no floor, no cast shadow outside feet, equal cells, no overlap across cells, no additional characters
Avoid: text, letters, labels, numbers, UI, borders, frames, checkerboard, logos, watermark, exaggerated visual effects, photorealism, borrowed game characters.
```

Godot imported the asset successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Generation Record 16 — Shade motion sheet v2

| Workspace asset | SHA-256 | Source result | Validation |
| --- | --- | --- | --- |
| `assets/art/enemies/shade-motion-runtime-sheet-v2.png` | `5AE4197B509D776779CD8CB613B49C0BD2ABB5CE21312E74039CAF0AE3ED229F` | `exec-0e430080-8a11-4095-b0bc-b1a3dc44eb67.png` | 1254×1254, transparent sampled background; equal 2×2 Shade-state sheet. |

The original generated file remains in the generator output directory. The workspace copy is a new versioned asset; no prior asset was overwritten.

### Shade-motion-v2 prompt

```text
Use case: stylized-concept
Asset type: production-ready 2D side-scrolling game enemy animation sheet for The First Nine
Primary request: Create exactly four equal full-body animation cells in a clean 2 by 2 grid of the same single enemy: an original shadow Shade, a small hovering wraith formed from violet-black smoke, ragged web-like wisps, two cold violet eye-lights, and a subtle pale-lilac rim light. Reading order: top-left calm hover with a compact silhouette; top-right hover with wisps opened; bottom-left threatening forward lunge with the same body leaning toward screen-left; bottom-right gentle death/dissolve with the body breaking into upward violet motes. Each cell must show the whole same creature centered and isolated, with large empty transparent margins. The pose variation must remain unmistakably one consistent character.
Scene/backdrop: none; genuine transparent background
Style/medium: polished painterly dark-fantasy 2D game sprite art, crisp silhouette at 96 pixels
Lighting/mood: cold violet shadow, ominous but readable
Color palette: blue-black, charcoal, restrained violet and pale-lilac highlights
Constraints: equal cells, no overlap across cells, no cropping, no floor, no cast shadow, no characters other than the one Shade per cell
Avoid: text, letters, labels, numbers, UI, borders, panel backgrounds, checkerboard, logos, watermark, photorealism, borrowed game characters.
```

Godot imported the asset successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`
