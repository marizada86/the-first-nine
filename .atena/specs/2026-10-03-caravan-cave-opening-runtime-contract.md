---
status: approved-prepared-not-implemented
kind: runtime-implementation-contract
created: 2026-10-03
approved: 2026-10-03
implements: '[[2026-10-03-caravan-relics-cave-prologue-and-travel]]'
---

# Contrato de runtime — prólogo da caverna e carroça viajante

## Fluxo obrigatório

`HQ de prólogo → acampamento na caverna → tutorial dia/noite → primeiro chefe → THE KISS OF SHAR → Marca I → cura escolhida → expedições e Echoes → quatro curas + carroça reparada → viagem lenta`.

## Estados necessários

- Carroça: `cave_damaged`, `stationed`, `travel_locked`, `travel_ready`, `travelling`.
- Aliado: `plagued`, `cured`, `assigned_defense`, `assigned_mission`, `assigned_pull`, `on_wagon`.
- Mundo: inventário de `web_anchors_opened`, persistido em checkpoint/save.

## Regras testáveis

1. A viagem falha com cinco ou mais doentes, carroça não reparada ou sem puxador.
2. Quatro ou menos doentes, carroça reparada e puxador disponível liberam a viagem; carga, passageiros, `Might` e terreno reduzem sua velocidade.
3. Até dois aliados podem operar postos; o puxador não pode ocupar posto ao mesmo tempo.
4. Um Web Anchor aberto permanece aberto após checkpoint, reload e retorno.
5. Nenhuma rota principal exige salto da carroça.
6. A HQ de prólogo e `THE KISS OF SHAR` são sequências narrativas distintas e ambas apresentam texto em inglês.

## Fora de escopo

Nenhuma cena, script, asset, save format, atlas, colisão, UI final ou balanceamento é implementado por este contrato. Cada pacote exige plano Godot separado e aprovação de admissão.
