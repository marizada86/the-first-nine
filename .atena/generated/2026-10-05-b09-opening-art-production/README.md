# Opening art package review

All thirty selected images are human accepted: twenty individual comic panels, two cave backgrounds and eight resting-patient sprites. The owner accepted the five revised endings first and the remaining twenty-five images on 2026-10-05. The offline art plan is complete; none of these images is admitted into the game.

## Review sheets

- [Opening comic](package-review-v2/opening-contact-sheet.png): nine panels.
- [Xiar bargain comic](package-review-v2/bargain-contact-sheet.png): six panels.
- [Accepted ending comic](ending-review-v1/ending-contact-sheet.png): five panels. Its earlier pending-review label is historical; the owner accepted it on 2026-10-05.
- [Cave interior and entrance](package-review-v2/cave-contact-sheet.png): two empty backgrounds with continuous flat lower-quarter floors.
- [Eight resting patients](package-review-v2/patients-contact-sheet.png): Aelira, Vaelun, Nimara, Thaviel, Ilyren, Orisya, Soreth and Luraen.
- [Body scale comparison](package-review-v2/patients-scale-comparison.png): existing standing Nolf reference and patient landmarks at the same logical body scale.

The review sheets retain the accepted narrative order, clothing identities, cave continuity and patient readability. Comic text remains editable and outside the artwork in [the English panel script](panel-text.en.json). [The acceptance receipt](package-acceptance-v1.json) identifies every accepted version and hash.

## Selected files and measurements

[The current selection](package-selection-v2.json) identifies every chosen version. Landscape masters in package-masters-v2/ are 1920 by 1080; their previews in package-review-v2/ are 1280 by 720. Patient masters are transparent 64 by 64 cells with nearest-neighbor 512 by 512 previews. Earlier provider outputs, rejected attempts and version-one normalized files remain preserved.

Patients use sixteen colors, safe gutters and ground contact at y56. Manually reviewed crown, neck, hip, extended-leg knee and heel measurements give body ratios from 0.9686 to 1.0156 against the common forty-pixel Nolf baseline. Reclining bounding-box height is not used as anatomical height. The annotated comparison is a review aid, not a new generated character or runtime asset.

[The technical report](package-technical-v2.json) records actual dimensions, hashes, crops, alpha counts, landmarks and pivots at the pre-acceptance checkpoint. Its five-panel acceptance scope is historical; the separate acceptance receipt now covers all thirty images. [Validation results](package-validation-v2.json) cover all forty-four generation attempts, thirty distinct selected masters, independent patient pixel scans, retry limits, file preservation, text coverage, ADD paths, twenty-five wiki links and four rejected negative controls. [Exact generation prompts](results.json) preserve historical names as actually submitted; their per-attempt statuses describe generation checkpoints.

## Limits and next gate

This is artwork only. No runtime admission, map geometry, gameplay, collision, comic reader, engine validation, CI, commit, push or external publication is included. Cave viewpoints still require camera and doorway/floor alignment during separately approved implementation. Some ending legs overlap other forms; no independent anatomical segmentation is claimed.

Generation used built-in ImageGen only. AI disclosure is required if used, and licensing has not been independently verified. No dependency was installed; YAML-parser validation is not claimed. The next gate is a separate bounded B-09 runtime admission and implementation approval, after B-08 acceptance and integration. [Closure checks](art-closure-validation-v1.json) verify acceptance, state/history preservation and unchanged production files.
