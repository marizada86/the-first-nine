---
status: complete-user-approved-runtime-migration
kind: thornwake-threat-runtime-migration-plan
created: 2026-10-03
approval_mode: per-plan
approval_selection: user-explicit-2026-10-03
approval_source: user-explicit
sources:
  - '[[2026-10-03-p5-individual-monster-sprite-masters-plan]]'
  - '[[2026-10-03-thornwake-caravan-action-loop-implementation]]'
  - '[[2026-10-03-runtime-art-readiness-audit]]'
---

# Plano P15 — migração runtime das ameaças de Thornwake

## Objetivo

Substituir o `Shade` genérico por Briar Hound, Stag of Mire e Antlered Hunger em `runtime_v2`, preservando ondas, alvo da carroça, combo e demais regras existentes.

## Escopo

1. Criar três folhas transparentes 2×2 em `assets/runtime_v2/enemies/thornwake/`: idle, mover, atacar e derrota.
2. Registrar proveniência P5, grids, pivôs e disclosure no manifesto `runtime_v2`.
3. Atualizar o renderer para escolher a folha por ameaça, sem alterar spawn, dano, comportamento ou balanceamento.
4. Remover apenas o preload do `Shade` do caminho ativo; manter seus PNGs legados intactos.
5. Rodar importação, autoteste e revisão humana visual.

## Regras vinculantes

- Briar Hound persegue Lolth; Stag of Mire permanece o agressor da carroça; Antlered Hunger é elite.
- Nenhuma ameaça vira espécie genérica de sombra, personagem jogável ou mecânica nova.
- Pixel art lateral minimalista, fundo transparente, silhueta clara e sem texto/UI.
- Não altera Lolth, carroça, HUD, regiões posteriores, Marcas ou sistema de ondas.

## Não escopo

Outros doze monstros P5, chefes de outras regiões, aliados, áudio, balanceamento, exclusão de legado e publicação.

## Aceitação

- Três PNGs novos, versionados, com alpha e grade 2×2 verificáveis.
- Cada ameaça ativa mostra sua identidade visual em Thornwake.
- Autoteste continua passando; rollback é restaurar somente os dois preloads legados de `Shade`.

## Gaps

- **BLOCKING:** nenhum para esta substituição visual.
- **DEFERRED:** ajuste humano de leitura, demais regiões e as doze ameaças restantes.
