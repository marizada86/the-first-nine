---
status: complete-implementation-merged
kind: preparation-and-implementation-evidence
created: 2026-10-04
plan: "[[2026-10-04-b05-thornwake-combat-readability]]"
implementation_note: "[[2026-10-04-b05-thornwake-combat-readability-implementation]]"
implementation_branch: codex/b05-controls-wagon-inventory
original_implementation_branch: b05-thornwake-combat-readability
implementation_base: 9ea4fc1bbfabd5be50a2d7f334b9b11325b8a77b
implementation_push_approved: true
pull_request_approved: true
merge_approved: true
pull_request: https://github.com/marizada86/the-first-nine/pull/4
merge_commit: bc7796e0fad33f5d7b773af3eaefc07749ec81b4
merged_feature_head: e5832da604226b33f424d18248b24f0825c568aa
closure_evidence: "[[2026-10-04-b05-documentation-closure]]"
---

## Current closure: B-05 integrated and completed

PR [#4](https://github.com/marizada86/the-first-nine/pull/4) was merged with a regular merge at `bc7796e0fad33f5d7b773af3eaefc07749ec81b4`, from `codex/b05-controls-wagon-inventory` at `e5832da604226b33f424d18248b24f0825c568aa` into `main`. All six PR commits and both feature branches are preserved. The original implementation branch `b05-thornwake-combat-readability` at `4400b59` is historical, not the current integrated delivery.

The owner separately authorized branch publication, PR opening, regular merge, and this documentation closure/publication on main. Initial local-only restrictions describe their original checkpoints; they do not negate those later approvals. Opus's delivered final review reported no blockers on `e5832da`; its reproduced Linux results are reviewer evidence, not fresh Atena results or CI checks.

B-05 is the last completed plan; the active-plan slot is cleared. This closure changes records only. No runtime, art, saved test outputs, canonical gameplay rules or dependencies change; no B-06 or branch deletion is authorized. Parry, balance tuning, higher-Mark progression and disk saves remain deferred. See [[2026-10-04-b05-documentation-closure]] and [[2026-10-04-b05-pull-request]] for verification and approval provenance.

## Historical preparation, implementation and review

The following sections preserve the original checkpoints and their evidence. Any pending-review, local-only, main-unchanged or no-PR/no-merge statement below refers to that stage, not today's closed state. Original implementation values superseded by later controls/geometry corrections remain historical.

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

The owner later authorized publication of the original implementation as `4400b59` on `b05-thornwake-combat-readability`. No B-05 PR or merge has occurred. The owner then requested independent controls, inventory and wagon management, followed by clean dash and larger-enemy corrections while deferring parry to a higher Mark. The implementation and 33/33 controls/menu plus 9/9 combat validation are recorded in [[2026-10-04-b05-local-controls-inventory-wagon-implementation]]. The owner accepted commit `43ab112` on 2026-10-04, then explicitly authorized publishing implementation and records to `codex/b05-controls-wagon-inventory`. Normal push was verified at `bb4a0d4` and publication reconciliation follows on the same branch. Human validation and branch publication are accepted; technical review is next and PR/merge remain unapproved. Do not treat earlier preparation/approval wording as current state.
