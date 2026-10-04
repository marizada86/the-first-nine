---
status: approved-ready-for-external-execution
kind: preparation-evidence
created: 2026-10-04
plan: "[[2026-10-04-b05-thornwake-combat-readability]]"
---

# B-05 preparation evidence

The user confirmed F4 playtester functions and reported two observable defects: attacking appears not to damage enemies, and the attack occurs alongside an apparent hurt animation. No combat fix has been implemented for B-05.

Read-only inspection found that base melee damage exists in `handle_primary()` but only when player/enemy positions are less than 56 px apart. The existing sprite is 200 px high, so visual reach should be measured with real input rather than inferred from the headless close-range self-test. `perform_dodge()` sets `hurt_cooldown`, while `draw_player()` interprets it as a hurt cue; the dodge VFX kind also differs from the draw check. These are investigation leads, not a verified explanation for every reported frame. The frame order also allows real enemy contact after the player's attack.

The latest locally tested F4 playtester code and validation records were prepared on `main` above base `787b1a1`; the approved B-04 merge is already recorded separately. The owner selected per-plan approval for B-05 and explicitly authorized pushing local commit `4ef349b` on 2026-10-04. The push succeeded: remote `main` contains `4ef349b` and approval record `a31c12c`. Opus must fetch and verify the current remote head before editing.

Prepared files: `[[2026-10-04-b05-thornwake-combat-readability]]` and `[[2026-10-04-b05-thornwake-combat-readability-instruction]]`. Source delivery is complete; Opus implementation, testing and review remain pending.
