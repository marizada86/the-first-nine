---
status: implemented-published-awaiting-final-technical-review
kind: bounded-review-correction
created: 2026-10-04
request_classification: IN_PLAN
approval_mode: per-plan
approval_source: explicit-owner-authorization-after-bounded-proposal
parent_plan: "[[2026-10-04-b05-controls-and-wagon-menu-revision]]"
implementation_base: e6b614c3d3554d142fe93a90c05347176796d731
implementation_branch: codex/b05-controls-wagon-inventory
implementation_commit: b8823c70c637fdbef9f36e6cf0da0925369faa47
geometry_human_validation_accepted: true
geometry_human_validation_date: 2026-10-04
push_approved: true
published: true
first_published_commit: b8823c70c637fdbef9f36e6cf0da0925369faa47
pull_request_approved: false
merge_approved: false
implementation_preceded_spec: false
---

# B-05 approved enemy geometry correction

## Scope and evidence

The owner approved this bounded local correction after Claude's read-only review of `e6b614c`. Classified IN_PLAN: it fulfills existing acceptance criterion 10 (proportions and melee reach) without changing design scope, controls, damage or progression. The prior implementation/human validation/publication history remains valid for its exact commits; this new correction is not automatically validated or published by that history.

The Stag sheet is 1774x887, with four approximately 2:1 cells. Rendering into a square compresses its width. Current melee reach uses older hand-measured widths separately from the alpha-threshold bounds used for drawing. Current bounds scanning occurs on each cell's first draw. Claude reproduced 9/9 combat and 33/33 controls tests on Linux; reported 27-70 ms per cold cell is external review evidence, not a local measurement.

## Plan of flight

1. Preserve Thornwake source-cell aspect using uniform scale, integer cell boundaries, grounded visible feet and centered visible body.
2. Derive Thornwake melee width from the same current-frame alpha >= 0.25 cached outline and uniform scale used for drawing. Keep Lolth's 44 px reach component and all damage/contact radii unchanged. Keep legacy prototype-region rendering/reach behavior rather than expanding this correction to those regions.
3. Prepare outlines before ordinary gameplay. The frame/geometry lookup must not scan pixels on a draw or melee call. Retain UI-prefixed cache fields outside F4 snapshots. Measure preparation separately; moving cost to startup is not eliminating it.
4. Validate all Thornwake frames/aspect/ground/centering/shared reach, positive boundary hits and negative boundary misses, unchanged contact-damage behavior, all existing self-tests and real-input runners. Add deliberate faults in isolated validation-only subclasses to prove aspect/reach/cache regressions are detected without mutating the production checkout. Run normal/headless smoke checks and inspect bounded captures.
5. Record the review and remaining limitations in English, preserve prior human acceptance without claiming acceptance of the new Stag correction, and return for review. Do not push, open a PR, merge, dispatch externally or start B-06.

## Acceptance criteria

- Every Thornwake drawn frame preserves source width/height ratio. Opaque feet align to the intended floor and body remains centered.
- Thornwake reach equals Lolth's component plus half the actual drawn outline width of the same selected frame; hit/miss checks bracket that boundary.
- All required outlines exist at startup; draw/reach/frame switching/new waves and boss spawn perform zero new pixel scans. Startup cost and runtime cache counts are reported separately.
- Existing input/menus/F4 and B-01 through B-05 regressions pass. New isolated negative controls fail for incorrect aspect, incorrect reach, and missing prewarm.
- No PNG edit/new art, damage/timing/contact-radius change, inventory-pause change, parry/Mark unlock, new dependency or later-region progression.

## Gaps, impacts and recovery

BLOCKING gaps: none. Frame geometry/Thornwake reach and validation runners change; prototype behavior and published commits are preserved. Recovery uses an ordinary local follow-up commit, not amend/reset/force-push.

The game-visual-debugging skill has no configured `.game-dev/adapter.json` or CLI in this project. Use the existing Godot-owned captures and explicit geometry assertions as a documented fallback; do not claim sealed harness evidence or GPU profiling.

DEFERRED observations from the review: unchanged 35 px contact-damage radius versus enlarged visual reach (balance), inventory pause during combat (approved behavior), inaccessible prototype Mark V+ Shift sense/anchor/Luraen actions (deliberate binding deferral; Mark 7 E gates remain), overlapping legacy HUD icons (cosmetic), and duplicate dash comparator rasters (expected proof of suppressed effect, not a before/after art comparison).

## Implemented outcome

Implemented as `b8823c70c637fdbef9f36e6cf0da0925369faa47` on the named branch with preserved published history. Independent native-alpha geometry checks pass 46/46; deliberately faulty subclasses are rejected 5/5; actual-input combat passes 9/9 and controls/menus 33/33. B-01 through B-05, F4 and the full self-test pass; normal and headless 600-frame smoke runs pass. See the evidence record with the same identifier for commands, captures, measurements and limitations.

On 2026-10-04 the owner stated "conferido. Vamos passar o próximo prompt para o opus 5.5", accepting the requested local visual-review checkpoint; no additional test-by-test results are inferred. Earlier acceptance of `43ab112` is preserved. After Opus reported the correction absent remotely, the owner explicitly authorized recording this acceptance and publishing the correction and records. A normal push published `b8823c7` to `origin/codex/b05-controls-wagon-inventory`, verified with `ls-remote`; remote main remains `9ea4fc1`. These later approvals supersede the original local-only restriction solely for this branch publication. Records follow in an ordinary commit without amend or force-push. B-05 remains active pending final technical review. No PR, merge, direct external dispatch or B-06 is authorized or performed.
