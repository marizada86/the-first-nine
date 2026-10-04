---
kind: batch-image-autopilot-progress
manifest: '[[2026-10-03-lolth-elf-unified-animation-manifest]]'
status: partially-accepted
generated: 2026-10-03
---

# Unified Lolth elf animation - generation pass

All six approved states now have an identity-preserving ImageGen candidate sourced from `assets/art/characters/lolth-elf-gameplay-poses-v1.png`.

| State | Candidate |
| --- | --- |
| Idle | `exec-404a5aaf-7b87-4bb0-8e14-c9712aa8a992.png` |
| Locomotion | `exec-6b63c808-f4b8-4dfb-bb4c-c5ddac1ad2f3.png` |
| Aerial | `exec-c4110bc1-b1a2-481f-94d2-85b2d6144854.png` |
| Action | `exec-3bc00ccc-b8b2-4b03-9683-06db0c765e2c.png` |
| Interaction | `exec-fa6b2f7c-7b84-4e26-9e1b-e86a2a0d30de.png` |
| Hurt | `exec-e9c113d7-c448-45e1-aaf4-03749061c712.png` |

## Recalibrated admission

The approved standing first cell of the source sheet is now the scale baseline (`0.8129` normalized alpha-bound height), rather than the mixed-pose mean. This preserves the intended gameplay silhouette.

| State | Status | Ratio | Result |
| --- | --- | ---: | --- |
| Idle | accepted | `1.031` | `assets/art/characters/lolth-elf-unified-idle-sheet-v1.png`; SHA-256 `122387CA818F31510962F6979A73F23D969B88B1665ABAEBC380AF1B68873C9D` |
| Interaction | accepted | `0.983` | `assets/art/characters/lolth-elf-unified-interaction-sheet-v1.png`; SHA-256 `B6508D8B7387725D76E201198B1A3CD05AC28A427EA87B4B038BBDBCA21A51A3` |
| Locomotion | pending retry | `1.130` | outside scale band |
| Aerial | pending retry | `0.814` | outside scale band and pivot varies by phase |
| Action | pending retry | `1.126` | outside scale band |
| Hurt | pending retry | `1.113` | outside scale band |

The candidates remain in the host-native generator directory. Neither accepted sheet is active in runtime yet. Before activation, integration and a Godot import/self-test remain required. AI disclosure remains required; license/usage remains unverified pending jam disclosure audit.
