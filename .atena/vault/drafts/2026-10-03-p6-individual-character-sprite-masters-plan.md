---
status: complete-user-approved-reference-only
kind: individual-character-sprite-master-plan
created: 2026-10-03
approval_mode: per-plan
approval_selection: user-explicit-2026-10-03
sources:
  - '[[2026-10-03-minimal-character-visual-direction]]'
  - '[[2026-10-03-full-trousers-character-skin-rule]]'
  - '[[2026-10-03-thalestriel-contextual-assists]]'
---

# Plano P6 - sprites individuais de Lolth e Thalestriel

## Objetivo

Criar masters transparentes individuais para Lolth em suas duas leituras e os oito Thalestriel antes/depois da cura. Esses masters permitem ao Opus converter o elenco em atlas sem inventar identidade, escala ou funcao.

## Escopo

1. Lolth elfica: idle, corrida, ataque, dano.
2. Lolth drow: idle, corrida, ataque de sombra, puxar carroca.
3. Oito Thalestriel `plagued`: postura sentada/abrigada e passageiro, sem violencia grafica.
4. Oito drows `cured`: postura de posto ligada a sua assistencia e defesa contextual; sem leitura de personagem controlavel.
5. Um arquivo por personagem/estado: 18 masters no total.

## Aliados e postos

Aelira forrageia; Vaelun porta carga; Nimara explora; Thaviel sustenta a chama; Ilyren repara; Orisya cura; Soreth vigia; Luraen revela passagens oniricas.

## Travas visuais

- Todos compartilham baseline 1,00; diferenciam-se por silhueta, postura, roupa e no maximo um prop funcional.
- Calcas opacas e completas da cintura ate as botas, sem pele exposta sob a roupa, para Lolth e todo Thalestriel.
- Perfil lateral, fundo transparente, grandes grupos de pixels, paleta curta e leitura a 24-40 px.
- Drows curados sao contextuais: nao recebem armas, combo, inventario, IA de acompanhante ou pose de personagem selecionavel.

## Nao escopo

Atlas final, recorte definitivo, importacao Godot, colisores, animacao de runtime, UI de posto, novas assistencias, mudanca de nomes/lore ou controle dos drows.

## Aceitacao

- Dezoito PNGs versionados em `.atena/generated/`.
- Lolth possui poses de gameplay separadas por forma; cada aliado aparece antes e depois da cura sem troca de identidade ou escala.
- Nenhum personagem mostra pele por baixo de calca/vestimenta inferior.
- Candidatos permanecem fora do Godot, aguardando curadoria humana.

## Gaps

- **BLOCKING:** nenhum para masters de referencia.
- **DEFERRED:** ordem exata de cura, recorte de atlas, numero final de frames, pivots e cenas de runtime.

## Execucao

- Aprovacao recebida em 2026-10-03, no modo `per-plan`.
- Dezoito masters foram gerados em `.atena/generated/2026-10-03-p6-individual-character-sprite-masters/`.
- Todos os PNGs foram conferidos como `Format32bppArgb`, com pixels transparentes nas bordas.
- A curadoria humana foi aprovada em 2026-10-03; os masters entraram no manifesto de referencia do Opus.
- A admissao no Godot permanece fora do escopo e pendente de plano proprio.
