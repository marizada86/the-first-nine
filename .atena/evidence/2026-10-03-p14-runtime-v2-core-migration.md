---
status: complete-user-approved-runtime-migration
plan: '[[2026-10-03-p14-runtime-v2-core-migration-plan]]'
runtime_result: '[[core-migration-v1-results]]'
---

# Evidência — P14 migração runtime_v2

## Execução

Seis candidatos versionados foram criados em `assets/runtime_v2/` e `main.gd` foi adaptado para carregá-los no núcleo de Thornwake. A estrutura legada permaneceu intacta.

## Validação

- Seis PNGs com alpha nas bordas e dimensões registradas.
- Importação local do Godot concluída.
- Autoteste Godot retornou `SELF_TEST_PASS`.
- O renderer não usa mais plataformas comuns no chão de Thornwake.

## Revisão pendente

Uma partida visual humana em 1280×720 ainda deve confirmar escala, leitura e continuidade antes de encerrar o plano.

## Revisão concluída

Aprovação humana recebida em 2026-10-03. A migração `runtime_v2` do núcleo de Thornwake é vigente; o legado foi preservado para rollback.
