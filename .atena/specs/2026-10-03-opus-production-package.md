---
status: complete-prepared-not-admitted
kind: production-specification-package
created: 2026-10-03
approved: 2026-10-03
approval_mode: per-plan
---

# Pacote de produção técnica — Opus

## Resultado

Este pacote transforma as referências aprovadas em uma fila de produção técnica. Nenhum item desta especificação está admitido no runtime; o Opus deve executar cada item somente sob um plano de integração separado.

## Ordem de produção

| Prioridade | Entrega | Necessária para |
| --- | --- | --- |
| P0 | Lolth, carroça aberta, materiais, pickups, ataque e hit | loop de exploração, salvamento e combate |
| P1 | drows `plagued`/`cured`, cura, puxar, defesa e oficina | sobrevivência, cura e viagem lenta |
| P2 | tiles/props de Thornwake e Stonehook + inimigos | primeiro trecho expandido |
| P3 | Hollowroot, Glass Dunes, Dreamwater e transições | progressão regional contínua |
| P4 | Marcas, Shar e Plano dos Sonhos | narrativa e final |

## Entregas vinculadas

- Inventário mestre: `[[2026-10-03-opus-asset-inventory]]`
- Contrato de sprites/animação: `[[2026-10-03-opus-sprite-animation-contract]]`
- Contrato de cenário/tile: `[[2026-10-03-opus-world-tile-contract]]`
- Mapa de integração e áudio: `[[2026-10-03-opus-integration-audio-map]]`

## Portão de admissão

Antes de qualquer arquivo entrar no Godot, uma etapa futura deve validar: arquivo novo/versionado, importação, pivô, colisão, cena consumidora, captura 1280×720, rollback e teste de gameplay. Este pacote não autoriza essa admissão.
