---
status: proposed
kind: asset-reference-refresh
created: 2026-10-03
approval_mode: per-plan
request_classification: PLAN_CHANGE_REQUEST
depends_on:
  - '[[2026-10-03-stonehook-reference-batch-e]]'
  - '[[2026-10-03-minimal-character-visual-direction]]'
---

# Plano — atualização minimalista de Stonehook Mountains

## Objetivo

Substituir as cinco referências visuais de Stonehook por cinco novas pranchas minimalistas, coerentes com os personagens e referências já aprovados. O lote permanece somente como direção de arte; nada será admitido em `assets/` ou no runtime.

## Escopo

1. Panorama lateral de Stonehook: cristas, passagens estreitas, cordas e uma transição ambiental suave vinda de Thornwake.
2. Recursos de reparo: sucata de metal, corda e ferramentas de eixo/freios, com leitura imediata de itens recuperáveis.
3. Travessia e risco: scree, queda, deslizamento e pontos de corda, sem introduzir escalada livre.
4. Ameaças regulares: Scree Crawlers e Cliff Harriers, com silhuetas de baixa complexidade e leitura clara.
5. Chefe Stone Maw: criatura mineral massiva, assimétrica e legível, sem anatomia humanoide.

## Direção aplicada

- Pixel art lateral de fantasia sombria, com massas grandes, paleta curta, contorno seletivo e pouca microtextura.
- Pedras azul-ardósia, poeira fria e poucos acentos de metal/corda; cada prancha usa contraste para separar rota, recurso e risco.
- Mudança de Thornwake para Stonehook por vegetação rareando, terreno elevando e paleta esfriando; sem corte de mapa, fade ou UI.
- A simplificação se inspira somente na legibilidade e economia visual das referências fornecidas pelo usuário. Não reutilizará personagens, símbolos, composição ou outros assets de terceiros.

## Não escopo

- Sprites finais, atlas, tiles, colisões, pivôs, animações, som, UI e implementação Godot.
- Números de dano/recursos, rotas de missão, Marca II, segunda cura, escalada livre ou alterações de mecânica/lore.
- Mudanças nos assets existentes e qualquer admissão em runtime.

## Aceitação

- Cinco PNGs sem texto, watermark ou UI final, um para cada item do escopo.
- Leitura distinta, em câmera lateral: recurso recuperável, rota segura, queda/deslizamento e inimigo não se confundem.
- Inimigos e chefe preservam as identidades canônicas; nenhum humanoide ou cópia de referência externa é aceito.
- Todos os resultados ficam apenas em `.atena/generated/2026-10-03-minimal-stonehook-batch-e2/`, com prompts, hashes, tentativas e recibo.

## Gaps

- **BLOCKING:** nenhum.
- **RESOLVABLE:** a paleta exata será inferida das referências minimalistas já aprovadas, mantendo Stonehook fria e legível.
- **DEFERRED:** especificação técnica de sprites, implementação Godot e admissão no runtime.

## Plano de voo

1. Registrar a extensão operacional da linguagem minimalista para ambiente e ameaças de Stonehook, sem alterar mecânicas ou lore.
2. Gerar as cinco referências com no máximo duas tentativas por item.
3. Validar resolução, transparência quando aplicável, ausência de texto/watermark e aderência ao escopo.
4. Registrar recibo, evidência e o encerramento no estado ADD; manter curadoria humana e admissão em runtime explicitamente diferidas.

## Recuperação

Se um item não atender à leitura ou à direção minimalista em duas tentativas, ele será marcado como pendente e não substitui a referência anterior. Nenhuma referência existente será apagada.
