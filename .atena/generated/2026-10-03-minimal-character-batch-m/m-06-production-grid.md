---
status: prepared-not-admitted
kind: sprite-conversion-contract
created: 2026-10-03
canonical_source: '[[2026-10-03-minimal-character-visual-direction]]'
---

# M-06 — grade de conversão para produção

## Contrato comum

Todos os sprites finais serão desenhados a partir das referências M e não serão recortados automaticamente destas pranchas. Célula, pivô, colisão e número de quadros são decisões do futuro pacote técnico. O artista/Opus deve conservar a baseline, a silhueta e a paleta curta; deve remover qualquer pixel ambíguo e não introduzir textura, gradiente ou adereço adicional.

| Família | Estados mínimos futuros | Fundo | Regra de leitura |
| --- | --- | --- | --- |
| Lolth élfica | idle, run, shadow-attack, hurt, pull | transparente | mesma altura e baseline em todos os estados |
| Lolth drow | idle, run, shadow-attack, hurt, pull | transparente | mesma altura/baseline da Lolth élfica |
| Thalestriel `plagued` | repouso/abrigo e passageiro | transparente | oito identidades por um único sinal de papel |
| Thalestriel drow `cured` | idle de posto, defesa, missão ou tração contextual | transparente | nenhuma leitura de personagem controlável |
| Shar | aparição narrativa, idle e dissolução opcional | transparente ou VFX separado | fora da escala de personagem jogável |

## Mapeamento inicial de referências

| ID | Fonte curada | Uso permitido futuro |
| --- | --- | --- |
| M-01 | `m-01-minimal-character-language-v2.png` | paleta, silhueta e escala percebida |
| M-02 Elf | `m-02-lolth-elf-poses-v1.png` | estado e proporção da Lolth élfica; referência com transparência real |
| M-02 Drow | `m-02-lolth-drow-poses-v1.png` | estado e proporção da Lolth drow; referência com transparência real |
| M-03 | `m-03-thalestriel-plagued-lineup-v1.png` | ordem, leitura de repouso e sinal de papel |
| M-04 | `m-04-thalestriel-drow-lineup-v1.png` | ordem, papel contextual e silhueta de drow |
| M-05 | `m-05-shar-narrative-v1.png` | presença narrativa, vazio e paleta |

## Portão de admissão

Antes de qualquer conversão em `assets/art/characters/` ou uso no Godot, um plano técnico deve definir: arquivo de destino novo e versionado, tamanho de célula, pivô, colisão, animações, mapeamento de cena, teste visual em 1280×720, importação e rollback. A aprovação deste lote não autoriza nenhuma dessas ações.
