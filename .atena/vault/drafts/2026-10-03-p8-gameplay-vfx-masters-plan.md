---
status: complete-user-approved-reference-only
kind: individual-gameplay-vfx-master-plan
created: 2026-10-03
approval_mode: per-plan
approval_selection: user-explicit-2026-10-03
sources:
  - '[[2026-10-03-caravan-survival-slow-travel]]'
  - '[[2026-10-03-continuous-caravan-ground-and-web-gates]]'
  - '[[2026-10-03-shadow-to-lolth-mark-visual-progression]]'
  - '[[2026-10-03-p0-loop-production-masters-plan]]'
---

# Plano P8 — masters individuais de VFX do loop

## Objetivo

Criar referencias separadas para os efeitos que tornam o loop de sobrevivencia legivel em jogo: luta de Lolth, coleta, reparo, cura, pressao inimiga e teia de progressao.

## Escopo

Criar 10 PNGs transparentes, com 3–4 poses/frame-chave horizontais quando houver movimento:

1. arco curto de ataque elfico;
2. impacto de dano em inimigo;
3. projecao curta de sombra de Lolth drow;
4. dissipacao/derrota inimiga;
5. coleta de recurso e brilho de salvamento;
6. reparo de carroca com faiscas discretas;
7. cura de aliado pela Marca, sem violencia grafica;
8. alerta de `Attraction` crescendo perto da carroca;
9. fiacao de teia no bloqueio especial;
10. conclusao de teia, quando o piso firme se conecta.

## Regras vinculantes

- Efeitos devem usar grandes grupos de pixels, paleta curta e leitura lateral em fundo transparente.
- O alerta de `Attraction` indica pressao inimiga concreta, nao um HUD substituto.
- Teia de progressao conecta a rota em um bloqueio especial; nao comunica salto comum, plataforma flutuante ou mapa separado.
- Cura e sombras respeitam a progressao visual Shar → fios de sombra → aranha de Lolth, sem texto ou simbolos legiveis.

## Nao escopo

Logica de dano, IA, numeros de combate, formulas de Attraction, particulas Godot, shaders, audio, UI final, atlas, timing final, colisores, importacao ou alteracao de mecanicas.

## Aceitacao

- 10 masters PNG em `.atena/generated/`.
- Cada efeito comunica uma unica acao do loop sem UI, texto ou personagem completo incorporado.
- Efeitos de teia preservam a continuidade da rota principal.
- Referencias ficam fora do Godot, aguardando curadoria humana.

## Gaps

- **BLOCKING:** nenhum para referencias visuais.
- **DEFERRED:** dano, custo de poder, frequencia de Attraction, duracao/loop de VFX, atlas, pivots e integracao Godot.

## Execucao

- Aprovacao recebida em 2026-10-03, no modo `per-plan`.
- Dez masters foram gerados em `.atena/generated/2026-10-03-p8-gameplay-vfx-masters/`.
- Todos os PNGs possuem transparencia confirmada nas bordas verificadas.
- Curadoria humana aprovada em 2026-10-03; os masters foram incluidos no manifesto de referencia do Opus.
- Nenhuma admissao no Godot ocorreu.
