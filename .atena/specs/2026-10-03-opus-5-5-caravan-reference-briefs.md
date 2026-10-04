---
status: executed-curated-reference-only
kind: external-reference-briefs
created: 2026-10-03
approval_mode: per-plan
executed: 2026-10-03
generated_receipt: '[[2026-10-03-caravan-reference-batch-c]]'
depends_on:
  - '[[2026-10-03-caravan-survival-slow-travel]]'
  - '[[2026-10-03-opus-5-5-caravan-implementation-manifest]]'
---

# The First Nine — briefs de referência da carroça para Opus 5.5

## Regra de execução

Cada brief é uma prancha de referência em pixel art 2D dark fantasy, vista lateral e 1280×720, com contraste entre noite azul-violeta, fogo âmbar e materiais recuperados. Não produzir texto legível, watermark, spritesheet, atlas, animação final, código, arquivos de runtime ou assets admitidos. A execução externa continua proibida até o usuário escolher os IDs desejados.

Todos os resultados devem registrar ID, fontes canônicas, instrução usada, data, ferramenta, hash, termos/proveniência, diretório de revisão e resultado da curadoria.

## C-01 — carroça: abrigo, reparo e viagem

**Objetivo:** estabelecer a mesma carroça em três leituras: `stationed`, `travel_locked` e `travelling`.

**Mostrar:** carroça danificada com oito sinais de aliados doentes; bancada de reparo e materiais recuperados; estado reparado com quatro doentes embarcados; arnês e canga de tração sem cavalo; carga pesada e construção élfica recuperada.

**Não mostrar:** cavalo, veículo extra, doentes abandonados, interface funcional, números de velocidade ou mapa de seleção.

**Aceitação:** a limitação de quatro passageiros é entendida sem texto; a versão viajante parece pesada, útil e mais lenta que Lolth a pé.

## C-02 — aliados, funções e tração

**Objetivo:** comunicar que Lolth permanece jogável e os drows curados ajudam de forma contextual e exclusiva.

**Mostrar:** Lolth puxando; um drow curado puxando; o mesmo drow em variante de defesa e missão, cada uma claramente separada; sinais visuais de `plagued`, `cured`, `assigned_defense`, `assigned_mission`, `assigned_pull` e `on_wagon`.

**Não mostrar:** drows seguindo Lolth, membros jogáveis, combate cooperativo, armas ou biografias novas.

**Aceitação:** não há leitura de party controlável; tração, defesa e missão parecem escolhas mutuamente exclusivas.

## C-03 — pressão e salvamento

**Objetivo:** tornar `Attraction` e o risco da permanência instantaneamente compreensíveis.

**Mostrar:** carroça parada em estado seguro, crescente e crítico; pistas ambientais e inimigos regionais se aproximando; telegraph concreto de ameaça; fuga lenta da carroça reduzindo a pressão; salvar/retornar associado ao abrigo e não à Marca.

**Não mostrar:** dano invisível, contador definitivo, inimigos de sombra genéricos, lua como ícone de save.

**Aceitação:** o jogador vê por que precisa mudar de local e como o risco diminui, sem que a ameaça pareça arbitrária.

## C-04 — fronteira Thornwake–Stonehook

**Objetivo:** provar a transição-gradiente de um mundo único.

**Mostrar:** trecho lateral contínuo e jogável: raízes, água e musgo de Thornwake desaparecem aos poucos em pedra, cordas, altitude e poeira de Stonehook; paleta, silhueta, partículas, som sugerido e marcos distantes se misturam em ambas as direções.

**Não mostrar:** porta de fase, tela preta, fade, mapa, menu, loading ou mudança brusca de tileset.

**Aceitação:** uma captura isolada permite identificar os dois biomas e ainda assim ler um único caminho contínuo.

## C-05 — HUD da sobrevivência da carroça

**Objetivo:** definir a hierarquia visual, não o layout final, para decisões de carroça e viagem.

**Mostrar:** saúde/condição da carroça, oito retratos em estado, quantidade de doentes, reparo pendente, puxador designado, passageiros, `Attraction`, fase de ciclo, `RECOVERED LOAD`, objetivo de Marca e prompt contextual sem bind fixo.

**Não mostrar:** texto final, valores numéricos imutáveis, controle direto de drows, UI pronta para runtime.

**Aceitação:** em poucos segundos é possível saber por que a carroça não parte ou por que está lenta, quem está indisponível e quão urgente é sair.

## Próximo portão

O usuário deve autorizar explicitamente um ou mais IDs `C-01` a `C-05` antes de usar o Opus 5.5 externamente. Cada execução autorizada continuará sendo somente referência e será revisada localmente antes de qualquer plano de implementação.
