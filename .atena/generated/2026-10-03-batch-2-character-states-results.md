---
kind: batch-image-autopilot-result
manifest: '[[2026-10-03-batch-2-character-states-manifest]]'
status: completed-with-exceptions
generated: 2026-10-03
---

# Batch 2 — Character states result

## Validation basis

- Manifest validation: `VALID: 5 assets; max_attempts=3`.
- Art direction: `assets/concept-art/ART_DIRECTION.md`.
- Scale reference: `lolth-drow-baseline`, the mean alpha-bound figure height of the four cells in `assets/art/characters/lolth-drow-aerial-runtime-sheet-v1.png`.
- Measurement: per-cell alpha bounds at alpha ≥32, normalized by cell height; the candidate mean divided by the reference mean must be within 0.95–1.05. The baseline mean was `0.7914`.
- Shared technical checks: 32-bit ARGB PNG; transparent corner sample; prescribed cell count/order; full-body side-view silhouette; no text, panel, or background.
- Provider/provenance: host-native ImageGen output saved under the generator directory; no paid provider, external credential, or spend was used. Jam license/usage status remains `unverified` until the project disclosure audit. AI disclosure is required.

## Accepted assets

| Asset | Attempts | Accepted candidate | Canvas | Ratio | Target | SHA-256 | Checks |
| --- | ---: | --- | --- | ---: | ---: | --- | --- |
| `assets/art/characters/lolth-drow-intensified-motion-runtime-sheet-v1.png` | 2 | `exec-697f5174-2cc8-48a7-abfa-3f77fbda2d9b.png` | 1360×1157, 32-bit ARGB | 1.0051 | 1.00 | `C4FDEF2FCB25661BDD6774F79F4F7CD09490EC2ADDAA31EA7E53E97741765067` | Transparent corner; equal 2×2 cells; side-view idle/idle/run/run reading order; normalized heights `0.8737, 0.8529, 0.7215, 0.7336`; shared pivot accepted. |
| `assets/art/characters/lolth-drow-intensified-aerial-runtime-sheet-v1.png` | 1 | `exec-6581bbe0-c824-4463-a9f6-d1c81c90764a.png` | 1274×1234, 32-bit ARGB | 1.0055 | 1.00 | `D9BF4EC2EE8E94F7E97372A3D2328633474C4BC0F0CDD55A4ADBD0F41953686C` | Transparent corner; equal 2×2 cells; ascending/apex/fall/landing reading order; normalized heights `0.8541, 0.8217, 0.9044, 0.6029`; shared pivot accepted. |

The accepted workspace copies are new versioned files. Godot imported them successfully, and the runtime now uses them for Marks 6–8 grounded and aerial presentation. The post-import self-test passed.

## Exceptions

| Asset | Attempt candidates and scale result | Final reason |
| --- | --- | --- |
| `lolth-elf-hurt-v1` | 1. `exec-0ffa779c-05b0-4054-a7b2-340e138e68bd.png` (1263×1246): visual edge review failed due to color fringe, before scale admission. 2. `exec-47056996-ec49-41f4-bd66-f1027a66ced4.png` (1268×1241): normalized mean `0.8824`, ratio `1.1149`. 3. `exec-a0d2ff2d-9b99-4301-90d5-4d571e3d03db.png` (1774×887): normalized mean `0.7458`, ratio `0.9423`. | All three attempts failed the declared ±5% scale contract. No workspace asset was copied. |
| `lolth-drow-hurt-v1` | 1. `exec-243aa140-ea75-4d13-88d8-76773689ee75.png` (1774×887): `0.8737`, ratio `1.1040`. 2. `exec-b5afeecf-b807-4fac-903f-e21771e8a79a.png` (1774×887): `0.7300`, ratio `0.9224`. 3. `exec-aedf28d3-f274-430a-91ec-d6744fe10969.png` (1265×1244): `0.8424`, ratio `1.0645`. | All three attempts failed the declared ±5% scale contract. No workspace asset was copied. |
| `lolth-drow-intensified-action-v1` | 1. `exec-f2b94a57-964f-4183-98f7-667058fa2dd8.png` (1077×1460): `0.6620`, ratio `0.8365`. 2. `exec-17de9f0f-2b60-4f88-9b3f-8de236246af7.png` (1230×1278): `0.9444`, ratio `1.1934`. 3. `exec-beacfe04-15a1-411e-9a16-dd9f3a6c3fdc.png` (1240×1268): `0.8415`, ratio `1.0633`. | All three attempts failed the declared ±5% scale contract. No workspace asset was copied. |

## Prompt and source trace

Every base prompt, target path, required check, scale reference, target ratio, and pivot contract is retained verbatim in `2026-10-03-batch-2-character-states-manifest.json`. Retry prompts changed only the failing variable: clean edge treatment or requested visible figure height. The source filenames in the tables above are the built-in ImageGen result files; originals remain in the generator output directory.

## Reconciliation

Two accepted candidates advance the approved Marks 6–8 presentation set. This batch does not change canonical lore, gameplay behavior, or existing assets. The approved follow-up integration maps the accepted motion and aerial sheets to Mark levels 6–8; Godot import and self-test passed. Human visual review at 1280×720 remains open.
