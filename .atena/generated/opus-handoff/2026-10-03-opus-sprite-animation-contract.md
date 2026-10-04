# Contrato de sprites e animação — Opus

## Base comum

- Master em pixel art com fundo transparente; sem suavização na importação.
- Baseline única por família; pivô no centro inferior para seres, no contato da roda/chão para carroça e props apoiados.
- Colisores separados do desenho e definidos na cena, nunca embutidos na prancha de referência.
- Atlas por família e versão; nunca recortar diretamente uma prancha de referência aprovada.

## Estados mínimos

| Família | Estados | Colisão proposta |
| --- | --- | --- |
| Lolth | idle, run, short attack, shadow cast, hurt, pull | corpo baixo, ataque/VFX separado |
| Drow `plagued` | abrigo, passageiro sentado | não ativo/ambiental |
| Drow `cured` | posto, defesa, missão, puxar | corpo contextual, sem controle do jogador |
| Carroça | parada, puxada lenta, dano/reparo | corpo + rodas; carga visual separada |
| Inimigos/chefes | idle, mover, atacar, hurt, derrota | corpo + ataque separados |
| Props | idle e variação de dano/coleta quando aplicável | estático/interação separada |

## Ritmo inicial proposto

Idle 4 quadros, movimento 6–8, ataque 4–6, hit 2–3. Esses valores são metas de orçamento, não parâmetros de gameplay.
