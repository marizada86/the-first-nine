---
status: complete-user-approved-runtime-migration
provider: built-in-imagegen
ai_disclosure: required-for-downstream-use
---

# Resultados — runtime_v2 núcleo

| Candidato | Fonte gerada | Grade/uso | Verificação |
| --- | --- | --- | --- |
| Lolth elfa | `exec-83cf5c01-feef-4723-b19f-25cbe3f08689.png` | 3×3, estados visuais unificados | PNG 1230×1278; alpha nas bordas |
| Lolth drow | `exec-91a67c89-7bf8-4ac5-994e-f11e8ae491b3.png` | 3×3, estados visuais unificados | PNG 1225×1284; alpha nas bordas |
| Carroça aberta | `exec-630a000d-87af-4591-b771-eb170ba70443.png` | 3 estados | PNG 2172×724; sem cavalo, sem cabine fechada |
| Chão Thornwake | `exec-488fee5e-19bc-4668-902d-2654eaebbe7a.png` | faixa contínua | PNG 2172×724; sem lacuna/plataforma |
| Pickups | `exec-e40e9206-b6f0-4601-9b83-226614ae761d.png` | 2×2 | PNG 1426×1103; alpha nas bordas |
| VFX | `exec-a5e1f835-3d39-472f-9b97-e58dfa5ac376.png` | 2×2 | PNG 1536×1024; alpha nas bordas |

## Integração limitada

- `main.gd` carrega os seis arquivos de `assets/runtime_v2/` para Lolth, carroça, pickups, VFX e Thornwake.
- O renderer de Lolth usa a grade 3×3 unificada para idle, movimento, golpe, esquiva, coleta, ar e hurt.
- Thornwake não desenha ou colide mais com plataformas comuns; o chão base é contínuo.
- Arquivos em `assets/art/` não foram movidos, sobrescritos ou excluídos.

## Validação

- O Godot importou os seis novos PNGs.
- `D:\Godot\godot.exe --headless --path . -- --self-test` retornou `SELF_TEST_PASS`.
- O modo editor relatou apenas falhas de gravação no cache global do Godot fora do projeto; a importação do projeto concluiu.

## Revisão pendente

Falta uma inspeção humana da cena em 1280×720 para aceitar a leitura visual, a escala e a continuidade do chão. Os assets legados preservados são o caminho de rollback.

## Revisão concluída

Aprovação humana recebida em 2026-10-03. `runtime_v2` passa a ser o núcleo visual vigente de Thornwake; os arquivos legados permanecem disponíveis apenas como rollback.
