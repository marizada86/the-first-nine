---
status: complete-user-approved-audit
plan: '[[2026-10-03-p13-runtime-art-readiness-audit-plan]]'
scope: read-only-runtime-audit
---

# Auditoria de prontidão da arte runtime

## Resultado executivo

O runtime possui **45 PNGs** em `assets/art/`; **33** são carregados diretamente por `main.gd` e **12** não têm consumidor estático atual. Nenhum dos 45 caminhos aparece como fonte no manifesto vigente P0–P11. Assim, eles são legado técnico/visual e não podem ser promovidos automaticamente como arte final aprovada.

## Matriz por família

| Família runtime | Carregados | Estado | Evidência | Ação recomendada |
| --- | ---: | --- | --- | --- |
| Lolth / personagens | 11 | substituir | pranchas pictóricas detalhadas, não o pixel art minimalista P6 | criar atlas versionados a partir de P6; preservar os atuais até a admissão aprovada |
| Carroça / acampamento | 3 | substituir/revisar | a carroça de reparo é fechada e coberta; conflita com carroça aberta sem quartos | produzir carroça aberta P0/P1 e revisar braseiro/props contra P7 |
| Inimigos | 2 | substituir | `Shade` genérico de sombra; o canon define quinze ameaças regionais P5 | admitir primeiro Thornwake e depois as demais famílias P5 |
| Ambiente | 7 | substituir/revisar | `traversal-platforms` institui plataformas comuns; cenários antigos não têm proveniência P2/P3/P9 | começar pelo chão contínuo de Thornwake, depois props e transições regionais |
| Portões / Marcas | 2 | substituir | portões antigos não documentam a progressão Shar → fios → Lolth | converter P4/P11 em layers narrativas e bloqueios específicos de teia |
| Pickups | 1 | revisar | papel de coleta é aproveitável, mas não possui ligação aos masters P0/P7 | redesenhar/recortar em atlas versionado com proveniência |
| UI | 5 | substituir/revisar | ícones antigos não cobrem de forma garantida a capacidade, puxador, Attraction e Marcas P10 | implementar componentes P10 após os estados de HUD existirem |
| VFX | 2 | revisar | função próxima de P8, porém sem origem no manifesto | converter VFX P8 em atlases novos e testar eventos reais |
| Variantes sem consumidor | 12 | manter como histórico | versões antigas de carroça, Lolth, Shade, pickups, portões e VFX | não apagar; não reutilizar sem novo plano de admissão |

## Conflitos canônicos encontrados

1. A carroça runtime amostrada é fechada e coberta; a direção vigente pede carroça aberta, sem cavalo e sem quartos.
2. A Lolth runtime amostrada é arte pictórica detalhada, enquanto a direção aprovada é pixel art minimalista lateral.
3. O `Shade` é inimigo genérico de sombra; as ameaças vigentes são famílias regionais P5.
4. A folha `traversal-platforms` representa plataformas comuns; a rota vigente exige chão contínuo, com teia apenas para bloqueios especiais.
5. Portões e selos antigos não comprovam a sequência visual de Shar para a aranha de Lolth.

## Fila de produção/admissão recomendada

1. **Lote núcleo do loop:** Lolth P6, carroça aberta P0/P1, chão contínuo de Thornwake P2, pickups P7 e VFX de ataque/coleta P8.
2. **Lote de combate inicial:** três ameaças de Thornwake P5 e os estados necessários dos aliados P6.
3. **Lote de sobrevivência e narrativa:** oficina/defesa P7, HUD P10, Marcas e âncoras P4/P11.
4. **Expansão regional:** Stonehook, Hollowroot, Glass Dunes e Dreamwater com P5/P9/P11.

Cada lote exige plano próprio de admissão Godot, candidato versionado, prova 1280×720 e rollback. Esta auditoria não criou, moveu, importou, editou ou excluiu arquivo runtime.

## Revisão concluída

Matriz aprovada pela pessoa usuária em 2026-10-03. Os assets legados permanecem preservados até que um lote de admissão versionado seja aprovado.
