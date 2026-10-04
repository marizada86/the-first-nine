---
status: complete
kind: project-readiness-audit-and-opus-handoff-gate
created: 2026-10-03
origin: guided-add-plan-change-request
request_classification: PLAN_CHANGE_REQUEST
preceded_by: '[[2026-10-03-p17-hollowroot-playable-chapter]]'
approval_mode: per-plan
approval_selection: user-explicit-2026-10-03
approved: 2026-10-03
---

# The First Nine — pente-fino de prontidão para Opus 5.5

## Objetivo

Auditar integralmente o estado local de *The First Nine*, reconciliar registros
operacionais e entregar um veredito factual de prontidão para um handoff externo
ao Opus 5.5. O resultado define o que pode ser enviado, o que deve ser corrigido
antes e o que requer validação humana, sem despachar material externo.

## Escopo

1. Reconciliar `.atena/state/plan.yaml`, specs, evidências e decisões canônicas,
   incluindo a divergência de autorização/status do P17.
2. Auditar Godot: `project.godot`, cena principal, scripts, imports, autotestes e
   o mapeamento entre consumidores e os candidatos `assets/runtime_v2/`.
3. Auditar arte e produção: masters P0–P11, versões vigentes, arquivos legados,
   rollback, metadados de origem e lacunas para atlas, pivôs, colisão, animação e
   cenas consumidoras.
4. Conferir cânone, mecânicas, progressão, controles, texto ao jogador e regras
   obrigatórias contra o runtime e contra o pacote de handoff.
5. Validar o pacote Opus: inventário, cinco briefs, matriz de conversão,
   exclusões, proveniência, regras de admissão e checklist de validação local.
6. Produzir um relatório priorizado com bloqueios, riscos, correções propostas,
   evidências e uma decisão `PRONTO`, `PRONTO COM CONDIÇÕES` ou `NÃO PRONTO`.

## Fora de escopo

- Executar, enviar ou compartilhar o Opus 5.5 externamente.
- Alterar código, cenas, assets, dependências, cânone, credenciais, publicação,
  deploy, merge ou apagar arquivos.
- Gerar, recortar ou admitir assets finais no Godot.
- Implementar Hollowroot ou qualquer capítulo durante a auditoria.

## Gaps

- **BLOCKING:** nenhum para a auditoria local. O envio externo permanece um
  portão separado, mesmo se o veredito for positivo.
- **RESOLVABLE:** o estado operacional diz que P17 está em execução e aprovado,
  enquanto seu plano declara execução pendente de aprovação. A auditoria registra
  a fonte de verdade e a correção necessária; não executará P17.
- **DEFERRED:** julgamento humano de ritmo, legibilidade e balanceamento; áudio
  final; implementação dos capítulos fora do P17.

## Plano de voo

| Lote | Trabalho | Evidência de saída |
| --- | --- | --- |
| B-001 | Estado ADD, links, decisões e autorização do P17 | registro de reconciliação e inventário de pendências |
| B-002 | Runtime Godot, imports, cena, scripts e autotestes | resultados reproduzíveis e mapa de falhas/riscos |
| B-003 | Assets, masters, runtime_v2, legado, rollback e proveniência | matriz de rastreabilidade asset → consumidor → origem |
| B-004 | Cânone, gameplay, controles, UI/texto e progressão | matriz de conformidade e divergências classificadas |
| B-005 | Pacote Opus, briefs e checklist de admissão | relatório de completude e bloqueios de handoff |
| B-006 | Síntese e gate | relatório final, plano de correção e veredito de prontidão |

## Critérios de aceitação

1. Todo achado cita arquivo local e evidência verificável.
2. Nenhum arquivo de runtime, asset ou cânone é modificado.
3. O relatório separa defeito confirmado, risco, dívida documental e decisão
   humana pendente.
4. O pacote Opus só recebe `PRONTO` se não houver bloqueio de origem, escopo,
   contrato técnico, validação local ou autorização externa.
5. O P17 não avança enquanto esta solicitação de mudança estiver sem aprovação.

## Validação planejada

- Auditoria estática de links, metadados, inventários e consumidores.
- Scan/importação do Godot e autoteste existente, sem mudanças no projeto.
- Leitura cruzada entre o pacote Opus, registros canônicos e runtime.
- Inspeção visual dos assets locais disponíveis; partida humana fica marcada
  separadamente caso a interação seja necessária.

## Recuperação

Como a auditoria é somente leitura, não há rollback de runtime. Se o plano não
for aprovado, o P17 permanece o plano operacional ativo e nenhuma alteração é
aplicada ao seu cursor.
