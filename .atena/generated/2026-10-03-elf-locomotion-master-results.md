---
kind: batch-image-autopilot-result
manifest: '[[2026-10-03-elf-locomotion-master-manifest]]'
status: completed-with-exceptions
generated: 2026-10-03
---

# Elf locomotion master-sheet result

## Validation basis

- Manifest validation: `VALID: 1 assets; max_attempts=3`.
- Source reference: `assets/art/characters/lolth-elf-motion-runtime-sheet-v1.png` (2 by 2 cells, `1327 x 1185`).
- Scale reference: mean alpha-bound figure height `0.9717`, measured per source cell at alpha >= 32. The approved target ratio is `0.90`, so the accepted candidate band is `0.8550-0.9450`.
- Pivot contract: all nine full figures must be fully contained within equal 3 by 3 cells and place their feet on one shared baseline. Transparent canvas corners were also required.
- Provenance: built-in ImageGen with the local current elf motion sheet as an identity reference; no external credential, paid provider, or spend was used. License/usage remains unverified pending the jam disclosure audit, and AI disclosure remains required.

## Final asset status

| Asset | Status | Workspace target |
| --- | --- | --- |
| `lolth-elf-locomotion-master-v2` | exception | `assets/art/characters/lolth-elf-locomotion-master-sheet-v2.png` was not created |

No generated candidate met both the scale and shared-ground/pivot gates. Per the approved batch contract, no source asset was overwritten and no failed candidate was admitted to the game.

## Attempt record

| Attempt | Candidate | Technical result | Decision |
| ---: | --- | --- | --- |
| 1 | `C:\Users\gui-m\.codex\generated_images\01a0fedd-37d5-7a20-9103-2fbc2c0bff41\exec-fdcb259b-4459-42f6-9de0-711266cb1a16.png` | `1290 x 1219`, transparent corners; mean height `0.9130`, ratio `0.9396` (within scale band), but feet baselines ranged `0.8276-1.0000` and multiple figures touched/crossed their cells. | rejected: shared pivot and containment failed |
| 2 | `C:\Users\gui-m\.codex\generated_images\01a0fedd-37d5-7a20-9103-2fbc2c0bff41\exec-e75ad57b-22b7-48af-97aa-d645c5851b85.png` | `1222 x 1287`, transparent corners; mean height `0.8824`, ratio `0.9081` (within scale band), but feet baselines ranged `0.8392-1.0000` and run frames crossed the grid boundaries. | rejected: shared pivot and containment failed |
| 3 | `C:\Users\gui-m\.codex\generated_images\01a0fedd-37d5-7a20-9103-2fbc2c0bff41\exec-d000e6fd-37b8-4d13-8337-31956a928d6e.png` | `1295 x 1215`, transparent corners; mean height `0.9531`, ratio `0.9808` (outside scale band); feet baselines ranged `0.9210-1.0000`, with cells still touching boundaries. | rejected: scale, shared pivot, and containment failed |

The base prompt, source reference, target, required checks, scale rule, and pivot contract are retained verbatim in the approved manifest. Each retry changed only the failed geometry constraint: first containment and shared baseline, then independent-cell padding and exact internal baseline.

## Safe runtime reconciliation

The gameplay runtime now keeps the approved initial elf skin for idle, run, rise, fall, and landing instead of selecting `lolth-elf-aerial-runtime-sheet-v1.png`, which had a different outfit. A non-destructive cleaned sibling, `assets/art/characters/lolth-elf-motion-runtime-sheet-v3.png`, removes every disconnected alpha component smaller than 512 pixels from the original sheet. Its alpha analysis contains exactly the four legitimate frame components and no detached pixel islands; SHA-256 is `79E0F65DB0D2ED864628F5693D6D51778A7B497C04536C2A28500A16CFB73546`.

The lower source row reads as a jump at the target gameplay scale, so the current safe fallback uses the two stable top-row frames for Mark 0 movement and air presentation, while movement direction remains visible through player motion and runtime mirroring. This prevents a false jump without changing the approved skin. A dedicated grounded walk atlas remains a future asset task. This does not claim a human visual review.
