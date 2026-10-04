---
kind: derived-asset-manifest
generated: 2026-10-02
spec: '[[2026-10-02-runtime-art-batch-1]]'
status: discovery-baseline
---

# Runtime Art Batch 1 — Asset Manifest

This is a read-only baseline of local source bytes. `Unverified` provenance means no prompt, license, provider receipt, or AI-disclosure record was found beside the PNG; it is not a license decision.

| Source | SHA-256 | Classification | Intended use | Runtime readiness |
| --- | --- | --- | --- | --- |
| `assets/art/characters/lolth-elf-gameplay-poses-v1.png` | `E5A199A655FCA836F5230598D1099759E13BC8EDBCADF7A3286CC9960D49F1FC` | crop source | Elf prologue poses | Needs individual frames, pivot/canvas normalization, and missing action states. |
| `assets/art/characters/lolth-gameplay-poses-v1.png` | `E25B3372B3BA697BD7B9B9F67E6372BA01197941B83D424CD211F16D9C33DD11` | crop source | Drow prototype poses | Needs individual frames, pivot/canvas normalization, and missing action states. |
| `assets/art/camp/last-camp-prop-sheet-v1.png` | `88D9277D9088073818E39CAA1F76184A1D923F55930A204F94CAD21F373D9F2C` | crop source | Caravan, brazier, supplies, debris, worktable | Needs separated transparent props and wagon repair states. |
| `assets/art/vfx/shadow-mark-effects-v1.png` | `50F8552CBC48CDBE7087A2B1662DBBF42D8FD234DA6B1880F2E79F3B0CBBAF4A` | crop source | Shadow action, Echo, portal, Mark effect prototypes | Needs effect separation, timing, blend choice, and animation frames. |
| `assets/concept-art/comic/the-kiss-of-shar-storyboard-v1.png` | `4C3A88DFB5FA063634B3B3324A440E68937F9A45DF5C8D701C96520E9F5F6013` | cinematic crop source | Seven HQ panels | Runtime selects seven measured portrait regions; English captions remain code-rendered. |
| `assets/concept-art/key-art/the-last-camp-elven-survivors-v2.png` | `650DF3709779CBF74139CA6F76F8EADF15B8EACC94EE3ACF4299BC8BD1EAB6FA` | cinematic source | Defeat end-card backdrop | Runtime uses it at native 16:9 ratio beneath the defeat overlay. |
| `assets/concept-art/characters/lolth-original-elf-form-v1.png` | `90604E64B77A6C2694BD5A5B7F7BC88E525A8E139AFE376D8C81486154FF11AF` | reference | Elf materials and silhouette | Reference only. |
| `assets/concept-art/characters/lolth-eight-mark-transformations-v2.png` | `19D878BCD44786E03B8E86090C8A6FBBB1E51C461322FA1271109E833D6391D6` | reference | Marks 1–8 progression | Reference only; final state is represented by separate Shadow Crown art. |
| `assets/concept-art/characters/first-drows-portrait-sheet-v1.png` | `D0FEBE22C0DA1E4D575170EB641E1F4B15A22FF0CA1D785C143097D7B7A0E3D6` | crop/reference source | Eight camp-survivor portrait medallions | Runtime selects the eight 4×2 source cells as compact camp portrait crops; no playable-sprite use. |
| `assets/concept-art/key-art/shadow-crown-drow-body-shadow-form-v1.png` | `CF7005F98F9E18951002D5FAFA73007169C533AE7E30D0891252331588FAA8B0` | cinematic source | Victory end-card backdrop | Runtime uses it at native 16:9 ratio beneath the victory overlay. |
| `assets/art/characters/lolth-elf-runtime-sheet-v1.png` | `9737CCD8914CE65BD77551578ECE36C5F0D5B3E5C9AE5AB4E395610C9797A069` | generated runtime candidate | Elf player, 3×3 pose grid | Needs runtime crop/pivot review; provenance in `[[runtime-art-batch-1-generation-record]]`. |
| `assets/art/characters/lolth-drow-runtime-sheet-v1.png` | `1FC73BAB6820FC7C4D945FDA4F688E2EB0ECBA93E134B44DB8600F532A536889` | generated runtime candidate | Drow player, 3×3 pose grid | Needs runtime crop/pivot review; provenance in `[[runtime-art-batch-1-generation-record]]`. |
| `assets/art/enemies/shade-runtime-sheet-v1.png` | `608450B5FD53DC532FB32994144C92E1A45FC717920AD41E9A7092AE85A70F7E` | generated runtime candidate | Shade, 2×2 state grid | Imported and integrated as current idle source; provenance in `[[runtime-art-batch-1-generation-record]]`. |
| `assets/art/items/salvage-pickups-runtime-sheet-v1.png` | `A8E55A0E96416BA8D4F0C0156C0B5F390D213FC974AC246D1EF8AECB54837712` | generated runtime candidate | Four recovery categories, 2×2 grid | Imported and integrated for the three current pickup types; provenance in `[[runtime-art-batch-1-generation-record]]`. |
| `assets/art/camp/wagon-repair-states-runtime-v1.png` | `CFBE59F94FA787FBD17D2223960DD6DB9A281A3B8462DE9C27C82019B94E39BC` | generated runtime candidate | Wagon repair stages, 3-cell row | Imported and mapped to repair progress. |
| `assets/art/gates/mark-gates-runtime-sheet-v1.png` | `0D0CE36C03886EC5CEA739E475F9FBBEF3CF3D48E90C449498923BBCBEC18D80` | generated runtime candidate | Four Mark gates, 2×2 grid | Imported and mapped to the current gates. |
| `assets/art/environment/veil-ruins-backdrop-runtime-v1.png` | `2D01AF68789E3CEA9F237E4A5EF1BBE0010F5D8599E10E0D40D685E8603F9D34` | generated runtime candidate | Zone 1 backdrop | Imported and integrated. |
| `assets/art/environment/last-threshold-backdrop-runtime-v1.png` | `8941F87377CCE089029B02644EC001714EFBBA596F05FEF4AA2D4208C9BDB31F` | generated runtime candidate | Zone 2 backdrop | Imported and integrated. |
| `assets/art/ui/hud-status-icons-runtime-v1.png` | `244AF6B448ED109988D26A2C15343CF97E235B7F3F712704648F1B91C2FB50DE` | generated runtime candidate | Four HUD status icons, 2×2 grid | Imported and integrated beside all current meters. |
| `assets/art/environment/ruins-foreground-overlays-runtime-v1.png` | `2C8B044D331BB48DE7A5078DF90192AB41AFFBEF75BAB90506E984D426485A47` | generated runtime candidate | Zone 1–2 foreground framing, 2-panel row | Imported and integrated as a transparent foreground layer. |
| `assets/art/vfx/shadow-actions-runtime-sheet-v1.png` | `AED00D1BBAF35DBC081847C67EFC2AEAC3E75AE888B74C7DB7A232CAA02B3092` | generated runtime candidate | Shadow action effects, 2×2 grid | Imported and integrated for strike, dash, collection, sense, and gate feedback. |
| `assets/art/characters/lolth-elf-motion-runtime-sheet-v1.png` | `407FAF623460A5D111D49C020E9AB0CC20D5563423FE40EBDFDE67382518B1E7` | generated runtime candidate | Elf idle/run motion, 2×2 grid | Imported and integrated for grounded movement. |
| `assets/art/characters/lolth-drow-motion-runtime-sheet-v1.png` | `AA414A4FCBB658FF3E9709334C81E23DD96DC67527977B75374CD15B7D4833B1` | generated runtime candidate | Drow idle/run motion, 2×2 grid | Imported and integrated for grounded movement. |
| `assets/art/enemies/shade-motion-runtime-sheet-v1.png` | `DAE0E4E9302E0EA30FDC5D6F22E03F7D2198312893293DA01C8C14AF4B4161BA` | generated runtime candidate | Shade hover, lunge, dissolve, 2×2 grid | Imported; runtime alternates the two hover cells. |
| `assets/art/ui/camp-status-emblems-runtime-v1.png` | `0A42D45F9111890ACF04BAC7785464E800ECE92157D792C485627D6AD6720E7B` | generated runtime candidate | Caravan safe/risk emblems, 2-cell row | Imported and mapped to the current provisions threshold. |
| `assets/art/ui/action-prompts-runtime-sheet-v1.png` | `37D8FC0BACE40603FDE2A43B65C0C7737F6C48068331034D683567F525F9B16A` | generated runtime candidate | Move, jump, primary, and shadow prompts, 2×2 grid | Imported and integrated above the HUD control groups. |
| `assets/art/environment/traversal-platforms-runtime-sheet-v1.png` | `705BEE567A1C5BDDC18E20747EE1364D22C437F1BB9F066A23D368AAF137A35B` | generated runtime candidate | Ashen Way, Veil Ruins, and Last Threshold platform surfaces, 3-cell row | Imported and integrated for all existing traversable platforms. |
| `assets/art/environment/zone-ground-bands-runtime-sheet-v1.png` | `437AC53DCDFC56995BDBB0ABFE47569370B6CD39857D3AAB55F10ED5E7BCF2A8` | generated runtime candidate | Ashen Way, Veil Ruins, and Last Threshold ground bands, 3-cell row | Imported and integrated below the shared ground line. |
| `assets/art/ui/mark-progression-seals-runtime-v1.png` | `988E87E8282669DFCCD9543B9FC48CAC20514C317091EC6B0D541CD7F85C2B8E` | generated runtime candidate | Nine Mark progression seals, 3×3 grid | Imported and shows the current Mark in the HUD after the first awakening. |
| `assets/art/ui/passive-mission-emblems-runtime-v1.png` | `D1CE2F0480B3F33A11DE79BDE0E189F9F775993718D0B3D2EA7197E2C4D30376` | generated runtime candidate | Search, Flame, and Debris mission emblems, 3-cell row | Imported and shown beside the persistent passive-mission HUD readout. |
| `assets/art/gates/dream-gate-runtime-v1.png` | `9E2199B27727243B0AEBB328613FB4780D3C599C0F669B42282B2FC5C04F60A8` | generated runtime candidate | Dedicated final Dream Gate prop | Imported and replaces the reused portal VFX once all nine Marks awaken. |
| `assets/art/enemies/shade-motion-runtime-sheet-v2.png` | `5AE4197B509D776779CD8CB613B49C0BD2ABB5CE21312E74039CAF0AE3ED229F` | generated runtime candidate | Shade hover, lunge, and dissolve sheet, 2×2 grid | Imported and mapped to existing enemy presentation states. |
| `assets/art/characters/lolth-drow-action-runtime-sheet-v1.png` | `802802EBEC2AAB6EA3BEFE44D52BB64F46BA2F4DCFB0E0FB9CE6711CA0B44A87` | generated runtime candidate | Lolth drow strike sequence, 2×2 grid | Imported and used for the existing post-awakening Primary strike window. |
| `assets/art/characters/lolth-elf-action-runtime-sheet-v1.png` | `623AF900B398F01AC40D164F2A8402B4D9F90D1AA43E15A71EB00093F12FF8DB` | generated runtime candidate | Lolth elf strike sequence, 2×2 grid | Imported and used for the existing pre-awakening Primary strike window. |
| `assets/art/gates/mark-gates-runtime-sheet-v2.png` | `061C1DA03C741B509807B24C07782403C5221326FDE8CDDB0E3FFE6EDC45C9BE` | generated runtime candidate | Echo Veil, Broken Bulwark, and Web Anchor gate sheet, 2×2 grid | Imported and mapped to the three current interactive gate Marks. |
| `assets/art/camp/caravan-flame-runtime-states-v1.png` | `20C1AF89330F0D347E58A564E7412679C8C75FC833A18A0B7D3C54D93ADDCDC1` | generated runtime candidate | Low, stable, and strong caravan flame states, 3-cell row | Imported and mapped to existing Flame value ranges. |
| `assets/art/camp/wagon-repair-states-runtime-v2.png` | `4E2F7E3B3AF2CCF6368BA69C48EBFED866E7D8F3F5835EFB51B39CEA97325B33` | generated runtime candidate | Broken, partial, and road-ready wagon states, 3-cell row | Imported and mapped to the current repair index. |
| `assets/art/environment/ashen-way-foreground-overlay-runtime-v1.png` | `467442ED23CF35A2EC711F9D8CD0B9B14F8CE01DC4F34A706C47104C9BF9DA74` | generated runtime candidate | Peripheral Ashen Way foreground frame | Imported and used only for zone 0. |
| `assets/art/environment/ashen-way-backdrop-runtime-v1.png` | `DD976616F50C99D53CDA4D52CB5784A9FF7CBAFE98C9936BD0D8FD1987FD2587` | generated runtime candidate | Ashen Way full-zone backdrop | Imported and used only for zone 0 behind terrain and actors. |
| `assets/art/items/salvage-pickups-runtime-sheet-v2.png` | `C64780D28AA8D3B760A3A97E423AA480DE894742198D873D5F45B152071FFE0B` | generated runtime candidate | Provisions, Kindling, Salvage, and Shadow Echo pickups, 2×2 grid | Imported and mapped to the existing four pickup types. |
| `assets/art/characters/lolth-drow-dash-runtime-sheet-v1.png` | `C6695B1FC0420B01DB2EB070E97BB987FED6DA00DB45501A48FF7803383A6D5E` | generated runtime candidate | Lolth drow Velvet Veil dash, 2-cell row | Imported and used during the existing dash VFX window. |
| `assets/art/vfx/shadow-actions-runtime-sheet-v2.png` | `DAFDFF65F949E45B164505CE8E91777D2C79794035FADD38C6A16879FDED8B86` | generated runtime candidate | Strike, collection, dash, and Night Choir/gate action feedback, 2×2 grid | Imported and mapped to the existing action-feedback kinds. |
| `assets/art/characters/lolth-drow-aerial-runtime-sheet-v1.png` | `AAEBBED756E2C9B4E12EF11B8D91AA20EA2B3A89B43E3539E82967C2B2A84C05` | generated runtime candidate | Drow ascending, apex, falling, and landing movement, 2×2 grid | Imported and integrated for post-awakening aerial presentation. |
| `assets/art/characters/lolth-elf-aerial-runtime-sheet-v1.png` | `EF0AEF4454EC33D24E70A8FEA578FB0382BDB1CA87DC2C8A8853581A395A8AE4` | generated runtime candidate | Elf ascending, apex, falling, and landing movement, 2×2 grid | Imported and integrated for pre-awakening aerial presentation. |
| `assets/art/characters/lolth-drow-intensified-motion-runtime-sheet-v1.png` | `C4FDEF2FCB25661BDD6774F79F4F7CD09490EC2ADDAA31EA7E53E97741765067` | generated runtime candidate | Intensified drow idle/run, 2×2 grid | Imported and integrated for Mark 6–8 grounded movement. |
| `assets/art/characters/lolth-drow-intensified-aerial-runtime-sheet-v1.png` | `D9BF4EC2EE8E94F7E97372A3D2328633474C4BC0F0CDD55A4ADBD0F41953686C` | generated runtime candidate | Intensified drow aerial movement, 2×2 grid | Imported and integrated for Mark 6–8 aerial presentation. |

## Missing runtime families

- Complete elf and drow Lolth animation frame packs.
- Shade frame pack.
- Four category-distinct pickup icons/props.
- Compact camp-safe/warning and input-prompt variants.

## Provenance gate

Every entry above has `provenance: unverified` until a source record is supplied or a new generation request records its prompt, parameters, provider, license/usage status, and disclosure requirement. No source file has been modified by this manifest.
