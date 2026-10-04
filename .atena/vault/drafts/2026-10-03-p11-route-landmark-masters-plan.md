---
status: complete-user-approved-reference-only
kind: route-landmark-reference-master-plan
created: 2026-10-03
approval_mode: per-plan
approval_selection: user-explicit-2026-10-03
approval_source: user-explicit
sources:
  - '[[2026-10-03-five-region-route-crafting-and-marks]]'
  - '[[2026-10-03-caravan-survival-slow-travel]]'
  - '[[2026-10-03-continuous-caravan-ground-and-web-gates]]'
  - '[[2026-10-03-shadow-to-lolth-mark-visual-progression]]'
---

# Plano P11 — masters de marcos de rota

## Objetivo

Criar referencias individuais para pontos de interesse laterais que tornam a rota continua legivel: locais de salvamento, apoio a carroca, defesa e ancoras narrativas das Marcas.

## Escopo

Criar 10 PNGs transparentes, em pixel art minimalista lateral:

1. deposito drow abandonado de suprimentos recuperaveis;
2. clareira de ervas e agua de Thornwake;
3. pilha de metal e cordas de Stonehook;
4. oficina de campo arruinada para reparo;
5. ponto de defesa com braseiro e barreira recuperada;
6. ancora de Marca de Thornwake;
7. ancora de Marca de Stonehook;
8. ancora de Marca de Hollowroot;
9. ancora de Marca de Glass Dunes;
10. ancora de Marca de Dreamwater.

## Regras vinculantes

- Os marcos ficam sobre ou ao lado de chao horizontal continuo; nenhum cria abismo, salto, plataforma flutuante ou troca de mapa.
- As ancoras de Marca usam sombra, lua velada de Shar e fios que apontam gradualmente para a aranha de Lolth, sem mudar a progressao ou conceder uma cura extra.
- Salvamento comunica materiais ja canonicos: madeira, ervas, agua, metal, corda e ferramentas. Nao cria moedas, inventario novo, cavalo ou quartos na carroca.
- Defesa comunica braseiro, barricada e alarme de corda; nao vira torre, base permanente ou novo combate automatico.
- Cada master e apenas uma referencia visual; nao define colocacao, frequencia, interacao, custo, colisao ou balanceamento.

## Nao escopo

Terreno modular, tileset, atlas, mapas, UI, textos finais, logica de coleta, receitas, spawn, navegacao, runtime, importacao ou alteracao no Godot.

## Aceitacao

- Dez PNGs individuais transparentes em `.atena/generated/`.
- Silhuetas laterais, paletas curtas e leitura minimalista consistente com os masters aprovados.
- Os cinco marcos de Marca seguem o arco visual Shar → Lolth e nao representam a Marca IX como cura.
- Nenhuma referencia contradiz rota continua, carroca sem cavalo/sem quartos, ou assistencia contextual dos drows.
- Os masters permanecem fora de `assets/` e `res://` ate um plano tecnico separado.

## Gaps

- **BLOCKING:** nenhum para referencias visuais.
- **RESOLVABLE:** a distribuicao exata das oito Marcas entre regioes continua aberta; estes cinco objetos serao ancoras regionais genericas, nao Marcas numeradas.
- **DEFERRED:** tiles, escalas finais, areas de interacao, frequencia, recompensas, colisao, balanceamento e admissao Godot.

## Plano de voo

1. Gerar os dez masters fora do projeto runtime.
2. Validar transparência, lateralidade, leitura dos materiais e limites canonicos.
3. Solicitar curadoria humana e, se aprovada, vincular os arquivos ao manifesto de referencias do Opus.

## Execucao autorizada

- Aprovacao por plano recebida em 2026-10-03 para os dez masters listados neste documento.
- A curadoria humana continua obrigatoria antes de qualquer vinculacao ao manifesto do Opus.
- Dez masters foram gerados e passaram na validacao de transparencia e limites canonicos; aguardam curadoria humana.
- Curadoria humana aprovada em 2026-10-03; os dez masters foram vinculados ao manifesto de referencias do Opus, sem admissao no Godot.
