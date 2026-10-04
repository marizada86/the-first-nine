---
status: implemented-awaiting-human-review
kind: preparation-and-implementation-evidence
created: 2026-10-04
plan: "[[2026-10-04-b05-thornwake-combat-readability]]"
implementation_note: "[[2026-10-04-b05-thornwake-combat-readability-implementation]]"
implementation_branch: b05-thornwake-combat-readability
implementation_base: 9ea4fc1bbfabd5be50a2d7f334b9b11325b8a77b
implementation_push_approved: false
pull_request_approved: false
merge_approved: false
---

# B-05 preparation evidence

The user confirmed F4 playtester functions and reported two observable defects: attacking appears not to damage enemies, and the attack occurs alongside an apparent hurt animation. No combat fix has been implemented for B-05.

Read-only inspection found that base melee damage exists in `handle_primary()` but only when player/enemy positions are less than 56 px apart. The existing sprite is 200 px high, so visual reach should be measured with real input rather than inferred from the headless close-range self-test. `perform_dodge()` sets `hurt_cooldown`, while `draw_player()` interprets it as a hurt cue; the dodge VFX kind also differs from the draw check. These are investigation leads, not a verified explanation for every reported frame. The frame order also allows real enemy contact after the player's attack.

The latest locally tested F4 playtester code and validation records were prepared on `main` above base `787b1a1`; the approved B-04 merge is already recorded separately. The owner selected per-plan approval for B-05 and explicitly authorized pushing local commit `4ef349b` on 2026-10-04. The push succeeded: remote `main` contains `4ef349b` and approval record `a31c12c`. Opus must fetch and verify the current remote head before editing.

Prepared files: `[[2026-10-04-b05-thornwake-combat-readability]]` and `[[2026-10-04-b05-thornwake-combat-readability-instruction]]`. Source delivery is complete; Opus implementation, testing and review remain pending.

## Implementation

Claude fetched and verified `origin/main` at `9ea4fc1bbfabd5be50a2d7f334b9b11325b8a77b`. It implemented B-05 on the local branch `b05-thornwake-combat-readability`.

**Reproduction.** Before any change, the reported defect was reproduced with real input at 1280 by 720: F4, **Next night**, walking to the Briar Hound, and pressing E.

- An attack pressed at a 63 px gap missed with no pose or effect (hound 1 -> 1).
- The hound's telegraphed lunge then genuinely struck Lolth (3.0 -> 2.0) and showed the hurt pose.
- A clean dodge with no damage (3.0 -> 3.0) also showed the hurt pose and pink circle.
- Measured sprite bodies place visible hound contact at about an 82 px center gap, against the old 56 px hit radius.

**Fix.** Melee reach now matches visible contact: Lolth's 44 px half-body plus the target's measured half-body. The nearest target is chosen and Lolth faces it. Misses within 220 px show a distinct swing and "Out of reach" message without damage, and hits flash the enemy. Attack, dodge, and hurt poses are separate states. Hurt visuals follow real health loss only. Contact damage, the combo, telegraphs, and the Echo rules are unchanged.

**Validation.**

- The Godot 4.7.2 headless self-test passes B-01 to B-05, the playtester suite, and the legacy prototype suite.
- 11 B-05 negative controls fail as expected.
- The real-input runner passes 9 of 9. Among its checks:
  - a hit at a 66 px gap (hound 1 -> 0, Lolth 3.0 -> 3.0);
  - a miss at 127 px (stag 2 -> 2);
  - a clean dodge (3.0 -> 3.0, no hurt);
  - a real hound strike (3.0 -> 2.0, hurt shown);
  - the wave advancing to the Stag of Mire;
  - the F4 restore.
- The existing playtester runner and the normal and headless runs pass without script errors.

Full results, captures, and limitations are in `[[2026-10-04-b05-thornwake-combat-readability-implementation]]`.

At the original implementation checkpoint, implementation push, pull request, and merge were not approved or performed. Human review was pending.

## Subsequent publication and local follow-up

The owner later authorized publication of the original implementation as `4400b59` on `b05-thornwake-combat-readability`. No B-05 PR or merge has occurred. The owner then requested local independent controls, inventory and wagon management, followed by clean dash and larger-enemy corrections while deferring parry to a higher Mark. The local implementation and 33/33 controls/menu plus 9/9 combat validation are recorded in [[2026-10-04-b05-local-controls-inventory-wagon-implementation]]. The owner accepted local commit `43ab112` on 2026-10-04. Human validation is accepted and follow-up publication approval is pending; do not treat earlier preparation/approval wording as its current state.
