---
status: approved
kind: implementation-specification
approved: 2026-10-02
plan: '[[2026-10-02-salvage-micro-metroidvania-plan]]'
---

# Salvage micro-metroidvania

Implementar o plano de voo aprovado para controles equivalentes, plataforma, combate curto, carga recuperada e gates compactos das Marcas. Os critérios de aceitação, escopo e não objetivos são os definidos em `[[2026-10-02-salvage-micro-metroidvania-plan]]`.

## Resultado de implementação — 02/10/2026

- Lolth agora tem movimento de plataforma com gravidade, pulo e plataformas verticais em cada trecho.
- As ações primária, pulo, sombra e acampamento/carga possuem vínculos equivalentes para teclado, teclado/mouse e controle.
- O contato com sombras remove Vigor de Lolth, com brevíssima invulnerabilidade, em vez de causar falha instantânea.
- `RECOVERED LOAD` substitui o transporte visível: inicia em dois slots, cresce para três em `DEEP HUNGER` e quatro em `SHADOW CROWN`; itens de `Salvage` podem usar dois slots.
- Os cinco status canônicos de Lolth são representados por Marca; `Might` determina a carga e `Vigor` determina a vida máxima de três a cinco segmentos.
- `VELVET VEIL`, `NIGHT CHOIR`, `DEEP HUNGER` e `SPIDER'S PROMISE` possuem ações de exploração/gates compactos. As demais Marcas continuam progredindo a narrativa e os status.
- A rota automatizada passou; ver `[[2026-10-02-salvage-micro-metroidvania]]` em `evidence`.

## Validação humana — concluída

Em 02/10/2026, o responsável pelo projeto confirmou a validação de teclado, teclado/mouse e controle, além de pulo, ação primária, ação de sombra, carga, gates e prompts. Os critérios da especificação estão aceitos.

## Apresentação de Ashen Way — 02/10/2026

O plano de apresentação aprovado foi integrado sem alterar as regras desta especificação. A cena agora usa as folhas de produção de Lolth, acampamento e VFX; a verificação automatizada passou. Ver `[[2026-10-02-ashen-way-presentation]]` em `evidence` para os recortes e a pendência de inspeção visual humana.
