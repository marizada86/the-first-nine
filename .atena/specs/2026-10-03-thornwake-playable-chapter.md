---
status: approved
kind: implementation-specification
created: 2026-10-03
approved: 2026-10-03
intent: '[[2026-10-02-thalestriel-exodus-game-intent]]'
depends_on:
  - '[[2026-10-03-thornwake-foundation]]'
  - '[[2026-10-03-thornwake-combat-economy-and-progression-decisions]]'
---

# The First Nine — capítulo jogável de Thornwake

## Objetivo

Converter as fundações técnicas em um capítulo que tenha começo, pressão, preparação, combate, encerramento e transição clara para Stonehook Mountains.

## Escopo

- Tornar explícito o combate inicial de Lolth: ataque corporal, esquiva curta, dano, invulnerabilidade breve e respostas distintas para Briar Hound, Stag of Mire e Antlered Hunger.
- Organizar a coleta de Thornwake em ciclos finitos com renovação parcial ao amanhecer, custos de receitas visíveis e ausência de bloqueio irrecuperável.
- Fazer o Kit de Roda, a defesa noturna e o encontro com Shar formarem requisitos reais e legíveis de conclusão do capítulo.
- Aplicar as regras aprovadas de morte pós-Marca, queda/retorno de drows e limite de dois postos ativos.
- Entregar a transição de Thornwake para Stonehook como estado jogável de encerramento, sem construir Stonehook ainda.
- Preservar teclado, mouse/teclado e controle equivalentes.

## Fora de escopo

- Stonehook Mountains como mapa explorável.
- Melhorias concretas das Marcas 3, 5 e 7.
- Arte final, IA avançada de seguidores, morte permanente, economia definitiva e conclusão narrativa da Marca 9.

## Critérios de aceitação

1. Uma partida nova apresenta defesa noturna, tutorial de coleta e retorno à carroça sem impasse.
2. Lolth usa ataque básico e esquiva para enfrentar os três inimigos de Thornwake; as três ameaças possuem leitura e resposta diferentes.
3. O jogador consegue fabricar o Kit de Roda com recursos disponíveis no capítulo e sabe quais requisitos ainda faltam.
4. A carroça só abre o encontro com Shar quando o reparo e a defesa noturna exigidos estiverem concluídos.
5. Depois da Marca 1, uma falha recarrega o checkpoint de Marca; um drow caído retorna à carroça no amanhecer.
6. Após curar o primeiro drow, o encerramento comunica que a rota para Stonehook está pronta.
7. Autotestes cobrem combate, economia, requisitos de conclusão e regras de checkpoint; uma partida humana avalia ritmo e legibilidade.

## Impactos previstos

- `main.gd` ou seus módulos extraídos receberão máquina de estados do capítulo, dados de inimigo, dados econômicos e estado de conclusão.
- O HUD ganhará comunicação de objetivos, requisitos da carroça, recursos relevantes, inimigo em combate e drows destacados.
- Checkpoints armazenarão estado de capítulos, postos destacados e drows temporariamente caídos.

## Plano de voo proposto

1. Auditar os sistemas já existentes e separar parâmetros temporários de regras aprovadas.
2. Implementar e testar o kit de combate inicial e os comportamentos dos três inimigos.
3. Implementar coleta por ciclo, renovação parcial e receitas/requisitos de conclusão legíveis.
4. Encadear reparo, noite de defesa, Shar, cura e a transição para Stonehook.
5. Aplicar falha pós-Marca, retorno de drows e limite de postos.
6. Executar autotestes no Godot de `D:\Godot`, fazer validação visual humana, registrar evidência e reconciliar os documentos afetados.

## Resultado de implementação — 03/10/2026

- Lolth agora possui ataque básico e esquiva curta antes da segunda Marca; Briar Hound, Stag of Mire e Antlered Hunger se aproximam com ritmos distintos e exibem vida legível.
- Thornwake oferece os ingredientes necessários para Cataplasma, Kit de Roda e Braseiro, com renovação parcial a cada amanhecer.
- Shar só se torna acessível depois do primeiro amanhecer, da preparação de Cataplasma, do Kit de Roda e do Braseiro.
- A primeira cura encerra o capítulo com a estrada para Stonehook pronta. Checkpoints preservam postos, estado dos drows e o primeiro amanhecer.
- Até dois drows podem estar em postos contextuais; drows caídos retornam à carroça ao amanhecer.

## Evidência

- Saída do autoteste do capítulo no Godot.
- Capturas ou vídeo da defesa, oficina, combate, cura, falha pós-Marca e encerramento.
- Registro dos parâmetros de economia usados no primeiro balanceamento.

## Pendência de validação humana

Ainda é necessária uma partida visual para ajustar ritmo do ciclo, dano dos monstros, leitura dos requisitos e clareza do fluxo de postos. Essa calibração não altera as regras aprovadas sem nova decisão canônica.
