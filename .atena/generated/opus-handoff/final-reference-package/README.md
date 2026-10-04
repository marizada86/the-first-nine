# Handoff final de referencias - Opus 5.5

Este pacote informa ao Opus 5.5 quais referencias estao vigentes e como transforma-las em assets de runtime. Ele nao autoriza gerar, importar ou editar o Godot por si so.

## Ordem de implementacao sugerida

1. P0 - loop base: Lolth, carroca, pickups, VFX e props iniciais.
2. P1 - sobrevivencia: aliados, cura, tracao e oficina.
3. P2-P4 - regioes, transicoes continuas, Marcas e final narrativo.
4. P5 - quinze monstros individuais, convertidos em atlas por familia.
5. P6 - Lolth e Thalestriel individuais, sempre como protagonista ou assistencias contextuais.
6. P7-P9 - salvamento, teia, VFX e props regionais.
7. P10-P11 - interface de sobrevivencia e marcos de rota.

## Cobertura vigente

O manifesto possui 108 masters aprovados de P0 a P11. O contrato operacional atualizado esta em `../2026-10-03-opus-p0-p11-reconciled-technical-contract.md`.

Cada pacote so pode entrar no Godot sob plano de integracao proprio, aprovado, com a lista de admissao deste diretorio.
