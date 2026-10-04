# Batch contract

The manifest is JSON. Validate it before generation:

```text
node .codex/skills/batch-image-autopilot/scripts/validate_batch_manifest.mjs <manifest.json>
```

Required root fields are `approval`, `art_direction`, `output_dir`, `max_attempts`, and `assets`. `approval` is either `approved` for one batch or `plan-approved` for a bounded series; `max_attempts` must be between 1 and 5.

For `plan-approved`, add this object and verify its record before generation:

```json
"plan_approval": {
  "record": ".atena/vault/canon/approved-visual-series.md",
  "plan_id": "2026-10-03-visual-reference-series",
  "batch_id": "I"
}
```

The record must explicitly list the `batch_id` and authorize its generation. A series approval does not authorize batches or scope not named in that record.

Every asset needs an `id`, `kind`, `prompt`, `target`, and `checks`. Character assets additionally require `scale_reference`, `target_height_ratio`, and `ground_pivot`.

Use this shape for character assets:

```json
{
  "id": "shade-idle-v3",
  "kind": "character",
  "prompt": "...",
  "target": "assets/art/enemies/shade-idle-v3.png",
  "checks": ["transparent-background", "side-view", "no-text"],
  "scale_reference": "lolth-drow-idle-v2",
  "target_height_ratio": 1.15,
  "ground_pivot": "feet-on-shared-ground-line"
}
```

The reference can be another manifest asset or a named entry in the approved scale sheet. A ratio means `candidate visible height / reference visible height`. For a 1.15 target, accepted results fall from 1.0925 through 1.2075 inclusive. The visible height excludes padding and non-body extensions.

Write results in JSON or Markdown under `.atena/generated/`. For each attempt retain: asset ID, prompt, source references, candidate path, check decisions, declared and measured ratio, ground/pivot decision, final status, provenance, provider/license status, AI disclosure requirement, and exception reason when applicable.
