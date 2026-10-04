---
status: draft
kind: chapter-cards
created: 2026-10-03
origin: approved-master-production-plan
depends_on:
  - '[[2026-10-03-five-region-route-crafting-and-marks]]'
  - '[[2026-10-03-mark-route-stonehook-and-progression-decisions]]'
  - '[[2026-10-03-caravan-survival-slow-travel]]'
---

# The First Nine — fichas de capítulo e matriz de progressão

## Rota completa

| Capítulo | Região | Objetivo e avanço | Recursos / risco | Ameaças | Marca e transição |
| --- | --- | --- | --- | --- | --- |
| 1 | Thornwake Forest | fabricar **Wheel Kit** e concluir uma defesa noturna | água, ervas, comida, madeira; escuridão e carroça exposta | Briar Hounds, Stags of Mire, Antlered Hunger | I; Shar desperta o primeiro drow e libera Stonehook |
| 2 | Stonehook Mountains | instalar **axle and brakes** | metal, corda, ferramentas; queda, scree e rotas por corda | Scree Crawlers, Cliff Harriers, Stone Maw | II; segundo drow e passagem para Hollowroot |
| 3 | Hollowroot Caverns | **PROPOSTA PENDENTE DE DECISÃO CANÔNICA:** preparar a peça de passagem protegida com ferramentas melhores | fungos, minérios, resina; esporos, colapso e passagens fechadas | Chitin Burrowers, Sporebound, Hollow Mother | III e IV; terceira/quarta cura e saída para Glass Dunes |
| 4 | The Glass Dunes | **PROPOSTA PENDENTE DE DECISÃO CANÔNICA:** montar proteção de travessia e reserva de água | água, lona, vidro reaproveitável; exposição, sede e areia cortante | Glass Scorpions, Dune Striders, Sunken Colossus | V e VI; quinta/sexta cura e rota para Dreamwater |
| 5 | The Dreamwater Run | **PROPOSTA PENDENTE DE DECISÃO CANÔNICA:** assegurar a travessia do riacho e a passagem final | juncos, madeira flutuante, relíquias; correnteza e plano dos sonhos | Reed Eels, Floodborn, the Currentless | VII e VIII; sétima/oitava cura. IX no encontro final e portal |

As três peças indicadas como proposta não são fatos canônicos: o cânone exige apenas um avanço material por região. Elas precisam de uma decisão canônica própria antes de uma especificação de implementação desses capítulos. Portanto, não bloqueiam esta fase documental, mas bloqueiam seus respectivos handoffs de runtime.

## Matriz das Marcas e da caravana

| Marco | Echoes para obter | Cura | Estado da caravana / rota | Teste de aceitação |
| --- | ---: | --- | --- | --- |
| Prólogo | — | nenhuma | oito sobreviventes debilitados; proteger carroça | falha reinicia do prólogo |
| I | encontro com Shar | primeira escolha | Thornwake concluída | a cura transforma o escolhido em drow e habilita seu posto |
| II | 3 | segunda escolha | eixo e freios instalados | Echo excedente é preservado |
| III | 4 | terceira escolha | Hollowroot em curso | Black Pulse ensinado em encontro seguro |
| IV | 5 | quarta escolha | Hollowroot resolvida | Gloam Spine usado num perigo claro |
| V | 6 | quinta escolha | Glass Dunes em curso | Night Choir revela conteúdo legível |
| VI | 7 | sexta escolha | Dunes resolvidas | Deep Hunger abre bloqueio material |
| VII | 8 | sétima escolha | Dreamwater em curso | Spider's Promise resolve travessia |
| VIII | 9 | oitava escolha | todos os oito despertos | Heart of the Web protege a transição |
| IX | foco narrativo | nenhuma | chegada ao Plano dos Sonhos | Shadow Crown abre portal; sem grind |

## Portão por capítulo

Cada capítulo só entra em implementação quando tiver: ficha de peça material aprovada, mapa de postos de drows, tabela de recursos e receitas, telemetria de balanceamento, referência visual aprovada, pacote de inimigos com estados completos e roteiro de teste de checkpoint.

## Revisão vinculante: matriz de sobrevivência e rota

Esta matriz substitui a leitura de que a Marca abre uma região por teleporte, que o acampamento fica para sempre no mesmo ponto ou que a carroça pode viajar antes da quarta cura.

| Faixa de progressão | Forma de alcançar o conteúdo | Estado da carroça | Mudança de grupo |
| --- | --- | --- | --- |
| Prólogo | defesa junto ao abrigo | `stationed` e `travel_locked`; oito doentes | Lolth sozinha em ação |
| I–IV | expedições de Lolth a pé por trechos contínuos | continua estacionada; 5+ doentes mantêm trava | cada Marca cura um drow escolhido |
| Após IV | retorno, reparo confirmado e embarque | `travel_ready`, depois `travelling`; quatro doentes a bordo | Lolth ou um drow puxa; puxador fica indisponível para outro posto |
| V–VIII | expedição a pé a partir de novos pontos da carroça e viagem lenta entre localidades | deslocamento reduz `Attraction`; permanência a aumenta | curas completam os oito drows |
| IX | encontro narrativo final | carroça e grupo sobrevivem à jornada | sem cura; final no Plano dos Sonhos |

As fronteiras de Thornwake, Stonehook, Hollowroot, Glass Dunes e Dreamwater são faixas graduais do mesmo mundo. Cada ficha futura deve incluir uma composição de borda de entrada e saída, além de sua peça material, postos e ameaças.
