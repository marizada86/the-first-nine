---
status: approved
kind: game-design-decision
approved: 2026-10-02
related_intent: '[[2026-10-02-thalestriel-exodus-game-intent]]'
---

# Lolth — Marcas e adaptação de RPG de mesa

## Decisão

*The First Nine* adapta o RPG de mesa pela estrutura de cenas, escolhas e consequências, e não pela reprodução integral de combate, fichas ou rolagens aleatórias. Lolth é a única personagem controlável; os oito Thalestriel formam a party por meio de sobrevivência, cura pelas Marcas e assistências contextuais.

Cada trecho segue a sequência: acampamento, jornada, obstáculo narrativo/físico, teste de atributo visível, consequência e retorno. A vertical slice não usa rolagens aleatórias: os testes apresentam requisitos claros e a Marca de Lolth abre soluções antes indisponíveis.

## Status de Lolth

Os cinco status usam escala de 0 a 10:

- `Might`: força física e dano contra obstáculos.
- `Vigor`: resistência e vida.
- `Grace`: velocidade, esquiva e mobilidade.
- `Shadow`: potência das habilidades sombrias.
- `Web`: controle, alcance e duração das teias.

| Marca | Might | Vigor | Grace | Shadow | Web |
| --- | ---: | ---: | ---: | ---: | ---: |
| Sem Marca | 6 | 6 | 5 | 0 | 0 |
| `FIRST THREAD` | 6 | 6 | 5 | 2 | 1 |
| `VELVET VEIL` | 6 | 6 | 7 | 3 | 1 |
| `BLACK PULSE` | 6 | 6 | 7 | 5 | 2 |
| `GLOAM SPINE` | 6 | 8 | 7 | 5 | 3 |
| `NIGHT CHOIR` | 6 | 8 | 7 | 7 | 4 |
| `DEEP HUNGER` | 8 | 9 | 7 | 8 | 4 |
| `SPIDER'S PROMISE` | 8 | 9 | 7 | 9 | 7 |
| `HEART OF THE WEB` | 8 | 10 | 8 | 10 | 9 |
| `SHADOW CROWN` | 10 | 10 | 9 | 10 | 10 |

## Habilidades das Marcas

| Marca | Habilidade |
| --- | --- |
| `FIRST THREAD` | Ataque de sombra básico. |
| `VELVET VEIL` | Passo pelas sombras. |
| `BLACK PULSE` | Pulso que afasta ou atordoa sombras. |
| `GLOAM SPINE` | Carapaça sombria. |
| `NIGHT CHOIR` | Visão de ecos. |
| `DEEP HUNGER` | Rasgar destroços pesados. |
| `SPIDER'S PROMISE` | Âncora de teia. |
| `HEART OF THE WEB` | Vínculo com a caravana. |
| `SHADOW CROWN` | Transformação final e abertura do portal. |

## Party despertada

Antes de ser curado, cada sobrevivente tem `Condition`, `Assignment` e `Specialty`. Cada nova Marca permite a Lolth curar uma pessoa; o Thalestriel curado torna-se drow e oferece assistência contextual em postos do mapa ligados à sua especialidade. Eles não possuem ficha de combate, não seguem Lolth e não são controláveis diretamente. Ver `[[2026-10-03-thalestriel-contextual-assists]]`.

## Echoes e escolha de cura

Após a primeira Marca, qualquer inimigo derrotado entrega sombra absorvível como `Shadow Echo`. As Marcas 2–8 exigem limiares crescentes e permitem ao jogador escolher qual sobrevivente curar; Echoes excedentes permanecem para o próximo limiar. A Marca 9 vem de encontro final ou foco narrativo. Ver `[[2026-10-03-five-region-route-crafting-and-marks]]`.

## Regra de apresentação

Cada Marca deve ser ensinada ao jogador em uma situação que use a nova habilidade logo após ser recebida. Os status devem ser mostrados como progressão de personagem, mas testes e escolhas priorizam legibilidade sobre cálculo oculto.

`Might` também determina a capacidade de `RECOVERED LOAD`; ver `[[2026-10-02-lolth-recovered-load]]`.
