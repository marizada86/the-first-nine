# Pesquisa — tema: Salvage

Status: research (não canônico)  
Data: 2026-10-02

## Referências de design

### Hardspace: Shipbreaker

- Fonte: https://www.blackbirdinteractive.com/shipbreaker
- O que observar: a sequência **inspecionar → separar → classificar** transforma sucata em um quebra-cabeça legível. Perigo (combustível, eletricidade e radiação) dá significado à precisão sem exigir combate.
- Para a jam: troque a simulação física e o corte livre por três a cinco pontos de desmontagem claramente visíveis. Cada retirada deve ter uma consequência imediata e audiovisual.

### DREDGE

- Fonte: https://www.dredge.game/
- O que observar: coletar itens e levá-los em segurança ganha tensão por meio de viagem, espaço de carga e descoberta. O mistério dá valor narrativo ao que seria somente loot.
- Para a jam: use um mapa pequeno, uma limitação de inventário e uma descoberta estranha por partida. O jogador deve escolher entre voltar com segurança ou buscar uma última peça.

### GDC — How to Dissect an Exploding Spaceship in Hardspace: Shipbreaker

- Fonte: https://media.gdcvault.com/gdcsummer2020/presentations/Harrison-Richard-HowToDissectAnExplodingSpaceship.pdf
- O que observar: o jogo completo modela peças e conexões como um grafo. A abstração relevante para a jam é simples: uma peça só se solta ao remover as conexões corretas.
- Para a jam: represente as conexões com cabos, parafusos ou ícones. Não implementar corte de malha, destruição procedural ou simulação geral.

## Hipóteses de conceito para prototipar

1. **Último Mergulho** — mergulhador recupera módulos de um submarino afundado antes que o oxigênio acabe. Loop: entrar, escolher rota, soltar 2–3 travas, levar peça ao sino de mergulho. Tom: suspense aquático.
2. **Ferro-Velho Orbital** — drone reboca sucata entre três destinos de reciclagem. Loop: ler a etiqueta da peça, escolher o ponto seguro de corte, usar cabo magnético para classificar. Tom: ficção científica industrial.
3. **Relíquia da Chuva Ácida** — pequeno robô explora um museu destruído, restaura uma máquina com peças recuperadas e revela memórias. Loop: vasculhar, escolher peça compatível, encaixar e testar. Tom: melancólico e acolhedor.

## Recomendação inicial

Prototipar **Último Mergulho** como um jogo 2D de tela única. É a melhor relação entre tema e prazo: o salvamento é a ação central, há tensão visível (oxigênio e profundidade), e uma única cena polida já comunica a fantasia inteira.

### Vertical slice mínimo

- Um cenário navegável e uma base de retorno.
- Três peças, cada uma atrás de um obstáculo ou trava distinta.
- Um recurso de pressão/oxigênio e um único perigo móvel ou ambiental.
- Vitória ao recuperar a peça principal; derrota ao esgotar o recurso.

### Cortes de escopo deliberados

- Sem mundo procedural, loja, árvore de upgrades, crafting, combate, inventário em grade ou múltiplas fases.
- Sem física de cabos; usar arrastar ou levar uma peça por vez.

## Próximo gate ADD

Escolher uma hipótese (ou combinar elementos) e aprovar uma intenção inicial em `vault/canon/`. Só depois criar uma spec com plano de voo para implementação.
