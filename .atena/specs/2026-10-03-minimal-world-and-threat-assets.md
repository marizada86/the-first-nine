---
status: complete-user-approved-reference-only
kind: minimal-world-reference-plan
created: 2026-10-03
request_classification: PLAN_CHANGE_REQUEST
request_mode: direct
approval_mode: per-plan
approved: 2026-10-03
depends_on:
  - '[[2026-10-03-minimal-character-visual-direction]]'
  - '[[2026-10-03-caravan-survival-slow-travel]]'
  - '[[2026-10-03-thornwake-references-d-approval]]'
---

# The First Nine — lote minimalista de mundo, salvage e ameaças

## Objetivo

Expandir a nova leitura minimalista para os assets centrais de Thornwake sem tocar no Godot: carroça, acampamento, chão/vegetação, pickups de salvage e inimigos regionais. As referências preservam os papéis já aprovados e usam blocos de pixels grandes, paletas curtas e silhuetas claras, sem imitar assets externos.

## Escopo

| ID | Referência | Leitura obrigatória |
| --- | --- | --- |
| W-01 | Carroça e acampamento | estacionada, reparo e viagem humana sem cavalo; abrigo e chama |
| W-02 | Kit de terreno Thornwake | solo lateral, plataforma, raiz, pedra, vegetação e água rasa em camadas mínimas |
| W-03 | Salvage e pickups | madeira, erva, sucata/metal, água e carga recuperada; distinguíveis sem texto |
| W-04 | Briar Hound | perseguidor baixo e rápido, silhueta de espinhos |
| W-05 | Stag of Mire | ameaça maior com telegraph de investida contra a carroça |
| W-06 | Antlered Hunger | elite de encerramento de noite, grande e legível sem excesso de detalhe |

## Regras visuais

- Objetos e inimigos seguem a paleta curta, grupos grandes de pixels, textura mínima e contraste funcional de `[[2026-10-03-minimal-character-visual-direction]]`.
- A carroça não tem cavalo nem tração animal; quando viajar, uma única figura humanoide a puxa.
- Pickup é um objeto físico de salvage, não moeda ou ícone flutuante.
- Briar Hound persegue Lolth; Stag aponta/avança contra a carroça; Antlered Hunger é elite regional. Nenhuma ameaça é uma sombra genérica.
- Os resultados são referências em `.atena/generated/`, não sprite final, atlas, tileset importado, cena, código ou asset admitido.

## Não objetivos

Não produzir UI, VFX, capítulos posteriores, cavalo, mundo aberto, mapas finais, runtime, build, dependência, publicação ou integração no Godot. Não substituir os assets de personagem aprovados.

## Critérios de aceitação

1. Cada item é lido em miniatura e a 1280×720 por silhueta e cor, sem texto.
2. A carroça comunica peso, reparo e tração humana única; nunca cavalo.
3. Terreno, salvage e ameaças têm leitura de gameplay distinta e mantêm a paleta minimalista.
4. Os três inimigos preservam seus papéis mecânicos sem introduzir novos poderes ou lore.
5. Cada saída recebe prompt, hash, dimensões, proveniência, curadoria e declaração de IA.
6. Nenhum arquivo fora de `.atena/generated/` é alterado.

## Gaps

- **BLOCKING:** nenhum para referências.
- **RESOLVABLE:** começar por Thornwake, pois é o capítulo jogável e contém carroça, salvage e as três ameaças iniciais.
- **DEFERRED:** tamanho de tile, atlas, pivôs, colisão, animação, implementação de telegraph, importação e demais capítulos.

## Plano de voo

1. Gerar e curar W-01 a W-06 em diretório isolado.
2. Rejeitar variações que incluam tração animal, detalhe pictórico excessivo, texto, UI ou comportamento não canônico.
3. Registrar recibo, hash, dimensão, prompt resumido, AI disclosure e evidência.
4. Encerrar com referências curadas, sem converter em runtime.

## Aprovação solicitada

Autorizar a geração e curadoria de W-01 a W-06 como referências minimalistas em diretório de revisão. Não autoriza admissão no Godot, sobrescrita, runtime, dependências, publicação ou execução externa.
