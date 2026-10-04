---
status: completed
kind: implementation-plan
created: 2026-10-02
depends_on:
  - '[[2026-10-02-compact-salvage-exploration]]'
  - '[[2026-10-02-lolth-mark-rpg-adaptation]]'
  - '[[2026-10-02-lolth-recovered-load]]'
  - '[[2026-10-02-cross-input-controls]]'
approval_required: true
approved: 2026-10-02
completed: 2026-10-02
---

# Plano de voo — Salvage micro-metroidvania

## Resultado pretendido

Uma partida curta de plataforma e ação com Lolth, jogável por teclado, teclado/mouse e controle. Ela explora três áreas verticais compactas, recupera recursos dentro de `RECOVERED LOAD`, combate sombras com leitura clara e abre atalhos por meio das Marcas.

## Escopo de implementação

1. Substituir o movimento plano por corrida, pulo, gravidade e colisão de plataforma.
2. Implementar as ações equivalentes de entrada: mover, pular, primária, sombra, acampamento/carga e pausa.
3. Trocar falha por contato por vida curta de Lolth, ataques telegráficos de inimigos e checkpoint ao esgotar a vida.
4. Implementar `RECOVERED LOAD`: dois slots no início, capacidade derivada de `Might`, itens leves e volumosos, lista contextual no acampamento e restauração pelo checkpoint.
5. Implementar como gates principais apenas `FIRST THREAD`, `VELVET VEIL`, `NIGHT CHOIR`, `DEEP HUNGER` e `SPIDER'S PROMISE`; as demais Marcas atualizam status, aparência ou versões existentes.
6. Converter cada trecho em uma área vertical curta com uma rota principal, uma rota opcional de recuperação e um atalho de retorno à carroça.
7. Atualizar HUD, tutorial, README, testes automatizados e evidências; executar teste humano para os três modos de entrada.

## Não objetivos

Sem mapa amplo, minimapa, combate profundo, múltiplas armas, árvore de habilidades, inventário em grade, suporte para remapeamento nesta jam, novas dependências ou ativos externos.

## Critérios de aceitação

1. Uma partida completa funciona em teclado, teclado/mouse e controle sem ação exclusiva.
2. Lolth pode mover, pular, atacar, interagir e executar uma ação de sombra.
3. O jogador começa com dois slots de carga e recebe mais por `Might` conforme as Marcas previstas.
4. Ao menos uma área usa pulo/dash, uma usa percepção de ecos e uma usa quebra/teia como gate de `Salvage`.
5. Uma derrota de Lolth retorna ao checkpoint; todos os nove são restaurados.
6. A rota automatizada passa e a verificação humana cobre os três modos de entrada, controles, carga, legibilidade e duração.

## Riscos e mitigação

- **Escopo:** priorizar um único quarto vertical polido por trecho e reutilizar plataformas/ameaças.
- **Controles:** usar ações semânticas e prompts contextuais, não caminhos de entrada separados.
- **Progressão:** não transformar cada uma das nove Marcas em novo botão.
- **Sensação de plataforma:** validar pulo, coyote time e buffer de entrada antes de construir os três trechos.
