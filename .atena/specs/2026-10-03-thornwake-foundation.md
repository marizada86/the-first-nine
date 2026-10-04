---
status: approved
kind: implementation-specification
created: 2026-10-03
approved: 2026-10-03
intent: '[[2026-10-02-thalestriel-exodus-game-intent]]'
depends_on:
  - '[[2026-10-03-caravan-awakening-progression]]'
  - '[[2026-10-03-night-clock-caravan-stakes]]'
  - '[[2026-10-03-thalestriel-contextual-assists]]'
  - '[[2026-10-03-five-region-route-crafting-and-marks]]'
---

# The First Nine — fundações e Thornwake Forest

## Objetivo

Substituir a rota única atual por uma primeira fatia expandida que prove o loop completo de **dia → preparar → noite → proteger a carroça → absorver sombras → Marca → cura**, usando Thornwake Forest como primeiro capítulo jogável.

## Escopo da primeira entrega

### Sistemas fundamentais

- Relógio contínuo, com estados visuais de dia/noite e valores de duração centralizados para balanceamento posterior.
- Carroça com condição de 0–100%, aviso de ataque e falha quando chega a 0%.
- Regra de distância: ataques noturnos à carroça só progridem quando Lolth está fora do raio de defesa; o retorno permite interromper ou estabilizar o ataque.
- Checkpoint inicial antes da primeira Marca e checkpoint completo a cada Marca posterior.
- Estoque da carroça com cinco slots, separado de `RECOVERED LOAD`.
- Oficina funcional com uma receita de cada família: Cataplasma, Kit de Roda e Braseiro. As outras receitas aprovadas entram nos capítulos posteriores.
- `Shadow Echoes` recebidos de todo inimigo derrotado após a Marca, com limiares persistentes e seleção de sobrevivente para cura.
- Estrutura de dados para os oito drows, suas assistências e a defesa automática da carroça.

### Thornwake Forest

- Prólogo noturno: os oito estão debilitados; Lolth enfrenta monstros para manter a carroça segura até o amanhecer.
- Tutorial diurno: movimento, pulo, interação, coleta, retorno à carroça, estoque e oficina.
- Recursos de floresta: ervas, água, alimento, madeira e componentes de reparo.
- Ameaças: Briar Hound (aproximação rápida), Stag of Mire (avanço pesado) e Antlered Hunger (encontro de encerramento).
- A primeira ida a Shar concede Marca 1; o jogador escolhe o primeiro Thalestriel a curar.
- O drow curado usa sua assistência canônica quando a situação correspondente existir no mapa e também contribui para a defesa noturna da carroça.

## Fora de escopo desta entrega

- Stonehook Mountains, Hollowroot Caverns, The Glass Dunes e The Dreamwater Run como áreas jogáveis completas.
- As receitas adicionais, chefes completos, arte final e balanceamento final dos cinco capítulos.
- Mundo aberto, IA de seguidores, controle de drows, inventários individuais, crafting livre e novas dependências.
- Ajuste definitivo de duração do ciclo, dano, raio de segurança e economia: estes devem ser parâmetros visíveis em dados ou constantes, não fatos enterrados na lógica.

## Critérios de aceitação

1. Um ciclo de dia e noite acontece sem troca manual do jogador e é legível no mundo e no HUD.
2. Durante a noite, afastar Lolth da carroça permite um ataque inimigo; ela recebe aviso e a carroça perde condição. Em 0%, a tentativa falha.
3. Antes da Marca 1, falha reinicia o prólogo. Depois da Marca 1, falha retorna ao estado salvo da Marca e restaura Lolth, aliados, carroça, estoque e carga conforme o checkpoint.
4. Lolth transfere itens entre carga e cinco slots da carroça, fabrica Cataplasma, Kit de Roda e Braseiro por receitas explícitas e aplica seus efeitos.
5. Todo inimigo derrotado após a Marca gera Echo; a barra de Echo carrega para a próxima Marca sem perder excedentes.
6. Ao conquistar uma Marca elegível, o jogador seleciona um dos sobreviventes ainda não curados; o escolhido muda para drow, aparece na carroça e oferece sua assistência contextual.
7. Thornwake Forest contém prólogo noturno, tutorial diurno, coleta, craft, risco de carroça, inimigos e encontro de encerramento que conduz a Shar.
8. Lolth continua a única personagem controlável; teclado, mouse/teclado e controle mantêm ações equivalentes.
9. O autoteste cobre relógio, dano/falha da carroça, estoque/crafting, Echo/cura e restauração de checkpoint; uma partida humana avalia clareza do primeiro capítulo.

## Impactos técnicos

- `main.gd` será decomposto em dados e funções de sistemas para tempo, carroça, inventário, receitas, inimigos e persistência de checkpoint.
- O estado de checkpoint passa a incluir hora/fase, condição da carroça, estoque, receitas aplicadas, Echoes, aliado curado e defesa disponível.
- O inimigo temporário `Shade` deixa de ser a única forma de inimigo e será substituído por dados de inimigo para os três encontros de Thornwake.
- HUD e prompts precisam incluir fase do ciclo, condição/alerta da carroça, estoque, receitas, Echoes e cura disponível.

## Plano de voo proposto

1. Criar dados centrais para capítulo, relógio, carroça, estoque, receitas, inimigos, Echoes e sobreviventes; preservar os controles existentes.
2. Refatorar checkpoint, falha e HUD para persistir e comunicar os novos estados.
3. Construir o prólogo noturno e o tutorial diurno de Thornwake sem depender de arte final.
4. Implementar recursos, cinco slots, três receitas e os efeitos mínimos de cura, reparo e defesa.
5. Implementar os três inimigos, coleta de Echo depois da Marca e o encontro de Shar com escolha de cura.
6. Integrar a assistência do drow escolhido e a defesa da carroça; verificar que nenhuma delas dá controle direto ou IA de seguidor.
7. Atualizar o autoteste, executar a rota automatizada, testar uma partida humana, registrar evidência e reconciliar a documentação operacional.

## Evidência prevista

- Saída do autoteste da fundação e de Thornwake.
- Capturas de HUD diurno, ataque noturno, oficina, cura e checkpoint.
- Registro de parâmetros temporários usados para o primeiro balanceamento.
- Checklist de partida humana e lista de exceções para arte, inimigos ou clareza ainda pendentes.

## Resultado de implementação — 03/10/2026

- `main.gd` agora tem relógio contínuo, risco noturno da carroça, falha por destruição, estoque de cinco slots, Cataplasma, Kit de Roda e Braseiro.
- A Marca 1 abre uma seleção de cura; Echoes posteriores preservam excedente e usam os limiares aprovados.
- Thornwake usa Briar Hound, Stag of Mire e Antlered Hunger como dados de inimigo sobre os assets temporários existentes.
- Assistências de drows já têm efeitos iniciais e postos visíveis em Thornwake; todos contribuem para a defesa noturna da carroça.
- O autoteste passou; ver `[[2026-10-03-thornwake-foundation]]` em `evidence`.

## Validação humana pendente

Ainda é necessária uma partida visual para calibrar ritmo, pressão de dano, disposição de recursos, clareza do HUD e leitura dos postos de aliados.
