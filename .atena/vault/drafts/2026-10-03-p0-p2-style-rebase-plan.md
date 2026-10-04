---
status: complete-user-approved-reference-only
kind: production-master-style-rebase
created: 2026-10-03
approval_mode: per-plan
reference_anchor: 'exec-bcb511e1-5da9-47a1-9840-2d75a93facfa'
approval_source: user-explicit
costume_rule: '[[2026-10-03-full-trousers-character-skin-rule]]'
supersedes_operationally:
  - '[[2026-10-03-p0-loop-production-masters-plan]]'
  - '[[2026-10-03-p1-survival-travel-production-masters-plan]]'
  - '[[2026-10-03-p2-thornwake-stonehook-production-masters-plan]]'
---

# Plano — correção de estilo dos masters P0–P2

## Objetivo

Regenerar os quinze masters P0, P1 e P2 como versões v2, corrigindo o desvio visual apontado pelo usuário. A referência `exec-bcb511e1-5da9-47a1-9840-2d75a93facfa` é a âncora de estilo. As versões v1 são preservadas para histórico; os masters continuam fora do Godot.

## Travas obrigatórias de estilo

- Perfil lateral e leitura de gameplay; nunca visão superior ou isométrica.
- Figuras e props heroicos grandes, silhueta forte e pixel clusters médios/grandes.
- Fundo transparente para masters de personagem/prop/VFX; faixa lateral neutra para cenário quando necessária.
- Paleta escura e contorno seletivo; sem render genérico de RPG, microtextura, gradiente pictórico ou grade visível.
- Prancha orientada à ação/uso no jogo, não catálogo de tiles decorativos.

## Correções de conteúdo

- A carroça é aberta, tem baús, assentos e mesa de craft; nunca cavalo, quarto, cama privada ou humano genérico como puxador.
- Lolth/drows mantêm identidade élfica/drow e baseline; drows não parecem controláveis.
- Terreno e riscos aparecem em perfil lateral modular, nunca por vista superior.
- Inimigos e chefes preservam silhuetas regionais e leitura lateral.

## Escopo

1. P0 v2: Lolth, carroça, pickups, VFX, props de Thornwake.
2. P1 v2: doentes, drows, cura, viagem puxada e oficina/defesa.
3. P2 v2: terreno Thornwake, terreno Stonehook, props/riscos, inimigos e chefes.
4. Atualizar recibos para apontar v2 como referência vigente, mantendo v1 como histórico.
5. Registrar a trava de estilo para todos os futuros masters.

## Não escopo

- Sprite sheets finais, atlas, importação, cenas, código, colisão, UI, balanço, áudio ou integração Godot.

## Aceitação

- Quinze PNGs v2, cinco por lote, sem texto/watermark/UI.
- Nenhum master em visão superior/isométrica ou com grade de tiles visível.
- Carroça, personagens e regiões respeitam os contratos acima.
- V1 preservada; v2 permanece não admitida no runtime.

## Gaps

- **BLOCKING:** nenhum.
- **RESOLVABLE:** a referência ancora composição e economia visual, sem copiar personagem, roupa, asset ou marca externa.
- **DEFERRED:** recorte técnico e validação de escala no Godot.

## Plano de voo

1. Registrar a trava visual corrigida.
2. Regenerar P0, P1 e P2, até duas tentativas por item.
3. Inspecionar lateralidade, escala e conteúdo obrigatório.
4. Atualizar recibo/evidência e aguardar curadoria humana.
