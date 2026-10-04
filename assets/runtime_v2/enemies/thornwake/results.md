---
status: complete-user-approved-runtime-migration
---

# P15 — ameaças runtime de Thornwake

- `briar-hound-core-v1.png`, `stag-of-mire-core-v1.png` e `antlered-hunger-core-v1.png` foram gerados como folhas 2×2 transparentes e conectados ao renderer.
- `main.gd` seleciona Briar Hound por padrão, Stag of Mire pelo nome e Antlered Hunger pelo nome, preservando os comportamentos existentes.
- O `Shade` legado não foi apagado; apenas deixou de ser carregado pelo caminho ativo.
- O autoteste retornou `SELF_TEST_PASS` após a reimportação.

Aprovação humana recebida em 2026-10-03; as três ameaças são as visuais vigentes de Thornwake.
