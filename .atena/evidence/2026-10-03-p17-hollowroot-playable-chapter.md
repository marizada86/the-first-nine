---
status: complete
plan: '[[2026-10-03-p17-hollowroot-playable-chapter-plan]]'
validated: 2026-10-03
---

# P17 evidence — Hollowroot

## Implemented

- Stonehook's completion screen now advances to Hollowroot with the primary
  action.
- Hollowroot uses the approved continuous-route backdrop and has no required
  platform route.
- Root Wraith and Root Crown are active encounter identities; Root Crown is
  the chapter boss and appears during Hollowroot night defense.
- Defeating the Root Crown and collecting its Echoes advances to Mark 3, which
  cures one Thalestriel through the existing contextual-assist flow.
- Web Anchor is a Mark-3 special crossing. It displays the web VFX and records
  the solid-web state in checkpoints.
- Checkpoints now preserve Hollowroot boss, Mark readiness and Web Anchor state.

## Validation

`D:\Godot\godot.exe --headless --path . -- --self-test` returned:

`SELF_TEST_PASS: Thornwake, Stonehook, and Hollowroot combat, cures, web crossing, checkpoints, and chapter transitions are ready`

The automated visual capture could not be performed because no native game
window is exposed to this workspace. The validation remains reproducible in
the Godot project; user-profile log/certificate warnings are environment
restrictions and did not affect the test.
