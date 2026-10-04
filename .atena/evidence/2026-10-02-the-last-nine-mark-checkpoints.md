---
kind: automated-validation
date: 2026-10-02
spec: '[[2026-10-02-the-last-nine-vertical-slice]]'
---

# The First Nine — validação de Marca e checkpoints

## Comando

`godot --headless --path . -- --self-test`

## Resultado

**Aprovado.** O teste integrado confirmou a sequência de nove níveis da Marca, oito despertares e o estado final do portal.

Saída confirmatória: `SELF_TEST_PASS: Mark checkpoints restore and nine levels reach the final portal state`.

## Observações do ambiente

O Godot não conseguiu criar `user://logs` no ambiente restrito e não leu o armazenamento de certificados do Windows. Esses avisos não interromperam a inicialização, a análise do script nem o teste; o processo terminou com sucesso.

## Cobertura

- A HQ concede `FIRST THREAD` e cria o primeiro checkpoint.
- Um checkpoint intermediário é acionado, restaurado e conferido antes da continuação do teste.
- Oito Ecos avançam os níveis restantes até `SHADOW CROWN`.
- Níveis 1–8 resultam em oito sobreviventes despertos.
- O nível 9 habilita o estado final do portal.
- Checkpoints guardam Marca, área, recursos, despertos e fase do Eco final para impedir duplicação de progresso após reinício.

## Pendente

É necessária uma partida humana para validar legibilidade, ritmo de 8–12 minutos e missão passiva na interface.
