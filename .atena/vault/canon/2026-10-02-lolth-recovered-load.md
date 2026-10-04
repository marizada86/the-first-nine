---
status: approved
kind: game-design-decision
approved: 2026-10-02
related_intent: '[[2026-10-02-thalestriel-exodus-game-intent]]'
related_progression: '[[2026-10-02-lolth-mark-rpg-adaptation]]'
---

# Lolth — Recovered Load

## Decisão

Lolth usa `RECOVERED LOAD`, uma carga recuperada limitada por `Might`, em vez de um inventário tradicional. Objetos coletados não aparecem nas mãos nem exigem animação de transporte; a interface mostra a carga brevemente após a coleta.

## Capacidade

| Might | Slots de carga |
| ---: | ---: |
| 0–5 | 1 |
| 6–7 | 2 |
| 8–9 | 3 |
| 10 | 4 |

Lolth começa com `Might 6` e dois slots. `DEEP HUNGER` eleva `Might` para 8 e libera o terceiro slot. `SHADOW CROWN` eleva `Might` para 10 e libera o quarto.

## Tamanho dos itens

| Item | Slots |
| --- | ---: |
| `Provisions` | 1 |
| `Kindling` | 1 |
| `Shadow Echo` | 1 |
| `Salvage` leve | 1 |
| `Salvage` volumoso | 2 |

## Regras

- Não há pilhas infinitas, grade de inventário, peso decimal ou organização manual.
- Uma carga cheia exige descartar algo ou retornar à caravana antes de recuperar outro objeto.
- No acampamento, o jogador abre uma lista contextual para aplicar, guardar ou converter itens.
- O checkpoint restaura a carga exatamente ao estado salvo; itens coletados depois dele são perdidos na falha.
- O indicador usa a forma `RECOVERED LOAD 1/2 [Provisions] [Empty]`, aparecendo brevemente ao recuperar algo.
