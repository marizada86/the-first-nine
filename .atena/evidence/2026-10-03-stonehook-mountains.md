---
type: automated-validation
date: 2026-10-03
spec: '[[2026-10-03-stonehook-mountains]]'
result: passed-with-human-visual-validation-pending
---

# Stonehook Mountains — validação

## Checagens executadas

1. `D:\Godot\godot.exe --headless --path D:\dev\eclipse-game-jam -- --self-test`
2. `D:\Godot\godot.exe --headless --path D:\dev\eclipse-game-jam --editor --quit`

## Resultado

O autoteste passou com: `SELF_TEST_PASS: Thornwake, Stonehook traversal, combat, wagon, crafting, Echo cure, drow recovery, checkpoint, and chapter transitions are ready`.

Ele cobre a transição de Thornwake, os dois inimigos montanhosos iniciais, Stone Maw após o reparo, escorregamento em scree, rota de corda, construção de eixo/freios, Marca II, segunda cura, checkpoint e encerramento para Hollowroot.

O editor Godot também concluiu a varredura do projeto, a reimportação necessária e o carregamento do layout sem erros de projeto.

## Exceção registrada

Falta uma partida visual humana para validar ritmo de travessia, perigo de scree, clareza das rotas de corda e pressão dos monstros. Essa pendência não bloqueia o comportamento lógico coberto pelo autoteste.
