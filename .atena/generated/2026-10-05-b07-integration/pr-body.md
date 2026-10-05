## Summary

Add the finite first Stonehook foothill encounter: one Scree Crawler, telegraphed lunges, fixed native-aspect artwork, capped reward and coherent restoration. The cave wagon and family remain stationary. No boss, shrine, Mark II, additional cure, parry or wagon travel is enabled.

## Review and owner authorization

Implementation: `4da953cd34469b8024eb2d3831ba7c8ae06cb34a`, based on `fcc98b63e1919c54b6df563c8de0c7173a7affcb`.

Documentation reconciliation: `523421ebbf3a0c70fd14ce7664a570ebbe12ccbe`. Only records and the scoped integration validator changed after the tested implementation.

The owner accepted the listed B07 limitations and authorized record publication, opening this PR, a regular merge preserving history/branch, and operational closure. The response was “aceito, borah” on 2026-10-05. This does not claim an itemized owner playtest or authorize B08 implementation.

## Fresh Windows validation by Atena

Godot 4.7.2.stable.official.ed1daf0bf, native Windows x64, NVIDIA GTX 1650, driver 616.92, OpenGL compatibility, 1280x720. Exact implementation ran in an isolated clone. Full runner exit 0, all 24 cases met their expected outcomes and had zero project diagnostics.

- B07 headless 24/24; real-input runtime 28/28.
- B06 headless 30/30; route runtime 53/53.
- Combat and continuous trigger-noise combat 9/9 each; menus 33/33.
- Geometry 46/46; facing 65/65 headless and 102/102 rendered.
- Full self-test and both 600-frame smoke runs passed.
- Eleven faulty controls genuinely rejected with exit 1 and their required named assertions, not crashes.
- Eight fresh crawler captures inspected; implementation-checkpoint records validator passed.

Raw Windows artifacts remain owner-local. The published Windows review receipt records them separately from the executor's Linux results. Linux rendered facing was the documented 101/102 software-renderer difference, not a fresh Windows failure. No CI result is claimed.

## Scope and limitations

Production edits are limited to `main.gd`; remaining files are under `.atena/`. Assets, scenes, project settings, canon, dependencies and historical validators are unchanged.

Accepted limitations: static artwork, unreviewed balance, foreground occlusion outside the clear patrol, close-range label/ore overlap and in-memory saves. F4 exact encounter restore is headless-tested, not a fresh rendered F4 input case.

Crawler home is x=2520 with patrol 2400-2860; each landed lunge uses the existing one-point hurt in Lolth's three-health model. These are disclosed playtest settings.

B08 remains a separate inactive proposal. It will be reconciled against the integrated B07 code and presented for separate scope and approval-mode selection; it is not included in this PR.
