---
status: proposed
kind: production-asset-masters
created: 2026-10-03
approval_mode: per-plan
depends_on:
  - '[[2026-10-03-opus-production-package]]'
  - '[[2026-10-03-caravan-open-utility-layout]]'
  - '[[m-06-production-grid]]'
---

# Plano — P0 masters técnicos do loop jogável

## Objetivo

Produzir masters técnicos iniciais para Lolth, carroça aberta, salvamento e combate básico, a partir das referências aprovadas. Os arquivos serão novos e versionados sob `.atena/generated/`; não entram em `assets/` ou Godot nesta etapa.

## Escopo

1. Folha de referência de animação de Lolth: idle, corrida, ataque curto, magia de sombra, hurt e puxar.
2. Folha técnica da carroça: parada, puxada lenta, reparo/dano, baús, assentos e mesa de craft; sem cavalo/quartos.
3. Kit de pickups: madeira, metal, corda, resina, lona, água e relíquia em escala unificada.
4. Kit de combate: ataque, hit, Shadow Echo e leitura de defesa.
5. Kit de solo/props de Thornwake para primeiro trecho: terreno, espinho, tronco, abrigo e barreira.

## Diretrizes técnicas propostas

- Master de personagem: célula 48×48 px, baseline inferior comum; saída futura 1× sem antialias.
- Carroça: master 128×64 px, pivô no contato das rodas/chão; carga em camada visual separada.
- Pickup/prop: grade 24×24 ou 32×32 px conforme silhueta; pivô inferior central.
- VFX: células 48×48 transparentes; colisão nunca embutida na arte.
- Tile: bloco-base 32×32 px, repetição testada em faixa lateral; colisão e regras de terreno ainda diferidas.

## Não escopo

- Importar, editar ou executar Godot; atlas final; colisores finais; animações programadas; balanceamento; áudio final; outros capítulos; publicação.

## Aceitação

- Cinco PNGs de master/referência de produção, sem texto e com fundo apropriado (transparente quando aplicável).
- Convenções de célula, pivô e baseline documentadas em recibo.
- Carroça aberta, puxada por personagem e sem cavalo/quartos em todos os resultados.
- Nenhuma alteração em `assets/`, `res://`, cenas ou código.

## Gaps

- **BLOCKING:** nenhum para masters de produção.
- **RESOLVABLE:** a célula proposta é baseline de produção; a validação de escala acontecerá só na admissão Godot.
- **DEFERRED:** recorte final de atlas, colisão, integração, testes de performance e gameplay.

## Plano de voo

1. Gerar cinco masters coerentes com as referências aprovadas.
2. Validar dimensões, transparência aplicável, leitura e convenções técnicas.
3. Registrar recibo, hashes e evidência; aguardar curadoria humana antes de qualquer admissão.
