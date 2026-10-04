---
status: approved-preparation-complete
kind: canonical-design-and-implementation-plan
created: 2026-10-03
request_classification: PLAN_CHANGE_REQUEST
approval_mode: per-plan
approved: 2026-10-03
supersedes_on_approval:
  - '[[2026-10-03-caravan-awakening-progression]]'
  - '[[2026-10-03-fixed-camp-save-checkpoint]]'
  - '[[2026-10-03-five-region-route-crafting-and-marks]]'
  - '[[2026-10-03-mark-route-stonehook-and-progression-decisions]]'
depends_on:
  - '[[2026-10-02-thalestriel-exodus-game-intent]]'
  - '[[2026-10-02-salvage-gameplay-pillar]]'
  - '[[2026-10-03-thalestriel-contextual-assists]]'
  - '[[2026-10-03-production-reset-and-opus-handoff]]'
---

# The First Nine — sobrevivência da carroça e viagem lenta

## Objetivo

Reorientar a jornada para que Lolth comece sozinha em termos de ação, mantenha oito aliados doentes vivos na carroça/acampamento e conquiste as Marcas por expedições a pé. A carroça só fica apta a viajar quando estiver reparada e apenas quatro aliados ainda estiverem com a peste. Sem cavalo, um personagem disponível precisa puxá-la; peso e força definem a lentidão da viagem.

## Fluxo aprovado em proposta

1. Lolth inicia como a única personagem ativa, com oito Thalestriel ainda doentes sob proteção da carroça.
2. Enquanto houver cinco ou mais aliados com a peste, a carroça não pode viajar: ela não comporta todos os doentes e o grupo não os abandona.
3. Lolth sai a pé do acampamento para mapas externos, recupera recursos, enfrenta risco crescente e alcança as Marcas seguintes sem mover a carroça.
4. Cada Marca I–VIII cura um aliado escolhido; os drows despertos tornam-se força disponível para proteger a carroça, cumprir missões contextuais ou puxá-la quando houver viagem.
5. Com a carroça reparada e somente quatro aliados ainda com a peste, os quatro embarcam e a viagem é liberada.
6. A carroça não tem cavalo. Lolth é a puxadora padrão até existir um drow disponível; o jogador pode designar um drow curado como puxador. O puxador não realiza simultaneamente missão ou defesa ativa.
7. A viagem é lenta, com peso alto pelos quatro passageiros. Menor `Might` do puxador reduz ainda mais a velocidade; a regra usa parâmetros de balanceamento, não valores canônicos fixos.
8. Permanecer numa localização eleva o nível de atração inimiga. A atração aumenta a pressão, as ondas ou a chance de ameaça contra a carroça; deslocar-se reduz esse nível.
9. O jogo encerra somente na Marca IX. As oito curas ocorrem até a Marca VIII; a última Marca resolve Lolth, Shar e a chegada ao Plano dos Sonhos.

## Escopo

- Fazer o jogador perceber todas as regiões como um único mundo contínuo: a fronteira entre mapas usa transição-gradiente de terreno, paleta, som ambiente, vegetação/arquitetura e marcos distantes, sem seleção de mapa, tela preta ou corte seco.
- Definir estados de aliados: `plagued`, `cured`, `assigned_defense`, `assigned_mission`, `assigned_pull` e `on_wagon`.
- Definir a trava de viagem por quantidade de aliados doentes, reparo da carroça e puxador disponível.
- Manter mapas externos acessíveis a pé antes da viagem da carroça, sem mundo aberto ou mapa procedural.
- Introduzir `Attraction` como pressão contextual da localização, com comunicação legível no HUD e no acampamento.
- Preparar todos os contratos narrativos, mecânicos, visuais e de asset necessários para um handoff de implementação limitado ao Opus 5.5.
- Planejar referências de carroça sem cavalo, posições de quatro doentes, arnês/tração, postos dos drows, deslocamento lento e escalada de inimigos.

## Fora de escopo

- Controle direto de drows, IA de seguidores, segundo veículo, cavalo, mundo aberto, sobrevivência livre, crafting livre ou combate profundo.
- Implementar o novo runtime, gerar assets, enviar contexto ao Opus 5.5, adicionar dependência, publicar ou admitir arte em `res://`.
- Inventar as peças materiais, receitas ou chefes dos capítulos III–V além do que uma decisão canônica futura aprovar.

## Critérios de aceitação

1. A história explica por que a carroça permanece parada com cinco ou mais aliados doentes e por que quatro doentes liberam a viagem.
2. Lolth pode obter Marcas II–IV em expedições a pé sem contradição de mapa, carroça ou checkpoint.
3. Toda cura muda de forma legível a capacidade defensiva/operacional da carroça; não cria personagem controlável.
4. O jogador entende qual personagem puxa a carroça, por que ela está lenta e qual função esse personagem deixa de cumprir.
5. A atração inimiga aumenta de maneira compreensível ao permanecer e reduz quando a carroça muda de localização.
6. A Marca IX permanece o único encerramento do jogo e não cura um nono aliado.
7. O pacote para Opus 5.5 delimita arquivos, assets, estados, não-objetivos e validação; ele não depende do protótipo como arquitetura final.

8. A transição de uma região para a seguinte é percebida como gradiente do mesmo mundo, e não como troca discreta de mapa.

## Impactos

- **Mapa/apresentação:** cada fronteira exige uma faixa de transição compartilhada, na qual materiais e silhuetas da região atual se misturam gradualmente aos da próxima antes que sua identidade visual domine a tela.
- **Cânone:** substitui o acampamento exclusivamente fixo por estados de acampamento estacionado e carroça viajante; substitui checkpoint por Marca como única regra operacional; realoca a leitura das primeiras quatro Marcas para expedições a pé antes da viagem.
- **Narrativa:** os quatro primeiros despertares constituem o primeiro arco de sobrevivência; a carroça cheia torna a decisão de viagem emocionalmente e mecanicamente visível.
- **Mecânicas:** adiciona estado de puxador, passageiros, atração e viagem lenta; revisa defesa, missões e transições de capítulo.
- **Assets:** exige referências de posições de doentes, arnês/tração sem cavalo, animações/poses de puxar, variações de carroça estacionada/viajante e telegraphs de atração.
- **Opus 5.5:** precisa de handoff por pacotes verificáveis, após as referências e a arquitetura-alvo receberem aprovação separada.

## Gaps

- **DEFERRED (continuidade):** largura, duração e composição exata das faixas de transição são decisões de level design e playtest; a regra de não usar corte seco já fica vinculante.
- **BLOCKING:** nenhum para aprovar este plano. O usuário confirmou que Lolth pode alcançar outros mapas a pé antes de a carroça viajar.
- **RESOLVABLE:** usar Lolth como puxadora padrão e permitir um único drow curado como puxador designado. A velocidade será uma função de faixa de `Might`, peso de passageiros e atração, com números definidos por playtest.
- **DEFERRED:** composição exata de rotas a pé, valores de velocidade, fórmula de atração, UI final, equilíbrio de ondas, peças materiais dos capítulos III–V, sprites/atlas, implementação e geração de assets.

## Plano de voo

1. Criar a decisão canônica de sobrevivência/viagem e atualizar os registros de carroça, save, rota e Marcas por links de supersessão, sem apagar histórico.
2. Revisar a Bíblia de Produção e as fichas de capítulo para distinguir expedição a pé, carroça estacionada e carroça viajante.
3. Produzir o manifesto de referência e os briefings de handoff P0 para carroça/aliados, rota/atração, HUD e Thornwake inicial.
4. Submeter os briefings de referência para aprovação; somente então o usuário executa o Opus 5.5 externamente para gerar os outputs autorizados.
5. Revisar localmente cada output, registrar proveniência e aprovar as referências antes de preparar os pacotes de implementação.
6. Criar pacotes de implementação pequenos para Opus 5.5, começando por estados de dados e depois pelo primeiro capítulo; validar toda integração no Godot e reconciliar a evidência.

## Validação e evidência

- Revisão visual comprova que cada fronteira é lida como passagem gradual entre partes do mesmo mundo, sem menu, fade escuro ou interrupção brusca.
- Matriz de progressão mostra: oito doentes → quatro curas/expedições a pé → quatro doentes embarcados → viagem lenta → Marca IX/final.
- Testes futuros cobrem trava com cinco doentes, desbloqueio com quatro, indisponibilidade de função do puxador, redução de velocidade por força/peso, atração por permanência e redução após viagem.
- Revisão visual comprova leitura sem cavalo, lotação de quatro passageiros, estado do puxador, defesa/missões dos drows e telegraphs de atração.
- Todo output do Opus 5.5 recebe recibo de proveniência, licença/termos, hash, aprovação de referência e validação local antes de qualquer admissão.

## Aprovação solicitada

Autorizar esta revisão canônica, o plano de referência e a preparação de briefings externos para Opus 5.5. A aprovação não autoriza gerar assets, enviar os briefings, modificar o runtime, adicionar dependências, publicar ou admitir arquivos em `res://`.
