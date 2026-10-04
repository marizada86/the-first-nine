---
status: complete-user-approved-reference-only
kind: asset-reference-refresh
created: 2026-10-03
approved: 2026-10-03
approval_source: user-explicit-per-plan
approval_mode: per-plan
request_classification: NEW_PLAN
depends_on:
  - '[[2026-10-03-stonehook-reference-batch-e]]'
  - '[[2026-10-03-minimal-character-visual-direction]]'
  - '[[2026-10-03-minimal-stonehook-visual-direction]]'
---

# Lote E-M — atualização minimalista de Stonehook Mountains

## Escopo

Gerar cinco referências minimalistas: panorama lateral, recursos de reparo, travessia e risco, ameaças regulares e Stone Maw. Os arquivos serão referências visuais apenas e não entram no runtime.

## Aceitação

- Cinco PNGs sem texto, watermark ou UI final.
- Recursos, rota, risco e inimigos distinguíveis em vista lateral.
- Stone Maw mineral, massivo, assimétrico e não humanoide; ameaças regulares com silhuetas simples.
- Transição ambiental gradual vinda de Thornwake.
- Prompts, hashes, tentativas, recibo e evidência em `.atena/`.

## Gaps

- **BLOCKING:** nenhum.
- **RESOLVABLE:** paleta inferida das referências minimalistas aprovadas, mantendo Stonehook fria e legível.
- **DEFERRED:** sprites finais, atlas, tiles, colisão, animação, implementação Godot e admissão em runtime.

## Plano de voo

1. Gerar cada uma das cinco referências, com no máximo duas tentativas por item.
2. Validar leitura, ausência de texto e aderência à direção aprovada.
3. Registrar proveniência, recibo e evidência, e encerrar o plano preservando a revisão humana como opcional.

## Resultado

Cinco referências foram geradas, passaram pela validação automática e receberam aprovação explícita do usuário. Recibo: `[[2026-10-03-minimal-stonehook-batch-e2]]`. A admissão em runtime continua diferida.
