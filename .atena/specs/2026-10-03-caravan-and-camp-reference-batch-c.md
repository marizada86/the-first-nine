---
status: approved
approved: 2026-10-03
approval_source: user-explicit
kind: asset-reference-batch
created: 2026-10-03
origin: direct-execution-followed-by-add-reconciliation
depends_on:
  - '[[2026-10-03-visual-language-a-approval]]'
  - '[[2026-10-03-protagonist-references-b-approval]]'
  - '[[2026-10-03-caravan-awakening-progression]]'
  - '[[2026-10-03-night-clock-caravan-stakes]]'
---

# Lote C — carroça e acampamento

## Escopo proposto

Gerar cinco pranchas de referência, somente para revisão, em `.atena/generated/`: carroça em estados, composição de acampamento, chama/defesas, oficina/estoque e postos contextuais dos drows.

| ID proposto | Conteúdo | Critério central |
| --- | --- | --- |
| `camp.wagon.states` | carroça intacta, danificada, em reparo e pronta para rota | condição é legível sem mudar a função de hub |
| `camp.layout` | carroça, fogueira, mesa de oficina, estoque e perímetro | hub claro em composição lateral noturna |
| `camp.flame-defenses` | chama, braseiro, barricada e alarme de corda | calor/segurança contrastam com ameaça noturna |
| `camp.workshop-stock` | cinco slots de estoque como referência de leitura, receitas curtas e props | não virar UI funcional, crafting livre ou árvore tecnológica |
| `camp.drow-posts` | oito postos/símbolos ligados às assistências contextuais | não sugerir controle direto, IA de seguidores ou inventário individual |

## Contratos invioláveis

- Carroça: abrigo, estoque, oficina, local de preparo e foco de risco noturno.
- Estoque inicial tem cinco slots; `RECOVERED LOAD` continua separado como carga de campo de Lolth.
- Famílias de receita: remédios/provisões, ferramentas/reparos e defesas noturnas; sem combinações ocultas.
- Drows só assistem contextualmente; todos ajudam a defender a carroça conforme especialidade, sem comando direto.
- A destruição da carroça falha a tentativa/checkpoint, mas não produz morte permanente.

## Critérios de aceitação

1. As cinco pranchas usam a linguagem A e são referências, nunca assets de runtime.
2. A leitura diferencia estoque, oficina, chama, defesa e posto sem texto embutido.
3. A carroça mantém o mesmo perfil visual entre os quatro estados.
4. Os postos remetem a Aelira, Vaelun, Nimara, Thaviel, Ilyren, Orisya, Soreth e Luraen sem criar novos poderes.
5. Recibo registra prompt, proveniência, hash e exclusões; falhas são exceções visíveis.

## Gaps

- **BLOCKING:** nenhum para referências conceituais.
- **RESOLVABLE:** células, pivôs, colisores e medidas de inventário permanecem `TBD-C` e não serão inventados nesta fase.
- **DEFERRED:** UI funcional, números de defesa/dano, receitas/custos, atlas final, admissão em runtime e implementação.

## Plano de voo após aprovação

1. Criar e validar manifest aprovado de cinco itens com o `batch-image-autopilot`.
2. Gerar e revisar cada prancha, no máximo duas tentativas por falha.
3. Registrar resultados, hashes, proveniência e estado Atena.
4. Solicitar aceitação humana antes de tornar C referência canônica.

## Reconciliação direta

Este plano foi preparado após o pedido direto “prossiga”. Ele não autoriza geração até uma aprovação Guided ADD explícita.
