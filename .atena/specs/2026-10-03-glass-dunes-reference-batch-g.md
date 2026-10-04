---
status: approved
kind: asset-reference-batch
created: 2026-10-03
approved: 2026-10-03
approval_source: user-explicit
depends_on:
  - '[[2026-10-03-visual-language-a-approval]]'
  - '[[2026-10-03-five-region-route-crafting-and-marks]]'
  - '[[2026-10-03-mark-route-stonehook-and-progression-decisions]]'
---

# Lote G — The Glass Dunes

## Escopo

Cinco referências de revisão: panorama de dunas, ruínas e abrigo; água, lona e vidro reaproveitável; exposição, sede e areia cortante; Glass Scorpion e Dune Strider; Sunken Colossus.

## Contratos preservados

- Glass Dunes é a quarta região: administrar água, abrigo e travessia exposta.
- Água, lona, vidro e ruínas são leitura visual de recursos e contexto; não definem a peça material ainda aberta.
- Glass Scorpions, Dune Striders e Sunken Colossus são monstros próprios da região, não sombras.
- Marcas V e VI, quinta/sexta curas e rota a Dreamwater ficam fora destes assets de referência.

## Aceitação

- Linguagem A em pixel art 2D dark fantasy: contraste de dunas, ruínas e horizonte; calor/exposição representados sem perder a paleta do jogo.
- Água e abrigo se distinguem de areia cortante e risco ambiental.
- Sem texto, watermark, UI final, sprite/atlas, colisão, pivô, tile ou runtime.

## Impactos

Somente cinco PNGs de referência, manifesto e recibo sob `generated/2026-10-03-glass-dunes-reference-batch-g/`. Nenhuma mudança em `res://`, código, cenas, dados, mecânicas ou cânone.

## Gaps

- **BLOCKING:** nenhum para referências visuais.
- **RESOLVABLE:** a linguagem de água, abrigo e materiais será ambiental; não especificará receitas, consumo ou mecânicas de sobrevivência.
- **DEFERRED:** peça material, números de água/exposição/dano, Marcas V–VI, curas, colisão, tiles, sprites, atlas e implementação.

## Plano de voo

1. Criar e validar manifesto de cinco itens, com no máximo duas tentativas por item.
2. Gerar e curar panorama, props, riscos, inimigos regulares e chefe.
3. Registrar prompts, tentativas, verificações, hashes e proveniência.
4. Atualizar estado e evidência, mantendo qualquer admissão no runtime diferida.

## Aprovação solicitada

Autorizar a geração e curadoria automatizada destas cinco referências, dentro deste escopo e limites.

## Resultado

Geração e curadoria automatizada concluídas em 03/10/2026. As cinco referências foram aceitas; o Sunken Colossus exigiu uma segunda tentativa para remover anatomia humanoide. Recibo: `[[2026-10-03-glass-dunes-reference-batch-g]]`.

## Decisão posterior

Após a curadoria, o usuário aprovou explicitamente a primeira variante humanoide do Sunken Colossus como referência visual. Essa decisão substitui a forma bestial apenas como direção visual do chefe; ver `[[2026-10-03-sunken-colossus-humanoid-reference-approval]]`.
