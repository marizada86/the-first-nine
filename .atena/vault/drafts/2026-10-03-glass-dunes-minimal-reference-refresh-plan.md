---
status: proposed
kind: asset-reference-refresh
created: 2026-10-03
approval_mode: per-plan
depends_on:
  - '[[2026-10-03-glass-dunes-reference-batch-g]]'
  - '[[2026-10-03-minimal-hollowroot-visual-direction]]'
---

# Plano — atualização minimalista de Glass Dunes

## Objetivo

Criar cinco referências minimalistas para Glass Dunes, preservando sua leitura de travessia exposta, água e abrigo. O lote fica exclusivamente em `.atena/generated/`, sem mudança no Godot.

## Escopo

1. Panorama lateral: saída gradual das cavernas para dunas vítreas, ruínas baixas, rota exposta e abrigo visível.
2. Recursos: água, lona e vidro reaproveitável como três props distintos de salvamento.
3. Riscos: areia cortante, sol/exposição e trechos sem abrigo, sem criar sistemas ou números novos.
4. Ameaças regulares: Glass Scorpion e Dune Strider com silhuetas simples e não humanoides.
5. Sunken Colossus: chefe visualmente humanoide conforme decisão aprovada, porém minimalista, mineral e sem UI/cópia externa.

## Direção aplicada

- Pixel art lateral com grandes massas, paleta curta de ocre-violeta, sombras azuladas e brilho de vidro apenas como acento funcional.
- Transição gradual: a pedra e a luz fúngica de Hollowroot dão lugar a abertura, areia e ruínas; sem corte, fade ou loading.
- Água e abrigo devem diferir claramente de risco ambiental.
- A referência externa do usuário informa apenas economia e legibilidade; nada de terceiros será copiado.

## Não escopo

- Sprites finais, atlas, tiles, colisões, pivôs, animações, som, UI, implementação Godot e admissão em runtime.
- Regras, números de água/exposição/dano, Marcas V–VI, curas, receitas ou mudanças de narrativa/mecânicas.

## Aceitação

- Cinco PNGs sem texto, watermark ou UI final.
- Leitura lateral clara entre rota, recurso, abrigo, risco e criatura.
- Sunken Colossus respeita a decisão visual humanoide aprovada; os demais inimigos não são humanoides.
- Prompts, hashes, tentativas, recibo e evidência ficam registrados em `.atena/`.

## Gaps

- **BLOCKING:** nenhum.
- **RESOLVABLE:** a leitura de calor/exposição será ambiental, sem medidores ou regras novas.
- **DEFERRED:** especificação técnica, runtime, implementação Godot e admissão dos assets.

## Plano de voo

1. Registrar a extensão minimalista para Glass Dunes.
2. Gerar cinco referências, com até duas tentativas por item.
3. Validar leitura, ausência de texto e aderência à direção aprovada.
4. Registrar recibo/evidência e aguardar curadoria humana antes do encerramento.

## Recuperação

Se um item falhar em duas tentativas, ele fica pendente e a referência anterior é preservada. Nenhum arquivo existente será apagado.
