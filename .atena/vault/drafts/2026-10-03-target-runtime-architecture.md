---
status: draft
kind: target-architecture
created: 2026-10-03
origin: approved-master-production-plan
depends_on: '[[2026-10-03-production-reset-and-opus-handoff]]'
---

# The First Nine — arquitetura-alvo do runtime limpo

## Decisão de trabalho, não alteração de runtime

Esta é uma arquitetura proposta para o novo projeto. O `main.gd` e `main.tscn` atuais ficam congelados. Nenhum arquivo de runtime é criado nesta fase e nenhuma dependência externa é escolhida.

## Estrutura proposta

```text
res://
  app/                 bootstrap, cenas de fluxo e autoload mínimo
  actors/              Lolth, inimigos, aliados contextuais
  world/               regiões, mapas, perigos, pickups e checkpoints
  caravan/             estado, estoque, receitas, oficina, chama e defesa
  progression/         Marcas, Echoes, curas e gatilhos narrativos
  ui/                  HUD, prompts, menus e acessibilidade
  content/             Resources .tres de capítulos, inimigos, receitas e tuning
  art/                 assets admitidos e seus atlas importados
  tests/               smoke tests e cenários determinísticos
```

## Limites entre módulos

| Módulo | Possui | Não possui |
| --- | --- | --- |
| `app` | ciclo de jogo, save/checkpoint, roteamento de cena | regras de inimigo ou receitas |
| `actors` | movimento, combate e sinais de evento | custos, progresso de capítulo ou UI global |
| `world` | geometria, interações e encontro regional | estado persistente da caravana |
| `caravan` | estoque, condição, chama, crafting e postos | controle direto de drows |
| `progression` | Marca, Echoes, escolha de cura e desbloqueios | números de dano e renderização |
| `content` | dados ajustáveis e validação de IDs | lógica por frame |
| `ui` | apresentação e comandos de interface | regras autoritativas do jogo |

## Contratos técnicos

- Recursos de conteúdo usam IDs estáveis (`chapter.thornwake`, `enemy.briar_hound`, `mark.first_thread`) e validam referências ausentes ao carregar.
- Eventos entre sistemas são sinais/dados tipados: `resource_recovered`, `caravan_damaged`, `enemy_defeated`, `mark_earned`, `survivor_cured`, `checkpoint_set`.
- Save serializa IDs e estado de dados, nunca nós de cena. Checkpoint restaura estado completo de carroça, Marca, aliados curados, rota e conteúdo coletado conforme a regra de capítulo.
- Um adaptador de entrada mapeia as ações do projeto, para que UI e personagens não dependam de teclas físicas.
- Cada cena deve abrir sem recurso faltante; placeholders são explicitamente nomeados e não substituem assets admitidos.

## Estratégia de testes

1. Validação headless da carga de projeto e de scripts.
2. Testes determinísticos para carga, crafting, Echoes, limiares de Marca, cura, checkpoint e falha.
3. Smoke test de Thornwake: mover, recuperar, retornar, craftar, sobreviver à noite, ganhar Marca I e salvar checkpoint.
4. Revisão humana de legibilidade para cada pacote visual; automatização não substitui essa revisão.
