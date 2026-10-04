---
status: curated-reference-only
kind: generated-reference-receipt
created: 2026-10-03
authorization: user-explicit-for-C-01-through-C-05
source_briefs: '[[2026-10-03-opus-5-5-caravan-reference-briefs]]'
canonical_source: '[[2026-10-03-caravan-survival-slow-travel]]'
tool: built-in-image-generation
---

# Lote C — referências de sobrevivência da carroça

## Limite de uso

Estes PNGs são pranchas de referência visual curadas. Não são sprites, atlas, tilemaps, animações, UI final ou arquivos de runtime. Nenhum deles foi admitido em `res://`. A geração usa IA e deve constar na declaração da jam se qualquer resultado for usado na submissão.

## Entregas selecionadas

| Brief | Arquivo | Tamanho | SHA-256 | Curadoria |
| --- | --- | --- | --- | --- |
| C-01 | `c-01-wagon-states-v1.png` | 1672×941 | `d4dabc87828d603216327923b47bc04804c88c76d12da434c4bc3e8c34e431b2` | aprovado como referência de carroça estacionada/reparada/viajante, quatro passageiros e tração humana |
| C-02 | `c-02-allies-roles-v1.png` | 1672×941 | `e11e4fafb0a4670115e7e9f113d360127a15bb8e107b712dc2dde08096d41929` | aprovado como referência de exclusividade entre puxar, defender e cumprir missão |
| C-03 | `c-03-attraction-v2.png` | 1672×941 | `088cc3056cfaac91bc0d83af36db71f7621647dc483b498028884fc3e53aecb9` | aprovado como referência de pressão escalável, ameaça física e recuo após deslocamento |
| C-04 | `c-04-world-transition-v2.png` | 1672×941 | `49980b720fd6cb64da09878360d7b493e19151aad116f30a21321d5db73dec29` | aprovado como referência de transição gradual Thornwake–Stonehook sem corte |
| C-05 | `c-05-survival-hud-v1.png` | 1672×941 | `943451601654e576e72411e76e8f47fda3d9698cfd3da59bbb9897b0ba71091d` | aprovado como hierarquia conceitual de HUD, sem texto final ou binds |

## Instruções usadas

Os prompts completos seguiram os briefs C-01 a C-05, com pixel art 2D dark fantasy, composição lateral 16:9, paleta azul-violeta/âmbar, ausência de texto e uso exclusivo como referência. As restrições determinantes foram:

- C-01: mesma carroça em `stationed`, `travel_locked` e `travelling`; quatro doentes apenas no estado viajante; tração humanoide, nunca animal.
- C-02: Lolth como única protagonista; um drow consistente em tração, defesa e missão mutuamente exclusivas.
- C-03: pressão em quatro leituras, ameaça regional concreta e, no deslocamento, exatamente um drow puxando a carroça enquanto Lolth acompanha.
- C-04: caminho lateral contínuo com mistura progressiva de raízes, musgo, pedra, cordas e montanha; sem carroça, animal, portal ou loading.
- C-05: HUD conceitual sem palavras, números ou binds fixos, apresentando condição, retratos, vagas, puxador, Attraction, ciclo, carga, reparo e Marca.

## Revisão e rejeições

- A primeira variação de C-03 mostrava mais de um puxador e foi rejeitada; `v2` restringe a tração a um único drow.
- A primeira variação de C-04 introduzia tração animal e foi rejeitada; `v2` não mostra veículo ou animal.
- Os cinco arquivos selecionados foram inspecionados visualmente e conferidos por dimensões e hash local.

## Próximo portão

Um novo plano técnico e aprovação explícita são necessários antes de converter qualquer prancha em asset final, integrar em Godot, escrever runtime ou iniciar um pacote H-01–H-05.
