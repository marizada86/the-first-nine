---
status: proposed
kind: asset-reference-refresh
created: 2026-10-03
approval_mode: per-plan
depends_on:
  - '[[2026-10-03-hollowroot-reference-batch-f]]'
  - '[[2026-10-03-minimal-character-visual-direction]]'
---

# Plano — atualização minimalista de Hollowroot Caverns

## Objetivo

Produzir cinco referências visuais minimalistas para Hollowroot Caverns, alinhadas à linguagem já aprovada para personagens, Stonehook e Thornwake. O lote é somente de referência: nada será copiado para `assets/` ou para o runtime.

## Escopo

1. Panorama lateral de caverna: raízes grossas, fungos bioluminescentes, rota segura e a passagem gradual que sucede Stonehook.
2. Materiais e ferramentas: fungos, minério e resina com leitura de recursos recuperáveis; ferramentas melhores apenas como props.
3. Riscos e passagens: esporos, colapso e passagem fechada/protegida, sem criar regras novas de travessia.
4. Ameaças regulares: Chitin Burrower e Sporebound, não humanoides e distintos entre si.
5. Hollow Mother: chefe de raiz, quitina e fungo, massivo e legível, sem anatomia humanoide.

## Direção aplicada

- Pixel art lateral minimalista: massas grandes, silhueta primeiro, poucos tons, contorno seletivo e pouca microtextura.
- Pedra violeta escura, raízes marrons profundas e luz bioluminescente verde-azulada usada somente para rota, recurso ou risco.
- A transição de Stonehook é gradual: ar aberto e ardósia cedem a paredes próximas, raízes e luz fúngica; sem corte, fade, UI ou loading.
- A referência externa do usuário informa somente economia visual e leitura a distância. Nenhuma composição, personagem ou asset externo será copiado.

## Não escopo

- Sprites finais, atlas, tiles, colisões, pivôs, animações, som, UI, implementação Godot ou admissão de assets.
- Números de recursos/dano, Marcas III–IV, curas, receitas, poderes ou mudanças de lore e mecânicas.

## Aceitação

- Cinco PNGs sem texto, watermark, UI ou moldura final.
- Rota, recurso, esporo, colapso, criatura e passagem protegida são distinguíveis em câmera lateral.
- Criaturas preservam suas identidades e não são humanoides.
- Arquivos, prompts, hashes, tentativas, recibo e evidência permanecem sob `.atena/`.

## Gaps

- **BLOCKING:** nenhum.
- **RESOLVABLE:** o contraste da bioluminescência será limitado para não confundir recurso, perigo e rota.
- **DEFERRED:** especificação técnica, runtime, implementação Godot e admissão dos assets.

## Plano de voo

1. Registrar a extensão operacional da direção minimalista para ambiente e ameaças de Hollowroot.
2. Gerar as cinco referências com no máximo duas tentativas por item.
3. Validar leitura, ausência de texto e aderência à direção aprovada.
4. Registrar recibo, evidência e estado; nenhuma referência será admitida no runtime.

## Recuperação

Se uma referência falhar em duas tentativas, ela ficará pendente e a referência anterior será preservada. Nenhum arquivo existente será apagado.
