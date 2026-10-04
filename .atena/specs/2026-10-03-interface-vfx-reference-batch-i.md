---
status: complete-user-approved-reference-only
kind: asset-reference-batch
created: 2026-10-03
depends_on:
  - '[[2026-10-03-visual-language-a-approval]]'
  - '[[2026-10-03-master-asset-reference-manifest]]'
---

# Lote I — interface e VFX

## Escopo

Quatro pranchas de referência: HUD de jogo; oficina/estoque no acampamento; Marcas, Echoes e retratos de postos; VFX de sombra e Echoes.

## Contratos preservados

- A HUD comunica vida, carga, ciclo, carroça/chama, Echoes, objetivo e prompt contextual.
- A oficina comunica estoque, receitas, condição e postos; o acampamento é o checkpoint fixo.
- Drows continuam ser assistência contextual, não personagens controláveis.
- VFX de sombra/Echoes não encobrem alvos ou telegraphs.

## Aceitação

- Pixel art 2D dark fantasy de alto contraste, legível em referência de 1280×720.
- Sem texto gerado, watermark, código, sprites finais, atlas, lógica, dependência ou runtime.
- As pranchas descrevem linguagem visual, não implementam interfaces nem redefinem mecânicas.

## Gaps

- **BLOCKING:** nenhum para referências.
- **RESOLVABLE:** textos finais e controle específico continuam omitidos; serão representados por blocos sem texto.
- **DEFERRED:** layout responsivo, entradas, acessibilidade final, números, estados de implementação, sprites/atlas e runtime.

## Plano de voo

1. Validar manifesto com quatro referências e até duas tentativas por item.
2. Gerar e curar as quatro pranchas.
3. Registrar prompts, tentativas, hashes e proveniência; não admitir nada em `res://`.

## Aprovação solicitada

Autorizar a geração e curadoria automatizada das quatro referências deste lote.
