---
status: complete-user-approved-reference-only
kind: asset-reference-refresh
created: 2026-10-03
approved: 2026-10-03
approval_source: user-explicit-per-plan
approval_mode: per-plan
request_classification: NEW_PLAN
depends_on:
  - '[[2026-10-03-hollowroot-reference-batch-f]]'
  - '[[2026-10-03-minimal-character-visual-direction]]'
  - '[[2026-10-03-minimal-hollowroot-visual-direction]]'
---

# Lote F-M — atualização minimalista de Hollowroot Caverns

## Escopo

Gerar cinco referências minimalistas: panorama, materiais/ferramentas, riscos/passagens, inimigos regulares e Hollow Mother. Os arquivos são referências visuais apenas e ficam fora do runtime.

## Aceitação

- Cinco PNGs sem texto, watermark ou UI final.
- Rota, recurso, risco, passagem e criatura distinguíveis em vista lateral.
- Ameaças não humanoides e com silhuetas diferentes.
- Transição gradual de Stonehook para Hollowroot.
- Prompts, hashes, tentativas, recibo e evidência em `.atena/`.

## Gaps

- **BLOCKING:** nenhum.
- **RESOLVABLE:** bioluminescência restrita para preservar a leitura entre rota, recurso e risco.
- **DEFERRED:** sprites finais, atlas, tiles, colisão, animação, implementação Godot e admissão em runtime.

## Plano de voo

1. Gerar cinco referências, com no máximo duas tentativas por item.
2. Validar a leitura, a ausência de texto e a aderência à direção aprovada.
3. Registrar proveniência, recibo e evidência, mantendo a curadoria humana antes do encerramento.

## Resultado

Cinco referências foram geradas, validadas e aprovadas pelo usuário. Recibo: `[[2026-10-03-minimal-hollowroot-batch-f2]]`. A admissão em runtime continua diferida.
