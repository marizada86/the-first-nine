---
type: automated-validation
date: 2026-10-03
spec: '[[2026-10-03-thornwake-playable-chapter]]'
result: passed
---

# Thornwake — capítulo jogável

## Validações executadas

1. `D:\Godot\godot.exe --headless --path D:\dev\eclipse-game-jam -- --self-test`
2. `D:\Godot\godot.exe --headless --path D:\dev\eclipse-game-jam --editor --quit`

## Resultado

O autoteste passou com a confirmação: `SELF_TEST_PASS: Thornwake combat, wagon, crafting, Echo cure, drow recovery, checkpoint, and Stonehook transition are ready`.

Ele cobre controles, esquiva, dano/falha da carroça, estoque de cinco slots, receitas, cura via Echo, recuperação de drow no amanhecer, checkpoint e transição de Thornwake para Stonehook.

O editor Godot também concluiu a inicialização, a varredura do projeto e o carregamento de layout sem erros de projeto.

## Limite conhecido

Falta validar visualmente uma partida humana para calibrar o tempo de coleta, a agressividade dos três monstros, a pressão noturna, a leitura do HUD e os postos de aliados.
