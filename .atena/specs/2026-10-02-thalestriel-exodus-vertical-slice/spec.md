---
status: superseded
intent: '[[2026-10-02-thalestriel-exodus-game-intent]]'
created: 2026-10-02
plan_approved: 2026-10-02
---

# Spec — Vertical slice: Thalestriel — Êxodo Dourado (superseded)

## Objetivo

Entregar um vertical slice jogável que prove o loop de salvamento e sobrevivência da caravana: explorar, recuperar uma peça, voltar ao refúgio, usar a peça para prosseguir e alcançar o portal final.

## Escopo

- Um personagem controlável em 2D.
- Uma caravana/refúgio com chama visível e um medidor de chama.
- Três trechos curtos: saída da Cidade Dourada, travessia hostil e margem do portal.
- Itens recuperáveis com pelo menos dois usos: reparar/progredir ou manter a chama.
- Uma escolha final entre suprimento e relíquia narrativa.
- Vitória ao atravessar o portal para o Plano dos Sonhos e derrota se a chama se apagar.

## Não objetivos

- Combate complexo, inventário em grade, árvore de habilidades, geração procedural, múltiplos finais ou mapa aberto.
- Consolidar ou modificar a lore de Nottgard.
- Escolher, instalar ou configurar uma engine sem aprovação específica.

## Critérios de aceitação

1. Uma pessoa consegue concluir uma partida do início à cena final sem instrução externa.
2. Em cada trecho, o jogador precisa recuperar e aplicar ao menos um recurso para progredir ou preservar a chama.
3. O jogador recebe feedback claro ao recuperar, transportar, aplicar e perder um item.
4. A chama pode levar à derrota e a cena do portal só ocorre se a caravana sobreviver.
5. Uma partida de teste dura entre 5 e 10 minutos.

## Impactos e riscos

- A escolha da engine e de ferramentas ainda não foi aprovada; isso bloqueia a implementação.
- A pesquisa sobre o Plano dos Sonhos não deve ser apresentada como nova verdade canônica de Nottgard.
- O maior risco é ampliar o survival além de um único recurso central.
- Regras externas aplicáveis foram consolidadas em `[[eclipse-publishing-jam-rules]]`: antes da submissão, ainda é necessário auditar autoria e data do conteúdo da jam, licenças/créditos de ativos, avisos de conteúdo, build funcional e eventual divulgação de IA.

## Plano de voo proposto

1. Registrar a engine já disponível ou propor uma engine e as dependências necessárias para aprovação.
2. Criar o esqueleto local do projeto e uma cena de teste com movimento, colisão e a caravana.
3. Implementar o loop de recuperação, transporte e aplicação de uma peça.
4. Implementar os três trechos, o consumo da chama e os estados de vitória/derrota.
5. Adicionar feedback visual e sonoro mínimo, testar uma partida completa e registrar evidências.
6. Conferir os critérios de aceitação, revisar desvios de escopo e reconciliar os fatos operacionais.

## Evidências planejadas

- Registro dos testes de partida completa.
- Capturas ou vídeo curto dos estados de jogo.
- Resultado da verificação dos critérios de aceitação.

## Resultado de implementação

- Implementado em Godot 4.7.2, sem dependências adicionais.
- O projeto contém o loop completo de recuperação, transporte e aplicação de peças; a chama, perigos, três trechos e estados de vitória/derrota.
- A validação automatizada do percurso de vitória passou. Ver `[[2026-10-02-automated-playthrough]]`.
- A aceitação visual/manual continua pendente: é necessária uma partida humana para confirmar legibilidade visual, duração de 5–10 minutos e conclusão sem ajuda externa.

## Reconciliação

O vertical slice implementa a intenção aprovada à época. Em 02/10/2026, a intenção foi substituída por **The Last Nine**: os nove Thalestriel sobrevivem e alcançam juntos o Plano dos Sonhos; o jogo é integralmente apresentado em inglês e prevê a escolha entre os nove personagens. Uma nova especificação aprovada será necessária antes de adaptar a implementação a essa direção.
