---
status: superseded
kind: game-design-revision
created: 2026-10-03
depends_on:
  - '[[2026-10-02-thalestriel-exodus-game-intent]]'
  - '[[2026-10-02-lolth-mark-rpg-adaptation]]'
  - '[[2026-10-03-thalestriel-survivor-names]]'
  - '[[2026-10-03-caravan-awakening-progression]]'
approval_required: true
superseded_by: '[[2026-10-03-thalestriel-contextual-assists]]'
---

# Aliados contextuais Thalestriel

## Decisão proposta

O cânone já estabelece que cada Thalestriel curado pela Marca oferece assistência contextual em situações ligadas à sua especialidade. Esta proposta define as ações individuais e os postos narrativos: em trechos posteriores, cada aliado ocupa um posto fixo no mapa e ajuda Lolth quando ela entra no raio daquele posto e enfrenta o problema apropriado.

Lolth continua sendo a única personagem controlável. Os aliados não seguem a jogadora, não recebem comandos, não possuem inventário ou ficha de combate e não podem falhar permanentemente.

## Regra de interação

1. Cada aliado tem um posto reconhecível, um gatilho de proximidade e uma única resposta clara.
2. O retrato, o título e um ícone aparecem no HUD quando a ajuda está disponível.
3. Assistências de combate acontecem automaticamente apenas durante o evento apropriado; assistências de exploração exigem a ação primária de Lolth no objeto afetado.
4. Uma assistência com impacto forte tem uma carga por trecho; efeitos contínuos só funcionam dentro do posto.
5. Cada trecho comporta no máximo três postos ativos. A campanha completa distribui os oito aliados por seus próprios locais, não simultaneamente ao redor de Lolth.

## Roster de assistências

| Aliado | Posto no mapa | Ajuda contextual | Limite legível |
| --- | --- | --- | --- |
| Aelira, a Forrageira | clareira de ervas e destroços vivos | identifica uma provisão segura e torna sua coleta mais valiosa para o grupo | uma colheita por trecho |
| Vaelun, o Portador | guincho, carga presa ou encosta íngreme | sustenta uma peça de Salvage pesada, reduzindo seu custo de carga em um slot | apenas no objeto ancorado |
| Nimara, a Batedora | torre de vigia ou parapeito | revela inimigos, rotas e pontos fracos; no combate próximo, dispara uma flecha que interrompe um inimigo | uma interrupção por encontro |
| Thaviel, o Guardião da Chama | braseiro de rota | mantém a chama da caravana estável enquanto Lolth permanece na área e purifica uma ameaça de sombra local | efeito restrito ao braseiro |
| Ilyren, o Reparador | ponte quebrada, guincho ou mecanismo | conserta um atalho ou plataforma quando Lolth entrega a peça recuperada | um reparo permanente no trecho |
| Orisya, a Curadora | círculo de ervas e luz | recupera um ponto de Vigor de Lolth ou remove o próximo impacto inimigo | uma bênção por trecho |
| Soreth, a Sentinela | barricada ou passagem estreita | protege Lolth no confronto, imobilizando o inimigo mais próximo para abrir uma janela de ataque | uma guarda por encontro |
| Luraen, a Sonhadora | espelho d'água, ruína onírica ou arco velado | revela uma plataforma, um Echo ou a saída que existe entre o Material e o Sonho | efeito limitado ao local onírico |

## Distribuição inicial por trecho

- **Ashen Way:** Aelira, Vaelun e Nimara. Ensina provisões, carga e leitura de ameaça.
- **Veil Ruins:** Thaviel, Ilyren e Orisya. Ensina sobrevivência de rota, atalho e recuperação.
- **The Last Threshold:** Soreth e Luraen. Ensina defesa sob pressão e travessia onírica final.

Os postos só aparecem depois de o respectivo Thalestriel ter despertado. Isso faz cada Marca mudar a leitura de um trecho sem exigir retorno obrigatório por todo o mapa.

## Escopo e não objetivos

- Reutilizar os retratos e emblemas existentes; novos personagens em movimento são opcionais, não pré-requisito.
- Não criar IA de companheiro, troca de personagem, árvore individual de habilidades, inventário individual, morte permanente ou combate profundo.
- Não introduzir novos recursos. As assistências operam sobre Provisions, Kindling, Salvage, Vigor, Sombras, portões e plataformas existentes.

## Critérios de aceitação propostos

1. Lolth permanece a única personagem diretamente controlável em toda a campanha.
2. Todo sobrevivente despertado tem, no máximo, uma assistência contextual, com posto e resultado compreensíveis sem texto extenso.
3. Pelo menos uma assistência de carga, uma de rota e uma de combate alteram uma decisão real da vertical slice.
4. Nenhuma assistência transforma o trecho em sequência automática nem bloqueia a conclusão se estiver indisponível.
5. O percurso completo preserva o limite de 8–12 minutos e o autoteste de checkpoints continua passando.
