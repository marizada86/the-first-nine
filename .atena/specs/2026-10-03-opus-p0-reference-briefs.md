---
status: prepared-not-authorized
kind: external-reference-briefs
created: 2026-10-03
approval_mode: per-plan
depends_on:
  - '[[2026-10-03-reconciliation-resolutions]]'
  - '[[2026-10-03-opus-reference-manifest-approval]]'
---

# The First Nine — briefs P0 para Opus 5.5

## Regra comum

Cada brief produz uma prancha de referência de pixel art 2D dark fantasy, legível em composição lateral de 1280×720, com contraste de noite azul-violeta e fogo âmbar. Não gerar texto legível, watermark, interface funcional, spritesheet, atlas, asset final, código ou arquivos de runtime. Preservar Lolth como protagonista única controlável e todos os nomes/textos de jogo em inglês quando texto de placeholder for inevitável.

Todos os resultados devem registrar: ID, data, ferramenta, prompt usado, fontes canônicas, hash, proveniência/termos, diretório de revisão e decisão de curadoria. Um resultado sem recibo continua não utilizável.

## R-01 — Camp & checkpoint

**Objetivo:** mostrar o acampamento fixo como retorno seguro e emocional, com carroça central, chama âmbar, estoque, oficina e leitura de save.

**Composição obrigatória:** carroça estacionada, abrigo/chama com emblema de save sem lua, mesa de reparo, cinco posições conceituais de estoque, caminho claro de retorno vindo de uma rota externa e silhuetas dos sobreviventes sem sugerir seguidores.

**Não mostrar:** carroça viajando por mapas, lua como símbolo de save, menu funcional, receitas/custos novos, combate ou habilidade de drow não aprovada.

**Aceitação:** leitura instantânea de `return → store/repair → save → depart`; a chama é o maior acento quente e a carroça conserva materiais de madeira élfica/sucata recuperada.

## R-02 — Thornwake action read

**Objetivo:** mostrar a promessa da vertical slice: exploração de salvage de dia, ameaça física à carroça à noite e retorno compreensível.

**Composição obrigatória:** ruína/raiz recuperável, item físico útil, Lolth em silhueta jogável, carroça/acampamento distante mas localizável, Briar Hound perseguindo Lolth, Stag of Mire correndo para a carroça com telegraph claro e Antlered Hunger como presença de elite ao fundo.

**Não mostrar:** inimigos de sombra genéricos, moedas, mapas procedurais, combate de multidão, estética ou marcas de outro jogo.

**Aceitação:** pickup, perigo, rota de retorno e os três papéis inimigos são distinguíveis sem texto; VFX/cores não escondem collision space ou telegraph.

## R-03 — Marks & allies

**Objetivo:** estabelecer a leitura de Marca I, a primeira cura e o primeiro posto de Thalestriel sem criar um sistema de party controlável.

**Composição obrigatória:** Lolth antes/depois da Marca I em continuidade visual; Shar como presença narrativa distante; um sobrevivente élfico e seu correspondente drow com mesma identidade; oito retratos na ordem Aelira, Vaelun, Nimara, Thaviel, Ilyren, Orisya, Soreth e Luraen; baseline de chão 1,00 para figuras jogáveis.

**Não mostrar:** armas/equipamentos novos, biografia inventada, Shar jogável, drows seguindo Lolth ou escala de altura diferente para os Thalestriel.

**Aceitação:** a cura lê como alteração emocional/tática, a Marca não parece loot e os símbolos de posto sugerem assistência contextual limitada.

## R-04 — Interface/VFX delta

**Objetivo:** reconciliar a futura linguagem de UI e VFX com acampamento fixo, retorno, carga e ameaça inimiga física.

**Composição obrigatória:** variantes conceituais de HUD com vida, `RECOVERED LOAD`, ciclo, chama/condição da carroça, objetivo material, Echoes e posto disponível; painel conceitual de oficina; aviso de Stag direcionado à carroça; VFX de Marca/Echo que deixa alvo e telegraph visíveis.

**Não mostrar:** binds de teclas fixos, texto gerado como conteúdo final, números de balanceamento imutáveis, UI implementada, elementos que pareçam controle direto dos drows.

**Aceitação:** estados críticos podem ser identificados em segundos, os prompts permanecem agnósticos de entrada e o violeta de sombra não disputa com a chama, perigo ou pickups.

## Próximo portão

Estes briefs estão preparados, mas não autorizados para execução. O usuário deve escolher explicitamente um ou mais IDs `R-01` a `R-04` antes de executar o Opus 5.5 externamente.
