---
status: prepared-not-authorized
kind: implementation-reference-manifest
created: 2026-10-03
plan: '[[2026-10-03-caravan-survival-slow-travel-revision]]'
canonical_source: '[[2026-10-03-caravan-survival-slow-travel]]'
---

# The First Nine — manifesto de implementação para Opus 5.5

## Propósito e limite

Este manifesto prepara os materiais que o Opus 5.5 precisará para implementar o jogo depois de autorização explícita de cada lote. Ele descreve contratos, assets de referência, entradas e verificações; não é autorização para gerar arte, escrever runtime, enviar contexto externo ou admitir arquivos em `res://`.

O protótipo existente é evidência de sensação de combate, não arquitetura final. A implementação deve tomar este manifesto e as decisões canônicas como fonte de verdade.

## Contratos de sistema que não podem ser reinterpretados

| Contrato | Entrada mínima | Resultado legível | Exclusões |
| --- | --- | --- | --- |
| Aliados | oito `plagued`; Marca I–VIII e escolha do jogador | um aliado passa a `cured` e recebe uma função contextual | sem party controlável ou IA seguidora |
| Capacidade | contagem de `plagued`, reparo da carroça, puxador disponível | 5+ trava a viagem; 4 libera embarque de até quatro | sem abandonar aliado, cavalo ou segunda carroça |
| Funções | defesa, missão ou tração por drow curado | retrato/posto comunica a função e indisponibilidade | sem duas funções simultâneas |
| Tração | Lolth ou um drow `assigned_pull`; peso e `Might` | carroça se move devagar e explica causa da lentidão | sem números canônicos fixos |
| Attraction | permanência numa localidade; deslocamento | medidor/telegraph mostra risco crescente e alívio após viajar | sem dano abstrato ou inimigo invisível |
| Expedição a pé | Lolth parte de carroça `stationed` | regiões seguintes e Marcas permanecem alcançáveis antes da viagem | sem tela de seleção de mapa |
| Mundo contínuo | faixa de fronteira entre regiões | paleta, materiais, áudio e marcos mudam gradualmente | sem fade, tela preta ou corte seco |
| Final | Marca IX | desfecho sem nona cura e sem grind | sem terminar na liberação da carroça |

## Matriz de assets de referência

| ID | Entrega de referência | Conteúdo obrigatório | Não produzir |
| --- | --- | --- | --- |
| A-01 | Carroça estacionada | carroça danificada, abrigo, oficina, oito leitos/indícios de doentes e leitura de salvage | cavalo, UI final, spritesheet |
| A-02 | Carroça viajante | carroça reparada, até quatro passageiros doentes, arnês de tração sem animal e carga pesada | veículo leve, caravana múltipla |
| A-03 | Puxadores e postos | Lolth puxando; um drow puxando; poses de defesa e missão mutuamente exclusivas | controle direto de drow, animação final |
| A-04 | Aliados e estados | silhueta `plagued`/`cured`, retratos e sinal de função para os oito aliados | biografia, equipamento ou poderes novos |
| A-05 | Attraction | três leituras de pressão: segura, crescente, crítica; ameaça concreta à carroça | contador numérico definitivo, dano sem causa |
| A-06 | Transição Thornwake–Stonehook | faixa jogável com raízes/musgo cedendo a pedra, corda e altitude; marcos compartilhados | loading screen, corte ou seleção de mapa |
| A-07 | Transições posteriores | princípios de mistura para Stonehook–Hollowroot, Hollowroot–Glass Dunes e Glass Dunes–Dreamwater | mapas finais sem ficha aprovada |
| A-08 | HUD operacional | condição, doentes/curados, função do puxador, passageiros, Attraction, objetivo de reparo e Marca | layout final, texto gerado ou binds fixos |
| A-09 | Thornwake inicial | salvage diurno, combate legível, retorno, primeira ameaça e carroça estacionada | multidão, inimigos genéricos de sombra |

## Pacotes de handoff sugeridos

| Lote | Dependências | Entregas para Opus | Critério de saída |
| --- | --- | --- | --- |
| H-01 Fundação de estados | A-01–A-04 aprovados | esquema de dados, máquina de estados de aliados/carroça, tabela de mensagens e roteiro de teste | não há transição impossível entre função, passageiro e puxador |
| H-02 Viagem e pressão | A-02, A-03, A-05 aprovados | contrato de tração, parâmetros externos de velocidade, Attraction e ameaça com contrajogo | 5 trava, 4+reparo libera, puxador é exclusivo, mover reduz pressão |
| H-03 Mundo contínuo | A-06 aprovado | contrato de streaming/portais suaves, kit de faixa de transição e teste visual | cruzar limite não produz fade, corte ou seletor |
| H-04 Capítulo Thornwake | A-08, A-09 aprovados | cena inicial, loop de salvage/combate, HUD mínimo e integração H-01/H-02 | teste de prólogo, expedição a pé e retorno seguros |
| H-05 Capítulos posteriores | A-07 e fichas específicas aprovadas | uma implementação pequena por capítulo | cada região passa pelo portão de conteúdo próprio |

## Critérios comuns para qualquer execução futura

- Todo output deve trazer ID, lote, fontes, prompt/instrução, ferramenta, data, hash, termos/proveniência, diretório de revisão e decisão de curadoria.
- Todo asset precisa de referência aprovada antes de conversão em sprite, atlas, tilemap, animação ou arquivo de runtime.
- Implementação em Godot deve usar parâmetros de balanceamento para velocidade, peso, Attraction, ondas e dano; nenhuma dessas quantidades entra como verdade narrativa.
- Cada lote deve validar, no mínimo, o comando de verificação do projeto e um roteiro de smoke test acordado para o seu escopo.

## Próximo portão

O usuário escolhe um ou mais IDs de referência `A-01` a `A-09` para autorizar execução externa de um lote de referências. Depois da curadoria desses resultados, um novo plano técnico poderá autorizar um pacote `H-01` a `H-05` de implementação.
