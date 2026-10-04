---
status: complete-user-approved-audit
kind: runtime-art-readiness-audit-plan
created: 2026-10-03
approval_mode: per-plan
approval_selection: user-explicit-2026-10-03
approval_source: user-explicit
sources:
  - '[[2026-10-03-opus-p0-p11-reconciled-technical-contract]]'
  - '[[2026-10-03-p12-opus-technical-package-reconciliation-plan]]'
  - '[[2026-10-03-continuous-caravan-ground-and-web-gates]]'
  - '[[2026-10-03-caravan-survival-slow-travel]]'
---

# Plano P13 — auditoria de prontidão da arte runtime

## Objetivo

Comparar os assets já presentes em `assets/art/` com os 108 masters P0–P11, identificar reutilização segura, substituições necessárias e lacunas reais de produção antes de gerar ou admitir mais arte.

## Escopo

1. Inventariar as folhas runtime existentes por família e consumidor atual.
2. Cruzar cada família com o manifesto P0–P11 e seu contrato técnico vigente.
3. Classificar os arquivos existentes como `reutilizável`, `revisar`, `substituir` ou `fora-da-direção`.
4. Checar incompatibilidades canônicas visíveis: carroça sem cavalo/quartos, rota contínua sem plataformas comuns, drows contextuais e Marcas Shar → Lolth.
5. Produzir uma fila concreta dos candidatos de arte final faltantes, sem gerar, copiar, importar ou excluir arquivos.

## Regras vinculantes

- Auditoria é somente leitura: não altera `assets/`, `res://`, cenas, código, imports, dependências ou arquivos de arte.
- Não declara um asset runtime como aprovado apenas por existir; compara-o com canon e handoff técnico vigente.
- Não elimina histórico nem arquivos que parecem fora da direção. Toda substituição futura será versionada e precisará de plano de admissão próprio.

## Não escopo

Geração de imagens, normalização de atlas, edição Godot, importação, remoção de arquivos, correção de código, balanceamento, testes jogáveis ou publicação.

## Aceitação

- Matriz de prontidão por família com fonte, consumidor, estado e ação recomendada.
- Lista explícita de lacunas para P0–P11 e ordem de produção futura.
- Evidência de que a auditoria não modificou o runtime.

## Gaps

- **BLOCKING:** nenhum para auditoria somente leitura.
- **DEFERRED:** decisão de substituição, criação de assets finais, admissão Godot e testes visuais em runtime.

## Plano de voo

1. Mapear `assets/art/`, referências carregadas pelo código e manifesto P0–P11.
2. Comparar nomes, função, direção visual e restrições canônicas por família.
3. Registrar a matriz, lacunas e ordem recomendada; validar que nenhuma escrita runtime ocorreu.
4. Solicitar revisão humana antes de abrir qualquer plano de produção/admissão.

## Execução autorizada

O plano foi aprovado em 2026-10-03 no modo `per-plan`. A autorização cobre somente a auditoria de leitura e seus registros em `.atena/`.

## Execução concluída, revisão pendente

A auditoria registrou 45 PNGs runtime, 33 carregados por `main.gd`, 12 sem consumidor estático e nenhuma proveniência direta no manifesto P0–P11. A matriz e a fila de produção aguardam revisão humana antes de qualquer plano de admissão.

## Revisão aprovada

Aprovação humana recebida em 2026-10-03. P13 encerrado; o lote núcleo permanece como próximo plano, sem modificar assets legados.
