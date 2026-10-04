---
status: draft
kind: asset-reference-manifest
created: 2026-10-03
depends_on: '[[2026-10-03-production-reset-and-opus-handoff]]'
---

# The First Nine — Manifesto Mestre de Referências Visuais

## Regra de cada item

Cada asset recebe: ID estável, grupo, capítulo, uso em jogo, tamanho/célula, estados, animações, paleta, colisão quando aplicável, prompt-base, referência aprovada, destino no projeto e critério de aceitação.

O tamanho final de célula e o atlas são decisões técnicas do lote A; até a aprovação, `TBD-A` é uma marca explícita e não uma licença para escalar cada asset de forma independente. Os arquivos atuais em `assets/concept-art/` e `assets/art/` são referências de continuidade do protótipo, nunca assets finais admitidos.

## Lotes de referência

| Lote | Conteúdo | Saída de referência |
| --- | --- | --- |
| A — linguagem visual | Paleta, iluminação, câmera, escala, materiais e HUD | 1 quadro mestre aprovado |
| B — protagonistas | Lolth élfica, Lolth drow, Shar, oito Thalestriel | retrato, turnaround, locomoção e ação por personagem necessário |
| C — carroça e acampamento | carroça em estados, oficina, chama, estoque, postos e props | vistas, estados de dano/reparo e sprites de interação |
| D — Thornwake | floresta, recursos, perigos, três monstros e chefe | backdrop, tiles, props, pickups, inimigos e VFX |
| E — Stonehook | montanha, cordas, scree, metal, ferramentas e três monstros | mesma cobertura de D, adaptada à montanha |
| F — Hollowroot | caverna, fungos, passagens, ferramentas e três monstros | mesma cobertura de D |
| G — Glass Dunes | dunas, água, abrigo, ruínas e três monstros | mesma cobertura de D |
| H — Dreamwater | riacho, travessia, plano dos sonhos e três monstros | mesma cobertura de D |
| I — interface e VFX | HUD, inventários, craft, Marca, Echoes, objetivos, prompts e efeitos | atlas/estados coerentes com A |
| J — narrativa | selos de Marca, cenas de Shar, transições e encerramento | storyboards e key art de referência |

## Cobertura mínima por capítulo

- 1 backdrop principal, 2 camadas de parallax, tiles de chão/plataforma e 6 props de leitura.
- Recursos, peça de carroça, risco ambiental e marco narrativo próprios.
- Três inimigos com silhueta, idle, movimento, ataque, dano e derrota.
- Um conjunto de interação para carroça, oficina, postos de drow e HUD contextual.

## Inventário de referências por grupo

| ID | Lote / capítulo | Uso e estados mínimos | Prompt-base / destino | Aceitação |
| --- | --- | --- | --- | --- |
| `style.master-frame` | A | quadro mestre: Lolth, carroça, inimigo, pickup, HUD e parallax | "2D dark-fantasy pixel art, melancholic caravan, cold violet night, warm amber fire, side-view" / `art/references/style/` | escala, paleta, luz e câmera aprovadas em uma tela |
| `style.palette-materials` | A | paleta, rampas de valor, madeira, metal, corda, pedra, fungo e vidro | mesmo quadro mestre / `art/references/style/` | materiais leem sem perder contraste |
| `char.lolth.elf` | B | retrato, turnaround, idle, corrida, salto, ataque, esquiva, dano, derrota | "strong elven Lolth, coherent with master frame" / `art/references/characters/` | pivô/célula `TBD-A`, silhueta clara |
| `char.lolth.drow` | B | mesmos estados + sombra e forma de Marca | "drow Lolth, shadow-mark evolution, readable pixel silhouette" / `art/references/characters/` | evolução preserva proporção de Lolth |
| `char.shar` | B/J | retrato, presença de Marca, pose de encontro | "Shar as distant goddess of forgetting, violet-black pixel art" / `art/references/narrative/` | legível sem competir com Lolth |
| `char.thalestriel.roster` | B | oito retratos élficos e drow, idle de posto | "eight named Thalestriel survivors, consistent portrait order" / `art/references/characters/` | nomes e posições: Aelira, Vaelun, Nimara, Thaviel, Ilyren, Orisya, Soreth, Luraen |
| `camp.wagon` | C | intacta, dano, reparo, defesa, estoque e oficina | "weathered elven caravan, warm fire refuge" / `art/references/camp/` | estados não alteram colisão sem dado correspondente |
| `camp.fire-and-props` | C | chama, braseiro, barricada, alarme, mesa, estoque | "salvaged dark-fantasy camp props" / `art/references/camp/` | chama e condição legíveis à noite |
| `zone.thornwake` | D | backdrop, 2 parallax, chão/plataforma, seis props, pickups, risco | "thorny haunted forest, wet roots, cold violet night" / `art/references/thornwake/` | rota, recurso e perigo distintos |
| `enemy.briar-hound` | D | idle, mover, atacar, dano, derrota | "briar hound forest monster, not a shadow species" / `art/references/thornwake/` | silhueta e telegraph legíveis |
| `enemy.stag-of-mire` | D | idle, mover, atacar, dano, derrota | "mire stag forest monster" / `art/references/thornwake/` | leitura separada do hound |
| `enemy.antlered-hunger` | D | idle, mover, ataque chefe, dano, derrota | "antlered forest hunger boss" / `art/references/thornwake/` | escala de chefe sem ocultar Lolth |
| `zone.stonehook` | E | backdrop, parallax, scree, cordas, metal, ferramentas e props | "dangerous mountain scree, ropes, rusted metal" / `art/references/stonehook/` | quedas e ancoragens legíveis |
| `enemy.scree-crawler` | E | idle, mover, atacar, dano, derrota | "scree crawler mountain monster" / `art/references/stonehook/` | telegraph contra fundo rochoso |
| `enemy.cliff-harrier` | E | idle, mover, atacar, dano, derrota | "cliff harrier mountain monster" / `art/references/stonehook/` | leitura aérea clara |
| `enemy.stone-maw` | E | idle, mover, ataque chefe, dano, derrota | "stone maw mountain boss" / `art/references/stonehook/` | colisão coerente com forma |
| `zone.hollowroot` | F | backdrop, parallax, fungos, passagens, ferramentas e props | "root-filled cavern with bioluminescent fungi" / `art/references/hollowroot/` | fungo não confunde pickup/perigo |
| `enemy.chitin-burrower` | F | idle, mover, atacar, dano, derrota | "chitin burrower cavern monster" / `art/references/hollowroot/` | entrada/saída do solo clara |
| `enemy.sporebound` | F | idle, mover, atacar, dano, derrota | "sporebound cavern monster" / `art/references/hollowroot/` | perigo de esporo visível |
| `enemy.hollow-mother` | F | idle, mover, ataque chefe, dano, derrota | "hollow mother cavern boss" / `art/references/hollowroot/` | chefe não parece espécie de sombra |
| `zone.glass-dunes` | G | backdrop, parallax, dunas, água, abrigo, ruínas e props | "glass dunes, exposed desert, fractured ruins" / `art/references/glass-dunes/` | água/abrigo distinguíveis |
| `enemy.glass-scorpion` | G | idle, mover, atacar, dano, derrota | "glass scorpion desert monster" / `art/references/glass-dunes/` | acento de vidro sem invisibilidade |
| `enemy.dune-strider` | G | idle, mover, atacar, dano, derrota | "dune strider desert monster" / `art/references/glass-dunes/` | silhueta contra horizonte |
| `enemy.sunken-colossus` | G | idle, mover, ataque chefe, dano, derrota | "sunken colossus desert boss" / `art/references/glass-dunes/` | ataque não se mistura à areia |
| `zone.dreamwater` | H | backdrop, parallax, riacho, plano onírico, travessia e props | "moonlit dreamwater stream, surreal dark fantasy" / `art/references/dreamwater/` | mundo real/onírico têm leitura distinta |
| `enemy.reed-eel` | H | idle, mover, atacar, dano, derrota | "reed eel river monster" / `art/references/dreamwater/` | leitura na água clara |
| `enemy.floodborn` | H | idle, mover, atacar, dano, derrota | "floodborn river monster" / `art/references/dreamwater/` | telegraph sobre reflexos |
| `enemy.currentless` | H | idle, mover, ataque chefe, dano, derrota | "the Currentless dreamwater boss" / `art/references/dreamwater/` | foco de boss explícito |
| `ui.hud` | I | vida, carga, ciclo, carroça/chama, Echoes, objetivo, prompt | "minimal high-contrast dark fantasy pixel HUD" / `art/references/ui/` | legível em 1280×720 e com controle |
| `ui.camp-crafting` | I | estoque, receitas, condição, postos e confirmação | "warm camp workshop interface" / `art/references/ui/` | mostra custo, resultado e entrada ativa |
| `ui.marks-and-allies` | I | nove Marcas, Echoes, cura e retratos/postos | "shadow mark seals, drow companion portraits" / `art/references/ui/` | não sugere controle direto de drows |
| `vfx.shadow-and-echo` | I | absorção, ataque, pulso, visão, teia, dano e derrota | "restrained violet-black pixel VFX" / `art/references/vfx/` | efeito nunca encobre alvo/telegraph |
| `narrative.mark-seals` | J | selos I–IX e transições | "nine evolving shadow seals" / `art/references/narrative/` | ordem e ganho conferem com Bíblia |
| `narrative.shar-sequence` | J | HQ do Beijo de Shar e momentos de Marca | "English storyboard, Shar and Lolth, melancholy dark fantasy" / `art/references/narrative/` | texto em inglês e continuidade de personagem |
| `narrative.ending` | J | portal, nove drows e Cidade Dourada dos Sonhos | "nine drows reaching dream golden city" / `art/references/narrative/` | não transforma a cidade em área jogável |

## Metadados obrigatórios de admissão

Antes de qualquer asset final entrar em `res://art/`, seu recibo deve registrar: `asset_id`, lote, fonte/proveniência, licença/termos, arquivo original, hash, formato, célula/pivô, estados, colisão, revisor, data de aprovação e destino. Um asset sem recibo é referência, não conteúdo de runtime.

## Portões de qualidade

1. Aprovado o quadro mestre de linguagem visual antes de gerar outros lotes.
2. Aprovadas as proporções de Lolth e dos drows antes de gerar inimigos ou NPCs.
3. Aprovados os assets de Thornwake antes de se produzir a primeira versão final do runtime.
4. Todo lote recebe revisão de consistência, origem, licença quando aplicável e vínculo ao manifesto antes de admissão no projeto.
