---
status: approved
kind: design-reconciliation-plan
created: 2026-10-03
approved: 2026-10-03
request_classification: PLAN_CHANGE_REQUEST
depends_on:
  - '[[2026-10-02-thalestriel-exodus-game-intent]]'
  - '[[2026-10-03-caravan-action-loop-adaptation]]'
  - '[[2026-10-03-visual-language-a-approval]]'
  - '[[2026-10-03-interface-vfx-reference-batch-i]]'
---

# The First Nine — reconciliação de decisões e manifesto de referências

## Objetivo

Auditar cada decisão canônica e especificação aprovada do projeto contra a história, as mecânicas executáveis e o estado atual do runtime. Consolidar os resultados em uma matriz rastreável e em um manifesto de pranchas de referência que possam ser produzidas posteriormente no Opus 5.5.

## Escopo

- Inventariar todos os registros de `vault/canon/` e as especificações relevantes em `specs/`.
- Classificar cada regra como `CONFIRMADA`, `PARAMETRIZÁVEL`, `CONFLITO`, `DEFERIDA` ou `BLOQUEANTE` para referências.
- Ligar cada beat narrativo relevante a uma ação, estado ou comunicação jogável de Lolth, carroça, Marcas, Thalestriel e rota.
- Verificar limites de escopo, referência visual, integridade de IP, proveniência e regras da jam.
- Criar manifesto priorizado de referências para o Opus 5.5, contendo função, leitura, contrato visual, restrições e dependências de aprovação.

## Fora de escopo

- Alterar documentos canônicos, lore, mecânicas aprovadas, runtime, dependências ou o lote ativo de interface/VFX.
- Gerar imagens, prompts finais, assets de runtime, spritesheets, atlas, publicação ou admissão em `res://`.
- Resolver conflitos por inferência: cada conflito de intenção exige uma decisão canônica posterior do usuário.

## Critérios de aceitação

1. Todos os registros canônicos existentes possuem uma linha no registro de reconciliação.
2. Todo conflito ou decisão ausente declara dono, impacto e ação necessária; não há conflito oculto em um prompt de arte.
3. O ciclo de Thornwake é descrito como narrativa jogável, com evidência no runtime quando disponível.
4. O manifesto separa `P0` da vertical slice de capítulos futuros e distingue referência de asset final.
5. O manifesto não agenda geração até a aprovação explícita de seus lotes.
6. O resultado preserva autoria, licença, divulgação de IA e as restrições da jam.

## Gaps

- **BLOCKING:** nenhum para a auditoria. Uma futura geração fica bloqueada enquanto o manifesto não for aprovado por lote.
- **RESOLVABLE:** parâmetros de ritmo/dano e qualidade visual serão anotados como valores de teste, não como alterações de lore.
- **DEFERRED:** validação humana de ritmo, geração no Opus 5.5, produção de sprites/atlas, admissão runtime e as regiões além de Thornwake.

## Plano de voo

1. Inventariar evidências e ler as decisões canônicas e especificações aprovadas.
2. Construir matriz de decisão com impactos narrativos, mecânicos e visuais.
3. Confrontar a matriz com o runtime e o autoteste atual; registrar divergências sem corrigi-las.
4. Consolidar o contrato de experiência da vertical slice e os requisitos visuais que dele decorrem.
5. Produzir manifesto priorizado de referências e portas de aprovação por lote.
6. Validar links, registrar evidência da revisão e pedir uma única aprovação para qualquer resolução canônica e para os lotes de geração escolhidos.

## Evidência prevista

Registro de reconciliação, manifesto de referências, inventário de fontes, resultado de autoteste existente e relatório de links.
