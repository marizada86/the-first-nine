---
status: implemented-awaiting-human-validation
kind: implementation-specification
created: 2026-10-03
approved: 2026-10-03
implements: '[[2026-10-03-caravan-action-loop-adaptation]]'
reconciles: '[[2026-10-03-thornwake-playable-chapter]]'
---

# The First Nine — implementação do ciclo de ação da caravana em Thornwake

## Escopo executável

- Manter Thornwake como os três trechos já representados pela tela lateral: carroça/acampamento à esquerda, rota central de recursos e extremo de risco/objetivo.
- Tornar a noite uma sequência de até três ondas nomeadas e visíveis, com uma curta pausa entre elas. A sequência deve conter perseguidor, agressor de carroça e, após o primeiro amanhecer, elite.
- Dar a cada inimigo um alvo tático: o Briar Hound pressiona Lolth, o Stag of Mire tenta alcançar a carroça e o Antlered Hunger atua como elite. Lolth pode impedir o ataque à carroça voltando ao raio seguro ou derrotando o agressor.
- Adicionar telegraph textual/visual mínimo para agressão à carroça e onda atual, sem novos assets.
- Transformar a ação primária em uma cadeia curta de até três golpes contra um mesmo inimigo, com expiração breve; manter a esquiva atual e não introduzir mana.
- Manter a ação de sombra existente como habilidade de exploração até as Marcas previstas. Nenhuma nova habilidade de Marca será implementada neste recorte.
- Cobrir onda, alvo da carroça, combo e reinício em autoteste existente.

## Dados iniciais de balanceamento

| Parâmetro | Valor inicial | Motivo |
| --- | --- | --- |
| ondas por noite | 2 antes do primeiro amanhecer; 3 depois | Apresenta a noite sem alongar a primeira tentativa. |
| intervalo entre ondas | 3 s | Dá espaço para retornar à carroça e ler a próxima ameaça. |
| cadeia de ataque | até 3 golpes em 0,55 s | Recompensa proximidade sem criar sistema profundo. |
| dano de combo | 1, 1, 2 | Faz o terceiro golpe ser perceptível, mas não invalida postos. |
| ataque do Stag à carroça | somente à noite, perto da carroça | Cria urgência contextual em vez de dano global por distância. |

Todos os valores ficam em constantes no runtime para posterior ajuste; não são fatos canônicos.

## Critérios de implementação

1. O HUD mostra `WAVE n/m` à noite e informa a próxima ameaça no intervalo.
2. O Stag of Mire procura a carroça, anuncia seu ataque e reduz sua integridade somente quando consegue alcançá-la.
3. As ondas seguintes só surgem após a anterior ser resolvida ou após intervalo visível; o amanhecer encerra inimigos remanescentes.
4. Três pressões sucessivas de ataque contra o mesmo alvo dentro da janela de combo aplicam 1, 1 e 2 de dano; fora da janela voltam ao primeiro golpe.
5. Nenhuma regra aprovada de carga, oficina, postos, checkpoints, Marcas ou rota para Stonehook é removida.
6. `--self-test` no Godot encerra com `SELF_TEST_PASS` após cobrir os novos estados.

## Plano de voo

1. Declarar parâmetros e estados compactos do diretor noturno no `main.gd`.
2. Encadear spawn, pausa e resolução de ondas ao relógio já existente, evitando duplicar inimigos.
3. Adicionar alvo de carroça e telegraph ao comportamento do Stag; expor o estado no HUD.
4. Adicionar estado de combo ao ataque básico e ampliar o autoteste.
5. Rodar autoteste e inspeção de erros do Godot; corrigir até que os critérios automáticos sejam atendidos.
6. Registrar resultado e pendências de validação visual em `evidence/`, sem declarar ajuste de ritmo como concluído sem partida humana.

## Fora de escopo

Arte nova, transição de câmera, mapas adicionais, IA de aliados, novas habilidades das Marcas, reformulação de Stonehook e rebalanceamento humano final.

## Evidência esperada

Saída do autoteste, diagnóstico sem erros de parse, captura futura das três ondas e registro dos parâmetros aplicados.

## Resultado de implementação — 2026-10-03

- O diretor de Thornwake inicia duas ondas na primeira noite e três após o primeiro amanhecer, com uma pausa de três segundos entre elas.
- O Stag of Mire é agora o agressor da carroça: corre para ela à noite, recebe a etiqueta `WAGON RUNNER` e causa dano discreto apenas ao alcançá-la. A distância de Lolth, por si só, não aplica mais dano contínuo.
- O ataque básico de Lolth tem cadeia de dano `1, 1, 2` contra o mesmo alvo dentro de 0,55 s. Esquiva, postos, carga e habilidades de Marca permanecem inalterados.
- O HUD mostra estado e número da onda sem depender de novos assets.
- O autoteste do Godot passou, incluindo as novas verificações de onda, carroça e combo. Ver `[[2026-10-03-thornwake-caravan-action-loop]]`.

## Pendência de validação humana

Ainda é necessária uma partida visual de 8–12 minutos para avaliar leitura do `WAGON RUNNER`, duração da pausa entre ondas e dano da carroça. Esta pendência não bloqueia a integridade automatizada, mas impede declarar o ajuste de ritmo como concluído.
