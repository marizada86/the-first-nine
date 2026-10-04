---
status: complete-user-approved-documentation
kind: opus-technical-package-reconciliation-plan
created: 2026-10-03
approval_mode: per-plan
approval_selection: user-explicit-2026-10-03
approval_source: user-explicit
sources:
  - '[[2026-10-03-opus-production-package]]'
  - '[[2026-10-03-opus-sprite-animation-contract]]'
  - '[[2026-10-03-opus-world-tile-contract]]'
  - '[[2026-10-03-opus-integration-audio-map]]'
  - '[[2026-10-03-p5-individual-monster-sprite-masters-plan]]'
  - '[[2026-10-03-p11-route-landmark-masters-plan]]'
---

# Plano P12 — reconciliação do pacote técnico do Opus

## Objetivo

Atualizar o handoff técnico do Opus para refletir os 108 masters vigentes de P0–P11 e tornar explícita a conversão de cada família em arte de runtime futura.

## Escopo

1. Atualizar o índice e a ordem de produção para P0–P11.
2. Estender o inventário e a matriz de conversão para monstros individuais, personagens individuais, props de salvamento, VFX, props regionais, interface e marcos de rota.
3. Acrescentar contratos de conversão por família: atlas ou layers, célula/escala proposta, pivô, estados mínimos, colisão externa e consumidor futuro.
4. Atualizar o checklist de admissão para exigir proveniência de master, transparência, leitura em 1280×720 e nenhum overwrite de referência.
5. Registrar a cobertura e os itens deliberadamente adiados: dimensões finais de célula, recortes, sprites finais, áudio, importação e cenas Godot.

## Regras vinculantes

- Masters continuam sendo referências; nunca se tornam spritesheets, tiles ou assets Godot por esta reconciliação.
- A carroça continua aberta, sem cavalo e sem quartos; a rota permanece horizontal e contínua, com bloqueios especiais de teia.
- Drows curados permanecem assistências contextuais; nenhuma ficha técnica pode convertê-los em personagens controláveis.
- Marcas preservam Shar → Lolth e a Marca IX é final, não cura adicional.
- Não serão alterados lore, mecânicas, código, cenas, dependências, permissões ou arquivos em `assets/`/`res://`.

## Não escopo

Geração de arte, redesenho, recorte, normalização binária, atlas final, importação Godot, implementação, áudio, colisão real, balanceamento, publicação ou despacho ao Opus.

## Aceitação

- Os 108 itens do manifesto recebem cobertura explícita no pacote técnico, diretamente ou por família de conversão claramente identificada.
- P5–P11 aparecem na fila de produção e no handoff, sem sobrescrever o histórico P0–P4.
- Os documentos continuam distinguindo referência aprovada, candidato de produção e asset admitido no runtime.
- Todos os links internos atualizados resolvem localmente.

## Gaps

- **BLOCKING:** nenhum para documentação técnica.
- **RESOLVABLE:** master heterogêneo será normalizado por contrato de família, sem fixar dimensões de célula finais antes de uma prova no Godot.
- **DEFERRED:** recorte, dimensões finais, geração dos sprites finais, importação, cenas consumidoras, áudio e validação jogável.

## Plano de voo

1. Auditar o manifesto vigente e os documentos técnicos já preparados.
2. Atualizar os documentos de handoff e contratos para P0–P11.
3. Validar contagem, cobertura e links; registrar a evidência.
4. Não executar admissão no runtime; encaminhar o pacote atualizado para aprovação humana.

## Execução autorizada

O plano foi aprovado em 2026-10-03 no modo `per-plan`. A aprovação autoriza somente a reconciliação documental descrita acima.

## Execução concluída, revisão pendente

O contrato reconciliado, o brief P5–P11, o registro de cobertura, o índice, o README e o checklist foram atualizados. A validação confirmou 108 fontes resolvidas e nenhuma alteração no runtime. A aprovação humana deste resultado ainda é necessária para encerrar o plano.

## Revisão aprovada

Aprovação humana recebida em 2026-10-03. P12 encerrado com o handoff técnico P0–P11 vigente, sem admissão de assets no Godot.
