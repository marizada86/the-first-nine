---
status: proposed
kind: production-asset-masters
created: 2026-10-03
approval_mode: per-plan
depends_on:
  - '[[2026-10-03-p0-loop-production-masters-plan]]'
  - '[[2026-10-03-caravan-open-utility-layout]]'
  - '[[2026-10-03-caravan-survival-slow-travel]]'
---

# Plano — P1 masters técnicos de sobrevivência e viagem

## Objetivo

Produzir cinco masters técnicos para aliados doentes/curados, cura, funções contextuais, carroça puxada e oficina. São novos arquivos de produção sob `.atena/generated/`; não entram em `assets/` ou Godot.

## Escopo

1. Master dos Thalestriel `plagued`: abrigo e passageiro sentado, sem quartos.
2. Master dos drows `cured`: defesa, missão e tração como estados exclusivos, sem party controlável.
3. Master do ritual de cura: sombra de Shar se desfaz e fios de Lolth emergem, sem Marca IX/nona cura.
4. Master de viagem: carroça aberta puxada por uma pessoa, vazia e com quatro passageiros doentes.
5. Master de oficina/defesa: mesa, baús, reparo curto e barricada improvisada.

## Contratos técnicos propostos

- Personagens em células de 48×48 px; baseline unificada.
- Carroça em master 128×64 px, com puxador, carga e rodas em camadas visuais separadas.
- Cura/VFX em células 48×48 transparentes.
- Props de oficina em grade 24×24 ou 32×32; pivô inferior central.

## Não escopo

- Integração Godot, atlas final, colisões, IA, escolhas, UI, economia, balanceamento, animação programada ou novos sistemas.

## Aceitação

- Cinco PNGs de master sem texto/watermark; fundo transparente onde aplicável.
- Sem cavalo, quartos, cama privada, party controlável ou nona cura.
- Convenções documentadas e arquivos preservados fora do runtime.

## Gaps

- **BLOCKING:** nenhum.
- **RESOLVABLE:** seleção final das quatro identidades de passageiro será feita na admissão, não na referência.
- **DEFERRED:** atlas, código, dados de capacidade e testes Godot.

## Plano de voo

1. Gerar os cinco masters P1, até duas tentativas por item.
2. Validar os contratos visuais de carroça, cura e funções.
3. Registrar recibo/evidência e aguardar curadoria humana.
