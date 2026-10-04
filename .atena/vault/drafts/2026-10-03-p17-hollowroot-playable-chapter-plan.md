---
status: complete
kind: hollowroot-playable-chapter-plan
created: 2026-10-03
request_classification: NEW_PLAN
approval_mode: per-plan
approval_selection: user-explicit-2026-10-03
approved: 2026-10-03
sources:
  - '[[2026-10-03-continuous-caravan-ground-and-web-gates]]'
  - '[[2026-10-03-thalestriel-contextual-assists]]'
  - '[[2026-10-03-p16-complete-runtime-v2-migration-plan]]'
---

# P17 — capítulo jogável Hollowroot

## Aprovação

O usuário selecionou aprovação `por plano`. A execução permanece pendente da
aprovação explícita deste P17.

## Objetivo

Tornar Hollowroot o próximo capítulo jogável após Stonehook, reaproveitando os
assets `runtime_v2` já aprovados e preservando o ciclo de coleta, defesa,
Marcas e cura contextual.

## Escopo

1. Liberar a saída de Stonehook para Hollowroot após a segunda cura, mantendo
   transição gradual e rota horizontal contínua.
2. Criar encontros nomeados com Root Wraith, Shard Scarab e Drowned Shade,
   usando o atlas regional existente; implementar Root Crown como chefe de
   Hollowroot.
3. Adicionar coletas, uma defesa noturna e uma Marca de Hollowroot que cura
   exatamente um Thalestriel.
4. Converter o Web Anchor em bloqueio excepcional: Lolth cria chão de teia
   sólido depois da Marca requerida, sem plataformas ou saltos obrigatórios.
5. Estender autoteste, checkpoint, HUD e mensagens apenas para esse capítulo.

## Fora de escopo

- Glass Dunes, Dreamwater, novas regras de cura, novos poderes de Lolth,
  balanceamento final, áudio final, dependências, publicação e remoção de
  legado.

## Padrões resolvidos

- A progressão usará a Marca 3 ao concluir Hollowroot; isso é continuação
  técnica da sequência já existente, não uma alteração de lore.
- O Root Crown será o chefe ativo; os dois outros inimigos do atlas regional
  ficam disponíveis como variações futuras, sem adiantar seus capítulos.
- O Web Anchor só altera uma passagem marcada; o resto do piso permanece
  contínuo.

## Aceitação

- Após Stonehook, o jogador entra em Hollowroot sem tela de mapa ou corte.
- Hollowroot tem coleta, combate, chefe, Marca, cura e checkpoint verificáveis.
- Não há lacunas, plataformas obrigatórias ou controle direto dos drows.
- Importação Godot e `--self-test` passam, com prova visual local.

## Validação

- Scan/importação Godot.
- Autoteste ampliado do percurso Stonehook → Hollowroot.
- Captura local do capítulo com rota, bloqueio de teia e chefe.

## Resultado

Hollowroot está conectado a Stonehook e cobre combate, defesa, Root Crown,
Marca 3, cura, Web Anchor e checkpoint. Ver
`[[2026-10-03-p17-hollowroot-playable-chapter]]`.
