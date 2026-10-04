---
status: draft
kind: production-bible
created: 2026-10-03
origin: approved-master-production-plan
depends_on:
  - '[[2026-10-02-thalestriel-exodus-game-intent]]'
  - '[[2026-10-03-production-reset-and-opus-handoff]]'
  - '[[2026-10-03-five-region-route-crafting-and-marks]]'
  - '[[2026-10-03-caravan-survival-slow-travel]]'
---

# The First Nine — Bíblia de Produção

## Contrato de produção

Esta Bíblia transforma o cânone aprovado em comportamento implementável. Não altera lore: valores numéricos, cadência, custos, limites de pilha e dificuldade ficam em dados de balanceamento. Todo texto que chega ao jogador é em inglês. O protótipo atual é apenas referência e não pode ser usado como base de código sem um pacote de implementação aprovado.

## Loop principal

1. No acampamento, ler condição da carroça e do grupo, guardar carga, preparar receita curta e escolher até dois postos de drows despertos.
2. Durante o dia, explorar uma região compacta, combater, recuperar recursos e abrir atalhos que conduzem de volta à carroça.
3. À noite, retornar ou administrar o risco de monstros contra a carroça; usar defesa preparada e estabilizar a chama.
4. Converter recursos em provisões, reparos, ferramentas ou defesa. A passagem só avança com o requisito material do capítulo.
5. Depois da Marca I, derrotas concedem Shadow Echoes; ao atingir o limiar, a próxima Marca permite curar um Thalestriel escolhido.

## Sistemas e contratos de aceitação

| Sistema | Estados e entradas | Falha e UI | Teste de aceitação |
| --- | --- | --- | --- |
| Movimento de Lolth | chão, salto, queda, ataque, esquiva; `Move`, `Jump`, `Primary`, `Shadow` | queda/impacto reduz Vigor conforme dados; HUD mostra vida | teclado, mouse/teclado e controle produzem as mesmas ações |
| Combate | alvo alcançável, ataque básico, esquiva curta, dano, derrota | Lolth sem Vigor aciona falha/checkpoint | ataque não exige mana; inimigo derrotado não bloqueia a absorção pós-Marca |
| Salvage | detectar, extrair, carregar, depositar, reaproveitar | carga cheia impede recuperar e explica o requisito | todo pickup pertence a Provisions, Kindling, Salvage ou Shadow Echoes e tem uso legível |
| RECOVERED LOAD | slots definidos por `Might`; transferir para carroça | sem slot, a ação não consome o objeto | aumento de Might aumenta apenas a capacidade especificada em dados |
| Carroça/acampamento | estoque, oficina, chama, condição, receitas, postos | condição a zero falha a tentativa | começa com cinco slots; itens podem ser guardar, usar ou craftar |
| Dia/noite | dia, crepúsculo, noite, amanhecer; relógio contínuo | noite ativa ataques e aviso de risco | HUD comunica fase; recursos renovam apenas conforme dados ao amanhecer |
| Defesa noturna | monstros escolhem rota/ataque; drows contribuem por especialidade | carroça destruída dispara checkpoint | afastar Lolth da carroça torna o risco visível; retorno permite estabilizar |
| Marcas e Echoes | sem Marca, I–IX; Echoes absorvidos automaticamente após derrota | limiar incompleto não libera cura; excedentes preservados | I vem de Shar; II–VIII exigem 3–9 Echoes; IX vem do foco final, não de grind |
| Cura e assistências | sobrevivente adormecido, curado/drow, posto disponível/usado | drow caído retorna ao amanhecer; nunca morte permanente | cada Marca II–VIII permite uma escolha; Lolth continua única controlável |
| Checkpoints | prólogo, Marca I–VIII, desfecho | pré-Marca I reinicia prólogo; depois recarrega última Marca | morte de Lolth ou carroça destruída não mata permanentemente um Thalestriel |
| Narrativa | prólogo, encontro com Shar, transições, final | cenas podem ser repetidas após reload | HQ de Shar e todo diálogo/UI permanecem em inglês |

## Entradas equivalentes

| Ação | Teclado | Mouse/teclado | Controle |
| --- | --- | --- | --- |
| Mover | A/D ou setas | A/D ou setas | direcional/analógico esquerdo |
| Pular | Space | Space | botão inferior |
| Primária/contextual | E | botão esquerdo | botão esquerdo frontal |
| Sombra | Shift | botão direito | gatilho direito |
| Acampamento/carga | M | M ou clique UI | Menu/Select |
| Pausar | Esc | Esc | Start |

`Primary` ataca uma ameaça alcançável; fora disso, interage, recupera ou ativa um posto. Qualquer prompt deve mostrar a entrada atualmente ativa.

## Regras de dados de balanceamento

Os seguintes campos vivem em recursos de conteúdo, nunca em constantes narrativas: duração do ciclo, dano e cadência inimiga, raio de segurança, saúde de Lolth e carroça, quantidades e renovação de recursos, receitas, custos, pilhas, defesa dos drows, preço de reparo e parâmetros de boss. Uma partida humana de Thornwake é o requisito para selar esses valores.

## Marca e progressão

| Marca | Ganho canônico | Ensino imediato |
| --- | --- | --- |
| I — FIRST THREAD | ataque de sombra; primeira cura | absorver um Echo e curar um aliado |
| II — VELVET VEIL | passo pelas sombras; segunda cura | atravessar obstáculo curto |
| III — BLACK PULSE | pulso interruptor; terceira cura | interromper uma ameaça em Hollowroot |
| IV — GLOAM SPINE | carapaça; quarta cura | atravessar perigo com impacto |
| V — NIGHT CHOIR | visão de ecos; quinta cura | revelar recurso/passagem em Glass Dunes |
| VI — DEEP HUNGER | rasgar destroço pesado; sexta cura | abrir bloqueio material |
| VII — SPIDER'S PROMISE | teia-âncora; sétima cura | travessia de rota especial |
| VIII — HEART OF THE WEB | vínculo com a caravana; oitava cura | proteger a caravana durante transição |
| IX — SHADOW CROWN | forma final e portal | desfecho no Plano dos Sonhos; sem cura |

## Drows e postos

| Drow | Ação contextual | Apresentação/limite |
| --- | --- | --- |
| Aelira | melhora uma colheita segura | posto de forragem; uma vez por trecho |
| Vaelun | reduz em um slot a carga de peça pesada | posto de carga; ao transportar |
| Nimara | revela rota/inimigo e interrompe encontro próximo | posto de vigia; evento contextual |
| Thaviel | mantém braseiro e estabiliza chama | posto de chama; dentro da área |
| Ilyren | repara mecanismo/atalho com material entregue | posto de reparo; `Primary` no objeto |
| Orisya | recupera Vigor ou protege do próximo impacto | posto médico; uma vez por trecho |
| Soreth | imobiliza inimigo e abre janela de ataque | posto de sentinela; reação automática |
| Luraen | revela plataforma, Echo ou passagem do Sonho | posto onírico; `Primary` no objeto |

## Não-objetivos vinculantes

Sem mundo aberto, procedural, árvore de habilidades, crafting livre, seguidores com IA, controle de drows, inventários individuais, morte permanente, combate profundo ou grind para a Marca IX. O Plano dos Sonhos é a cena final, não uma região jogável principal.

## Validação da Bíblia

- Revisão de links canônicos e de cada regra de aceitação acima.
- Um roteiro de teste por sistema antes de qualquer pacote de runtime.
- Validação do projeto futuro com `D:\Godot\godot.exe --headless --path <projeto> --editor --quit` e um smoke test sem erros de script.

## Revisão vinculante: sobrevivência e viagem lenta

Esta seção substitui qualquer leitura anterior deste rascunho que trate o acampamento como permanentemente fixo, as Marcas como checkpoint ou a carroça como capaz de viajar antes da quarta cura.

1. Lolth inicia sozinha com oito aliados `plagued` e parte em expedições a pé para obter as Marcas I–IV.
2. Com cinco ou mais aliados doentes, a carroça está em `travel_locked`: ela só comporta quatro e o grupo não deixa os demais para trás.
3. Quatro ou menos doentes, carroça reparada e puxador disponível formam `travel_ready`. Até quatro doentes embarcam; Lolth ou um drow `assigned_pull` puxa a carroça sem cavalo.
4. Defesa, missão e tração são funções mutuamente exclusivas para cada drow. Lolth continua a única personagem controlável.
5. `Attraction` cresce enquanto a carroça fica numa localização e diminui depois do deslocamento. A ameaça deve ter inimigo, alvo, telegraph e contrajogo concretos.
6. As regiões são conectadas por faixas de transição de terreno, paleta, áudio e marcos; jamais por seletor de mapa, tela preta, fade ou corte seco.

Velocidade de tração, peso, `Might`, capacidade de carga, Attraction e ondas pertencem aos recursos de balanceamento. A Marca IX é o único final e nunca cura um nono aliado.
