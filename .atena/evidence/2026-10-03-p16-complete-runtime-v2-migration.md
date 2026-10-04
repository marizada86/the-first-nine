---
status: complete-user-approved
plan: '[[2026-10-03-p16-complete-runtime-v2-migration-plan]]'
validated: 2026-10-03
user_approved: 2026-10-03
---

# P16 evidence

## Delivered scope

The six approved batches produced and admitted ten versioned `runtime_v2` candidate sheets/atlases. `main.gd` now consumes the new Thalestriel, survival HUD, workshop, Stonehook, later-region, Mark and VFX assets where those visual families are active. Legacy art was preserved without deletion.

## Invariants checked

- The wagon is still open and horse-less; the new workshop prop is a craft table.
- Cured Thalestriel are shown as contextual helpers, not player avatars.
- Stonehook and later-region roads remain continuous; web is represented as the exceptional solid crossing, not a routine platform.
- Mark visuals progress from Shar's crescent/veil through shadow threads to the Lolth drow-spider symbol; Mark IX remains the ending seal.

## Validation

1. Godot editor headless scan imported all ten new PNGs successfully.
2. `D:\Godot\godot.exe --headless --path . -- --self-test` returned `SELF_TEST_PASS`.
3. The editor host emitted expected user-profile/cache write errors because AppData is unavailable in this workspace. These did not block project scan, import, or the self-test.

## Result

P16 is complete. Audio implementation and human balancing remain visible deferred work, per the approved plan.
