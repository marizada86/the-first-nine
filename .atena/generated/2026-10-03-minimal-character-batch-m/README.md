---
status: curated-reference-only
kind: generated-reference-receipt
created: 2026-10-03
authorization: user-explicit-per-plan
source_spec: '[[2026-10-03-minimal-character-asset-overhaul]]'
canonical_source: '[[2026-10-03-minimal-character-visual-direction]]'
tool: built-in-image-generation
---

# Lote M — referências minimalistas de personagens

## Limite de uso

Os arquivos são referências de IA curadas, não sprites finais, atlas, animações, assets admitidos ou runtime. Permanecem fora de `assets/` e `res://`. Se qualquer resultado influenciar a submissão, a declaração de IA da jam deve refletir esse uso.

## Entregas selecionadas

| ID | Arquivo | Tamanho | SHA-256 | Curadoria |
| --- | --- | --- | --- | --- |
| M-01 | `m-01-minimal-character-language-v3.png` | 1536×1024 | `18ae5833f7007401f5df25061153f19a8533b46dd6ff06b5f3328c1061221bb4` | **aprovado pelo usuário**: linguagem minimalista de blocos, paleta curta e leitura à distância |
| M-02 Elf | `m-02-lolth-elf-poses-v1.png` | 2172×724 | `af0586176183014e2ab56954c5e1562925e73eadda23e3687da9653185a62077` | **aprovado pelo usuário**: idle, corrida, ataque, dano e tração; cantos transparentes |
| M-02 Drow | `m-02-lolth-drow-poses-v2.png` | 2172×724 | `b7b5a7fb55e419a7a584c169c98a3f1a250b5ce478408b4c356cee440ef420ef` | **aprovado pelo usuário**: cinco poses, transparência e leitura minimalista |
| M-03 | `m-03-thalestriel-plagued-lineup-v1.png` | 2161×728 | `ec007f45fc9ac5d8eb4cbf433c8e9a4ea6e0bc7a020df5b747e8d10c920444d2` | **aprovado pelo usuário**: oito sobreviventes em abrigo, com ordem/papel preservados |
| M-04 | `m-04-thalestriel-drow-lineup-v1.png` | 2056×765 | `fbb5ed2ddbafba50939aa7c3022536de5797a502513f60091ec67ce27362b4b5` | **aprovado pelo usuário**: oito drows contextuais, sem leitura de party controlável |
| M-05 | `m-05-shar-narrative-v1.png` | 1145×1374 | `1d49527a0f36ce53bd0505e9d4c6b602792e4821a48b139534e885c204f3854f` | **aprovado pelo usuário**: Shar narrativa, isolada e fora da escala jogável |
| M-06 | `m-06-production-grid.md` | documento | n/a | contrato de conversão, sem pivôs, colisões ou destino de runtime |

## Cobertura do elenco

As referências cobrem 19 leituras: Lolth élfica, Lolth drow, Shar, oito Thalestriel `plagued` e os mesmos oito em forma drow `cured`. A ordem dos sobreviventes é Aelira, Vaelun, Nimara, Thaviel, Ilyren, Orisya, Soreth e Luraen.

## Revisão e rejeição

A primeira variação de M-01 foi rejeitada por renderização excessiva, adereços complexos e silhueta distante demais da simplicidade solicitada. A versão `v2` reduz roupa, prop, paleta e detalhe facial. Os demais arquivos foram inspecionados visualmente para leitura de papel, ausência de tração animal, ausência de texto e preservação das regras de personagem.

## Aprovação do usuário

Em 2026-10-03, o usuário aprovou explicitamente os outputs `exec-bcb511e1-5da9-47a1-9840-2d75a93facfa`, `exec-46c3e4c6-7f7e-4fe8-9be8-67567f588050`, `exec-6785fecc-ab47-4df3-a951-5884a1881438` e `exec-8d606b33-5dde-4fb4-8a3b-7d19b8babce3`, correspondentes a M-02 Elf, M-03, M-04 e M-05. M-01 e M-02 Drow permanecem pendentes de aprovação explícita.

Após a solicitação do usuário para regenerar os dois itens pendentes, `m-01-minimal-character-language-v3.png` substitui `m-01-minimal-character-language-v2.png` como candidato ativo de M-01, e `m-02-lolth-drow-poses-v2.png` substitui `m-02-lolth-drow-poses-v1.png` como candidato ativo de M-02 Drow. As versões anteriores foram preservadas apenas para histórico de revisão.

O usuário aprovou M-01 v3 e M-02 Drow v2 em 2026-10-03. As seis entregas M-01 a M-06 têm, portanto, curadoria humana completa como referências; essa aprovação não admite nenhum arquivo no Godot.

## Próximo portão

Use `m-06-production-grid.md` como entrada para um novo plano técnico de sprites. O próximo plano deverá autorizar explicitamente a criação de arquivos versionados, revisão humana, importação e mapeamento no Godot. Nenhuma referência deste lote pode ser copiada diretamente para o runtime.
