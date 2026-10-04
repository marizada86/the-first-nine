---
type: automated-validation
date: 2026-10-03
spec: '[[2026-10-03-thornwake-foundation]]'
result: passed
---

# Fundação de Thornwake — validação automatizada

## Checagem executada

O projeto Godot foi iniciado em modo headless com `--self-test` depois da implementação da fundação de Thornwake.

## Resultado

Passou: `SELF_TEST_PASS: clock, wagon threat, five-slot stock, crafting, Echo cure, ally, and checkpoint restore are ready`.

O teste confirma vínculos de controle, relógio noturno, dano/falha da carroça, estoque de cinco slots, Cataplasma, Kit de Roda, Braseiro, Echo que abre cura, assistência contextual de Aelira e restauração de checkpoint.

Em seguida, `D:\Godot\godot.exe --headless --path D:\dev\eclipse-game-jam --editor --quit` concluiu a inicialização, a varredura de arquivos e o carregamento do layout do editor. Não houve falhas de projeto nessa checagem.

## Limites

- Ainda é necessária uma partida visual para ajustar a duração dia/noite, a pressão de ataques, a leitura do HUD e a posição dos postos de aliados.
- A arte atual é placeholder para Thornwake e seus monstros; a validação não certifica a direção de arte final.
