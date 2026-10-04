---
status: approved-reference-direction
kind: reconciled-reference-manifest
created: 2026-10-03
plan: '[[2026-10-03-decision-reconciliation-and-opus-reference-plan]]'
approval_mode: per-plan
related_register: '[[2026-10-03-decision-reconciliation-register]]'
---

# The First Nine — manifesto reconciliado de referências para Opus 5.5

## Regra de uso

Opus 5.5 produzirá apenas **pranchas de referência** em diretório de revisão. Cada lote futuro recebe um pacote aprovado com fontes canônicas, lista de arquivos permitidos, não-objetivos, critérios de aceitação, recibo de proveniência e revisão local. Nenhuma saída entra em `res://`, torna-se sprite final ou altera o runtime sem um plano posterior.

## O que não deve ser refeito

As referências A–H já aprovadas preservam linguagem visual, protagonistas, carroça, Thornwake, Stonehook, Hollowroot, Glass Dunes e Dreamwater. O trabalho seguinte deve ser **delta de reconciliação**: corrigir somente as leituras que dependem dos conflitos resolvidos, em vez de regenerar a série inteira.

## Priorização

| Prioridade | Lote futuro | Boards de referência | Dependência |
| --- | --- | --- | --- |
| P0 | `R-01 Camp & checkpoint` | acampamento fixo, carroça no hub, chama/save, retorno de rota, estoque/oficina | resolução 1 do registro |
| P0 | `R-02 Thornwake action read` | loop de dia/noite, composição de ondas, Stag como agressor da carroça, telegraphs de Briar/Stag/Antlered | resolução 2; sem UI final |
| P0 | `R-03 Marks & allies` | Marca I, escolha de cura, primeiro drow, símbolos de posto e regra de retrato/escala | resolução 3 |
| P0 | `R-04 Interface/VFX delta` | estado de ciclo, retorno ao acampamento, condição da carroça, carga, Echoes, prompt contextual e VFX que não encobrem telegraphs | R-01 a R-03; reconcilia o lote I ativo |
| P1 | `R-05 Stonehook delta` | material eixo/freios, scree/cordas, Marca II, segunda cura e leitura de risco | já possui referência E; depende só da decisão de camp/save |
| P2 | `R-06 Hollowroot chapter card` | peça material, receitas, tutoriais de Marcas III–IV e postos | ficha material de Hollowroot aprovada |
| P2 | `R-07 Glass Dunes chapter card` | peça material, abrigo/água, tutoriais V–VI e Colossus humanoide | ficha material de Glass Dunes aprovada |
| P2 | `R-08 Dreamwater chapter card` | travessia, tutoriais VII–VIII, encerramento IX e portal | ficha material de Dreamwater e desfecho aprovados |
| P3 | `R-09 Narrative delta` | HQ de Shar, selos de Marca e conclusão da Cidade Dourada | resolução 3 e escopo do desfecho |

## Contratos de cada board P0

### R-01 Camp & checkpoint

- Mostra que o acampamento é o lugar de retorno, save, estoque, oficina e recuperação emocional.
- A carroça é visualmente central, mas não implica que viaje para cada mapa.
- O emblema de save é chama âmbar em abrigo/aro; lua/crescente pertence apenas a Luraen.
- Sem números, texto, UI funcional, receitas novas ou novos poderes de drow.

### R-02 Thornwake action read

- Uma composição lateral legível com rota, pickup físico, perigo, carroça distante/ameaçada e retorno claro.
- Briar Hound persegue Lolth; Stag of Mire anuncia e corre para a carroça; Antlered Hunger fecha a noite como elite.
- Monstros são regionais, não sombras. Fundo não compete com telegraphs, pickups ou silhueta de Lolth.
- Sem copiar mapas, moedas, inimigos ou estética de outros jogos.

### R-03 Marks & allies

- Lolth é a única figura controlável; o primeiro drow é auxílio contextual, não seguidor.
- Preserva nomes, papéis, ordem de retratos e baseline 1,00 dos oito Thalestriel.
- Trata a Marca I como transformação narrativa e primeiro ensino de poder segundo a tabela que for confirmada.
- Sem biografia inventada, arma/equipamento novo ou sprite/atlas final.

### R-04 Interface/VFX delta

- Comunica carga, estoque, estado da carroça/chama, fase de ciclo, objetivo material, Echoes e disponibilidade de posto.
- Não fixa bind de tecla na arte; prompts devem ser substituíveis conforme a entrada.
- VFX de sombra reforça alvo, perigo e progresso sem encobrir informação de combate.
- É referência em 1280×720, sem texto gerado, watermark, código ou layout final.

## Metadados obrigatórios por saída futura

`reference_id`, lote, fontes canônicas, prompt aprovado, data, autor/ferramenta, proveniência/termos, hash, diretório de revisão, critério de aceitação, decisão de revisão e declaração de IA para a submissão da jam.

## Portões

1. Aprovar o registro de reconciliação e este manifesto.
2. Resolver e registrar as decisões canônicas listadas como bloqueantes.
3. Aprovar um manifesto de batch limitado para um ou mais boards P0.
4. O usuário executa o Opus 5.5 externamente usando o handoff do batch.
5. Revisar localmente os resultados, registrar proveniência e aprovar referências.
6. Só um plano técnico posterior pode converter referências aprovadas em assets finais ou runtime.

## Não-objetivos

Não produzir arte final, atlas, tilemap, animação final, dependência, código, build, publicação, novo lore, mecânica ou asset admitido. Não usar referências geradas para declarar conformidade de licença/IA sem recibo factual.
