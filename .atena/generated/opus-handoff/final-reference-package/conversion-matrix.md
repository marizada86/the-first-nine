# Matriz de conversao para runtime

| Familia | Converter em | Pivot | Estados minimos | Consumidor futuro |
| --- | --- | --- | --- | --- |
| Lolth | atlas transparente | centro inferior | idle, run, attack, shadow cast, hurt, pull | personagem controlado |
| Thalestriel | atlas por estado | centro inferior ou assento | plagued abrigo/passageiro; cured posto/defesa/missao/puxar | contexto da carroca |
| Carroca | atlas por estado e carga separada | contato das rodas/chao | parada, puxada lenta, dano/reparo | viagem e oficina |
| Terreno | modulos laterais e parallax | linha de chao | base, variacao, gate de teia | streaming regional |
| Inimigos | atlas por familia | contato no chao | idle, mover, atacar, hurt, derrota | combate regional |
| VFX e Marcas | atlas transparente | centro visual | inicio, loop curto, fim | combate e narrativa |
| Shar/final | keyframes ou layers narrativas | por composicao | presenca, beijo, limiar, portal | sequencias narrativas |

Masters sao referencias, nao spritesheets: o Opus deve recortar ou redesenhar em novos arquivos versionados. Colisao nunca deve ser embutida na arte.
