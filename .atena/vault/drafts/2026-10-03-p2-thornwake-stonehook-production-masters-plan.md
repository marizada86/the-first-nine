---
status: proposed
kind: production-asset-masters
created: 2026-10-03
approval_mode: per-plan
depends_on:
  - '[[2026-10-03-p0-loop-production-masters-plan]]'
  - '[[2026-10-03-minimal-stonehook-reference-refresh]]'
  - '[[2026-10-03-minimal-world-transitions-batch-l]]'
---

# Plano — P2 masters técnicos de Thornwake e Stonehook

## Objetivo

Produzir cinco masters técnicos para o primeiro trecho regional: terreno, props, risco, inimigos e chefes de Thornwake/Stonehook. Nenhum atlas, tile ou cena será admitido no Godot.

## Escopo

1. Master de terreno Thornwake: terra, espinho, tronco, água rasa e bordas.
2. Master de terreno Stonehook: ardósia, scree, penhasco, corda e bordas.
3. Props/risco compartilhados: pickup, abrigo, barricada, queda e deslizamento.
4. Master de ameaças regulares: Briar Hound, Stag of Mire, Scree Crawler e Cliff Harrier.
5. Master de chefes: Antlered Hunger e Stone Maw, não humanoides e com leitura de escala.

## Contratos técnicos propostos

- Terreno/props: blocos-base de 32×32 px; bordas e sobreposições em camadas separadas.
- Ameaças regulares: células de 48×48 px; chefe: master de 96×96 px ou maior conforme silhueta.
- Pivô inferior comum; colisores, navegação e dano ficam fora da arte.
- Stonehook preserva a transição gradual vinda de Thornwake.

## Não escopo

- Atlas final, importação Godot, código de IA, colisão, navegação, spawn, balanceamento, mapas completos ou outros capítulos.

## Aceitação

- Cinco PNGs de master sem texto/watermark.
- Terreno, rota, risco e pickup distinguíveis; inimigos não confundidos com sombras genéricas.
- Sem UI, cavalo, nova mecânica ou admissão em runtime.

## Gaps

- **BLOCKING:** nenhum.
- **RESOLVABLE:** tamanho final de chefe será validado na futura captura 1280×720.
- **DEFERRED:** tileset recortado, colisão, IA, cena e testes Godot.

## Plano de voo

1. Gerar os cinco masters P2, até duas tentativas por item.
2. Validar leitura modular e silhuetas regionais.
3. Registrar recibo/evidência e aguardar curadoria humana.
