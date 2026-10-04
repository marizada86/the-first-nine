---
status: automated-validation-passed
date: 2026-10-03
spec: '[[2026-10-03-thornwake-caravan-action-loop-implementation]]'
---

# Evidência — ciclo de ação da caravana em Thornwake

## Mudanças verificadas

- A primeira noite inicia duas ondas; noites posteriores iniciam três. A transição entre ondas tem intervalo de 3 s.
- Briar Hound pressiona Lolth, Stag of Mire corre até a carroça e Antlered Hunger fecha a noite posterior como elite.
- O Stag causa dano à carroça somente quando a alcança; defesa de drows e braseiro ainda reduz o dano.
- Três ataques consecutivos contra o mesmo alvo dentro de 0,55 s aplicam dano `1, 1, 2`.
- A HUD comunica `WAVE n/m` e os Stags mostram `WAGON RUNNER`.

## Comando de validação

`D:\Godot\godot.exe --headless --path . -- --self-test`

## Resultado

O processo terminou com código 0 e emitiu:

`SELF_TEST_PASS: Thornwake waves, caravan combat, combo, Stonehook traversal, crafting, Echo cure, drow recovery, checkpoints, and chapter transitions are ready`

O ambiente também relatou que não pôde escrever `user://logs/godot.log` e não leu o repositório de certificados do sistema. Esses avisos são externos ao projeto e não impediram o carregamento, o autoteste ou o resultado aprovado.

## Aceitação pendente

Falta uma partida humana para calibrar ritmo e legibilidade visual. Não foram feitas capturas, arte nova, dependências, publicação ou alterações de cânone.
