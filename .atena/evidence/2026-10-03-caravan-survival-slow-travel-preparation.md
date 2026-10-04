---
status: complete
kind: design-preparation-evidence
recorded: 2026-10-03
plan: '[[2026-10-03-caravan-survival-slow-travel-revision]]'
---

# Evidência — revisão de sobrevivência, carroça e viagem lenta

## Resultado

A aprovação por plano foi registrada em 2026-10-03. A decisão canônica `[[2026-10-03-caravan-survival-slow-travel]]` substitui operacionalmente os registros de acampamento fixo, rota/Marcas e reconciliação que poderiam levar a uma implementação contraditória.

## Materiais preparados

- `[[2026-10-03-production-bible]]`: recebeu a revisão vinculante de estados, expedições a pé, tração, Attraction e fronteiras graduais.
- `[[2026-10-03-chapter-cards-and-progression-matrix]]`: recebeu a matriz de oito doentes até Marca IX e a exigência de faixas de transição por região.
- `[[2026-10-03-opus-5-5-caravan-implementation-manifest]]`: lista contratos, matriz de referências A-01–A-09 e pacotes H-01–H-05.
- `[[2026-10-03-opus-5-5-caravan-reference-briefs]]`: prepara C-01–C-05 para execução externa somente quando o usuário os autorizar.

## Verificações documentais

| Verificação | Resultado |
| --- | --- |
| Não há gap `BLOCKING` na especificação aprovada | aprovado |
| Regra 5+ doentes trava / 4+reparo+puxador libera | registrada no cânone e manifesto |
| Lolth alcança Marcas iniciais a pé | registrada no cânone e matriz |
| Puxador sem cavalo e função exclusiva | registrada no cânone, manifesto e brief C-02 |
| Attraction com ameaça concreta e redução após deslocamento | registrada no cânone, manifesto e brief C-03 |
| Transição-gradiente sem fade/corte/seletor | registrada no cânone, manifesto e brief C-04 |
| Marca IX é o único final, sem nona cura | registrada no cânone e manifesto |
| Runtime, assets, envio externo, dependências e publicação | não executados |

## Execução autorizada de referências

O usuário autorizou os cinco briefs C-01 a C-05. Foram geradas e curadas cinco pranchas de referência no diretório `generated/2026-10-03-caravan-reference-batch-c/`; os recibos, hashes, dimensões, restrições e rejeições estão em `[[2026-10-03-caravan-reference-batch-c]]`.

Validação do lote: cinco PNGs esperados e um recibo presentes; todas as pranchas medem 1672×941; status do brief e do plano reconciliados; nenhuma cópia foi encontrada fora de `.atena/generated/2026-10-03-caravan-reference-batch-c/`.

## Limite e próximo passo

As referências foram geradas, mas nenhum asset foi admitido, o projeto Godot não foi modificado e nenhum pacote de implementação foi iniciado. O próximo portão exige um novo plano técnico e aprovação explícita para transformar referências curadas em assets finais ou iniciar H-01–H-05.
