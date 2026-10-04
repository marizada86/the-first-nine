---
status: approved
kind: game-design-specification
intent: '[[2026-10-02-thalestriel-exodus-game-intent]]'
lore_reconciliation: '[[2026-10-02-shadow-mark-and-dream-crossing]]'
created: 2026-10-02
approved: 2026-10-02
---

# The First Nine — vertical slice

## Objetivo

Produzir uma partida curta, coesa e inteiramente apresentada ao jogador em inglês. Ela deve provar a fantasia central de *The First Nine*: **Lolth explora ruínas para manter oito Thalestriel vivos; ela troca as memórias de sua antiga divindade pela Marca das Sombras; e os primeiros drows atravessam para a Cidade Dourada dos Sonhos.**

O slice é uma experiência de 8 a 12 minutos. Não é um protótipo de mundo aberto nem um sistema completo de sobrevivência.

## Limites e não objetivos

- A vertical slice contém três trechos exploráveis, uma HQ/interlúdio e uma cena final; isto não limita o tamanho do jogo completo.
- **Lolth é a única personagem diretamente controlável.**
- Combate simples contra protótipos de inimigos; sem árvore de habilidades, inventário em grade, crafting livre ou progressão infinita. O runtime atual ainda usa `Shade` como inimigo temporário.
- Os oito sobreviventes têm nomes canônicos em `[[2026-10-03-thalestriel-survivor-names]]`; os rótulos abaixo preservam perfis temporários de produção.
- Não definir geografia, origem ou população da Cidade Dourada dos Sonhos.
- Não permitir morte permanente dos nove, pois contradiz a lore aprovada. Falha retorna ao último acampamento.

## Estrutura da partida

| Etapa | Nome visto pelo jogador | Função | Resultado |
| --- | --- | --- | --- |
| 0 | `THE LAST CAMP` | Prólogo no acampamento; Lolth vê os oito enfraquecidos e aprende a manter a chama. | Objetivo: `Keep them alive.` |
| 1 | `ASHEN WAY` | Tutorial de exploração: recuperar mantimentos, ervas e combustível em destroços; enfrentar uma sombra simples. | O grupo sobrevive até o santuário. |
| HQ | `THE KISS OF SHAR` | Interlúdio em quadrinhos. Lolth oferece suas memórias a Shar, que inicia a Marca com O Beijo de Shar. | Marca no nível 1; primeiro sobrevivente desperta. |
| 2 | `VEIL RUINS` | Rotas curtas com inimigos, ecos sombrios e retornos ao acampamento. | Níveis 2–8; os outros sete sobreviventes despertam. |
| 3 | `THE LAST THRESHOLD` | Travessia final com os nove unidos na caravana. | Nível 9, transformação, portal e Cidade Dourada dos Sonhos. |

## Loop jogável

1. **Explore.** Lolth percorre a área, derrota ameaças simples e recolhe recursos visíveis.
2. **Return.** No acampamento, o jogador decide como usar os recursos para a chama, provisões e missões passivas.
3. **Awaken.** Depois da HQ, Ecos Sombrios elevam a Marca e estabilizam um sobrevivente a cada nível 1–8.
4. **Assign.** No acampamento, o jogador escolhe uma única missão passiva entre os sobreviventes despertos; ela resolve ao retornar do próximo trecho.
5. **Advance.** A sobrevivência do grupo libera o próximo trecho. O nível 9 encerra a jornada, não abre uma nova área.

## Recursos

| Recurso | Nome no jogo | Obtenção | Uso | Regra de escopo |
| --- | --- | --- | --- | --- |
| Combustível | `Kindling` | Destroços e caixas | Mantém `Caravan Flame` acesa. | Medidor visível; é o principal risco de derrota. |
| Comida e ervas | `Provisions` | Forragem, bolsas e ruínas | Estabiliza os oito antes de despertarem e cura o grupo depois. | Um único contador, para não criar microgerenciamento. |
| Peças recuperadas | `Salvage` | Ruínas, estruturas quebradas e missões | Repara um ponto seguro, melhora uma missão ou abre rota curta. | Cada peça deve ter uso claro e imediato. |
| Essência de inimigos | `Shadow Echoes` | Sombra absorvida de inimigos derrotados após a Marca e focos narrativos | Eleva a Marca das Sombras. | Quantidade curada; sem grind. |

### Pressão de sobrevivência

`Caravan Flame` e `Provisions` caem somente durante exploração e eventos roteirizados. A morte de **qualquer um dos nove** mostra `THE CAMP FALLS` e reinicia a partida no último checkpoint. Checkpoints são criados ao alcançar cada nível da Marca das Sombras; antes de receber `FIRST THREAD`, uma morte reinicia no estado imediatamente posterior ao tutorial. Nenhum Thalestriel morre de forma permanente. A interface deve sempre indicar o que está em risco e onde o recurso pode ser gasto.

## Marca das Sombras

Shar concede a Marca no interlúdio por meio de **O Beijo de Shar** depois que Lolth oferece as memórias do Plano Material anterior, quando era uma deusa. Antes disso, Lolth é uma elfa e luta apenas com força física. `FIRST THREAD` transforma-a na primeira drow e inaugura seus poderes de sombra. A partir daí, o jogador coleta `Shadow Echoes` e cada limiar tem um efeito inequívoco.

| Nível | Nome mostrado | Efeito de Lolth | Consequência para o grupo |
| --- | --- | --- | --- |
| 1 | `FIRST THREAD` | Ataque sombrio básico. | Desperta 1 sobrevivente. |
| 2 | `VELVET VEIL` | Esquiva curta pelas sombras. | Desperta 1 sobrevivente. |
| 3 | `BLACK PULSE` | O ataque alcança dois inimigos próximos. | Desperta 1 sobrevivente. |
| 4 | `GLOAM SPINE` | Defesa temporária ao derrotar uma sombra. | Desperta 1 sobrevivente. |
| 5 | `NIGHT CHOIR` | Ecos rendem mais energia em encontros roteirizados. | Desperta 1 sobrevivente. |
| 6 | `DEEP HUNGER` | Golpe pesado quebra uma barreira frágil. | Desperta 1 sobrevivente. |
| 7 | `SPIDER'S PROMISE` | Invoca uma teia de contenção breve. | Desperta 1 sobrevivente. |
| 8 | `HEART OF THE WEB` | A chama perde menos energia no trecho final. | Desperta o 8º sobrevivente. |
| 9 | `SHADOW CROWN` | Transformação final; não é poder de exploração adicional. | A forma drow de Lolth torna-se a cabeça de uma grande aranha sombria; Shar toma as memórias dos primeiros drows e o portal é aberto. |

Para a vertical slice, cada nível é garantido por encontros e focos colocados à mão. O jogador não deve repetir inimigos para completar a Marca.

## Os oito sobreviventes

Os perfis abaixo definem função de jogo, não identidade canônica. Na tela de despertar, aparecem como `THE AWAKENED` até que nomes aprovados sejam inseridos.

| Perfil temporário | Especialidade no acampamento | Missão passiva | Recompensa/efeito |
| --- | --- | --- | --- |
| `THE FORAGER` | Busca recursos. | `Search the brush` | Provisions. |
| `THE PORTER` | Recupera cargas pesadas. | `Recover debris` | Salvage. |
| `THE SCOUT` | Lê rotas seguras. | `Map the path` | Menos consumo de chama no próximo trecho. |
| `THE KEEPER` | Mantém a chama. | `Tend the flame` | Kindling convertido em mais chama. |
| `THE MENDER` | Repara abrigo e rota. | `Restore shelter` | Ponto seguro ou rota recuperada. |
| `THE HEALER` | Prepara remédios. | `Prepare remedies` | Recupera a estabilidade do grupo. |
| `THE WARDEN` | Protege o acampamento. | `Watch the camp` | Evita uma perda roteirizada de recurso. |
| `THE DREAMER` | Escuta ecos. | `Listen beyond` | Revela o próximo Shadow Echo. |

Uma missão passiva é atribuída no acampamento e resolve quando Lolth retorna da próxima área curta. Apenas uma missão fica ativa por vez; assim ela cria escolha sem exigir simulação complexa.

## HQ — `THE KISS OF SHAR`

A HQ é o ponto médio obrigatório, com sete quadros estáticos, narração mínima e botões `CONTINUE`/`SKIP`. Todo texto visível é em inglês.

1. Chuva escura cobre o acampamento; Lolth permanece de pé entre os oito corpos enfraquecidos.
2. Lolth diz: `I remember the world before this one. I was a goddess.`
3. Ela acusa Eol: `When Eol remade the Material Plane, he stripped it all from me.`
4. Ela oferece o acordo: `Take every memory. Give me a way to become a goddess again.`
5. Shar, deusa do esquecimento, aceita: `I am forgetting. Your memories are a worthy price.`
6. Shar inicia a transformação: `The Kiss of Shar will make you a creature of shadow. Whoever holds it may command you.`
7. Lolth responde: `Then no hand will hold it over me.` A interface revela `FIRST THREAD`; a perda das memórias só se conclui no nível 9.

O storyboard visual deve preservar duas leituras: Shar oferece poder, mas também estabelece uma ameaça futura de controle. A varinha deve ser reconhecível na cena final, quando Lolth a deixa para os Thalestriel guardarem.

## Cena final

No nível 9, o jogador vê Lolth concluir a metamorfose; Shar toma as memórias dela e dos outros primeiros drows. Lolth abre o portal e atravessa com os oito. Antes de entrar, ela deixa O Beijo de Shar sob a guarda do grupo. Texto final proposto: `WE CARRIED A HOME THAT NEVER WAS. NOW WE WILL DREAM ONE.`

O jogo termina ao revelar a `GOLDEN CITY OF DREAMS`; ela é uma imagem/cena final, não uma quarta área explorável.

## Critérios de aceitação

1. A primeira interação jogável controla Lolth, e os oito sobreviventes estão visivelmente sob risco.
2. A partida exige obter e gastar Kindling ou Provisions antes da HQ.
3. A HQ apresenta a troca das memórias de Lolth, concede a Marca, explica o risco de O Beijo de Shar e apresenta-se integralmente em inglês.
4. O percurso de teste alcança os nove níveis sem grind; os níveis 1–8 despertam exatamente oito sobreviventes e o 9º abre o portal.
5. Lolth permanece a única personagem controlável e as missões passivas de Provisions, chama e suporte de rota funcionam de ponta a ponta.
6. A morte de qualquer personagem retorna ao checkpoint do último nível da Marca; antes de `FIRST THREAD`, retorna ao pós-tutorial, sem morte permanente.
7. Uma partida completa chega à Cidade Dourada dos Sonhos com o loop de sobrevivência compreensível, incluindo a HQ.
8. Todos os textos apresentados ao jogador — HUD, objetivos, HQ, falha e final — estão em inglês.

## Impactos, riscos e decisões pendentes

- **Nomes e aparência dos oito:** pendentes de aprovação de lore; não inventar durante a implementação.
- **Economia:** manter quatro recursos no máximo. Se o teste ficar confuso, fundir Kindling e Salvage antes de adicionar interfaces.
- **Combate:** precisa gerar tensão e Ecos, não se tornar um sistema profundo.
- **Uso de IA e ativos:** seguir o registro de regras da jam; manter créditos, licença e divulgação de IA antes da submissão.
- **Plataforma e implementação:** usar a stack já presente apenas após aprovação desta especificação; dependências novas exigem aprovação separada.

## Plano de voo aprovado

1. Revisar e aprovar nomes visíveis, recursos e os nove níveis.
2. Converter o mapa em wireframes e o interlúdio em storyboard visual.
3. Adaptar o slice Godot existente para o prólogo, recursos e três trechos.
4. Implementar Marca, despertares narrativos e uma missão passiva por vez.
5. Integrar HQ, transformação e final; testar a rota completa e registrar evidências.
6. Auditar critérios, ativos, créditos e divulgação de IA antes de criar build de submissão.

## Resultado de implementação — 02/10/2026

- O slice Godot foi adaptado para apresentar *The First Nine* em inglês, com Lolth como única personagem controlável, recursos de sobrevivência, HQ de Shar, Marca de nove níveis, missões passivas e final no portal.
- A restauração após morte usa o checkpoint do último nível da Marca; antes de `FIRST THREAD`, usa o estado pós-tutorial.
- A validação automatizada passou. Ver `[[2026-10-02-the-last-nine-mark-checkpoints]]`.
- Permanecem pendentes a validação humana de ritmo/legibilidade e a produção de arte final para a HQ, personagens e mapa.

## Revisão aprovada — sobrevivência da caravana

Em 02/10/2026, foi aprovado que Lolth é a única personagem diretamente controlável. Os oito Thalestriel não são mais personagens jogáveis: permanecem na caravana e oferecem missões passivas, uma ativa por vez. Esta revisão substitui as etapas `Awaken`/`Deploy` do loop original por leitura do estado do grupo, seleção de missão e retorno ao acampamento.

O acampamento deve comunicar três pressões: `Caravan Flame`, condição coletiva dos sobreviventes e reparo da carroça/rota. `Salvage` repara a carroça e abre progresso; não será adicionado um quinto recurso. A implementação deve demonstrar três efeitos passivos completos — Provisions, eficiência de chama e suporte de rota — sem construir simulação individual, IA de companheiros ou inventários separados.

O plano e os critérios de aceitação desta revisão estão em `[[2026-10-02-caravan-survival-revision]]`.

## Decisão canônica posterior — adaptação de RPG

As Marcas de Lolth passam a usar os status `Might`, `Vigor`, `Grace`, `Shadow` e `Web`, com valores e habilidades definidos em `[[2026-10-02-lolth-mark-rpg-adaptation]]`. A versão de jam adapta o RPG por cenas, escolhas e testes visíveis sem aleatoriedade. Esta decisão exige um plano de implementação separado antes de alterar o código.

## Decisão canônica posterior — exploração compacta

A exploração passa a ter plataforma, verticalidade e atalhos de retorno à carroça em três áreas compactas de `Salvage`. Ela não amplia a jam para um mundo aberto ou metroidvania extenso. Ver `[[2026-10-02-compact-salvage-exploration]]`. A implementação requer plano de voo separado.

## Decisão canônica posterior — carroça e despertares

`[[2026-10-03-caravan-awakening-progression]]` remove a duração como limite do jogo. As três áreas desta especificação continuam sendo a vertical slice inicial, não o tamanho total do produto. A carroça passa a incluir oficina e estoque, e sobreviventes curados pelas Marcas passam a ajudar no mundo sem se tornarem controláveis. A implementação dessas regras exige especificação própria.
