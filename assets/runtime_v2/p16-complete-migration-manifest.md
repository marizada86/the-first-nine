# P16 runtime_v2 migration manifest

All paths below are project-owned runtime candidates produced in the approved P16 program. Generator originals remain preserved outside the project workspace; legacy `assets/art` files remain untouched for rollback.

| Batch | Runtime candidate | Active consumer |
| --- | --- | --- |
| B-001 | `characters/thalestriel/thalestriel-plagued-survivors-sheet-v1.png` | camp survivor display before cure |
| B-001 | `characters/thalestriel/thalestriel-cured-assists-sheet-v1.png` | camp survivor display after cure; guard, mission, craft and pull visual language |
| B-002 | `ui/survival-and-mark-icons-v1.png` | HUD meters and Mark seal |
| B-003 | `world/common/salvage-workshop-web-gates-v1.png` | wagon craft-table prop; salvage, defenses and web-gate atlas |
| B-004 | `world/stonehook/stonehook-continuous-route-v1.png` | Stonehook backdrop with uninterrupted route |
| B-004 | `enemies/stonehook/stonehook-threats-core-v1.png` | Stonehook enemy renderer |
| B-005 | `world/later-regions/continuous-route-atlas-v1.png` | Hollowroot active panel; Glass Dunes and Dreamwater prepared panels |
| B-005 | `enemies/later-regions/region-threats-and-bosses-v1.png` | registered future-region threat/boss atlas |
| B-006 | `marks/shar-to-lolth-progression-v1.png` | Mark gates; Shar veil to Lolth spider progression |
| B-006 | `vfx/shadow-web-actions-v1.png` | strike, collect, dash and web-creation VFX |

## Audio handoff specification

No audio files were generated. Keep audio as an authored implementation task:

- Continuous-wheel/foot-pull loop: slow, weighty, with no horse layer.
- Attraction bed: increases per stationary night, then drops on departure.
- Each Mark: low veil tone, torn-thread transition, subtle spider chime at the Lolth state.
- Web floor: dry silk snap and anchored stone resonance; never a jump-pad cue.
- Region transitions: crossfade ambience over travel distance; do not use loading stingers.

## Deferred human review

- Gameplay balance, encounter timings and audio mixing remain human decisions.
- Glass Dunes and Dreamwater visual atlases are ready for their future playable chapters; P16 does not add those chapters or alter their rules.
