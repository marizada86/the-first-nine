# Opus 5.5 — pacote de handoff

Estes pacotes são instruções para execução externa pelo usuário. Não autorizam execução automática, alteração do runtime congelado, dependências, geração de assets, publicação ou envio remoto.

## Formato obrigatório

Todo handoff informa: escopo limitado, contexto canônico, arquivos permitidos, arquivos vedados, não-objetivos, critérios de aceitação, validação local e saída esperada. A integração exige revisão local, validação do Godot e reconciliação ADD.

## Ordem de uso

1. `01-runtime-foundation.md` — somente depois de aprovação separada para implementação limpa.
2. `02-thornwake-package.md` — somente depois de a fundação ser aprovada e integrada.
3. `03-visual-language-a.md` — somente depois de aprovação separada para geração/curadoria de referências visuais.
