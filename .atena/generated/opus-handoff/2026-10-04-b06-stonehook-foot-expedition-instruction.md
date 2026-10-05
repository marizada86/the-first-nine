---
status: implemented-branch-published-isolation-follow-up-awaiting-review
kind: external-implementation-instruction
created: 2026-10-04
plan_id: 2026-10-04-b06-stonehook-foot-expedition
spec: "[[2026-10-04-b06-stonehook-foot-expedition]]"
evidence: "[[2026-10-04-b06-stonehook-foot-expedition]]"
approval_mode: per-plan
approved: 2026-10-04
approval_source: owner-selected-1-to-approve-the-presented-B06-implementation-scope
implementation_approved: true
execution_target: opus-5.5
documentation_publication_approved: true
documentation_published: true
delivery_commit: 77ee387d5649a131ae20c5910b2dc7421c76f22f
push_approved: false
pull_request_approved: false
merge_approved: false
dispatch_approved: false
implementation_branch: codex/b06-stonehook-foot-expedition
implementation_base: 7e477ba799ce5b4bf9cb6e9dde44e83c97db0bbc
implementation_commit: 42bddf87b64eafb2046a47b1f2695df3ad9d4075
implementation_evidence: "[[2026-10-04-b06-stonehook-foot-expedition-implementation]]"
steps_completed: [S-001, S-002, S-003, S-004]
human_review: pending
branch_publication_approved: true
branch_published: true
published_commit: ccc4fcf69271d88e421e26a81841cf6cce834a37
publication_authority: owner-authorized-normal-push-of-the-branch-for-review
follow_up_commit: d2012a1412f52d3066e4eff1216cfa9d57490acd
follow_up_published: true
latest_published_commit: 7c781ab65d75251af20880cf6e9548d1239be0dd
isolation_follow_up_commit: b446b7b507d6a5faa8fb2ac9d28197da34887e99
isolation_follow_up_published: false
---

# B-06 Stonehook Foot Expedition Instructions for Opus 5.5

Implement only the first reversible on-foot expedition from Thornwake to early Stonehook, using the repository plan as the source of truth. The owner approved the complete bounded implementation scope per plan by selecting option 1 on 2026-10-04 and then authorized documentation publication to main. Repository delivery is recorded below; this instruction has not been sent as an external message. Verify the delivered approval records before editing anything.

## Approval and Delivery Gate

Work in `marizada86/the-first-nine`. Inspect `.atena/state/plan.yaml`, the linked B-06 spec/evidence and this instruction. Require the delivered records to agree on explicit B-06 implementation approval and `per-plan`. Once authorized delivery is recorded and its checkpoint cleared, execute S-001 through S-004 without seeking new batch or step approval within this unchanged scope. If the live records are missing, unconfigured, unapproved or still awaiting delivery, read and report readiness only; do not start. Old B-01 through B-05 approvals, the accepted playtest and a pasted copy of this instruction do not substitute for the delivered B-06 approval records.

Report the exact inspected branch, HEAD and working-tree status. Fetch origin/main without discarding local work. It must contain acceptance `2f34635ff5adf735e51a7c144862e7c1bba37bed`, preparation `0a82ead8384969a11399f20ef3dcf3828734df27` and approval `77ee387d5649a131ae20c5910b2dc7421c76f22f`, plus this delivery reconciliation or a later verified descendant. Those three commits were normally pushed and verified at remote HEAD `77ee387`; gameplay remains from `05eac1e7a639e213f39cff81b1e75305727ab4d0`. Do not require an obsolete exact HEAD or start from the still-pending delivery wording at the initial approval commit. Confirm the listed records exist and the branch contains the accepted facing implementation/merge, preparation, approval and cleared delivery checkpoint. Stop and report missing delivery if required commits or files are absent. Never pretend an older branch contains a newer correction or reconstruct unseen records from this summary.

Use a separate `codex/b06-stonehook-foot-expedition` branch from the verified delivered main after the execution gate is met. Preserve dirty work and all existing branches. No force-push, destructive reset, published-history amend or branch deletion. The documentation push is already authorized and recorded; `push_approved: false` refers to future B-06 implementation publication. Per-plan implementation approval does not authorize that push, PR, merge or external messages.

## Read Before Editing

- `.atena/add.yaml`, applicable `AGENTS.md` instructions and `.atena/state/plan.yaml`.
- `.atena/specs/2026-10-04-b06-stonehook-foot-expedition.md` and `.atena/evidence/2026-10-04-b06-stonehook-foot-expedition.md`.
- `.atena/vault/canon/2026-10-03-caravan-survival-slow-travel.md` and `2026-10-03-caravan-relics-cave-prologue-and-travel.md`.
- `.atena/vault/canon/2026-10-03-continuous-caravan-ground-and-web-gates.md`, `2026-10-04-first-boss-mark-and-cure.md`, `2026-10-04-separated-controls-and-wagon-management.md` and `2026-10-03-minimal-stonehook-visual-direction.md`.
- Completed B-04 safe-wagon spec/evidence, B-05 controls/menu and geometry evidence, enemy-facing correction spec/evidence and `2026-10-04-enemy-facing-pull-request.md`.
- `main.gd`, `wagon_inventory_ui.gd` and the existing isolated combat/menu/geometry/facing validation scripts.

Later approved caravan decisions supersede the older statement that the wagon travels immediately after the first cure. Respect the current stationary cave hub and protected family/relics.

## Implement the Bounded Slice

Follow S-001 through S-004 and B-001 through B-003 in the approved spec. Add only one continuous floor-level corridor and reversible horizontal world/view translation. Proposed playtest spans are the unchanged 0-1280 Thornwake area, a 480-unit transition band and one 1280-unit Stonehook foothill section; keep the cave at x=190 and the existing ground height. Treat dimensions as reported playtest data, not lore.

Separate Lolth's displayed region from the stationary hub and actor-origin context. Do not merely remove `wagon_travel_locked()` or call `spawn_zone()` at a border. Departure requires legitimate Mark I, exactly one cure, repaired wagon and a survivable saved camp. Mark-only F4 overrides must not manufacture entitlement. Keep the return route physically available once away.

Spatially blend existing route/backdrop/foreground art across the connecting band. Do not use scene replacement, position reset, map selection, a loading card or a full-screen temporal dissolve. HUD and all interfaces stay in screen space. Preserve sprite reflection, grounded feet, native Thornwake aspect, shared-outline reach and prepared bounds while composing camera transforms.

Add one stable finite ore pickup, carry it with existing capacity rules and deposit at the actual cave wagon. Border revisits must not respawn loot, enemies or supplies. Audit every remote E/M/UI/save/craft path so camera or region changes cannot create a second camp or unlock ally roles.

Keep clock, Flame, Provisions, existing Thornwake waves, concrete cave attackers and wagon failure/defense active offscreen. Do not freeze or clear the camp at borders, or replace real enemies with invented abstract damage. Restore terminal failure anywhere to the latest valid cave snapshot, preserving Mark I and the selected cure and rolling back unsaved expedition data. Extend safe-wagon/F4/new-run coverage for route/camera/pickup state; never snapshot zero terminal values.

Preserve all current inputs and UI click isolation. No wagon travel, Mark II, second cure, parry, posts/missions, Stone Maw/shrine, axle/brakes crafting, rope teleport, Web Anchors, Hollowroot, new art/audio, dependencies or disk persistence. No new Stonehook combat in this first traversal slice. Allowed production edits are `main.gd` and narrowly necessary guard changes in `wagon_inventory_ui.gd`; all tests/records belong under `.atena/`. Ask for a plan change before any broader architecture or scope expansion.

## Validate and Return

Use the local Godot runtime (`D:/Godot/godot.exe` on Windows) or the available Godot executable in the external environment. Record actual version/platform, commands, exits and diagnostics. Do not edit production files to force a platform match or use a fixed-FPS workaround.

Add B-06 headless and real-input outward/return checks, border-repeat/capacity cases, offscreen Stag damage, terminal rollback at the foothills, exact F4 restore and new-run locks. Include camera-offset combat and UI tests and five transition positions in both day/night at 1280x720. Add genuine targeted negative controls for illegitimate departure, border duplication, remote camp/save access, paused offscreen simulation, lost restore fields and accidental progression unlocks.

Rerun the full self-test and applicable prior combat/menu/geometry/facing suites, writing fresh results to `.atena/generated/2026-10-04-b06-validation/` rather than overwriting committed evidence. Distinguish reproduction from inspected historical results. Preserve the intent of previous assertions; explain any narrow approved boundary adaptation. Do not use `self_test_travel_bypass` as an ordinary gameplay entitlement.

Write `.atena/evidence/2026-10-04-b06-stonehook-foot-expedition-implementation.md` and reconcile the spec/evidence/plan to actual implementation-awaiting-review status. Report: exact branch/base/head, changed files, implemented behavior, tests and actual exits, new captures, unresolved limitations, approval/checkpoint state and the next non-authorizing recommendation. State whether anything was committed or published. Stop for owner review. Do not push, open a PR, merge, delete a branch or start another batch without its required authority.

## Execution Record

The owner directed the assigned executor, in its chat session on 2026-10-05, to read this delivered instruction from the repository. Atena sent no external message, and `dispatch_approved` is unchanged. The executor verified the gate above and implemented the approved scope locally on `codex/b06-stonehook-foot-expedition` (implementation commit `42bddf8`, base `7e477ba`). Results are in [[2026-10-04-b06-stonehook-foot-expedition-implementation]]. Nothing was pushed, and no PR, merge or B-07 work occurred.

## Publication and Follow-up Record

The owner separately authorized the branch push; `origin/codex/b06-stonehook-foot-expedition` was created at `ccc4fcf69271d88e421e26a81841cf6cce834a37`. The reviewed follow-up `d2012a1` is local only. See [[2026-10-04-b06-stonehook-foot-expedition-implementation]].

## Follow-up Publication and Isolation Record

The owner separately authorized publishing `d2012a1` and `7c781ab`; the branch now stands at `7c781ab65d75251af20880cf6e9548d1239be0dd`. The test-only isolation follow-up `b446b7b` is local. See [[2026-10-04-b06-stonehook-foot-expedition-implementation]].
