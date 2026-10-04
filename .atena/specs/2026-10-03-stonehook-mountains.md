---
status: approved
kind: implementation-specification
created: 2026-10-03
approved: 2026-10-03
intent: '[[2026-10-02-thalestriel-exodus-game-intent]]'
depends_on:
  - '[[2026-10-03-thornwake-playable-chapter]]'
  - '[[2026-10-03-mark-route-stonehook-and-progression-decisions]]'
---

# The First Nine — Stonehook Mountains

## Objetivo

Construir o segundo capítulo jogável: uma travessia montanhosa em que Lolth obtém eixo e freios para a carroça, enfrenta perigos de queda e deslizamento, alcança a Marca II e escolhe o segundo drow a despertar.

## Escopo

- Transição legível a partir do encerramento de Thornwake.
- Mapa montanhoso com encostas, quedas, trechos de corda e rotas alternativas pequenas, sem mundo aberto.
- Recursos de metal, corda e ferramentas; oficina com reparo de eixo/freios.
- Scree Crawlers, Cliff Harriers e Stone Maw, com respostas próprias para ataque e esquiva.
- Defesas e postos de drows compatíveis com o limite de dois ativos.
- Encontro de Marca II, segunda escolha de cura e checkpoint posterior.

## Fora de escopo

- Hollowroot Caverns como mapa jogável.
- Melhorias das Marcas III, V e VII.
- Arte final, chefe cinematográfico, árvore de habilidades, seguidores controláveis ou expansão do inventário.

## Critérios de aceitação

1. Após o fim de Thornwake, o jogador alcança Stonehook com objetivo, requisitos e peça da carroça claros.
2. Queda, deslizamento e corda criam decisões de percurso sem morte inevitável ou bloqueio permanente.
3. O jogador coleta os recursos de Stonehook, fabrica/instala eixo e freios e entende seu efeito na carroça.
4. Cada inimigo tem uma leitura de movimento e uma resposta distinta para o kit inicial de Lolth.
5. A Marca II permite escolher e despertar exatamente um segundo Thalestriel, criando checkpoint completo.
6. Autotestes verificam travessia, recursos, reparo, combate, Marca II e restauração de checkpoint.

## Impactos previstos

- Dados de zona, recursos, inimigos e objetivos passam a comportar Stonehook sem remover Thornwake.
- O estado da carroça passa a registrar eixo/freios, além do reparo anterior.
- HUD e oficina comunicam progresso da peça montanhosa e risco de travessia.

## Gaps

- **BLOCKING:** nenhum.
- **RESOLVABLE:** os números definitivos de dano, queda e recursos dependem da partida visual humana; valores atuais permanecem parâmetros de balanceamento.
- **DEFERRED:** arte final, Hollowroot e as melhorias das Marcas III, V e VII.

## Plano de voo proposto

1. Auditar a transição de Thornwake e estruturar dados de capítulo para Stonehook.
2. Construir terreno, plataformas, quedas, cordas e recuperação segura de falhas.
3. Adicionar recursos, receitas e instalação de eixo/freios.
4. Implementar as três ameaças e sua leitura de combate.
5. Integrar postos, defesa noturna, encontro de Shar, Marca II e segunda cura.
6. Executar autotestes com `D:\Godot\godot.exe`, validar visualmente, registrar evidência e reconciliar documentos.

## Reconciliation

Ao concluir, registrar os testes do Godot, atualizar o estado de plano e manter a validação visual humana como pendência explícita se a janela de jogo não estiver disponível neste ambiente.

## Resultado de implementação — 03/10/2026

- O encerramento de Thornwake agora permite viajar para Stonehook Mountains.
- Stonehook possui encostas de scree que deslocam Lolth, duas rotas de corda e terreno de plataformas para uma travessia sem mundo aberto.
- Minério, corda e ferramenta de freio permitem fabricar e instalar **Axle & Brakes** na carroça.
- Scree Crawler, Cliff Harrier e Stone Maw possuem comportamentos próprios; o Stone Maw libera o santuário da Marca II após o reparo.
- A Marca II abre a segunda cura e encerra o capítulo com a passagem para Hollowroot explicitada, sem construir Hollowroot.
- O autoteste e a abertura headless do editor Godot passaram; ver `[[2026-10-03-stonehook-mountains]]` em `evidence`.

## Pendência humana

A partida visual humana continua necessária para calibrar escalas das encostas, resposta das cordas, agressividade dos monstros e leitura de HUD.
