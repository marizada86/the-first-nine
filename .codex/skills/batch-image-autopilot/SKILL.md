---
name: batch-image-autopilot
description: Generate and automatically validate approved game-image batches, including cross-character proportions, with either batch or bounded plan-series approval.
---

# Batch Image Autopilot

Use this skill when an approved asset manifest asks for a complete image batch to be generated and quality-checked autonomously. It can use one explicit approval for a bounded series of planned batches. Do not use it for a one-off image request or to establish new art direction.

## Required input and authorization

- Work only from a validated JSON manifest with either `approval: "approved"` (that batch) or `approval: "plan-approved"` (a bounded approved series).
- For `plan-approved`, require `plan_approval.record`, `plan_approval.plan_id`, and `plan_approval.batch_id`. Before generating, verify that the durable approval record exists, explicitly authorizes the named batch ID, and that the manifest stays within its listed scope. A plan-series approval never authorizes new art direction, canonical changes, runtime admission, new providers, or batches absent from its record.
- Treat its art direction, asset list, source references, target paths, retry limit, and character proportions as the bounded authorization. Do not invent missing lore, relationships, proportions, provider permissions, or spend authorization.
- An item with an incomplete contract is an exception. Record it and continue the rest of the batch; do not solicit a per-asset approval.

## Operating loop

1. Load the approved manifest and its referenced art-direction materials. Create the declared output and record locations without overwriting source assets.
2. For each item, form a generation prompt from the manifest. Generate only the specified asset and save a versioned candidate.
3. Inspect the candidate against its required composition, style, file requirements, and exclusions. For gameplay art, check transparency, canvas dimensions, readable silhouette, and ground/pivot alignment.
4. For every `kind: character` entry, compare the visible figure height (feet to crown; ignore transparent padding, VFX, weapons, and raised limbs) with the item’s `scale_reference`. Accept only a ratio within ±5% of `target_height_ratio` and with matching ground/pivot alignment. Use the manifest's scale sheet; Lolth is 1.00 only when that is the declared baseline.
5. If a check fails, improve only the failed item's prompt and retry it up to `max_attempts`. Do not revise an approved source or accepted sibling asset to make the result fit.
6. Mark a passing candidate `accepted`. At the retry limit mark it `exception` with the unmet checks; continue. Never label a character candidate accepted if its declared proportion cannot be measured.
7. At the end, write a result record containing every attempt, final status, prompt, source references, measured proportions, technical checks, and provenance/disclosure fields. Report a batch summary and the exception list.

## Stopping boundaries

Complete the batch without individual approval prompts. Stop and request direction only if the manifest lacks valid batch or plan-series approval, a required permission/provider is absent, a safety issue appears, or proceeding would change canonical intent or exceed an explicit budget. A normal validation failure is an exception, not a reason to stop the batch.

Read [references/batch-contract.md](references/batch-contract.md) for the manifest contract and result-record requirements.
