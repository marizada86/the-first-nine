---
status: complete-user-approved-runtime-migration
kind: runtime-v2-core-migration-plan
created: 2026-10-03
approval_mode: per-plan
approval_selection: user-explicit-2026-10-03
approval_source: user-explicit
sources:
  - '[[2026-10-03-runtime-art-readiness-audit]]'
  - '[[2026-10-03-opus-p0-p11-reconciled-technical-contract]]'
  - '[[2026-10-03-continuous-caravan-ground-and-web-gates]]'
  - '[[2026-10-03-caravan-open-utility-layout]]'
  - '[[2026-10-03-minimal-character-visual-direction]]'
---

# Plano P14 — migração do núcleo para runtime_v2

## Objetivo

Implementar uma estrutura runtime nova e reversível para o primeiro loop jogável, substituindo apenas as famílias visuais que hoje conflitam com a direção aprovada: Lolth, carroça, chão de Thornwake, coleta e VFX básico.

## Escopo

### B-001 — estrutura e proveniência

Criar `assets/runtime_v2/` com subpastas `characters/lolth/`, `caravan/`, `items/`, `world/thornwake/`, `vfx/` e `manifests/`. Criar um manifesto de admissão que ligue cada candidato ao master P0/P6/P7/P8 correspondente, com versão, grid, pivô e disclosure de IA.

### B-002 — seis candidatos finais do núcleo

Gerar e validar, como PNGs transparentes versionados:

1. folha unificada de Lolth elfa, grade 3×3;
2. folha unificada de Lolth drow, grade 3×3;
3. carroça aberta em três estados: danificada, reparando e reparada;
4. faixa modular de chão contínuo de Thornwake;
5. folha 2×2 de pickups de salvamento;
6. folha 2×2 de VFX de golpe/coleta.

### B-003 — adaptação do renderer

Atualizar somente `main.gd` para carregar os candidatos `runtime_v2`, usar as duas folhas unificadas de Lolth sem perder estados de jogo e desenhar Thornwake sem plataformas comuns. O bloqueio especial de teia permanece um ponto de progressão, não uma plataforma.

### B-004 — validação e recuperação

Executar validação Godot e o autoteste existente, capturar evidência local 1280×720 e preservar os preloads legados como fallback até a aprovação humana da partida visual.

## Regras vinculantes

- Nenhum arquivo em `assets/art/` será movido, sobrescrito ou excluído.
- A carroça nova é aberta, sem cavalo e sem quartos; mostra baús, assentos e mesa de craft.
- Lolth e todas as folhas novas seguem pixel art minimalista lateral; roupas inferiores opacas até as botas.
- O chão principal de Thornwake é contínuo; código e arte não criam saltos, abismos ou plataformas de travessia comum.
- Esta etapa não admite inimigos P5, aliados P6 além de Lolth, HUD P10, regiões posteriores ou Marcas P4/P11.
- Não altera lore, custos, balanceamento, permissões, dependências ou publicação.

## Não escopo

Conversão dos outros 102 masters, drows contextuais, chefes, regiões posteriores, UI final, áudio, save, alteração das regras de combate, exclusão de legado ou envio ao Opus.

## Aceitação

- Seis PNGs novos, versionados e com proveniência no manifesto `runtime_v2`.
- `main.gd` não carrega as folhas legadas equivalentes para Lolth, carroça, pickups, VFX básico ou plataformas de travessia em Thornwake.
- A cena continua iniciando em 1280×720 e o autoteste passa.
- Chão contínuo, carroça aberta e leitura minimalista são confirmados em captura local.
- O rollback é uma troca documentada dos preloads para os caminhos legados, sem remover arquivos.

## Gaps

- **BLOCKING:** nenhum para o núcleo; a grade 3×3/2×2 resolve o contrato do renderer atual sem alterar mecânicas.
- **RESOLVABLE:** a referência de carroça não explicita a posição exata da mesa/baús em cada frame; serão mostrados como leitura estável e não como novo sistema.
- **DEFERRED:** todas as outras famílias P0–P11, pixels finais de escala, performance, áudio e avaliação humana de ritmo.

## Recuperação

As folhas novas terão caminhos `runtime_v2` e versões novas. Se a validação falhar, o plano restaura apenas as constantes/preloads de `main.gd` para os caminhos legados; nenhum PNG legado é alterado.

## Plano de voo

1. Criar estrutura, manifesto e contrato de seis candidatos.
2. Gerar e validar os seis PNGs com transparência, grade, pivô e limites visuais.
3. Adaptar o renderer e remover somente a renderização de plataformas comuns de Thornwake.
4. Rodar Godot/autoteste, inspecionar captura e registrar evidência.
5. Solicitar aprovação humana antes de declarar a migração vigente.

## Execução autorizada

O plano foi aprovado em 2026-10-03 no modo `per-plan`. A autorização inclui a criação de candidatos versionados, a adaptação limitada de `main.gd` e a validação local, preservando o legado para rollback.

## Execução concluída, revisão pendente

Os seis candidatos foram gerados, versionados e conectados ao renderer. A importação e o autoteste do Godot passaram. Falta somente a inspeção humana em 1280×720 antes de declarar a migração vigente.

## Revisão aprovada

Aprovação humana recebida em 2026-10-03. P14 encerrado: `runtime_v2` é o núcleo visual vigente de Thornwake, com legado preservado para rollback.
