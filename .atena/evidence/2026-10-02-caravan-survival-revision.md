---
status: verified-automated
date: 2026-10-02
spec: '[[2026-10-02-caravan-survival-revision]]'
---

# Evidência — revisão de sobrevivência da caravana

## Verificação executada

Comando de validação local:

`D:\Godot\godot.exe --headless --path . -- --self-test`

Resultado: `SELF_TEST_PASS: Caravan survival loop, passive mission, Mark checkpoints, and nine levels reach the final portal state`.

O teste cobre:

- requisito conjunto de Provisions e reparo da carroça antes da HQ;
- atribuição e resolução de uma missão passiva;
- avanço com reparo de rota;
- restauração de Marca, sobreviventes e reparo no checkpoint;
- chegada aos nove níveis da Marca e ao estado final.

O Godot relatou falhas para criar `user://logs` e ler o repositório de certificados do sistema no ambiente headless. Elas não impediram o carregamento do projeto nem o resultado aprovado do teste.

## Validação humana ainda necessária

Uma inspeção visual humana continua pendente: confirmar que os três medidores, os oito sobreviventes junto à carroça e os comandos `E`/`F`/`M` são compreensíveis sem instrução externa, e cronometrar uma partida completa.
