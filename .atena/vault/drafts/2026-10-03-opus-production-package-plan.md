---
status: proposed
kind: production-specification-package
created: 2026-10-03
approval_mode: per-plan
depends_on:
  - '[[m-06-production-grid]]'
  - '[[2026-10-03-caravan-open-utility-layout]]'
  - '[[2026-10-03-shadow-to-lolth-mark-visual-progression]]'
---

# Plano — pacote de produção técnica para o Opus

## Objetivo

Converter as referências aprovadas em uma especificação técnica de produção para o Opus: inventário, ordem de entrega, contratos de sprite/tile/atlas, animações, pivôs, colisões, áudio e validação. Não gera sprites finais nem altera o Godot.

## Escopo

1. Inventário mestre com cada família visual aprovada, referência-fonte e prioridade de produção.
2. Contrato de sprites: escala, célula, transparência, baseline, pivôs, colisores e nomes versionados.
3. Contrato de tiles e cenários: módulos, camadas de fundo, transições graduais e landmarks.
4. Matriz de animação: Lolth, drows contextuais, carroça puxada, ameaças, chefes e objetos de salvamento.
5. Mapa de integração: cenas/famílias consumidoras, testes 1280×720, critérios de aceite, rollback e fila de áudio.

## Diretrizes obrigatórias

- A carroça é aberta, sem cavalo e sem quartos; contém baús, assentos e mesa de craft.
- As Marcas começam em sombra sob Shar e culminam no emblema de aranha drow de Lolth.
- Drows nunca passam a parecer personagens controláveis; defesa, missão e tração são funções exclusivas.
- Mapas se conectam por transições graduais, sem corte ou loading visual.

## Não escopo

- Desenhar assets finais, criar atlas, editar cenas/código, importar no Godot, alterar lore/mecânicas, instalar dependências ou publicar.

## Aceitação

- Pacote em `.atena/specs/` e `.atena/generated/opus-handoff/`, com links para referências aprovadas.
- Cada item tem prioridade, dono previsto (Opus), formato, dimensão/célula proposta, estados, pivô/colisão ou justificativa de não aplicabilidade.
- Ordem de produção permite implementar primeiro o loop jogável sem depender de arte decorativa.
- Todo item de runtime permanece marcado como **não admitido**.

## Gaps

- **BLOCKING:** nenhum para a especificação.
- **RESOLVABLE:** dimensões finais de célula serão propostas como baseline e registradas como decisão pendente de validação no Godot.
- **DEFERRED:** criação, admissão e testes dos assets reais no Godot; mixagem e implementação de áudio.

## Plano de voo

1. Inventariar referências aprovadas e remover duplicatas/superseded da fila de produção.
2. Especificar sprites, tiles, animações, áudio e integração em contratos separados, todos ligados ao inventário mestre.
3. Validar links, cobertura dos loops de jogo e ausência de admissão em runtime.
4. Registrar evidência e um manifesto de entrega para o Opus.
