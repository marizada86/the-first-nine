---
status: complete-local-validation
kind: bounded-naming-revision
created: 2026-10-05
origin: planned
implementation_preceded_spec: false
request_classification: PLAN_CHANGE_REQUEST
approval_mode: per-plan
approval_source: Owner explicitly instructed the three replacements and preservation of all remaining names.
canonical_decision: ../vault/canon/2026-10-05-nolf-xiar-naming.md
evidence: ../evidence/2026-10-05-nolf-xiar-naming.json
blocking_gaps: []
---

# Apply Nolf Xiar and Xiar's kiss

Apply the three exact naming changes supplied by the owner to the local game and current production text. This is an approved nomenclature amendment to B-09, not a replacement of its production plan or checkpoints. Its existing per-plan approval level remains; the owner has explicitly approved the amendment's complete scope by providing the replacements.

## Scope and impacts

Update visible runtime labels and messages, the README, current canonical prose, B-09 specifications, English panel text and descriptive manifest text. Preserve original wording in historical approvals, recorded user statements, audit results and generation receipts. Preserve resource paths and internal compatibility identifiers. Attach the approved naming amendment to the active operational state without moving its cursor.

## Non goals

No other names, gameplay, character traits, art, assets, dependencies or permissions change. No image generation, runtime comic admission, filename migration, export, commit, push, publication or external dispatch is authorized.

## Acceptance and validation

The protagonist's labels and inventory read Nolf/NOLF. Runtime narrative uses Xiar and Xiar's kiss. The 20 current English comic panels use the same names. Drow, Eol, survivors and regions are preserved. Current canonical amendments are dated rather than presented as original wording. Resource references remain valid, Godot imports the project and the existing self-test passes.

## Plan of flight and gaps

Record the authorized canonical decision and scoped specification; apply the replacements to current text; run source/reference checks, the Godot import and self-test; record results and reconcile the operational naming amendment. There are no blocking gaps. Uppercase UI labels use NOLF, XIAR and XIAR'S KISS; ordinary text uses Nolf, Xiar and Xiar's kiss.

## Recovery and evidence

Save pre-edit copies and hashes of changed text files in the local revision evidence directory. Rollback is limited to those exact edits and must preserve any concurrent production progress. The completion receipt records changed files and actual validation results. Existing B-09 batch membership, accepted visuals and pending production gates remain binding.

## Completion

The names are applied to runtime presentation, README, four current canonical narrative records, the two current B-09 specs, panel text and four production manifests. The active B-09 record carries the approved naming amendment; its production fields and ART-003 cursor were preserved against the immediate pre-edit snapshot. Earlier inspection had observed ART-002; production advanced independently before this naming amendment was written.

Godot 4.7.2 imported the project and passed the full existing self-test. The existing rendered keyboard, mouse and controller menu regression passed 33/33 checks. The captured inventory heading reads NOLF'S INVENTORY and its description uses Nolf. Static checks verified the 20 panel IDs and sequence, unchanged non-string runtime code, preserved remaining names, resource references, 33 wiki links and the required ADD contract. Scoped whitespace checks passed. The engine reported a Windows root-certificate-store diagnostic in the restricted environment; no project diagnostics remained in the final runs. This revision does not claim publication or legal clearance.
