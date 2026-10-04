---
status: partially-verified
date: 2026-10-02
plan: '[[2026-10-02-ashen-way-presentation-plan]]'
---

# Evidência — apresentação de Ashen Way

## Implementação

- O runtime passou a usar exclusivamente as folhas em `assets/art/` para Lolth, carroça/fogueira/recursos e efeitos da Marca.
- As referências conceituais foram removidas da cena jogável; continuam preservadas apenas como direção de arte.
- Lolth usa quatro regiões de pose, selecionando repouso, movimento, ação e salto. A ação de sombra, golpe, coleta e gates ativam uma breve composição da folha de VFX.
- A carroça usa a região `0,0–1060,620` da folha de props; a fogueira usa `1050,55–1536,625`; caixas de provisões e destroços usam as duas regiões inferiores.
- O portal, o painel narrativo e os VFX de exploração usam as quatro regiões da folha `shadow-mark-effects-v1.png`.

## Verificação automatizada

Comando: `D:\Godot\godot.exe --headless --path . -- --self-test`

Resultado: `SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`.

O ambiente reportou indisponibilidade de `user://logs` e do repositório local de certificados, sem afetar o resultado do teste.

## Pendência de validação humana

Falta apenas a inspeção visual humana da rota de `ASHEN WAY` após a integração, com atenção a legibilidade de plataformas, recursos, carroça/fogueira, VFX e HUD em movimento.
