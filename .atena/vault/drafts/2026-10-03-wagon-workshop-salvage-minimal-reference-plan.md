---
status: proposed
kind: asset-reference-batch
created: 2026-10-03
approval_mode: per-plan
depends_on:
  - '[[2026-10-03-caravan-open-utility-layout]]'
  - '[[2026-10-03-caravan-awakening-progression]]'
---

# Plano — oficina da carroça e salvamento minimalistas

## Objetivo

Criar cinco referências visuais para a mesa de craft, armazenamento, materiais recuperados, reparos curtos e defesas noturnas da carroça aberta. Não cria crafting livre, árvore de tecnologia, receitas novas ou runtime.

## Escopo

1. Mesa de craft aberta: ferramentas curtas e espaço de trabalho na carroça.
2. Baús e organização: armazenamento visual sem inventário/UI.
3. Materiais recuperados: madeira, metal, corda, resina e lona em leitura simples.
4. Reparo: eixo, freio e roda como trabalho pontual, sem cavalo.
5. Defesa improvisada: barricada, luz e peças reaproveitadas, sem torre/base permanente.

## Direção aplicada

- Pixel art lateral minimalista, grandes massas e paleta curta de madeira escura, metal frio e luz âmbar.
- O objeto recuperável é sempre distinguível do objeto reparado e da defesa.
- A carroça preserva baús, assentos e mesa; não ganha quartos ou animal de tração.

## Não escopo

- Receitas, custos, tempos, inventário, UI, árvores de tecnologia, estruturas permanentes, sprites finais, animações ou Godot.

## Aceitação

- Cinco PNGs sem texto, watermark, HUD ou botões.
- Mesa, baú, material, reparo e defesa são legíveis em câmera lateral.
- Sem cavalo, quarto, base fixa ou mecânica nova.

## Gaps

- **BLOCKING:** nenhum.
- **RESOLVABLE:** materiais aparecem como linguagem visual, não como quantidade ou receita.
- **DEFERRED:** dados, interface, economia e implementação.

## Plano de voo

1. Gerar cinco referências, até duas tentativas por item.
2. Validar a carroça aberta e os limites de crafting.
3. Registrar recibo/evidência e aguardar curadoria humana.
