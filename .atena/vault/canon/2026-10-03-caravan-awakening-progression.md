---
status: approved
kind: game-design-decision
approved: 2026-10-03
superseded_by: '[[2026-10-03-caravan-survival-slow-travel]]'
related_intent: '[[2026-10-02-thalestriel-exodus-game-intent]]'
supersedes:
  - fixed-duration scope
  - survivors as passive-mission-only contributors
---

# A carroça, a cura e os despertares

## Decisão

O jogo completo não tem duração máxima nem limite canônico de três áreas. As três áreas existentes são uma vertical slice e uma unidade de produção inicial, não um teto para a jornada.

O objetivo principal é colocar a carroça novamente em movimento e conduzir os nove Thalestriel até o Plano dos Sonhos. A carroça é o hub da jornada: abrigo, estoque de itens, oficina de ferramentas e local de preparo de ervas e remédios.

## Fluxo narrativo e jogável

1. **Prólogo noturno:** Lolth protege os oito companheiros, debilitados pela peste e incapazes de acordar, enquanto monstros e inimigos atacam à noite.
2. **Tutorial diurno:** o dia revela exploração, movimento e interações com o mapa.
3. **Sobrevivência e reparo:** Lolth busca ervas, água, comida e materiais. Na carroça, ela armazena itens, prepara remédios e fabrica ferramentas com receitas limitadas para reparar a carroça e liberar a rota.
4. **Pressão antes de Shar:** manter o grupo vivo exige escolhas e esforço recuperável; a carroça só avança quando seus reparos e suprimentos são suficientes.
5. **Encontro com Shar:** Lolth recebe a primeira Marca e pode curar um companheiro. O companheiro curado torna-se drow.
6. **Progressão:** cada novo nível da Marca permite curar mais um Thalestriel, até os oito estarem despertos.
7. **Ajuda no mundo:** os drows despertos ajudam Lolth em postos e situações ligados à sua especialidade, sem se tornarem personagens diretamente controláveis.

## Pressão noturna sobre a carroça

À noite, a carroça é vulnerável quando Lolth se afasta dela. Monstros podem atacá-la e causar dano à sua condição de reparo; o jogador deve equilibrar a necessidade de explorar com o risco de deixar o grupo sem proteção. O HUD precisa comunicar que a carroça está sob ataque e o retorno de Lolth deve permitir estabilizar a situação.

O raio de segurança, a cadência de ataques, a escala de dano, as formas de defesa e a consequência exata de uma carroça destruída serão definidos na especificação de implementação. Esta regra não cria morte permanente dos Thalestriel.

## Regra da Sombra

`Sombra` não nomeia uma espécie de inimigo. Lolth enfrenta monstros e inimigos próprios de cada área, e os encontros hostis acontecem à noite. Depois de receber a Marca, Lolth pode absorver a sombra de qualquer inimigo derrotado e convertê-la em `Shadow Echoes`, que fazem avançar a Marca e viabilizam a cura dos Thalestriel.

## Regras de escopo

- A oficina da carroça usa receitas curtas e explícitas; as três famílias aprovadas são remédios/provisões, ferramentas/reparos e defesas noturnas. Ela não vira sistema de crafting livre, árvore de tecnologia ou simulador de sobrevivência. Ver `[[2026-10-03-five-region-route-crafting-and-marks]]`.
- A carroça começa com cinco slots de estoque; regras de interface e expansão serão definidas em especificação própria. `RECOVERED LOAD` continua sendo a carga de campo de Lolth.
- Lolth continua a única personagem diretamente controlável.
- As ações individuais dos aliados contextuais seguem `[[2026-10-03-thalestriel-contextual-assists]]`.
- A quantidade, o tamanho e a ordem de futuras áreas serão planejados por capítulos; não se assume mundo aberto ou geração procedural.

## Impactos

- A duração de 8–12 minutos deixa de ser critério de escopo do jogo e, se usada, serve apenas para avaliar a vertical slice existente.
- As antigas missões passivas deixam de ser a única forma de contribuição dos sobreviventes.
- A introdução noturna, o tutorial diurno, a oficina/estoque e a cura por Marca exigem uma especificação e plano de voo de implementação antes de mudanças no runtime.
