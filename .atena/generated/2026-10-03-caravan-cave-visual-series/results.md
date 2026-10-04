---
status: complete-reference-generation
kind: imagegen-batch-receipt
recorded: 2026-10-03
plan_id: 2026-10-03-caravan-cave-visual-series
approval: plan-approved
approval_record: "[[2026-10-03-caravan-cave-visual-series-approval]]"
---

# Curated visual-reference receipt - cave, caravan and prologue

## Provenance and limits

All four images were generated as original AI-assisted visual references through the built-in ImageGen service and copied without modification into this directory. They are not final game assets, sprites, atlases, or Godot imports. Keep their C2PA provenance intact where available. Any later public or jam submission must carry the applicable AI-use disclosure and must be checked against the submission terms at that time.

Provider: OpenAI built-in ImageGen media service. License/provenance status: AI-generated reference, retained locally with its source manifest. Declared/measured character ratios, ground pivots and sprite-cell measurements: not applicable to these storyboard and environment boards.

## Results

| Batch | Candidate | Result | Local review |
| --- | --- | --- | --- |
| C-01 | `c-01-prologue-comic-v1.png` | accepted, attempt 1/2 | Six wordless panels establish relics, horse-less wagon, cave arrival, damaged wheel, sick group and Lolth departing. |
| C-02 | `c-02-cave-caravan-v1.png` | accepted, attempt 1/2 | The same open wagon reads in damaged, repaired and pulled-travel states; relic cargo, camp beds and a continuous ground base are visible. |
| C-03 | `c-03-day-night-tutorial-v1.png` | accepted, attempt 1/2 | Day gathering, dusk return and night attack are distinct; the wagon is the protected focal point and the creatures have nonverbal telegraphs. |
| C-04 | `c-04-posts-web-anchor-v1.png` | accepted, attempt 1/2 | Temporary contextual post, limited companion assistance and a visibly fixed, wagon-supporting web bridge are legible. |

## Per-attempt record

### C-01 - prologue comic

- Manifest: `c-01-prologue-comic.manifest.json`; target: `c-01-prologue-comic-v1.png`.
- Execution prompt: six-panel wordless opening-comic reference showing the family fleeing with precious relics to an open horse-less wagon, plague exhaustion among eight companions, arrival at a root-lined cave with a broken wheel and splintered wood, and Lolth leaving the eight sick allies resting at camp.
- Checks: six panels, open horse-less wagon, cave arrival, sick group, no readable text, no watermark. Result: passed by local visual review; no exception.

### C-02 - cave camp and caravan states

- Manifest: `c-02-cave-caravan.manifest.json`; target: `c-02-cave-caravan-v1.png`.
- Execution prompt: three separated side-view states of the same wagon - cave-damaged with wheel and rail damage, repaired at a camp with relic cargo and eight beds, then travelling with four weak passengers and one person pulling it.
- Checks: three wagon states, open horse-less wagon, relics visible, straight continuous ground, no readable text, no watermark. Result: passed by local visual review; no exception.

### C-03 - day/night tutorial

- Manifest: `c-03-day-night-tutorial.manifest.json`; target: `c-03-day-night-tutorial-v1.png`.
- Execution prompt: three side-view frames - Lolth gathering medicine at day, returning to the lantern-lit wagon camp at dusk, then defending the wagon as shadow creatures approach at night with glowing-eye and cast-shadow danger cues.
- Checks: three tutorial frames, day/night contrast, wagon-threat telegraph, no readable text, no watermark. Result: passed by local visual review; no exception.

### C-04 - posts and permanent web anchor

- Manifest: `c-04-posts-web-anchor.manifest.json`; target: `c-04-posts-web-anchor-v1.png`.
- Execution prompt: three side-view frames showing a temporary regional post, up to two recovered allies helping Lolth reach a ledge, and Lolth forming a thick fixed web bridge that becomes a level continuous base under the horse-less wagon.
- Checks: contextual posts, permanent web ground, continuous wagon road, no readable text, no watermark. Result: passed by local visual review; no exception.

## Validation

On 2026-10-03, `c-01-prologue-comic.manifest.json`, `c-02-cave-caravan.manifest.json`, `c-03-day-night-tutorial.manifest.json`, and `c-04-posts-web-anchor.manifest.json` each passed the batch manifest validator with one asset, `max_attempts: 2`, and `approval: plan-approved`.

