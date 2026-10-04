---
status: implemented-published-awaiting-final-technical-review
kind: bounded-review-correction-evidence
created: 2026-10-04
batch: B-05
request_classification: IN_PLAN
approval_mode: per-plan
spec: "[[2026-10-04-b05-enemy-geometry-followup]]"
parent_revision: "[[2026-10-04-b05-controls-and-wagon-menu-revision]]"
implementation_branch: codex/b05-controls-wagon-inventory
implementation_base: e6b614c3d3554d142fe93a90c05347176796d731
implementation_commit: b8823c70c637fdbef9f36e6cf0da0925369faa47
geometry_human_validation_accepted: true
geometry_human_validation_date: 2026-10-04
push_approved: true
published: true
first_published_commit: b8823c70c637fdbef9f36e6cf0da0925369faa47
pull_request_approved: false
merge_approved: false
---

# B-05: enemy geometry review correction

## Authority and preserved history

The owner authorized the proposed local correction after delivering Claude's read-only review of `e6b614c`. This fulfills the existing enemy-proportions/reach acceptance criterion and is IN_PLAN under the existing per-plan mode. The bounded spec was recorded before implementation. The owner's earlier human acceptance of `43ab112` and publication of `43ab112`, `bb4a0d4` and `e6b614c` remain valid historical facts, not acceptance/publication of this new correction. No published commit is amended or replaced. B-05 remains active; B-04 remains the latest completed plan.

The delivered review reported successful Linux Godot 4.7.2 self-tests, 9/9 combat and 33/33 controls checks. Its cold-frame 27–70 ms measurements and clean hypothetical merge are reviewer-provided evidence, not independently reproduced local performance or merge results. The local work below verifies the actual correction instead; no merge was attempted.

## Implemented changes

1. Thornwake uses integer atlas-cell edges and a uniform source-to-destination scale. Stag's 1774×887 atlas has approximately 2:1 cells; rendering no longer compresses each into a square. Cell heights remain Hound 160, Stag 200 and boss 260 px. Opaque feet stay at the 555 px floor, visible bodies stay centered, and overhead labels/bars use the same bounds. No source PNG is edited.
2. Thornwake melee reach uses Lolth's unchanged 44 px component plus half the current frame's drawn alpha >= 0.25 outline width. Rendering and reach share `enemy_draw_geometry()`, including the selected pose. The old manual widths remain only for unchanged prototype-region melee. Damage, health, combo, timing, vertical reach and the 35 px enemy contact-damage rule are unchanged.
3. `_ready()` prepares 22 cells across the five existing enemy sheets before gameplay. Drawing, melee and subsequent waves use cache lookups only. Images are read once per sheet during preparation; no lazy pixel scan remains in the gameplay lookup. Cache/counters use the existing UI-prefix exclusion from F4 snapshots. Prototype atlas sampling and square rendering are retained; their outline cost is merely prepared earlier.

Reach intentionally varies with the selected frame. Native-alpha measurements across all four poses, including the defeated frame for geometry only:

| Enemy | Drawn outline width | Center reach |
| --- | --- | --- |
| Briar Hound | 147.75–157.19 px | 117.88–122.60 px |
| Stag of Mire | 232.51–380.63 px | 160.25–234.32 px |
| Antlered Hunger | 247.56–253.78 px | 167.78–170.89 px |

Defeated enemies still cannot be selected as melee targets. These are outline bounds, not per-pixel collisions or a promise that every transparent interior gap counts as body. Stag's idle/contact poses have notably different widths; pose-based reach follows the approved shared-outline rule, not a new fixed attack radius. Human proportion/balance feedback remains useful.

## Validation and reproducibility

Godot 4.7.2 Windows, `D:/Godot/godot.exe`; normal 1280×720 OpenGL Compatibility on NVIDIA GTX 1650. No fixed-FPS argument, new dependency, production adapter or art generation. Final logs, images, JSON and runners are under `.atena/generated/2026-10-04-b05-geometry-validation/`. Original revision logs/captures remain untouched.

- `node .atena/generated/2026-10-04-b05-geometry-validation/run_validation.cjs geometry combat runtime self-test normal-smoke headless-smoke` runs the named Godot scenarios, redirects existing runner captures using `OUT`, and records actual child-process exit codes in `*-result.json`. Each final scenario exits 0. Saved successful Godot logs contain no script errors or warnings.
- Geometry: 46/46 in headless and normal rendering. Independently reads native atlas alpha, verifies all 12 Thornwake source/aspect/bounds/centering/ground/shared-reach combinations, brackets each species' hit/miss boundary for a controlled phase, retains real contact damage, and checks cache counts through frame switching, night waves, boss setup and attacks. For pulse 0 with distance-driven frame selection, the largest integer hit gaps are Hound 122, Stag 160 and boss 167 px; these are controlled-phase results, not universal fixed reaches.
- Preparation: 22 cells. First headless run: 756.113 ms; final normal-render run: 645.064 ms. Gameplay-added scans: 0 in the tested scenarios. Cost is moved to startup, not eliminated. These are native CPU elapsed counters for preparation, not GPU timings, steady-state FPS claims or a sealed performance benchmark.
- Actual-input combat: 9/9, `B05_RUNTIME_PASS: 0 failures`. Hound hit pressed at 79 px lowers enemy 1→0 without lowering Lolth 3→3; Stag miss pressed at 207 px leaves enemy 2→2; genuine Hound contact lowers Lolth 3→2 with hurt visuals. Waves clear and F4 restores the original run.
- Actual-input controls/menus: 33/33, including E/LMB separation, inventory/wagon integrity and pause, keyboard/controller access, locked cave allies, prototype two-post/recall guards, F4 restore, clean dash and inactive right-click.
- Self-test: `SELF_TEST_B01_PASS`, `SELF_TEST_B02_PASS`, `SELF_TEST_B03_PASS`, `SELF_TEST_B04_PASS`, `SELF_TEST_B05_PASS`, `SELF_TEST_PLAYTESTER_PASS`, `SELF_TEST_PASS`. Prototype-suite success does not admit later-region progression.
- Normal and headless smoke: each 600 frames, exit 0.
- ADD record validator: contract, 52 record/active-plan links, preserved prior acceptance/publication, local-only correction gate, final log diagnostics and actual process-result JSON pass. No whole-file YAML parser verification is claimed. Code/record whitespace checks pass. Godot's raw smoke logs retain their engine-generated final blank lines; the complete staged diff is checked with `blank-at-eof` disabled for that check only, without editing logs or changing Git configuration.
- `node .atena/generated/2026-10-04-b05-geometry-validation/run_negative_controls.cjs`: 5/5 faulty subclasses rejected with actual exit 1 and targeted geometry assertions, not script errors. Faults: square Stag aspect (4 assertions), short reach (15), excessive reach (15), old manual reach (15), absent startup preparation (1). These isolated subclasses extend the real script and are never loaded by the production scene. They are new geometry controls, not reruns of the original 11 B-05 mutations.

The first real-input follow-up run exposed a stale harness assumption: it measured Stag reach before walking, when the selected pose differed from the attack pose. Its miss check failed because the new current-frame reach correctly allowed the strike. The revised runner uses a controlled pulse 0 phase at a 210 px approach target, with real mouse dispatch and world processing still active. Independent native-pixel assertions remain the non-circular geometry oracle. The successful final run, not that preliminary failure, is the acceptance result.

## Visual evidence and fallback

Inspected normal captures: `briar-hound-aspect.png`, `stag-of-mire-aspect.png`, `antlered-hunger-aspect.png`, `dash-clean.png`, `dash-drow.png`, `b05-hit.png`, `b05-miss.png` and `b05-hurt.png`. Stag is no longer horizontally compressed; all three enemies are grounded, with labels above the visible body. The elf/drow dash retains body-only art; strike/miss/genuine hurt remain distinct. UI captures are retained beside the logs. Real-play shots still expose legacy resource-label crowding; no UI polishing is claimed.

The game-visual-debugging skill informed controlled captures and explicit measurement separation. This repository has no `.game-dev/adapter.json` or available game-dev CLI. Validation therefore uses the existing Godot-owned runners/captures as a documented fallback, not sealed run bundles, semantic GPU attachments or performance profiling. No adapter or dependency was installed.

## Deferred review observations and gates

- Larger visual/melee bounds versus the unchanged 35 px enemy contact-damage radius: balance tuning deferred; tested, not changed.
- Inventory pauses during combat: existing owner-approved behavior, preserved.
- Prototype higher-Mark Shift sense/Night Choir/Spider's Promise/Luraen assist: inaccessible through the new always-dash binding; intentionally deferred, not silently remapped or unlocked. Existing Mark 7 E gates remain as before.
- Legacy HUD icons overlap hints and resources crowd labels: cosmetic follow-up, out of this correction.
- Paired dash comparator images are expected to be identical when supplementary VFX is suppressed; not presented as pre-fix art evidence.
- At implementation time the new visual-review checkpoint was pending. The subsequent owner confirmation recorded below accepts that checkpoint without inventing additional detailed human tests. Earlier acceptance remains valid for `43ab112`; future balance changes would require their own review.
- Full-file YAML parser verification remains unavailable without adding a dependency; the local validator checks contract/state invariants, links, gates and final logs instead. No parser-pass claim is made.

The correction commit `b8823c7` carries runtime changes, isolated tests, captures and the original local-only records. It was created before its own hash could be recorded in those files; no self-referential hash was fabricated. The original local-only gate is preserved as implementation history, not the current publication state.

## Owner acceptance and authorized publication

On 2026-10-04 the owner stated "conferido. Vamos passar o próximo prompt para o opus 5.5", confirming the requested visual-review checkpoint for `b8823c7`. No detailed human checklist, additional machine run or balance change is inferred. Opus subsequently reported that the commit and its spec/evidence were absent from GitHub and correctly stopped without reviewing the old version as a fix.

The owner then explicitly authorized recording the confirmation and publishing the correction and records to the existing branch, without PR or merge. Classified IN_PLAN. A normal push advanced `origin/codex/b05-controls-wagon-inventory` from `e6b614c` to `b8823c70c637fdbef9f36e6cf0da0925369faa47`; `ls-remote` verified that exact hash and remote main unchanged at `9ea4fc1bbfabd5be50a2d7f334b9b11325b8a77b`. This reconciliation follows in an ordinary documentation/record-validator commit on that branch, not an amend or force-push.

No runtime, asset, test-result log, validation metric or canonical rule changed in this reconciliation. The record validator is updated only for the now-accepted/published operational state. Existing runtime results above remain historical successful results, not fresh engine reruns. B-05 stays active for final technical review; B-04 remains the latest completed plan. The English resume instruction is prepared for the owner, not sent automatically. No PR, merge, branch deletion or B-06 was authorized or performed.
