---
status: approved
kind: asset-reference-batch
created: 2026-10-03
approved: 2026-10-03
approval_source: user-explicit
mode: guided
depends_on:
  - '[[2026-10-03-master-production-rebuild]]'
  - '[[2026-10-03-production-reset-and-opus-handoff]]'
---

# Lote visual A — quadro mestre e materiais

## Escopo aprovado

Gerar e validar automaticamente duas referências de linguagem visual: um quadro mestre 2D pixel art e uma prancha de paleta/materiais. As duas saídas ficam em `.atena/generated/` para revisão; não são assets finais, não entram em `res://`, não substituem referências existentes e não autorizam implementação.

## Critérios de aceitação

1. O quadro mestre contém Lolth, carroça, um inimigo de Thornwake, pickup recuperável, espaço de HUD e três planos de profundidade.
2. A prancha torna explícitas as rampas de valor e materiais de madeira, metal, corda, pedra, fungo e vidro.
3. As duas imagens mantêm noite azul-violeta, sombra quase preta/violeta e contraste de fogo âmbar/dourado.
4. Não há texto de UI, watermark, logotipo, sprite sheet final nem importação no runtime.
5. O recibo registra prompt, tentativas, validação, proveniência e divulgação de IA.

## Plano de voo

1. Validar o manifest JSON aprovado do batch-image-autopilot.
2. Gerar candidatos versionados sem usar imagens de terceiros como entrada.
3. Inspecionar composição, contraste, presença/ausência de elementos e adequação a 1280×720.
4. Repetir apenas o item que falhar, até duas tentativas; registrar exceções sem ampliar o escopo.
5. Salvar o recibo e atualizar o estado Atena.

## Gaps

- **BLOCKING:** nenhum. A autorização explícita cobre geração e curadoria deste lote delimitado.
- **RESOLVABLE:** célula e pivô ficam como proposta `TBD-A`, pois este é o objetivo de avaliação da referência.
- **DEFERRED:** aprovação humana para transformar a referência aceita em direção final, todos os lotes B–J e qualquer admissão no runtime.

## Validação e evidência

Validador de manifest do skill, inspeção visual de cada saída, registro de hashes e recibo em `.atena/generated/2026-10-03-visual-language-a/`.
