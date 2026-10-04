---
status: complete-local-validation
kind: runtime-implementation-evidence
created: 2026-10-04
origin: post-hoc
implementation_preceded_spec: true
spec: "[[2026-10-04-playtester-debug-controls]]"
published: false
---

# Playtester debug controls — implementation evidence

## Implementation

Implemented locally after the user's direct request, based on local `main` at `787b1a1`. No prior Guided ADD plan or approval is invented. B-04 remains the last completed approved batch, and no B-05 was started.

- F4/Playtester button opens an opaque English panel (F8 was the initial shortcut and was corrected after user feedback).
- Mark -/+ sets the existing Mark level within 0–9, clears Echoes, and refreshes health; cures stay unchanged.
- Next night invokes the real night boundary and starts enemies, including before Wheel Kit repair.
- Next day invokes dawn renewal/cleanup and clears active waves.
- The panel pauses world processing. A one-frame guard isolates close/restore clicks from gameplay actions.
- The first override stores a deep-copy runtime snapshot. Restore recovers original gameplay and checkpoints, closes the panel, and ends overrides.
- `OS.is_debug_build()` gates panel creation, F4 binding, and mutation callbacks.
- The HUD identifies active playtesting, including at Mark IX without indexing beyond Echo thresholds.

## Files

- `main.gd`: runtime tool and dedicated self-test.
- `.atena/generated/2026-10-04-playtester-validation/validate_playtester.gd`: reproducible normal-rendering keyboard/mouse validation.
- `.atena/generated/2026-10-04-playtester-validation/panel.png`: inspected panel capture at 1280×720.
- `.atena/generated/2026-10-04-playtester-validation/forced-night.png`: inspected night capture with a visible Briar Hound.
- This evidence, its post-hoc specification, and `.atena/state/plan.yaml`: local operational reconciliation only.

## Validation performed

Godot version: 4.7.2. Normal rendering: OpenGL compatibility on NVIDIA GeForce GTX 1650, 1280×720.

Final headless full self-test: **exit 0**, no script errors, with:

```text
SELF_TEST_B01_PASS
SELF_TEST_B02_PASS
SELF_TEST_B03_PASS
SELF_TEST_B04_PASS
SELF_TEST_PLAYTESTER_PASS
SELF_TEST_PASS
```

Playtester assertions cover panel pause, actual button signals, Mark increase/decrease and bounds, no automatic cures, forced and repeated night, dawn cleanup, nested-data isolation, input-frame isolation, exact original checkpoint/safe-wagon restoration after a Mark-I session, and restoration of an opening-shell session.

Initial normal-rendering runner, before the shortcut correction: **exit 0**, no script errors, with:

```text
PLAYTESTER_RUNTIME_PASS: F8, pause, mouse Mark +/-, Next night/day, enemy spawn, dawn cleanup, resume, restore
```

This runner injects keyboard and mouse events rather than invoking gameplay callbacks directly. Both captures were visually inspected. The final opaque panel is legible and fits without covering the bottom controls at 1280×720.

Follow-up correction on 2026-10-04: Godot's documented editor shortcut for Stop is F8, matching the user's report. F4 now binds the playtester action; the panel's two button labels and the active playtest objective also say F4. The real-input runner asserts the F4 binding and injects F4 key presses. Its final normal-rendering run exited 0 without script errors:

```text
PLAYTESTER_RUNTIME_PASS: F4 binding/toggle, pause, mouse Mark +/-, Next night/day, enemy spawn, dawn cleanup, resume, restore
```

The final full headless suite also exited 0 with B-01, B-02, B-03, B-04, playtester, and legacy prototype passes. The refreshed panel capture was inspected and displays F4 in both places. This automated run validates in-game behavior; it cannot simulate the Godot editor intercepting a physical key while the editor has focus.

ADD contract directories and all new artifact paths exist; `git diff --check` passed. The prior `plan.yaml` contents were compared against HEAD after removing the new direct-execution mapping and were identical. A full YAML parser was unavailable locally; no dependency was installed. The new mapping's indentation/scalar structure was checked separately.

Earlier validation exposed inferred-Variant boolean declarations; these were corrected before the final passing runs. An initial sandbox launch could not create Godot's external log; final runs used approved local execution with normal log access.

## Limits and recovery

- Marks II–IX inspect pre-existing prototype states; they do not represent completed later chapters.
- No automatic cure selection, travel unlock, or finale is introduced. Mark/time overrides do not prove ordinary campaign progression.
- Debug time jumps may change tutorial flags and renew resources. Their effects are restored with the original session.
- Snapshots are in memory only, not save files.
- No release build was exported; the debug gate was verified in code.
- The reported attack/damage animation issue is unchanged and outside this request.

Use **Exit playtest and restore previous state** to discard overrides, or restart the game for a fresh session.

## Publication state

Local implementation and validation only. The source and these records were later included in the local preparation commit for B-05; this does not publish them to the remote. No push, PR, merge, canon edit, dependency installation, or asset admission was performed for this request.
