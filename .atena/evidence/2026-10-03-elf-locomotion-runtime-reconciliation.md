---
status: verified-structure
date: 2026-10-03
spec: '[[2026-10-03-elf-locomotion-master]]'
---

# Evidence - Elf locomotion runtime reconciliation

- The approved master-sheet batch manifest validated before generation.
- All three ImageGen attempts were retained in the generated result record and rejected because their 3 by 3 cell containment and shared feet baseline were not reliable enough for runtime admission.
- `main.gd` now routes Mark 0 through `lolth-elf-motion-runtime-sheet-v3.png` on the ground and in the air, preventing the former aerial outfit substitution. The sibling is a non-destructive sanitation of the approved v1 source.
- Alpha-component analysis at alpha > 0 removes every detached component under 512 pixels. The v3 sheet contains exactly four remaining connected components, one per source frame; SHA-256 is `79E0F65DB0D2ED864628F5693D6D51778A7B497C04536C2A28500A16CFB73546`.
- The lower motion row is not used at current gameplay scale because it reads as an airborne stride. Mark 0 movement uses the stable top row pending a properly grounded walk atlas.
- Left movement uses the existing reflected draw transform around the player x-coordinate. No duplicate left-facing image asset is required.
- Godot `--headless --path . --import` completed its project scan successfully. The sandbox could not write Godot's user-level editor cache, which does not affect project import.
- Godot `--headless --path . -- --self-test` passed: `SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`.
- Human gameplay review at 1280 by 720 remains open.
