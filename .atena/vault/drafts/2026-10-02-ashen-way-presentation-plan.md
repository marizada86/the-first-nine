---
status: approved
kind: implementation-plan
created: 2026-10-02
depends_on:
  - '[[2026-10-02-salvage-gameplay-pillar]]'
  - '[[2026-10-02-compact-salvage-exploration]]'
approval_required: true
approved: 2026-10-02
---

# Plano de voo — apresentação de Ashen Way

## Objetivo

Fazer de `ASHEN WAY` a referência visual final do vertical slice: uma área de plataforma de Salvage legível, melancólica e coesa com o acampamento, Lolth e a Marca das Sombras.

## Fontes de arte locais

- `assets/art/characters/lolth-elf-gameplay-poses-v1.png`: poses de Lolth para repouso, corrida, interação e ataque.
- `assets/art/camp/last-camp-prop-sheet-v1.png`: carroça, chama e props do acampamento.
- `assets/art/vfx/shadow-mark-effects-v1.png`: sinais da Marca, impacto e sombra.

Arte em `assets/concept-art/` e `assets/references/` permanece como direção visual; ela não será colocada diretamente no runtime sem uma decisão de produção específica.

## Plano de implementação

1. Auditar transparência, resolução e regiões úteis das três folhas de arte runtime; registrar os recortes escolhidos.
2. Integrar Lolth no loop de repouso, corrida, salto, ação primária, dano e dash, sem alterar colisão nem controles.
3. Substituir a carroça geométrica e os sobreviventes provisórios pelos props de acampamento; manter leitura de chama, grupo e reparo.
4. Aplicar VFX de Marca em ataque, dash, coleta e gates; reforçar ouro quente, ruína azul e sombra violeta.
5. Tratar plataformas, ruínas, itens recuperáveis e inimigos como silhuetas legíveis, usando os props e paleta já aprovados antes de criar qualquer asset novo.
6. Ajustar HUD e prompts para reduzir ruído e preservar leitura durante exploração.
7. Validar uma rota completa e capturar evidência visual de `ASHEN WAY`.

## Limites

- Não gerar arte nova, não adicionar dependências, áudio ou efeitos de pós-processamento.
- Não usar arte de referência/conceito como sprite final sem aprovação.
- Não alterar regras de jogo, capacidade de carga, progressão ou mapas nesta etapa.

## Critérios de aceitação

1. Lolth, a carroça e a Marca deixam de ser formas geométricas provisórias em `ASHEN WAY`.
2. As poses de Lolth distinguem pelo menos repouso, movimento e ação.
3. A carroça continua comunicar chama, sobreviventes e reparo à primeira vista.
4. Recursos, plataformas, inimigos e gates permanecem legíveis em movimento.
5. A rota automatizada continua passando e uma inspeção humana confirma coerência visual.
