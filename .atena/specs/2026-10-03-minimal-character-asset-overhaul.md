---
status: complete-reference-generation-not-admitted
kind: character-art-revision-plan
created: 2026-10-03
request_classification: PLAN_CHANGE_REQUEST
request_mode: guided
approval_mode: per-plan
approved: 2026-10-03
supersedes_on_approval:
  - '[[2026-10-03-protagonist-references-b-approval]]'
  - '[[2026-10-03-protagonist-reference-scale]]'
depends_on:
  - '[[2026-10-03-thalestriel-survivor-names]]'
  - '[[2026-10-03-caravan-survival-slow-travel]]'
  - '[[2026-10-03-opus-5-5-caravan-implementation-manifest]]'
---

# The First Nine — revisão minimalista de todos os personagens

## Objetivo

Refazer as referências de todos os personagens nomeados de *The First Nine* com leitura minimalista de pixel art: silhuetas pequenas, poucos agrupamentos de cor, contraste forte e animação econômica. As imagens enviadas pelo usuário definem esse grau de simplificação e leitura a distância; não autorizam copiar seus personagens, ícones, cavalo, cenários, interface, paleta exata ou assets.

## Escopo

O elenco completo desta revisão tem 19 leituras de personagem:

1. Lolth élfica;
2. Lolth drow;
3. Shar, como presença narrativa;
4. Aelira, Vaelun, Nimara, Thaviel, Ilyren, Orisya, Soreth e Luraen em estado `plagued`;
5. os mesmos oito Thalestriel em estado drow `cured`.

O lote gera somente referências e candidatos de produção em `.atena/generated/`, sem substituir os assets existentes. Inimigos, carroça, ambientes, HUD, texto e runtime não fazem parte deste lote.

## Direção visual vinculante proposta

- Personagem jogável lido em aproximadamente 24–40 px de altura no enquadramento de gameplay; o master pode ser maior apenas para preservar pixels limpos.
- Silhueta primeiro: um gesto reconhecível, uma peça principal de roupa e no máximo um prop que defina o papel.
- Paleta por personagem limitada a uma cor de sombra, 2–3 cores de massa, uma cor de destaque e uma cor de luz; sem renderização pictórica, microtextura, brilho difuso ou detalhes faciais finos.
- Contorno seletivo e grupos de pixels grandes; sombra no chão curta e funcional; fundo transparente nos candidatos a sprite.
- Lolth élfica e drow mantêm identidade, baseline e altura visual equivalentes. Os oito Thalestriel mantêm nomes, ordem, papel e baseline compartilhada; Shar permanece fora da escala jogável.
- Drows continuam aliados contextuais, não personagens controláveis. O estado `plagued` comunica doença e abrigo, sem violência gráfica.

## Entregas planejadas

| ID | Entrega | Conteúdo | Saída |
| --- | --- | --- | --- |
| M-01 | Linguagem de personagem | escala, paleta, contorno, leitura de 24–40 px, sombras e comparação antes/depois | prancha de direção |
| M-02 | Lolth dual | formas élfica e drow: idle, corrida, ataque, dano e tração | referências e candidatos de sprite separados |
| M-03 | Thalestriel `plagued` | oito silhuetas no abrigo/carregamento, ordem nominal preservada | lineup e poses estáticas |
| M-04 | Thalestriel drow `cured` | oito silhuetas com leitura de defesa, missão ou tração sem controle direto | lineup e poses de função |
| M-05 | Shar | silhueta narrativa minimalista, leitura à distância e sem kit jogável | prancha narrativa |
| M-06 | Grade de produção | pivô, baseline, área segura, estados exigidos e matriz de arquivos candidatos | contrato de conversão para Opus 5.5 |

## Não objetivos

- Copiar *Kingdom Two Crowns* ou qualquer outro jogo, nem reproduzir seus personagens, moeda, cavalo, UI, tiles ou composição.
- Sobrepor ou apagar assets em `assets/` ou `res://`; modificar cenas, scripts, colisões, pivôs ativos, dependências, build ou publicação.
- Alterar nomes, lore, papel, habilidades, altura canônica, ordem dos sobreviventes ou regras de carroça.
- Produzir spritesheets finais, atlas final ou admitir candidatos no Godot antes de um plano técnico posterior.

## Critérios de aceitação

1. As 19 leituras constam em referências que preservam identidade, ordem e estados canônicos.
2. Cada personagem é identificável em uma checagem visual a 1280×720 e em miniatura; nenhum depende de textura ou rosto detalhado.
3. Lolth élfica e drow mantêm baseline/escala; os oito Thalestriel compartilham baseline e papel por silhueta, não por estatura.
4. A prancha de produção descreve a conversão em sprites sem decidir pivôs, colisões ou runtime final.
5. Cada saída registra prompt, ferramenta, hash, dimensões, fonte, curadoria e declaração de IA.
6. Nenhum arquivo de runtime ou asset existente é alterado durante o lote.

## Gaps

- **BLOCKING:** nenhum para preparar ou gerar referências. A nova escala final de sprite permanece bloqueante apenas para admissão no runtime, portanto fica fora deste plano.
- **RESOLVABLE:** aplicar a direção minimalista como leitura/silhueta/paleta, sem imitar os assets de referência fornecidos pelo usuário.
- **DEFERRED:** resolução de célula, atlas, pivô, colisão, quadro por animação, importação Godot, substituição de sprites existentes e ajuste de cenas.

## Plano de voo

1. Registrar a decisão visual que preserva o cânone de personagem e substitui apenas a direção de referência anterior.
2. Gerar M-01 a M-05 e a grade M-06 como referências de revisão, em diretório isolado.
3. Revisar a legibilidade, escala relativa, regras de paleta, ausência de cópia e coerência dos estados; registrar recibos, hashes e rejeições.
4. Preparar o pacote de conversão para Opus 5.5, sem iniciar implementação nem admitir arquivos.
5. Após aprovação de curadoria, criar um plano técnico separado para sprites finais, importação e mapeamento controlado no Godot.

## Validação e evidência

- Checklist de 19 leituras, baseline, nome/ordem/papel, paleta e legibilidade em miniatura.
- Inspeção visual das pranchas e hash/dimensões de cada PNG aprovado.
- Verificação de que os arquivos novos permanecem em `.atena/generated/` e que nenhum caminho em `assets/`, `res://`, cena ou script foi modificado.
- Evidência ADD com prompts, origem, curadoria e itens rejeitados.

## Aprovação solicitada

Autorizar a substituição da direção de referência dos personagens e a geração/curadoria das entregas M-01 a M-06 em diretório de revisão. A aprovação não autoriza admissão no Godot, sobrescrita de assets, alteração do runtime, dependências, publicação ou envio externo.
