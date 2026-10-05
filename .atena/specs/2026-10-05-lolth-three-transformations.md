---
status: complete-human-accepted
kind: character-skins-animation-and-bounded-runtime-admission
created: 2026-10-05
origin: planned
implementation_preceded_spec: false
request_classification: NEW_DIRECT_REQUEST
request_mode: direct-analysis-then-approval-gated-production
approval_mode: per-plan
implementation_approved: true
human_acceptance: accepted
human_acceptance_date: 2026-10-05
human_acceptance_source: 'Owner replied aprovados after delivery of the three skins and animated previews.'
approved: 2026-10-05
approval_source: 'Owner replied 1 to the presented scope and approval selection; option 1 approves the entire presented plan.'
canonical_decision: '[[2026-10-05-lolth-three-transformation-visual-stages]]'
evidence: '[[2026-10-05-lolth-three-transformations-production]]'
analysis: '[[2026-10-05-lolth-three-transformations-analysis]]'
---

# Lolth: three transformations at Marks III, V and VII

## Objective and scope

Create three coherent additional Lolth skins, their animation cycles, animated local previews and bounded Godot presentation integration at the owner's requested Mark thresholds. Preserve the existing elf stage at 0 and base drow stage at I–II. Stages III, V and VII persist through the next threshold: III–IV, V–VI and VII–VIII. The existing Mark IX prototype can display the last stage as a documented placeholder; this plan does not implement or claim completion of SHADOW CROWN.

Preparation was authorized by the direct owner request. The owner subsequently replied `1` to the presented concrete direction, full scope and approval selection, approving production and bounded local technical admission per plan. No prior active plan is replaced.

## Proposed art progression

| Stage | Appearance | Transformation motion | Signature presentation |
| --- | --- | --- | --- |
| III — BLACK PULSE | Compact angular shadow armour around shoulders/forearms; white hair, dark mantle, opaque trousers and boots retained | Shadow gathers from feet to torso; armour silhouette resolves; one outward pulse | Anticipation, outward hand/body pulse, recovery |
| V — NIGHT CHOIR | Four spectral spider appendages folded behind the humanoid torso; short violet accent masses | Four appendages emerge sequentially and settle behind the mantle | Echo-listening pose; sparse echoes separate then converge |
| VII — SPIDER'S PROMISE | Eight spectral spider appendages forming a restrained arachnid silhouette; chest/shoulder web motif | Appendages unfold in paired waves, draw a web shape and retract into the resting silhouette | Brace, web release, tension, recovery |

These are visual proposals linked to existing powers. They add no flight, new attacks, hitboxes, reach, resource costs, movement buffs or revised Mark ability order. Hair, face identity, humanoid height, floor baseline and opaque clothing persist. The old painted evolution boards inform only silhouette progression. The P6 drow master and current runtime sheet supply identity; approved minimalist rules govern simplification.

## Deliverables and animation contract

Three transparent versioned skin masters; three normalized atlases and animation manifests; three animated previews; a comparison board including the base drow; prompts, source references, hashes and validation receipts. Keep generated candidates under `.atena/generated/2026-10-05-lolth-three-transformations/`. Save accepted runtime copies to new versioned paths only after the approved admission checks pass.

Per stage, target 36 distinct frames: idle 4, run 6, strike 4, dodge 3, collect 3, rise 2, fall 2, hurt 2, transformation 6 and signature presentation 4. Total target: 108 frames. Signature presentation is an isolated preview unless a corresponding ability already has an authorized runtime presentation hook. Artwork must show genuine phase changes; do not synthesize a cycle solely by moving, tinting or scaling one pose.

Work on a 64-by-64 logical grid with approximately 40-pixel standing body height; reserve the surrounding space for appendages and hair. Use nearest-neighbour enlargement for masters and integer atlas cells. Before production, measure the existing standing body's visible bounds and use that to set the new display scale; preserve collision geometry and feet placement. Require transparent safe gutters, no neighbouring-frame spill, short palettes and no pictorial microtexture. Grounded defaults may be adjusted within these acceptance criteria and recorded without changing history.

## Plan of flight and checkpoints

- B-001 / S-001: measure base art; finalize common cell/pivot and palette contract; produce all three skin masters and comparison board; record AI provenance and retry results. Approval authorizes this proposed direction; any incompatible redesign needs a new decision.
- B-002 / S-002: produce and normalize the 108 animation frames, manifests and animated previews; verify phase continuity, body scale and cell isolation. A still pose board is not an animated delivery.
- B-003 / S-003: admit only validated new files; add a presentation-stage selector independent of the narrative elf/drow form; trigger transformation presentation on an actual threshold increase; derive correct persistent skin after load/restore and F4 overrides. Restoration must not replay acquisition or alter cure/progression state. Keep the normal gameplay animation timings and gameplay authority intact.
- B-004 / S-004: run local Godot checks and visual review, document results and exceptions, reconcile permitted operational facts and present the completed package for human acceptance.

The selected mode applies to these stable IDs: per-plan authorizes the whole scope; per-batch pauses before each B checkpoint; per-step pauses before each S checkpoint. Mandatory canonical, destructive, dependency, remote-context and publication gates remain independent. No subagents, dependency installs, remote handoff, commit, push, PR or deployment are included.

Executed adjustment: final cells are 112 by 112 logical pixels with pivot (56,100), preserving the 40-pixel anatomical body and measured existing display height. Larger transparent padding accommodates pulse/web effects without clipping. This replaces the proposed 64-pixel safe-area default only; silhouette direction, palette, frame count and physical geometry are preserved. Actual measurements and checks are recorded in production evidence.

## Acceptance and validation

1. All three skins are identifiable by silhouette in side view and both facings, at logical size and the current 1280-by-720 camera. Same body-height ratio within ±5% against the measured base; appendages and VFX excluded from anatomical height.
2. All humanoid frames have opaque trousers through the boots. Identity, short palette and large pixel clusters match [[2026-10-03-minimal-character-visual-direction]] and [[2026-10-03-full-trousers-character-skin-rule]].
3. Each named clip has the declared frame count, valid atlas rectangles and meaningful phases. Standing baseline/pivot is stable; air frames preserve their intended displacement. No clipping, stray pixels, unrelated weapons or mirrored facing errors.
4. Stage boundaries 0/1/2/3/4/5/6/7/8/9 select the documented appearance. Normal state, F4 override/restore and failure/safe-state restoration agree. Crossing III/V/VII upward presents the transition once; normal idle and restoration do not retrigger it. No new progression unlocks, cures, anchor capabilities or Mark powers are introduced.
5. Use `D:/Godot/godot.exe` for import/parse, relevant existing facing/combat/menu/restore regressions and short rendered smoke checks. Add focused threshold/restore assertions appropriate to the actual renderer change. Inspect fresh captures and animation playback at both facings; record engine version and actual results. No blanket historical test-pass claim.
6. Prompts, built-in image generation provenance, source references, dimensions, transparency, hashes, attempts and exceptions are durable. Maximum three generation attempts per declared item; unresolved failures remain exceptions and block that item's admission.
7. Validate the ADD workspace contract and new links; compare evidence with every criterion before reporting completion. Original sheets remain available for local rollback. New code changes must be individually reversible without overwriting unrelated local work.

## Impacts, gaps and recovery

Impacts: new approved visual-stage intent, additional art/animation storage, a bounded renderer-stage/clip mapping and restoration checks. Canonical progression, combat tuning, input bindings, allies and world routes retain their established rules. Admission must not modify prior asset provenance or imply that AI-generated boards are verified production sprites.

BLOCKING preparation gaps: none. Production gates: owner approval of proposed appearance/admission scope and approval-mode selection. RESOLVABLE: measured display scale, frame timings, atlas arrangement and safe-area dimensions within the common contract. DEFERRED: full Mark IX spider form/final cinematic, new ability implementation, audio, disk saves, broad animation rewrites for the original two skins and external delivery.

Rollback: retain original sheets and narrative form function; revert only the new presentation mapping/transition bookkeeping and remove references to the new versioned assets. Do not reset the working tree, delete unrelated records or overwrite the owner's state.

## Approval requested

Approve the three proposed visual stages, production of their complete animation package and bounded local Godot admission described above. Select per-plan, per-batch or per-step. After approval, record its actual wording and date, persist the mode/checkpoint in `.atena/state/plan.yaml`, and record the narrowly approved new visual decision in canon. Approval does not authorize publication or external sharing.
