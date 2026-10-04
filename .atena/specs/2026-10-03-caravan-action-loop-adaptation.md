---
status: approved
kind: game-design-and-implementation-plan
created: 2026-10-03
approved: 2026-10-03
request_classification: PLAN_CHANGE_REQUEST
origin: guided-add
related_intent: '[[2026-10-02-thalestriel-exodus-game-intent]]'
depends_on:
  - '[[2026-10-02-compact-salvage-exploration]]'
  - '[[2026-10-03-caravan-awakening-progression]]'
  - '[[2026-10-03-night-clock-caravan-stakes]]'
  - '[[2026-10-03-thornwake-combat-economy-and-progression-decisions]]'
  - '[[2026-10-03-thalestriel-contextual-assists]]'
active-plan-note: 'The active interface/VFX reference plan remains untouched; this proposal requires a subsequent approved implementation plan.'
---

# The First Nine — adaptação do ciclo de caravana e combate

## Objetivo

Transformar a vertical slice de **Thornwake Forest** em um ciclo compacto de ação, preparação e defesa: a carroça é a âncora emocional e tática; Lolth explora e luta diretamente; a noite cobra as decisões tomadas durante o dia. A referência é apenas a clareza estrutural de jogos de caravana/sobrevivência lateral, sem copiar IP, arte, mapa, economia ou conteúdo de *Kingdom Two Crowns*.

## Escopo proposto

- Organizar Thornwake em três trechos artesanais e conectados: **acampamento**, **rota de recursos** e **ponto de risco/objetivo**. Cada trecho deve ter retorno visual e mecânico à carroça; não há mapa grande, geração procedural ou mundo aberto.
- Fixar uma tentativa curta em cinco batidas: amanhecer (escolher até dois postos), dia (explorar, coletar e enfrentar ameaças), entardecer (retornar e preparar), noite (duas ou três ondas) e novo amanhecer (avaliar avanço, reparo ou nova tentativa).
- Preservar `RECOVERED LOAD`, os cinco slots da carroça e receitas explícitas. Recursos só existem para quatro funções: provisão/cura, reparo/rota, defesa noturna e progresso do capítulo.
- Consolidar o combate inicial de Lolth como ação legível, e não como combate profundo: ataque básico de cadeia curta, esquiva curta e uma ação de sombra com recarga breve. A ação de sombra deve ter uma função inequívoca de interrupção, controle localizado ou finalização — a escolha exata será prototipada e medida no plano de implementação.
- Fazer os três inimigos de Thornwake terem papéis reconhecíveis: perseguidor comum, agressor de carroça e ameaça de elite/chefe. Eles devem forçar posicionamento sem exigir IA complexa.
- Usar os Thalestriel despertos como postos contextuais e defesa passiva da carroça. Não adicionar seguidores, comandos de aliados, inventário individual ou troca de personagem.
- Simplificar a apresentação: fundos em poucas camadas, silhuetas contrastantes, um marco visual por trecho e telegraphs de combate claros. Arte detalhada fica reservada a retratos, marcos e tela de conclusão.

## Fora de escopo

- Reproduzir mapas, moedas, construção, estética, inimigos, regras ou identidade de *Kingdom Two Crowns*.
- Produzir as outras quatro regiões, árvore de habilidades, combate de combos extensos, barra de mana, loot aleatório, crafting livre, mundo aberto ou procedural.
- Redefinir a lore, a rota de cinco regiões, a Marca 9, o elenco, os papéis dos drows ou o plano ativo de referências de interface/VFX.
- Criar arte final, spritesheets, novas dependências, publicação ou alteração remota.

## Contrato de experiência

`amanhecer: postos → dia: rota e coleta → entardecer: carroça/oficina → noite: defesa → amanhecer: avanço ou reparo`

O jogador deve sentir que se afastar da chama compra oportunidade, mas cria uma dívida que a noite cobra. Vencer combate não basta: a rota só avança quando o reparo/material do capítulo estiver pronto e a carroça sobreviver.

## Critérios de aceitação

1. Uma partida de Thornwake explica, por interação e HUD, o ciclo completo sem tutorial textual longo.
2. O jogador consegue identificar em qualquer momento o estado da carroça, da chama, da carga, do objetivo material e a proximidade da noite.
3. A rota de recursos oferece uma decisão real entre voltar cedo em segurança ou permanecer para buscar um recurso/atalho útil.
4. Cada ameaça de Thornwake possui silhueta, telegraph e contrajogo distintos com ataque, esquiva, posicionamento ou posto contextual.
5. A defesa noturna contém duas ou três batidas legíveis, mistura pressão sobre Lolth e a carroça, e termina sem grind obrigatório.
6. O Kit de Roda, a defesa noturna e o primeiro despertar continuam os requisitos inequívocos para concluir Thornwake.
7. O recorte mantém Lolth como única personagem controlável, até dois postos ativos, carga limitada e ausência de morte permanente após a Marca 1.
8. O orçamento visual do capítulo usa cenários modulares simples e não exige arte final para validar leitura e ritmo.

## Impactos previstos

- **Runtime:** o fluxo de zona, o diretor noturno, estados de inimigo e HUD precisarão ser separados de parâmetros de balanceamento para permitir iteração curta.
- **UI/VFX:** o lote de referências ativo pode informar a legibilidade do HUD e dos telegraphs, mas não é alterado nem admitido em runtime por este plano.
- **Conteúdo:** Thornwake torna-se a unidade completa da jam; Stonehook e capítulos posteriores permanecem somente como progressão prometida.
- **Canon:** a proposta é compatível com os registros atuais, mas a aprovação transforma a estrutura de batidas e o contrato de combate em direção operacional. Nenhum registro canônico será alterado antes dessa aprovação.

## Gaps

- **BLOCKING:** nenhum para aprovar este plano. Os valores abaixo não precisam ser decididos agora porque não alteram a direção e serão medidos no protótipo.
- **RESOLVABLE:** duração de dia/noite, número exato de inimigos por onda, dano, alcance da carroça, custo/recarga da ação de sombra e composição de cada trecho. Padrão proposto: instrumentar todos como dados ajustáveis e iniciar testes com uma sessão total de 8–12 minutos.
- **DEFERRED:** implementação concreta das melhorias das Marcas 3, 5 e 7; arte final; balanceamento para as cinco regiões; acessibilidade final; validação humana de ritmo; e qualquer expansão de escopo após Thornwake.

## Plano de voo, após aprovação

1. Criar uma especificação de implementação de Thornwake que liste os parâmetros, estados e critérios de telemetria; reconciliar a especificação do capítulo existente em vez de duplicar regras.
2. Bloquear o mapa em três trechos com geometria simples, retornos claros e pontos de posto, sem arte final.
3. Extrair dados de recursos, ondas e inimigos; implementar os três papéis inimigos e os três verbos de Lolth (ataque, esquiva, sombra).
4. Encadear a preparação do entardecer, a defesa noturna e os requisitos de conclusão em uma máquina de estados verificável.
5. Integrar indicadores mínimos no HUD para carga, risco noturno, condição da carroça, objetivo e postos.
6. Executar autotestes no Godot local, uma partida visual controlada e uma avaliação humana de 8–12 minutos; registrar capturas, parâmetros e resultados em `evidence/`.
7. Comparar resultados com os critérios de aceitação, reconciliar documentação operacional afetada e submeter qualquer ajuste de cânone ou expansão para nova aprovação.

## Validação e evidência planejadas

- Autotestes: transições de ciclo, derrota/recomeço, capacidade de carga, receitas, postos, agressão à carroça e conclusão do capítulo.
- Capturas/vídeo: um quadro para cada batida do ciclo, cada inimigo e a tela de objetivo/retorno.
- Registro de balanceamento: parâmetros usados, duração observada, falhas de leitura e alterações justificadas.
- Avaliação humana: conseguir explicar, após uma tentativa, por que retornar à carroça foi ou não a decisão certa.

## Aprovação

Direção aprovada em 2026-10-03 para a próxima implementação de Thornwake. A aprovação permite preparar a especificação detalhada e executar o plano de voo; não autoriza expansão para outras regiões, nova dependência, publicação ou mudança de lore sem uma aprovação específica.
