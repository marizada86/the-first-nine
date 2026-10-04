---
status: verified
date: 2026-10-02
spec: '[[2026-10-02-salvage-micro-metroidvania]]'
---

# Evidência — Salvage micro-metroidvania

## Verificação automatizada

Comando: `D:\Godot\godot.exe --headless --path . -- --self-test`

Resultado: `SELF_TEST_PASS: controls-ready Salvage load, caravan survival, passive mission, Mark checkpoints, and nine levels reach the final portal state`.

O teste confirma que:

- as ações `primary`, `jump` e `shadow_action` receberam os vínculos de entrada esperados;
- `RECOVERED LOAD` começa com dois slots, é preservada no checkpoint e chega a quatro no nono nível da Marca;
- `Might` e `Vigor` derivam dos status por Marca e governam, respectivamente, carga e vida máxima;
- o tutorial exige provisões e reparo; missão passiva, avanço, checkpoint e nove níveis continuam íntegros.

O ambiente headless voltou a reportar indisponibilidade de `user://logs` e do repositório de certificados, sem afetar a conclusão aprovada do teste.

## Validação humana — concluída

O responsável pelo projeto confirmou em 02/10/2026 que tudo foi validado, incluindo os três métodos de entrada, pulo em plataformas, dash, dano de Lolth, carga recuperada, gates das Marcas e ritmo da partida.
