---
status: complete-human-accepted
created: 2026-10-05
plan: '[[2026-10-05-lolth-three-transformations]]'
canonical_decision: '[[2026-10-05-lolth-three-transformation-visual-stages]]'
analysis: '[[2026-10-05-lolth-three-transformations-analysis]]'
approval_mode: per-plan
approval_source: owner-replied-1-to-entire-presented-scope
implementation_preceded_spec: false
published: false
human_acceptance: accepted
human_acceptance_date: 2026-10-05
human_acceptance_source: owner-replied-aprovados-after-delivery
---

# Lolth transformations: production and local validation

## Owner acceptance

On 2026-10-05, following delivery of the comparison board, animated previews and local integration results, the owner replied `aprovados`. The three produced skins and animations at Marks III, V and VII are accepted. Human review is closed and the plan is complete. The technical delivery sections below retain the earlier pending-review checkpoint as history; this explicit acceptance supersedes it. `human-acceptance.json` and `results.json` in the generation directory record the receipt. No assets or runtime behavior changed during this acceptance update.

Acceptance record validation passed: all three stage receipts agree with the owner response; all eight ADD contract entries exist; ten wiki links in the updated spec, decision and production evidence resolve; the completed cursor and B-07/B-08/B-09 records remain preserved. Whitespace validation passed, with only the existing Godot project line-ending notice. The asset-generation receipt script preserves this acceptance on rerun.

## Delivered

Three additional skins at Marks III, V and VII, each with 36 unique frames: idle 4, run 6, strike 4, dodge 3, collect 3, rise 2, fall 2, hurt 2, transformation 6, signature preview 4. The three normalized atlases are 672 by 672 RGBA, with a shared 12-color palette and transparent gutters. Three isolated masters, animation manifests, animated GIFs in both facings and a comparison board including the original base drow are in `.atena/generated/2026-10-05-lolth-three-transformations/`.

New versioned atlases/manifests were admitted to `assets/runtime_v2/characters/lolth/` under the approved technical scope. `lolth_transformations.gd` owns presentation-only stage/clip selection. `main.gd` selects it at 3/5/7, starts acquisition/F4 transitions, clears transient visuals on failure restoration and retains the original narrative elf/drow function. Mark IX retains stage VII only as a prototype placeholder, not completed SHADOW CROWN. Signature clips are previews with no new power/input binding. Combat constants, physical reach and action durations retain their original values; nearest filtering applies only to the new Lolth textures.

The cure modal darkens the world. Acquisition therefore also shows the six-frame transition in its unused lower area, without delaying or covering cure choices.

## Art checks and technical adjustment

Nine built-in ImageGen calls: three attempts per stage. Attempts 1/2 were rejected for excessive detail, spacing or appendage/effect readability; attempt 3 supplied the selected source poses, not a ready-made exact atlas. Component analysis found 36 disconnected primary characters in each selected source, allowing isolated extraction without cutting the neighbouring character or synthesizing a cycle by moving one still.

The proposed 64-pixel safe area could not accommodate the pulse/web effects at the required body size. Final cells use 112 logical pixels with pivot (56,100) and a 40-pixel standing body. This increases transparent padding, not body size or physical reach. Uniform per-stage scaling, binary alpha and 12-color conversion produce the final atlas. All 108 cells have at least two transparent gutter pixels and distinct raster hashes.

The original drow's standing body measures 410 pixels inside a 428-pixel cell rendered at 200 pixels, giving 191.5888 visible display pixels. New bodies use that display height. Idle measurements are 40/40/40/40 for III and V, and 40/40/41/40 for VII: maximum ratio 1.025, within ±5%. Hair/appendage/VFX extents are excluded from anatomical height. Inspection of all normalized sheets confirms continuous opaque trousers/boots and compact/four-tip/eight-tip resting silhouettes.

## Fresh validation

Godot 4.7.2.stable.official.ed1daf0bf on Windows; rendered checks on GTX 1650, OpenGL compatibility, NVIDIA driver 616.92, 1280 by 720.

- Asset checks: three atlases, 108 unique frames, 12 colors maximum, safe gutters and GIF exports.
- Focused integration: 196/196 assertions, including 0–9 boundaries, narrative form, clip rectangles/indices, action priority/progress, air phases, once-only acquisition, F4 exact restoration, checkpoint/safe restoration and original geometry constants; exit 0.
- Full self-test: B-01 through B-07, playtester and final SELF_TEST_PASS; exit 0.
- Existing combat regression with motion isolation: nine checks, zero failures, exit 0. The first run's missing capture directory caused PNG-save errors despite passing checks. The directory was created and the complete second run (`combat-rerun.log`) passed with fresh captures; the first log is retained and is not final evidence.
- Existing menu/controller regression: 33/33; exit 0.
- Existing enemy geometry oracle: 46/46; exit 0.
- Existing rendered enemy-facing regression: 102/102; exit 0. This is an enemy regression, not an independent new-Lolth mirror oracle.
- Actual runtime rendering: 63 fresh captures (three stages, ten clips, two facings, plus three acquisition/cure previews); exit 0. Representative gameplay captures, all atlases, comparison board and VII cure-acquisition capture were inspected. New Lolth facings were visually reviewed; owner playback acceptance remains pending.

An inferred Variant size in the cure preview caused a parse error during development. It was corrected to explicit Vector2, then the focused suite, full self-test and 63-capture renderer passed again on final source. Initial validation-script type errors were corrected before passing results. No claim that every development attempt passed is made.

Godot emitted environment diagnostics for inaccessible user shader/editor caches and the root certificate store in this restricted session. Import completed; final runtime checks/render captures have no project-script diagnostics. No global configuration, permissions or certificate settings changed.

## Receipts and reconciliation

`prompts.json` stores all exact generation prompts. `results.json` records tool, source/output hashes, all attempts, AI disclosure, acceptance status, measurements and pending owner review. `components.json`, `normalization-report.json`, `asset-validation.json`, `runtime-validation.json` and `render-captures.json` hold technical receipts.

All four approved batches/steps are technically complete. Existing B-07 history, B-08 preparation, concurrently prepared B-09 records and unrelated local evidence are preserved. Original sprites remain available. No commit, push, dispatch, dependency change or publication occurred. Human art/playback acceptance is not inferred from production approval. Full Mark IX art, new powers and broad original-skin animation rewrites remain deferred.

Final record validation: all eight required ADD contract entries exist and all 15 wiki-link occurrences in the four new/updated plan, decision and evidence documents resolve locally. Plan state records local completion with human review pending and clears the execution cursor; prior B-07 completion is preserved in history.

Record consistency and whitespace checks passed. An optional full YAML parser check could not run because neither PyYAML nor the Node `yaml` package is bundled; no dependency was installed. The final check verified the unique null active-plan field, complete cursor, new last-completed ID, preserved B-07 history and B-08/B-09 entries directly.
