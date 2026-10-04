---
status: approved
kind: production-specification
created: 2026-10-03
approved: 2026-10-03
intent: '[[2026-10-02-thalestriel-exodus-game-intent]]'
depends_on:
  - '[[2026-10-03-production-reset-and-opus-handoff]]'
  - '[[2026-10-03-master-asset-reference-manifest]]'
---

# The First Nine — plano mestre de reconstrução

## Objetivo

Preparar o jogo inteiro para uma reconstrução limpa: fechar a Bíblia de Produção, aprovar todas as referências visuais e entregar pacotes limitados para execução externa com Opus 5.5.

## Escopo

- Consolidar mecânicas de combate, exploração, carroça, crafting, ciclo, inimigos, Marca, Echoes, drows, checkpoints e progressão dos cinco capítulos.
- Produzir o guia visual mestre e o manifesto de referências para personagens, carroça, regiões, inimigos, UI, VFX e narrativa.
- Criar um formato único de pacote de handoff para Opus, com restrições e validação local.
- Definir a arquitetura alvo antes de substituir qualquer parte do protótipo congelado.

## Fora de escopo

- Gerar assets finais, enviar jobs de provedor, admitir pacotes no projeto, executar Opus 5.5 ou reescrever o runtime.
- Alterar lore aprovada sem uma decisão canônica própria.
- Escolher dependências, publicar, enviar código ou usar credenciais externas.

## Critérios de aceitação

1. A Bíblia de Produção lista todas as mecânicas com estados, entradas, falhas, UI e teste de aceitação.
2. Os cinco capítulos têm objetivo, peça da carroça, recursos, risco ambiental, três inimigos, recompensa de Marca e transição.
3. O Manifesto Mestre cobre todos os grupos de assets e contém portões de aprovação antes da produção final.
4. O pacote de handoff do Opus tem escopo, contexto canônico, arquivos permitidos, não-objetivos, testes e saída esperada.
5. O runtime atual está identificado apenas como referência; nenhuma implementação nova parte dele sem plano próprio aprovado.
6. Não há gaps `BLOCKING`; geração e implementação permanecem ações futuras com aprovação separada.

## Gaps

- **BLOCKING:** nenhum. O usuário confirmou reconstrução limpa, pixel art 2D dark fantasy e execução externa do Opus 5.5.
- **RESOLVABLE:** parâmetros numéricos de balanceamento entram em tabelas de ajuste, não como lore.
- **DEFERRED:** ferramentas específicas de geração de imagem, admissões de assets, chamadas ao Opus e implementação do novo runtime.

## Plano de voo proposto

1. Criar a Bíblia de Produção a partir do cânone já aprovado e separar decisões ainda abertas.
2. Fechar as fichas dos cinco capítulos e a matriz de progressão de Marcas/drows.
3. Completar o quadro mestre visual e as fichas de referência por lote no Manifesto Mestre.
4. Definir arquitetura limpa, estrutura de pastas e estratégia de testes do Godot para o novo runtime.
5. Escrever o template de handoff do Opus e os primeiros pacotes: fundação de runtime, Thornwake e lote visual A.
6. Revisar os artefatos com o usuário. Somente depois, solicitar aprovação separada para geração de referências e, depois, para cada execução de implementação.

## Evidência prevista

- Bíblia de Produção e matriz de capítulos vinculadas ao cânone.
- Manifesto de assets com IDs, lotes e portões de aprovação.
- Template de handoff do Opus e checklist de revisão local.
- Registro de que nenhuma geração, dependência, admissão de asset ou implementação foi disparada nesta fase.

## Reconciliação

Ao terminar, registrar os documentos resultantes, atualizar `.atena/state/plan.yaml` e apresentar o plano mestre para uma única aprovação antes da próxima fase.
