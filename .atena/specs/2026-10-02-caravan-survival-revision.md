---
status: approved
kind: game-design-specification
intent: '[[2026-10-02-thalestriel-exodus-game-intent]]'
approved: 2026-10-02
source_draft: '[[2026-10-02-caravan-survival-revision]]'
---

# The First Nine — revisão de sobrevivência da caravana

## Escopo aprovado

Lolth é a única personagem controlável. Os oito Thalestriel ficam na caravana, em risco visível, e contribuem somente por uma missão passiva selecionada de cada vez. A pressão legível do acampamento é: chama, condição do grupo e reparo da carroça/rota.

## Critérios de aceitação

1. Lolth é a única personagem controlada em uma partida completa.
2. O acampamento comunica chama, grupo em risco e reparo antes de Lolth partir.
3. O jogador usa `Salvage` para reparar a carroça ou rota e avançar ao menos uma vez.
4. Uma missão passiva é escolhida no acampamento e resolve com feedback ao retornar de um trecho.
5. Uma falha restaura todos os nove no checkpoint da última Marca.
6. A rota automatizada de Marca/checkpoint passa; uma partida humana comprova compreensão do loop.

## Plano de voo aprovado

1. Reconciliar intenção e especificação.
2. Refatorar estado e HUD: remover troca de personagem; adicionar reparo e estado legível do grupo.
3. Posicionar recursos distintos para escolhas recuperáveis e usar `Salvage` para progresso.
4. Implementar três resultados de missão passiva: provisões, chama e suporte de rota.
5. Atualizar objetivos, tutorial e README.
6. Validar rota automatizada e partida humana; registrar evidência e reconciliação.

## Não objetivos

Sem morte permanente, IA de companheiros, combate profundo, crafting livre, inventários individuais, novas dependências ou mudanças de lore/nomenclatura.

## Resultado de implementação — 02/10/2026

- Lolth é a única personagem controlada; o atalho de troca de personagem foi removido.
- `Provisions` comunica a condição coletiva dos oito sobreviventes, que aparecem visivelmente junto à caravana.
- `Salvage` repara a carroça em três etapas e é necessário para liberar os trechos seguintes.
- As missões passivas `SEARCH THE BRUSH`, `TEND THE FLAME` e `RECOVER DEBRIS` podem ser escolhidas no acampamento e resolvem ao avançar de trecho.
- A validação automatizada passou para o tutorial, missão passiva, reparo, checkpoint e nove níveis da Marca. Ver `[[2026-10-02-caravan-survival-revision]]` em `evidence`.

## Validação humana pendente

Ainda é necessário executar uma partida visível de ponta a ponta para confirmar legibilidade do HUD e leitura dos sobreviventes no acampamento.

## Reconciliação posterior — 03/10/2026

`[[2026-10-03-caravan-awakening-progression]]` remove a duração como limite do jogo, introduz a oficina/estoque da carroça e estabelece ajuda contextual após a cura por Marca. Esta especificação continua descrevendo a vertical slice já implementada; uma nova especificação será necessária antes de implementar a expansão.

Além disso, durante a noite a carroça poderá sofrer dano de monstros quando Lolth estiver distante. Os parâmetros de defesa, dano e recuperação fazem parte da futura especificação de implementação.
