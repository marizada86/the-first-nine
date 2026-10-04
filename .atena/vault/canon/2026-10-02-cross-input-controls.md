---
status: approved
kind: game-design-decision
approved: 2026-10-02
related_intent: '[[2026-10-02-thalestriel-exodus-game-intent]]'
---

# Controles equivalentes

## Decisão

*The First Nine* deve ser jogável integralmente por teclado, teclado/mouse e controle. As três formas de entrada usam as mesmas ações, sem conteúdo ou vantagem exclusiva.

| Ação | Teclado | Teclado/mouse | Controle |
| --- | --- | --- | --- |
| Mover | `A`/`D` ou setas | `A`/`D` ou setas | direcional ou analógico esquerdo |
| Pular | `Space` | `Space` | botão inferior |
| Ação primária | `E` | botão esquerdo | botão esquerdo frontal |
| Ação de sombra | `Shift` | botão direito | gatilho direito |
| Abrir acampamento/carga | `M` | `M` ou clique de interface | Menu/Select |
| Pausar | `Esc` | `Esc` | Start |

## Regra de contexto

Ação primária ataca quando há ameaça alcançável e interage/recupera quando Lolth está diante de objeto, alavanca, entrada ou ponto de acampamento. A interface sempre deve exibir o ícone da entrada ativa quando pedir uma ação.

## Owner revision on 2026-10-04

The shared contextual-primary binding above is superseded by [[2026-10-04-separated-controls-and-wagon-management]]: E collects/interacts, left-click attacks, Space jumps, Shift dashes, and I opens Lolth's inventory. All ally management belongs in the wagon menu. The cross-input equivalence requirement remains; this revision changes action separation and interface access, not the availability of keyboard/controller play. Runtime implementation is tracked separately in [[2026-10-04-b05-controls-and-wagon-menu-revision]].
