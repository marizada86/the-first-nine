---
status: complete-user-approved-reference-only
kind: individual-monster-sprite-master-plan
created: 2026-10-03
approval_mode: per-plan
approval_selection: user-explicit-2026-10-03
approval_source: user-explicit
sources:
  - '[[2026-10-03-five-region-route-crafting-and-marks]]'
  - '[[2026-10-03-minimal-character-visual-direction]]'
  - '[[2026-10-03-opus-final-reference-handoff-plan]]'
---

# Plano P5 - sprites individuais dos monstros

## Objetivo

Criar um master transparente individual para cada uma das quinze ameacas canonicas. Cada master entrega leitura lateral clara e quatro poses de referencia para conversao posterior em atlas: idle, locomocao, ataque e hurt/derrota.

## Escopo

| Lote | Sprites individuais |
| --- | --- |
| B1 - Thornwake | Briar Hound, Stag of Mire, Antlered Hunger |
| B2 - Stonehook | Scree Crawler, Cliff Harrier, Stone Maw |
| B3 - Hollowroot | Chitin Burrower, Sporebound, Hollow Mother |
| B4 - Glass Dunes | Glass Scorpion, Dune Strider, Sunken Colossus |
| B5 - Dreamwater | Reed Eel, Floodborn, The Currentless |

## Travas visuais

- Fundo realmente transparente, perfil lateral e silhueta forte; quatro poses bem separadas, sem UI, texto, watermark ou grade.
- Pixel art minimalista: grupos de pixels grandes, paleta curta, contorno seletivo; nunca pintura detalhada, isometria ou vista superior.
- Cada familia preserva sua regiao e papel: perseguidor, agressor da carroca, elite ou chefe; inimigos nunca sao uma especie generica de sombra.
- Criaturas humanoides vestidas, incluindo o Sunken Colossus, usam tecido opaco continuo ate os pes quando houver calca ou vestimenta inferior.

## Nao escopo

Atlas final, recorte definitivo, importacao Godot, colisores, codigo de IA, balanceamento, animacao em runtime, novos monstros ou alteracao de lore.

## Aceitacao

- Quinze PNGs novos, um por monstro, preservados em `.atena/generated/`.
- Cada arquivo tem as quatro poses em leitura lateral e fundo transparente.
- Nenhum nome, papel mecanico ou familia regional e omitido.
- Os masters sao vinculados ao manifesto Opus, mas nao admitidos no Godot.

## Gaps

- **BLOCKING:** nenhum para masters de referencia.
- **DEFERRED:** tamanho final de celula, numero de frames por pose, atlas, pivot, colisao e teste de combate.

## Plano de voo

1. Gerar cinco pranchas regionais, cada uma com tres sprites individuais e quatro poses por sprite.
2. Inspecionar numero de criaturas, lateralidade, transparência e familia regional.
3. Salvar como quinze masters separados, registrar recibo e atualizar o handoff como candidatos para conversao tecnica.
