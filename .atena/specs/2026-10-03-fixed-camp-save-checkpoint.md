---
status: draft-awaiting-approval
kind: game-design-change
created: 2026-10-03
origin: guided-add
depends_on:
  - '[[2026-10-03-caravan-awakening-progression]]'
  - '[[2026-10-03-night-clock-caravan-stakes]]'
  - '[[2026-10-03-thalestriel-contextual-assists]]'
---

# Acampamento fixo e checkpoint de entrada

## Mudança proposta

- O acampamento passa a ser um lugar fixo, fora dos mapas de coleta.
- Lolth sai do acampamento para explorar mapas separados e retorna a ele com recursos.
- Ao entrar no acampamento, o jogo grava automaticamente o checkpoint atual.
- O checkpoint de acampamento substitui o retorno a checkpoints de Marca como ponto de restauração operacional; Marcas continuam progresso narrativo e de cura, não locais de save.

## Símbolos

- A lua/crescente, dreamcatcher e acentos violeta pertencem a **Luraen, a Sonhadora**, pois representam sua assistência de revelar passagem, Echo ou plataforma ligada ao Sonho.
- O novo símbolo de acampamento/save é proposto como **uma chama âmbar dentro de um abrigo/aro simples**, sem lua. Ele comunica abrigo, retorno e persistência sem invadir a identidade de Luraen.

## Impactos

- A carroça continua a concentrar estoque, oficina e preparação, mas deixa de ser a unidade que se desloca entre capítulos.
- A defesa noturna e a condição da carroça ocorrem no acampamento fixo; dano, raio de ataque e balanceamento seguem dados futuros.
- A exploração de recursos começa no acampamento, atravessa um portal/saída de mapa e retorna ao save; não cria mundo aberto.
- UI futura deve mostrar confirmação discreta de salvamento ao entrar no acampamento, sem texto embutido nas referências visuais.

## Aceitação

1. Entrar no acampamento chama uma única gravação de checkpoint e atualiza o ponto de retorno.
2. Morte de Lolth ou destruição da carroça restaura o último save de acampamento, sem morte permanente de Thalestriel.
3. Lua não aparece no emblema do save; Luraen conserva o motivo lunar/onírico.
4. Nenhuma implementação, asset final ou alteração de runtime ocorre antes de plano técnico próprio.

## Gaps

- **BLOCKING:** aprovação explícita desta substituição de checkpoint móvel/Marca por save de entrada no acampamento.
- **RESOLVABLE:** aparência final do símbolo e feedback de save entram no próximo lote de UI/props.
- **DEFERRED:** formato de arquivo de save, frequência de escrita, tela de carregamento e implementação Godot.
