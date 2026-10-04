---
status: approved
kind: asset-production-automation-specification
approved: 2026-10-03
intent: '[[2026-10-02-thalestriel-exodus-game-intent]]'
related_spec: '[[2026-10-02-runtime-art-batch-1]]'
source_decision: 'User approval in this conversation, including mandatory cross-character proportion validation.'
---

# Batch Image Autopilot

## Scope

Provide a repository-local skill that turns an explicitly approved image-batch manifest into generated game-art assets, evaluates each candidate automatically, retries bounded failures, and records outcomes without requesting approval asset by asset.

## Non-goals

- Generating assets before a batch manifest is approved.
- Changing canonical lore, art direction, character relationships, game rules, or provider/spend permissions.
- Admitting an asset whose provenance, technical contract, or required character proportion is unverified.

## Acceptance criteria

1. The skill requires an approved JSON batch manifest and rejects incomplete manifests before generation.
2. The workflow generates, validates, retries, and records assets without pausing for individual approvals.
3. Each character-bearing entry declares a scale reference and target visible-height ratio; validation accepts a maximum ±5% deviation and a matching ground/pivot line.
4. A candidate that still fails after the approved retry limit is logged as an exception while the remaining batch continues.
5. Each accepted and excepted entry has a durable result record with prompt, source references, validation decisions, and provenance fields.

## Plan of flight

1. Validate the approved manifest structure before generation.
2. Establish or load its reference scale sheet, with Lolth at 1.00 unless the manifest specifies another baseline.
3. Generate each asset and conduct technical, art-direction, and proportion checks.
4. Retry only the failing item up to its declared limit; do not alter accepted assets or canonical sources.
5. Save outputs and a batch result record; finish the batch with a concise exception report.

## Evidence

- Skill validation output.
- A sample manifest validation result.
- Future per-batch result records under `.atena/generated/` and visual-review evidence under `.atena/evidence/`.

## Reconciliation

The runtime-art Batch 1 specification now treats cross-character proportion as a required scale validation, not an optional art review preference.
