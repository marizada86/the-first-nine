---
status: complete-user-approved-reference-only
kind: canonical-gameplay-change-and-reference-revision
created: 2026-10-03
request_classification: PLAN_CHANGE_REQUEST
approval_mode: per-plan
approval_source: user-explicit
approval_selection: user-explicit-2026-10-03
supersedes_operationally:
  - '[[2026-10-03-p3-regions-transitions-production-masters-plan]]'
---

# Plano - chao continuo e bloqueios de teia

## Decisao proposta

A carroca percorre o mundo em linha reta sobre chao continuo. O percurso comum nao depende de saltos, abismos ou plataformas desconectadas. Somente bloqueios selecionados interrompem a passagem; Lolth os supera quando desenvolve o poder de criar chao temporario ou permanente com suas teias.

## Impacto

| Area | Ajuste |
| --- | --- |
| Rota e carroca | A rota horizontal passa a ter linha de contato continua e navegavel pela carroca. |
| Progressao | Gates passam a ser bloqueios materiais/narrativos, resolvidos pela teia de Lolth, e nao testes de pulo. |
| Combate e exploracao | Verticalidade pode existir no fundo ou em pontos opcionais, mas nao separa o caminho principal. |
| P3 ja gerado | Os tres terrenos e o panorama de transicoes precisam de v2: remover lacunas de travessia e acrescentar, no maximo, um bloqueio de teia claro por prancha. Inimigos/chefes permanecem validos. |
| Godot | Nao ha alteracao runtime agora; um contrato futuro devera cobrir colisao, estado de gate e superficie de teia. |

## Escopo da revisao P3

1. Registrar a decisao canonica quando aprovada.
2. Regenerar `hollowroot`, `glass-dunes`, `dreamwater` e `continuous-world-transitions` como v2.
3. Manter a faixa lateral e o gradiente entre regioes; substituir abismos e plataformas obrigatorias por chao continuo.
4. Mostrar bloqueios pontuais com leitura clara de teia como proxima superficie de passagem, sem UI ou texto.
5. Preservar o master de inimigos/chefes P3 v1.

## Aceitacao

- A linha de caminhada da carroca e continua em cada master e no panorama.
- Nenhum salto ou abismo e necessario para a rota principal.
- Cada bloqueio excepcional comunica que o poder de teia de Lolth cria a superficie que falta.
- Os mapas continuam um unico mundo, com transicoes espaciais graduais e sem corte/fade.
- Nenhum arquivo entra no Godot.

## Recuperacao

P3 v1 e preservado como historico. Se a revisao visual for rejeitada, ela nao altera as referencias anteriores nem o runtime.

## Gaps

- **BLOCKING:** nenhum para a decisao e referencias; o comportamento exato da teia no runtime permanece fora do escopo.
- **DEFERRED:** duracao da teia, custo, colisao, pontos exatos de gate e ordem de desbloqueio.
