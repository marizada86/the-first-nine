---
status: approved
kind: asset-reference-batch
created: 2026-10-03
approved: 2026-10-03
approval_source: user-explicit
origin: direct-execution-reconciled-by-guided-approval
depends_on:
  - '[[2026-10-03-visual-language-a-approval]]'
  - '[[2026-10-03-thalestriel-survivor-names]]'
  - '[[2026-10-03-thalestriel-contextual-assists]]'
---

# Lote B — protagonistas e escala de personagens

## Escopo proposto

Criar exclusivamente referências de revisão para: Lolth élfica, Lolth drow, Shar e os oito Thalestriel, antes de inimigos ou NPCs. Os resultados ficariam em `.atena/generated/`, com recibo de geração, validação de proporção e nenhuma importação em `res://`.

| ID proposto | Conteúdo de referência | Uso posterior |
| --- | --- | --- |
| `char.lolth.elf` | retrato, turnaround, idle, locomoção, salto, ataque e esquiva | protagonista pré-Marca |
| `char.lolth.drow` | retrato, turnaround, idle, locomoção, sombra e ação | protagonista pós-Marca |
| `char.shar` | retrato e presença do encontro de Marca | narrativa, nunca personagem jogável |
| `char.thalestriel.elves` | lineup e retratos de Aelira, Vaelun, Nimara, Thaviel, Ilyren, Orisya, Soreth e Luraen | prólogo e condição debilitada |
| `char.thalestriel.drows` | lineup, retratos e leitura de posto dos mesmos oito | cura e assistência contextual |

## Contratos invioláveis

- Lolth é a única personagem diretamente controlável; os oito drows não recebem IA de seguidores, comandos, inventário ou ficha de combate.
- Os nomes, papéis e posições dos retratos preservam a decisão canônica de roster.
- Shar é uma presença narrativa; esta referência não inventa uma ficha jogável, história adicional ou nova forma de ascensão.
- Linguagem visual A é obrigatória: pixel art 2D, contraste noite violeta/fogo âmbar, silhueta clara e leitura de UI sem texto dentro da arte.
- Nada desta fase é asset final, sprite sheet de runtime ou admissão em `res://`.

## Critérios de aceitação

1. Cada sujeito aparece com silhueta e materiais coerentes com o lote A.
2. Os oito sobreviventes podem ser identificados por nome, papel e posição do retrato sem adicionar biografia.
3. A forma drow mantém identidade reconhecível do sobrevivente correspondente.
4. Toda figura jogável declarada no manifest recebe razão mensurável contra Lolth e compartilha linha de chão/pivô de referência.
5. Todo arquivo tem prompt, proveniência, hash, divulgação de IA e decisão de validação; falhas viram exceções, não são ocultadas.

## Gap resolvido

**RESOLVIDO — proporções de referência.** A aprovação explícita fixou a regra no registro `[[2026-10-03-protagonist-reference-scale]]`.

### Default proposto para aprovação

Usar **Lolth = 1,00** como baseline de figura jogável; Lolth drow e os oito Thalestriel usam **1,00** em uma prancha de referência com pés na mesma linha de chão. A diferenciação fica em silhueta, roupa, postura e papel, não em estatura. Shar fica fora da medição de personagem jogável por ser presença narrativa. Isso é uma convenção de produção, não lore nem tamanho final de sprite.

## Plano de voo aprovado

1. Registrar a regra de escala aprovada e criar manifest JSON com `approval: approved`.
2. Validar o manifest com o skill `batch-image-autopilot`.
3. Gerar somente as cinco pranchas acima, cada uma com no máximo duas tentativas.
4. Medir e registrar as figuras jogáveis; marcar como exceção o que não puder ser medido ou não mantiver a proporção.
5. Revisar consistência, proveniência, hashes e exclusão de runtime; pedir aceitação humana antes de tornar B referência canônica.

## Não-objetivos

Não gerar inimigos, ambientes, UI final, assets admitidos, animações finais, arte de lote C–J, código, dependências ou qualquer alteração do protótipo.

## Reconciliação direta

Este documento foi preparado em execução direta a pedido de “prossiga” e reconciliado pela aprovação Guided ADD do plano e da regra de escala em 2026-10-03.
