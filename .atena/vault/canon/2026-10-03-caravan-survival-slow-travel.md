---
status: approved
kind: game-design-decision
approved: 2026-10-03
approval_source: user-explicit-per-plan
related_spec: '[[2026-10-03-caravan-survival-slow-travel-revision]]'
supersedes_operationally:
  - '[[2026-10-03-caravan-awakening-progression]]'
  - '[[2026-10-03-fixed-camp-save-checkpoint]]'
  - '[[2026-10-03-five-region-route-crafting-and-marks]]'
  - '[[2026-10-03-mark-route-stonehook-and-progression-decisions]]'
  - '[[2026-10-03-reconciliation-resolutions]]'
---

# The First Nine — sobrevivência da carroça e viagem lenta

## Decisão

Lolth começa sozinha como única personagem controlável. Os oito Thalestriel estão tomados pela peste e dependem da carroça como abrigo, estoque, oficina e ponto de defesa. A jornada termina somente na Marca IX.

Até que a carroça possa viajar, Lolth alcança as regiões seguintes em expedições a pé; essas regiões pertencem ao mesmo mundo contínuo e não são escolhidas em uma tela de mapa. Cada Marca de I a VIII cura um aliado escolhido. O drow desperto pode defender a carroça, cumprir uma missão contextual ou puxá-la, mas nunca se torna controlável diretamente.

## Estados da carroça e dos aliados

| Estado | Regra vinculante |
| --- | --- |
| `stationed` | Carroça parada; Lolth pode partir a pé, recuperar recursos e retornar. |
| `travel_locked` | Cinco ou mais aliados seguem com a peste: a carroça não parte, pois só comporta quatro doentes e o grupo não abandona ninguém. |
| `travel_ready` | Carroça reparada, quatro ou menos aliados com a peste e ao menos um puxador disponível. |
| `travelling` | Até quatro aliados doentes vão embarcados. Um personagem puxa a carroça sem cavalo. |

Os estados de aliado são `plagued`, `cured`, `assigned_defense`, `assigned_mission`, `assigned_pull` e `on_wagon`. Um aliado não ocupa mais de uma função operacional por vez. `assigned_pull` é incompatível com defesa e missão; `on_wagon` é reservado a aliados ainda doentes durante a viagem.

Lolth é a puxadora padrão enquanto não houver outro drow disponível. O jogador pode designar um único drow curado e disponível como puxador. A velocidade é deliberadamente baixa e vem de parâmetros de balanceamento: faixa de `Might` do puxador, peso da carroça, passageiros, carga e condição do terreno. Não há cavalo nem segundo veículo.

## Progressão e risco

1. No prólogo, Lolth protege a carroça e os oito doentes.
2. Lolth explora a pé, recupera materiais e alcança as Marcas I–IV sem deslocar a carroça.
3. Cada Marca I–VIII cura um aliado escolhido e amplia as possibilidades de defesa, missão ou tração.
4. Ao restarem quatro aliados com a peste e a carroça estar reparada, os quatro embarcam e a viagem lenta é liberada.
5. A viagem permite reposicionar o abrigo para a próxima localidade, mas Lolth pode continuar fazendo expedições a pé a partir dele.
6. A Marca IX é o único encerramento: resolve Lolth, Shar e a chegada ao Plano dos Sonhos; não cura um nono aliado e não exige grind.

Permanecer em uma localização aumenta `Attraction`, a pressão inimiga legível contra a carroça. O sistema pode intensificar ondas, frequência ou probabilidade de ameaças, mas sempre por inimigos concretos com alvo, telegraph e contrajogo. Deslocar a carroça reduz `Attraction`; números e fórmula são conteúdo de playtest, não lore.

## Mundo contínuo

As regiões são trechos conectados de uma única jornada, não mapas discretos. Cada fronteira usa uma faixa de transição gradual que mistura terreno, paleta, som ambiente, vegetação/arquitetura e marcos distantes da origem e do destino. Não há seletor de mapa, tela preta, fade escuro ou corte seco como forma de mudar de região.

As cinco regiões, famílias de ameaça e a distribuição das Marcas continuam válidas como estrutura de conteúdo, com esta interpretação: Thornwake e os trechos iniciais de Stonehook são acessados a pé; a viagem da carroça fica disponível após a quarta cura. A geometria, largura e duração das faixas de transição são decisões de level design e playtest.

## Checkpoint e limites

A carroça estacionada ou viajante é o hub móvel da tentativa. Um retorno seguro à sua localização permite salvar e reabastecer; a forma técnica do save continua a exigir especificação de runtime. Não existe mundo aberto, mapa procedural, sobrevivência livre, IA de seguidores, controle de drows, morte permanente ou crafting livre.

Esta decisão não gera assets, modifica o runtime, envia material ao Opus 5.5, adiciona dependências ou publica conteúdo.
