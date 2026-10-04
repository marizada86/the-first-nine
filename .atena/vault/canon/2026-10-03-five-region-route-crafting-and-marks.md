---
status: approved
kind: game-design-decision
approved: 2026-10-03
superseded_by: '[[2026-10-03-caravan-survival-slow-travel]]'
related_intent: '[[2026-10-02-thalestriel-exodus-game-intent]]'
related_progression: '[[2026-10-03-caravan-awakening-progression]]'
related_stakes: '[[2026-10-03-night-clock-caravan-stakes]]'
---

# Rota de cinco regiões, crafting e progressão das Marcas

## Rota principal

| Capítulo | Região | Função da carroça | Ameaças noturnas |
| --- | --- | --- | --- |
| 1 | **Thornwake Forest** | Encontrar água, ervas, alimento e madeira; apresentar a primeira noite. | Briar Hounds, Stags of Mire e o Antlered Hunger. |
| 2 | **Stonehook Mountains** | Recuperar metal, corda e ferramentas para firmar rodas e freios. | Scree Crawlers, Cliff Harriers e o Stone Maw. |
| 3 | **Hollowroot Caverns** | Criar ferramentas melhores e liberar uma passagem protegida. | Chitin Burrowers, Sporebound e a Hollow Mother. |
| 4 | **The Glass Dunes** | Administrar água, abrigo e a longa travessia exposta. | Glass Scorpions, Dune Striders e o Sunken Colossus. |
| 5 | **The Dreamwater Run** | Cruzar o riacho, reunir os oito e alcançar a passagem ao Plano dos Sonhos. | Reed Eels, Floodborn e the Currentless. |

Os inimigos são monstros próprios de suas regiões, não espécies de sombra. Depois da primeira Marca, todo inimigo derrotado fornece sombra absorvível para `Shadow Echoes`.

## Progressão das Marcas e cura

- Shar concede a Marca 1; o jogador escolhe o primeiro Thalestriel a curar.
- Cada Marca 2–8 permite escolher mais um Thalestriel para curar. A ordem é decisão do jogador.
- Inimigo regular concede 1 `Shadow Echo`; inimigo de elite concede 2; chefe ou foco narrativo concede 3.
- As Marcas 2–8 exigem, respectivamente, 3, 4, 5, 6, 7, 8 e 9 Echoes.
- Echoes excedentes são preservados para a Marca seguinte.
- A Marca 9 resulta de encontro final ou foco narrativo, nunca de grind, e não cura outro sobrevivente.

## Oficina da carroça

Cada família tem poucas receitas explícitas por capítulo. A oficina não possui árvore tecnológica, crafting livre ou combinações ocultas.

| Família | Receitas iniciais | Papel |
| --- | --- | --- |
| **Remédios e provisões** | Cataplasma, refeição quente e tônico | Mantém o grupo vivo; não substitui a cura pela Marca. |
| **Ferramentas e reparos** | Kit de roda, alavanca e kit de ponte | Repara a carroça e abre rotas materiais. |
| **Defesas noturnas** | Braseiro, barricada e alarme de corda | Atrasa ou reduz o dano de monstros contra a carroça. |

Os ingredientes exatos, custos, duração e melhorias de cada receita são decisões de balanceamento da especificação de implementação.

## Limites

- As cinco regiões são a rota principal inicial até o Plano dos Sonhos; novos capítulos exigem escopo próprio.
- O objetivo é uma jornada maior e estruturada, não mundo aberto ou geração procedural.
- Nenhuma receita substitui a exploração, o risco noturno, o combate ou a cura pelas Marcas.
