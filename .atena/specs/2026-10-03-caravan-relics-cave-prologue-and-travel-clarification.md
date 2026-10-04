---
status: complete-canon-and-handoff-prepared
kind: canonical-design-and-runtime-change
created: 2026-10-03
origin: guided-add
request_classification: NEW_PLAN
approval_mode: per-plan
approval_selection: user-explicit-2026-10-03
approved: 2026-10-03
---

# The First Nine — carroça, relíquias, prólogo da caverna e viagem

## Objetivo

Consolidar a carroça como centro narrativo e mecânico de *The First Nine*:
ela guarda as relíquias Thalestriel, abriga os oito doentes e jamais é
abandonada. A mudança formaliza o prólogo em caverna, o tutorial de ciclo
dia/noite, o encontro de Shar após o primeiro chefe e as regras de viagem,
postos regionais e teias permanentes.

## Decisões propostas

1. A carroça contém relíquias insubstituíveis da família Thalestriel. O grupo
   não abandona a carroça nem um de seus membros; recursos comuns podem ser
   gastos ou perdidos, relíquias não.
2. O jogo abre com uma HQ curta, em inglês, que explica a fuga, a peste, as
   relíquias e a chegada à caverna. Ela antecede o controle do jogador e não
   substitui a HQ posterior `THE KISS OF SHAR`.
3. A caverna é o acampamento inicial: carroça sem cavalo, roda e madeira
   quebradas, oito Thalestriel doentes e Lolth como única personagem apta a
   explorar. O tutorial ensina suprimentos de dia, retorno ao acampamento e
   perigo de ataques noturnos.
4. Após o chefe do primeiro mapa, Shar aparece, concede a Marca I e Lolth cura
   exatamente um Thalestriel à escolha do jogador. Mortes seguintes geram
   `Shadow Echoes` para os limiares posteriores.
5. Quando a carroça estiver reparada e restarem quatro ou menos aliados
   doentes, eles embarcam e a viagem é liberada. Um puxador é obrigatório;
   carga, passageiros, `Might` do puxador e terreno reduzem a velocidade.
6. Aliados curados defendem a carroça. Até dois ocupam postos/missões no mapa,
   ajudando combate ou acesso; cada um possui um posto regional designado, mas
   retorna à carroça antes da viagem. Não há abandono permanente de aliados.
7. A rota principal mantém base reta e contínua para a carroça. Espaços altos
   podem servir às mecânicas de Lolth, sem bloquear a rota da carroça.
8. Um Web Anchor exige o nível de teia indicado; ao ser aberto, cria solo fixo
   e permanente, salvo no estado do mundo, para a carroça atravessar.
9. Na Marca IX, uma HQ mostra Lolth abrir o portal ao Plano dos Sonhos e deixar
   os Thalestriel em segurança com `THE KISS OF SHAR`.

## Impactos

- **Cânone:** amplia a motivação das relíquias, formaliza o prólogo na caverna
  e esclarece a não-separação do grupo.
- **Narrativa:** exige HQ de abertura adicional e preserva a HQ de Shar após o
  primeiro chefe.
- **Runtime:** altera prólogo/tutorial, estado da carroça, viagem, postos,
  persistência de Web Anchors e fluxo de capítulo.
- **Assets/Opus:** exige brief de caverna/acampamento inicial, relíquias,
  carroça quebrada, tutorial dia/noite, postos regionais e teias permanentes.

## Fora de escopo

- Implementar estas mudanças, gerar assets, executar o Opus, adicionar
  dependências, publicar ou alterar regiões posteriores nesta decisão.

## Gaps

- **BLOCKING:** nenhum para a decisão. A atribuição individual dos oito postos
  regionais será definida no plano de capítulos para evitar inventar afinidades
  sem base; esta decisão fixa somente a regra de posto regional e retorno à
  carroça.
- **RESOLVABLE:** parâmetros de velocidade, pressão inimiga e duração do
  tutorial serão balanceados por playtest, não tratados como lore.
- **DEFERRED:** cenas finais, áudio, atlas, colisores, UI final e cada pacote
  de implementação Godot.

## Critérios de aceitação

1. Nenhum documento permite abandonar carroça, relíquias ou aliado.
2. O fluxo de abertura é HQ → caverna/tutorial → primeiro chefe → Shar/Marca I
   → cura escolhida.
3. A viagem só abre com carroça reparada, quatro ou menos doentes e puxador.
4. Postos não deixam aliados permanentemente em mapas anteriores.
5. Web Anchors abertos permanecem como chão para viagens futuras.
6. A rota principal permanece contínua para carroça sem impedir mecânicas
   verticais opcionais de Lolth.

## Plano de voo

| Lote | Trabalho | Saída |
| --- | --- | --- |
| B-001 | Atualizar decisões canônicas e reconciliação de regras substituídas | decisões e precedência registradas |
| B-002 | Especificar HQ inicial, caverna, tutorial, primeiro chefe e Shar | roteiro e fluxograma de abertura |
| B-003 | Especificar estado de carroça, viagem, postos, pressão e Web Anchors | contrato mecânico e saves necessários |
| B-004 | Reconciliar pacote Opus e preparar briefs estritamente necessários | delta de handoff sem despacho |
| B-005 | Implementar em pacotes Godot, testar e registrar evidência | somente sob planos de implementação posteriores |

## Validação planejada

- Conferência de links e precedência canônica.
- Autoteste específico de prólogo, Marca I, quatro doentes, puxador, postos e
  persistência de teia, em plano de implementação aprovado.
- Playtest humano do tutorial, noite, leitura de risco e velocidade da carroça.
