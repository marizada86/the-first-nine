---
status: prepared-not-authorized
package: opus-thornwake
depends_on: opus-runtime-foundation
---

# Opus handoff — Thornwake playable chapter

## Gate

Use only after a clean runtime foundation has passed local review and this package has separate implementation approval.

## Canonical context

- `.atena/vault/canon/2026-10-03-thornwake-combat-economy-and-progression-decisions.md`
- `.atena/vault/canon/2026-10-03-caravan-awakening-progression.md`
- `.atena/vault/drafts/2026-10-03-production-bible.md`
- `.atena/vault/drafts/2026-10-03-chapter-cards-and-progression-matrix.md`

## Scope

Implement one bounded Thornwake scenario: exploration/Salvage, load transfer, Wheel Kit recipe, wagon condition and one night defense, Shar's Mark I event, one survivor cure choice and a checkpoint. Use declared placeholders only; no final art admission.

## Allowed files

Only the approved clean-runtime project and a new `content/chapters/thornwake/` data directory. Do not modify frozen prototype files or canonical records.

## Non-goals

No Stonehook+, balance sealing, final art, new lore, follower AI, open world, procedural systems, dependency, publishing or remote work.

## Acceptance and validation

Provide deterministic test coverage for: recover → transfer → craft Wheel Kit; night attack damages wagon; destruction reloads correct checkpoint; Mark I begins after Shar; cure selects exactly one drow; no permanent survivor death. Run Godot headless validation and report the exact modified files.
