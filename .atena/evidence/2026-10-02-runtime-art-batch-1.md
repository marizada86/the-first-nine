---
status: verified-automated-visual-review-pending
date: 2026-10-02
spec: '[[2026-10-02-runtime-art-batch-1]]'
---

# Evidence — Runtime Art Batch 1

## Completed local integration

`main.gd` now loads existing local source PNGs without modifying their bytes:

- `the-last-camp-elven-survivors-v2.png` as the zone-0 camp backdrop;
- `the-kiss-of-shar-storyboard-v1.png` as seven runtime-selected HQ panels;
- `lolth-elf-gameplay-poses-v1.png` for the unmarked player prototype;
- `lolth-gameplay-poses-v1.png` for the drow player prototype.

The runtime selects a standing, moving, or airborne source region for Lolth and selects the current HQ panel by the story index. The original composite images remain intact.

## Automated verification

Command:

`D:\Godot\godot.exe --headless --path . -- --self-test`

Result:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

The successful run compiles the new preload and draw paths while retaining the existing controls, Salvage loop, passive mission, checkpoints, and nine-Mark route. The known headless warnings about `user://logs` and the Windows certificate store did not stop the test.

## Added runtime group — 02

The generated `Shade` 2×2 sheet and four-category Salvage pickup 2×2 sheet were imported through Godot and integrated into `main.gd`. The current runtime uses the Shade idle cell and maps `Provisions`, `Kindling`, and `Salvage` to their distinct pickup cells; the fourth `Shadow Echo` cell is ready for an item-based Echo interaction.

After their import, the same `--self-test` command again returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 03

The three wagon-repair states, four Mark-gate props, `VEIL RUINS` backdrop, and `THE LAST THRESHOLD` backdrop were admitted as versioned assets. Runtime draws the wagon by repair stage, selects gate imagery from the required Mark, and draws the two new exploration backdrops behind gameplay geometry. After import completed, `--self-test` passed again.

## Added runtime group — 04

The four HUD status icons were imported and placed beside the Vigor, Flame, Group, and Wagon meters. The English text labels and input instructions remain code-rendered for clear, deterministic localization. `--self-test` passed after import.

## Added runtime group — 05

The two-panel ruins foreground overlay and the four-cell shadow-action VFX sheet were admitted as versioned, transparent PNG assets. Zone 1 now selects the Veil Ruins foreground panel and zone 2 selects the Last Threshold panel after Lolth is drawn, preserving gameplay geometry and HUD readability. Strike, dash, collection, sense, and gate feedback now select their corresponding cells from the new action-effect sheet; the existing portal effect remains unchanged.

Godot imported both new files successfully. The post-import validation command returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

The headless run continued to report its known nonblocking `user://logs` and Windows certificate-store warnings.

## Added runtime group — 06

Three versioned transparent motion sheets were admitted: grounded elf Lolth, grounded drow Lolth, and Shade. While grounded, Lolth now alternates between two idle cells and two run cells; her existing jump and action pose selection is retained. Shades alternate between their two hover cells. This is presentation-only work: collision, combat resolution, Mark progression, resource rules, and input controls are unchanged.

Godot imported all three sheets successfully. The post-import validation command returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 07

The safe/risk caravan emblems are now selected from the current Provisions threshold and appear beside the existing camp-status message. Four nonverbal action-prompt icons now sit above the Move, Jump, Primary, and Shadow instruction groups in the HUD; the English textual controls remain present. This alters presentation only, preserving existing input bindings and game rules.

Godot imported both sheets successfully. The post-import validation command returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Visual integration correction — reported screenshot

A human screenshot at 1280×720 exposed two layout defects: `THE LAST CAMP` overlapped the wagon art, `WAGON REPAIR` crossed the ground line, and ground-level pickup art sat too low against the terrain. The correction moves both camp labels into the free space below the wagon and clamps only ground-level pickup presentation to a safe visual anchor above the ground line. Item positions, interaction radii, collision, load behavior, and resource rules were not changed.

The project has no `.game-dev/adapter.json`, so no sealed windowless visual capture is available for a machine pixel comparison. The post-correction functional validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 08

The three-zone traversal-platform sheet was admitted and integrated as a visual layer over all existing platform collision rectangles. Zone 0 uses the timber-and-ash surface, zone 1 the cold ruin stone, and zone 2 the fractured ivory threshold. Collision rectangles, landing logic, and route layout remain unchanged. Alpha-bound inspection found substantial transparent vertical padding in the source, so runtime deliberately selects the measured y=250–520 content band rather than scaling the full sheet.

The local `game-dev` production utility was unavailable in this environment; no provider or paid workflow was attempted. The asset was generated through the built-in image generator, copied as a versioned workspace file, and imported by Godot. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 09

The three-zone ground-band sheet was admitted below the shared ground line. Zone selection matches the platform sheet: ash/timber, cold ruin stone, and ivory threshold. Measured transparent padding is excluded with a y=350–793 source crop.

The same visual pass corrected render anchoring that made the screenshot's player, caravan, and fire appear to float: Lolth's drawn feet now meet the collision surface, while wagon wheels and campfire render on the shared ground line. Camp labels were moved into free space above the camp. Physics circles, landing heights, collision rectangles, interaction radii, and game rules were not changed.

Godot imported the ground-band file successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Derived runtime integration — 10

`THE KISS OF SHAR` now renders the seven approved storyboard panels rather than cycling the generic shadow-VFX placeholder. Separator analysis on the unchanged 1672×941 source located panel boundaries at x=269–271, 510–512, 723–725, 948–949, 1174–1175, and 1401–1402; the seven runtime source rectangles use the resulting art bounds. Each selected portrait is drawn at its source aspect ratio, while the existing English narrative lines remain separately rendered text.

No source PNG was modified and no new provider was used. The post-integration validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Derived runtime integration — 11

The two end-card states now draw their approved local key art at the native 16:9 ratio before applying the existing dark contrast layer and code-rendered text. Victory selects the Shadow Crown source and defeat selects the Last Camp source. The original PNGs are unchanged; no provider or new asset generation was used.

The post-integration validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Derived runtime integration — 12

The eight abstract camp-survivor markers were replaced with compact portrait medallions derived from the unchanged First Drows 4×2 source sheet. Each medallion has a measured head-and-shoulders crop and a provisions-state border. The existing camp state remains driven by the same Provisions threshold; no survivor gained a new name, role, input, passive mission, or gameplay behavior.

The post-integration validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 13

The nine-Mark seal sheet is now integrated as a compact HUD element. It selects `mark_level - 1` from the 3×3 grid only after the first Mark, retaining the existing unmarked textual state at level zero. Names, stat values, awakening count, checkpoint rules, Mark abilities, and progression are unchanged.

Godot imported the sheet successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 14

The three passive-mission emblems are mapped directly to the existing `provisions`, `flame`, and `route` mission types. The HUD now persists the current mission name beside the recovered Load and shows its corresponding icon. Assignment, cycling, resolution, rewards, and all resource values remain unchanged.

Godot imported the sheet successfully. The post-import validation returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Visual-review boundary

The debug game window started successfully, but the available desktop-capture surface did not expose it for a screenshot in this session. Therefore no claim is made about final scale, crop, contrast, or panel readability. A human visible run must inspect the camp backdrop, Lolth's three provisional pose selections, and all seven HQ panels before this integration is accepted visually.

## Remaining acceptance work

- Derive or generate complete animation frames and alternate state packs for Lolth and Shade.
- Validate the new foreground framing and action-effect crop at gameplay scale.
- Validate all art at 1280×720 and during an 8–12 minute human playthrough.
- Resolve provenance/license/prompt records and the jam AI-disclosure audit before submission.

## Added runtime group — 15

The dedicated Dream Gate now replaces the generic shadow-effect cell in `draw_portal()`. It renders only in zone 2 after the ninth Mark; the Mark count, final-state condition, portal position, collision-free completion flow, and all gameplay state remain unchanged. Provenance, parameters, source result, and SHA-256 are recorded in the generated batch record.

Godot reimported `dream-gate-runtime-v1.png` successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 16

The Shade uses the new 2×2 sheet for alternating hover, close-range lunge, and a brief 0.42-second dissolve after defeat. These are presentation-only states: target selection, strike distance, damage, resource rewards, Mark progression, and zone advancement remain unchanged. Provenance, parameters, source result, and SHA-256 are recorded in the generated batch record.

Godot imported `shade-motion-runtime-sheet-v2.png` successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 17

After the first awakening, Primary uses the new Lolth drow sheet for the pre-strike, impact, and recovery moments in the existing 0.42-second strike window. The action mapping, range, Shadow reward, hit handling, resources, Marks, and all other locomotion poses are unchanged. Provenance, parameters, source result, and SHA-256 are recorded in the generated batch record.

Godot imported `lolth-drow-action-runtime-sheet-v1.png` successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 18

Before the first awakening, Primary now uses the elf action sheet for the same pre-strike, impact, and recovery moments. The selectable controls, strike timing and range, Shadow reward, hit handling, resources, Marks, and all non-strike motion remain unchanged. Provenance, parameters, source result, and SHA-256 are recorded in the generated batch record.

Godot imported `lolth-elf-action-runtime-sheet-v1.png` successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 19

The v2 gate sheet replaces only the visual source for the three current interactive gates: Echo Veil (Mark 5), Broken Bulwark (Mark 6), and Web Anchor (Mark 7). Their reveal checks, opening requirements, collisions, progression, and zone flow are unchanged. Provenance, parameters, source result, and SHA-256 are recorded in the generated batch record.

Godot imported `mark-gates-runtime-sheet-v2.png` successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 20

The caravan fire now selects a dedicated ember, stable, or strong-flame cell from the existing Flame value: 0–33, 34–67, or 68–100. The existing scale pulse remains. Flame drain, failure at zero, survivor state, mission effects, and all resource rules are unchanged. Provenance, parameters, source result, and SHA-256 are recorded in the generated batch record.

Godot imported `caravan-flame-runtime-states-v1.png` successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 21

The v2 wagon sheet replaces only the visual source for the existing repair index: broken at 0, partial at 1–2, and road-ready at 3. Salvage use, repair increments, route requirements, checkpoint state, and zone advancement are unchanged. Provenance, parameters, source result, and SHA-256 are recorded in the generated batch record.

Godot imported `wagon-repair-states-runtime-v2.png` successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 22

Ashen Way now receives a dedicated transparent foreground overlay around the left/right/lower edges only. It is rendered after actors and before VFX/HUD, like the existing ruin overlays; it does not alter the zone backdrop, terrain, platforms, collisions, pickups, or gameplay state. Provenance, parameters, source result, and SHA-256 are recorded in the generated batch record.

Godot imported `ashen-way-foreground-overlay-runtime-v1.png` successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 23

Ashen Way now draws its dedicated opaque backdrop before the existing ground, actors, foreground overlay, VFX, and HUD. The zone index, procedural terrain geometry, platforms, collisions, pickups, caravan position, and all gameplay state are unchanged. Provenance, parameters, source result, and SHA-256 are recorded in the generated batch record.

Godot imported `ashen-way-backdrop-runtime-v1.png` successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 24

The v2 2×2 pickup sheet replaces only the visual source for Provisions, Kindling, Salvage, and Shadow Echoes. Their type IDs, load-slot sizes, collection radius, reward handling, labels, and all resource rules are unchanged. Provenance, parameters, source result, and SHA-256 are recorded in the generated batch record.

Godot imported `salvage-pickups-runtime-sheet-v2.png` successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 25

Velvet Veil now uses a two-frame drow dash pose during its existing 0.42-second VFX window. The dash velocity, unlock at Mark 2, direction selection, VFX, input mapping, collision behavior, and all progression state are unchanged. The wider render rectangle is visual-only and remains anchored at Lolth's grounded position. Provenance, parameters, source result, and SHA-256 are recorded in the generated batch record.

Godot imported `lolth-drow-dash-runtime-sheet-v1.png` successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 26

The v2 action-feedback sheet maps four dedicated cells to the existing visual feedback: First Thread strike (top-left), collection (top-right), Velvet Veil dash (bottom-left), and Night Choir sense/gate response (bottom-right). The VFX trigger types, duration, positions, action input, collisions, rewards, and progression rules are unchanged. Provenance, prompt, source result, and SHA-256 are recorded in the generated batch record.

Godot imported `shadow-actions-runtime-sheet-v2.png` successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 27

After awakening, Lolth now selects an aerial sheet while off the floor: ascending/apex poses during upward velocity and falling/landing poses during descent. The prologue elf and all jump mechanics remain on their existing presentation and behavior. Jump force, gravity, landing, collisions, inputs, and progression are unchanged. Provenance, prompt, source result, and SHA-256 are recorded in the generated batch record.

Godot imported `lolth-drow-aerial-runtime-sheet-v1.png` successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 28

Before awakening, Lolth now selects the matching elf aerial sheet while off the floor: ascending/apex poses during upward velocity and falling/landing poses during descent. The drow aerial states continue after awakening. Jump force, gravity, landing, collisions, inputs, and progression rules are unchanged. Provenance, prompt, edited source result, and SHA-256 are recorded in the generated batch record.

Godot imported `lolth-elf-aerial-runtime-sheet-v1.png` successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Added runtime group — 29

At Marks 6–8, Lolth now selects the accepted intensified drow motion sheet while grounded and the accepted intensified aerial sheet while off the floor. Mark 0 still selects elf presentation, and Marks 1–5 still select the existing drow sheets. Jump force, gravity, landing, dash, attack, collisions, inputs, resource rules, and progression are unchanged. The Batch 2 result record preserves the character-scale validation and provenance.

Godot imported both intensified sheets successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`

## Visual correction — 30

Player sheets use differing source-cell proportions. Lolth now renders each selected cell at its native aspect ratio, anchored by a shared feet offset instead of being forced into one 100×200 rectangle. Direction is persistent: horizontal input updates the facing direction, and the whole player sheet is mirrored around Lolth's center when facing left; leftward Velvet Veil uses the same facing state. This is presentation-only: movement speed, dash speed, jump, collisions, input bindings, and progression are unchanged.

Godot imported the project successfully. The post-import self-test returned:

`SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`
