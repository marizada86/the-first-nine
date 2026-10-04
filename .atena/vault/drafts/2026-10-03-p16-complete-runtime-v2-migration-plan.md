---
status: complete-user-approved
kind: complete-runtime-v2-migration-plan
created: 2026-10-03
approval_mode: per-plan
approval_selection: user-explicit-2026-10-03
approved: 2026-10-03
sources:
  - '[[2026-10-03-opus-p0-p11-reconciled-technical-contract]]'
  - '[[2026-10-03-runtime-art-readiness-audit]]'
  - '[[2026-10-03-p14-runtime-v2-core-migration-plan]]'
  - '[[2026-10-03-p15-thornwake-threat-runtime-migration-plan]]'
---

# Plano P16 — migração completa para runtime_v2

## Objetivo

Converter e integrar todas as famílias visuais restantes já aprovadas em P0–P11, concluindo a substituição progressiva do runtime legado sem alterar lore, regras centrais, dependências ou publicação.

## Lotes autorizados pelo mesmo plano

| Lote | Entrega |
| --- | --- |
| B-001 | Thalestriel `plagued`/`cured`, assentos, defesa, missão, tração e sobrevivência da carroça |
| B-002 | UI de sobrevivência: capacidade, reparo, puxador, Attraction, interações e Marcas |
| B-003 | salvamento, oficina, defesas, bloqueios de teia, chão tecido e marcos de rota |
| B-004 | Stonehook: chão contínuo, props, três ameaças e chefe |
| B-005 | Hollowroot, Glass Dunes e Dreamwater: terreno, props, ameaças, chefes e transições graduais |
| B-006 | Marcas/Shar/Lolth, final, VFX restante, áudio de especificação, validação Godot e provas visuais |

## Regras

- `runtime_v2` recebe apenas arquivos novos e versionados; legado fica preservado até cada substituição validada.
- Referências P0–P11 definem o visual; nenhum master é importado diretamente sem conversão em candidato runtime.
- Carroça aberta, rota contínua, teia como bloqueio especial, drows contextuais e Marca IX final são invariantes.
- Não alterar mecânicas aprovadas, balanceamento, dependências, permissões, publicação ou arquivos canônicos.

## Aceitação

- Todas as famílias restantes recebem candidato runtime, proveniência e consumer definido.
- Cada lote passa em importação, autoteste e prova visual local antes de seguir ao próximo.
- O runtime ativo deixa de carregar famílias legadas substituídas; rollback continua disponível.
- O resultado final contém uma matriz de cobertura P0–P11 e pendências explícitas de áudio/balanceamento humano.

## Limites da autorização única

Esta aprovação autoriza os seis lotes listados. Ela não autoriza mudanças de lore/regras, dependências/permissões, exclusões de legado, publicação, push, deploy ou qualquer família não listada.
