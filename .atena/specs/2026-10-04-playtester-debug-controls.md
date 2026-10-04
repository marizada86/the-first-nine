---
status: complete-local-validation
kind: runtime-debug-tool
created: 2026-10-04
origin: post-hoc
implementation_preceded_spec: true
mode: direct
request_classification: NEW_DIRECT_REQUEST
execution_authority: direct-user-request-2026-10-04
evidence: "[[2026-10-04-playtester-debug-controls]]"
published: false
---

# Playtester controls — post-hoc implementation record

## Origin and scope

The user directly requested a playtester mode with Mark increase/decrease and next-day/next-night controls. Ordinary local implementation preceded this specification under ADD Direct Execution. This is a truthful reconciliation, not a retroactive claim of a pre-approved plan. No plan was active at the start; B-04 was already closed.

Add an English debug-only panel to the existing runtime. F4 or the Playtester button opens it; Mark controls inspect levels 0–9. Day/night buttons run the existing time-boundary behavior, including night enemy spawning and dawn cleanup, without requiring initial Wheel Kit repair. Preserve the pre-override run in memory and allow an explicit restore.

## Non-goals

- No change to canonical Mark/cure progression, travel rules, narrative, or B-01 through B-04 approvals.
- No automatic cures, boss victories, new regions, art, enemies, or abilities.
- No fix to the separately reported combat/damage animation issue.
- No disk saves, dependencies, release export, Git commit, push, PR, or merge.

## Acceptance criteria and results

1. English panel opens through F4 and a visible button: implemented; F4 and button callbacks tested.
2. Mark +/- respects 0–9 bounds and updates the existing form/power state: passed headless and mouse-input tests. Cure selections remain unchanged.
3. Next night works before repair and starts real Thornwake waves: passed; Briar Hound appears. Repeating the command replaces the night setup rather than duplicating enemies.
4. Next day runs dawn cleanup and ends active waves: passed headless and mouse-input tests.
5. The world pauses while the panel is open; closing/restoring consumes the input frame to avoid accidental attacks: passed.
6. Explicit restore recovers the previous gameplay variables, nested stock/checkpoints, Mark, cures, time, and opening state: passed for new and already-secured Mark-I runs.
7. Tools are gated by `OS.is_debug_build()`; release builds do not create the panel or bind F4: implemented by code guard; no release export was produced.
8. Existing B-01 through B-04 and legacy prototype self-tests still pass: passed on Godot 4.7.2.

## Implementation impacts

`main.gd` contains panel setup, input/pause handling, reversible overrides, a playtest objective, and a dedicated self-test. The snapshot deep-copies script-owned mutable arrays/dictionaries and excludes playtester UI/tool fields. The first override invalidates sandbox safe-wagon state and creates a sandbox checkpoint; the original checkpoint is retained separately for restoration.

Mark changes clear Echoes and refresh health to the existing level maximum for inspection. They do not award cures or complete Shar/boss steps. Levels II–IX expose only existing prototype states, not newly completed progression. A time jump may update tutorial/dawn flags through the existing boundary handler; those effects stay inside the reversible session.

## Gaps

- BLOCKING: none.
- RESOLVED: F4 plus mouse controls; debug-only availability; 0–9 bounds; no automatic cures; reversible in-memory session.
- DEFERRED: release-export verification, disk persistence, later progression implementation, and combat-animation diagnosis/fix.

## Actual execution sequence

1. Read operational state, existing runtime, and relevant B-04/canonical boundaries.
2. Implement the requested local debug controls and isolated restore behavior.
3. Add headless assertions and a normal-rendering real-input runner.
4. Validate F8, mouse controls, enemy spawning, dawn cleanup, and restoration; inspect captures and improve panel contrast.
5. Record this post-hoc specification, evidence, and direct-execution operational fact without replacing completed B-04 history.

## Validation and recovery

Use `D:/Godot/godot.exe` with `--headless --path . -- --self-test`. Use the runner `.atena/generated/2026-10-04-playtester-validation/validate_playtester.gd` in normal rendering at 1280×720 for UI validation and captures.

Close the panel to play with overrides; select **Exit playtest and restore previous state** to recover the original run. Ending the process discards both in-memory sessions. The owner later approved publishing the tested F4 source; commit `4ef349b` was pushed to `origin/main` on 2026-10-04.

## Shortcut correction, 2026-10-04

The first local implementation used F8. The user reported that pressing it stopped the game in the Godot editor; the editor's documented default maps F8 to Stop. The user directly requested F4, which now replaces F8 in the runtime binding, panel labels, objective, and real-input validation. This correction followed implementation and does not retroactively change the original request or validation history.
