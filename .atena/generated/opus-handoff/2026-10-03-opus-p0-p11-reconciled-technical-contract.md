# Contrato tecnico reconciliado P0-P11 — Opus

Status: aprovado como handoff técnico vigente em 2026-10-03. Não autoriza admissão no runtime.

## Estado e fonte

Este contrato cobre os **108 masters aprovados** do manifesto `final-reference-package/asset-manifest.md`. Ele complementa os contratos anteriores e substitui sua leitura operacional quando houver divergencia de cobertura. Masters continuam sendo referencias; nenhum deles e admitido em `res://`.

## Inventario de conversao

| Pacotes | Masters | Familia | Produto de runtime futuro | Consumidor |
| --- | ---: | --- | --- | --- |
| P0 | 5 | loop base | atlas/layers de Lolth, carroca, coleta e combate | loop inicial |
| P1 | 5 | sobrevivencia | atlas contextual de aliados, cura, tracao e oficina | carroca/acampamento |
| P2-P4 | 15 | regioes e narrativa | tiles, parallax, inimigos, Marcas e keyframes | rota completa |
| P5 | 15 | monstros individuais | atlas por criatura: idle, mover, atacar, hurt, derrota | combate regional |
| P6 | 18 | personagens individuais | atlas de Lolth e Thalestriel por estado | protagonista/assistencias |
| P7 | 10 | salvamento e teia | props interativos e layers de bloqueio | exploracao/travessia |
| P8 | 10 | VFX | atlas transparente de inicio, loop e fim | combate e narrativa |
| P9 | 10 | props regionais | props estaticos e variacoes | cenarios |
| P10 | 10 | interface | componentes/layers responsivos | HUD de sobrevivencia |
| P11 | 10 | marcos de rota | landmarks e areas de interacao | encontros e progresso |

## Regras de normalizacao

1. Criar um arquivo runtime novo e versionado a partir de cada master ou familia; nunca importar nem sobrescrever o master de referencia.
2. Definir grade, celula, baseline e pivot por familia em cena de prova. Seres usam centro inferior; carroca e props usam contato de roda/objeto com o chao.
3. Separar arte de colisores, hitboxes, areas de interacao, dano e duracao. UI e VFX nao recebem colisao embutida.
4. Recortar/redesenhar para atlas apenas apos validar leitura em 1280x720; dimensoes finais de celula continuam uma decisao tecnica adiada.
5. Registrar no candidato runtime o caminho do master de origem no manifesto.

## Limites de conversao

- Carroca aberta: sem cavalo e sem quartos; baus, assentos e mesa de craft sao elementos utilitarios.
- Rota: chao horizontal continuo; somente bloqueios especiais recebem layer de teia tecida por Lolth.
- Aliados curados: defesa, missao ou tracao contextuais; nunca personagens controlaveis.
- Marcas: Shar velada -> fios de sombra -> aranha de Lolth; Marca IX encerra, sem cura adicional.
- Interface: comunica sobrevivencia e Marcas, sem mapa separado, seletor de regiao ou comando direto de drows.

## Ordem de admissao futura

1. P0/P1 para prova do loop jogavel.
2. P5/P6 requeridos pela primeira regiao e combate.
3. P7/P8 para salvamento, teia e feedback.
4. P2-P4/P9/P11 para expansao regional e narrativa.
5. P10 apos os estados reais de HUD existirem.

Toda admissao exige plano proprio aprovado e o checklist de Godot.
