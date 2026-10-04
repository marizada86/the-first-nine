---
status: complete-user-approved-reference-only
kind: survival-interface-reference-master-plan
created: 2026-10-03
approval_mode: per-plan
approval_selection: user-explicit-2026-10-03
sources:
  - '[[2026-10-03-caravan-survival-slow-travel]]'
  - '[[2026-10-03-shadow-to-lolth-mark-visual-progression]]'
  - '[[2026-10-03-p8-gameplay-vfx-masters-plan]]'
---

# Plano P10 — masters de interface da sobrevivencia

## Objetivo

Criar referencias de interface minimalistas que tornem legiveis os estados canonicos de sobrevivencia sem inventar recursos, poderes, menus de mapa ou controle direto dos drows.

## Escopo

Criar 10 PNGs de referencia de UI, em pixel art minimalista:

1. moldura de leitura de recursos recuperados;
2. faixa dos oito aliados, com estados `plagued` e `cured`;
3. indicador de capacidade da carroca para quatro doentes;
4. leitura de reparo da carroca;
5. selecao de um puxador disponivel;
6. marcadores contextuais de defesa, missao e tracao;
7. aviso de Attraction crescente;
8. trilha de Marcas I–VIII, de Shar a Lolth;
9. destaque da Marca IX final;
10. moldura curta de interacao para coleta, reparo, cura e teia.

## Regras vinculantes

- Interface nao vira mapa do mundo, seletor de regiao ou menu de controle direto dos drows.
- Os estados da carroca permanecem `stationed`, `travel_locked`, `travel_ready` e `travelling`; a interface apenas comunica esses estados.
- Drows curados recebem apenas leitura contextual de funcao, nunca retrato de personagem selecionavel ou barra de combo.
- O aviso de Attraction e legivel, mas representa inimigos concretos e nao substitui sua presenca no mundo.
- Marcas preservam a progressao visual de Shar para Lolth; Marca IX encerra a jornada e nao cura outro aliado.

## Nao escopo

Implementacao de HUD, texto final/localizacao, navegacao, input, save, formulas, logica de atribuicao, efeitos runtime, atlas, shaders, acessibilidade tecnica ou integracao Godot.

## Aceitacao

- 10 masters de UI em `.atena/generated/`.
- Cada referencia comunica um estado existente sem instituir mecanica nova.
- Nenhuma referencia apresenta mapa separado, cavalo, controle de aliado ou cura alem da Marca VIII.
- Referencias ficam fora do Godot, aguardando curadoria humana.

## Gaps

- **BLOCKING:** nenhum para referencias visuais.
- **DEFERRED:** textos finais, inputs, navegacao, escala/adaptacao de tela, acessibilidade e implementacao Godot.

## Execucao

- Aprovacao recebida em 2026-10-03, no modo `per-plan`.
- Dez masters foram gerados em `.atena/generated/2026-10-03-p10-survival-interface-masters/`.
- Todos os PNGs possuem transparencia confirmada nas bordas verificadas.
- Curadoria humana aprovada em 2026-10-03; os masters foram incluidos no manifesto de referencia do Opus.
- Nenhuma admissao no Godot ocorreu.
