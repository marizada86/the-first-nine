---
status: draft
kind: visual-direction
created: 2026-10-03
origin: approved-master-production-plan
depends_on: '[[2026-10-03-production-reset-and-opus-handoff]]'
---

# The First Nine — guia mestre de linguagem visual

## Quadro mestre A

Pixel art 2D de dark fantasy: silhuetas legíveis, ruínas melancólicas e uma fonte quente de segurança contra ambientes frios. A câmera lateral privilegia plataformas, perigos e retorno visual à carroça. O contraste de valor, não ruído de detalhe, conduz a leitura de jogo.

| Elemento | Direção de referência | Regra de produção |
| --- | --- | --- |
| Escala | Lolth ocupa uma altura consistente de gameplay; inimigos regulares leem em uma tela de ação | definir célula e pivô por atlas antes da produção final; não misturar escalas |
| Paleta | noite azul-violeta, sombras quase pretas com acento violeta, chama âmbar/dourada, materiais terrosos dessaturados | cada região ganha 1–2 acentos próprios sem perder o contraste da chama |
| Luz | bordas frias e recortes quentes ao redor de fogo, braseiro e UI crítica | luz nunca reduz legibilidade de colisão, pickup ou inimigo |
| Silhueta | Lolth é esguia e forte; drows são identificáveis pelo retrato/posto; monstros por forma regional | toda animação deve funcionar em leitura monocromática |
| Materiais | madeira rachada, metal gasto, corda, pedra úmida, fungo e areia vítrea em clusters simples | textura serve à leitura do objeto recuperável, não a detalhe gratuito |
| Câmera | lateral com enquadramento de ameaça e rota; parallax discreto | UI e prompts ficam no espaço de tela, sem sobrepor o alvo |
| HUD | painéis escuros, bordas finas quentes, ícones de alto contraste | mostra vida, carga, ciclo, condição/chama, Echoes, objetivo e prompt contextual |

## Referências locais de continuidade

- Personagem: `assets/concept-art/characters/lolth-definitive-production-sheet-v1.png`, `first-elves-portrait-sheet-v1.png`, `first-drows-portrait-sheet-v1.png`.
- Carroça e acampamento: `assets/concept-art/key-art/the-last-camp-elven-survivors-v2.png` e `assets/art/camp/*` como referência de protótipo, não asset final.
- Marca, UI e VFX: `assets/concept-art/characters/lolth-mark-evolution-v1.png`, `assets/art/ui/*`, `assets/art/vfx/*` como referência de linguagem, não admissão final.

## Critérios de aprovação do quadro A

1. Uma tela mestre mostra Lolth, carroça, inimigo, pickup, HUD e profundidade de cenário na mesma escala.
2. A leitura de personagem, ameaça, pickup e entrada contextual permanece clara em 1280×720 e em captura reduzida.
3. Paleta, luz e pivôs são documentados no manifesto antes de produzir os demais lotes.
4. Nenhuma referência aprovada é tratada como asset final sem proveniência, licença e admissão separadas.
