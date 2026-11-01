# AGENTS.md — índice do agente

Índice compartilhado. Não repete normas. Diz qual documento ler.

Cursor, OpenCode e Codex leem este arquivo. Claude Code entra por `CLAUDE.md` (`@AGENTS.md`). Gemini CLI entra por `.gemini/settings.json`.

## Sempre

- Não invente requisitos. Não extrapole o escopo confirmado.
- Se faltar contexto, houver contradição ou escopo indefinido: pause e peça esclarecimento.
- Não use `.prompt-status`. O mecanismo está desativado. Não crie, não leia e não atualize esse arquivo.
- Não leia CCIA/handoff sem pedido explícito do usuário (`@arquivo`).

## Onde está cada norma

| Situação | Documento |
|---|---|
| Governança, hierarquia, escopo, CCIA (resumo) | `rules.md` |
| Sequência de trabalho e definição de pronto | `flow.md` |
| O que o projeto é | `spec-root.md` |
| Qualquer script (UX, input, uninstall) | `rules-scripts.md` |
| Código de software/sistemas | `software-development-rules.md` — ignorar se o domínio não for software |
| Script de repositório vs script de produto | `rules.md` (fronteira) e o detalhe em `scripts/readme.md`, `core/readme.md`, `core/scripts/readme.md` |
| Spec ativa | `specs/to-do/` — ela manda no escopo |
| CCIA / handoff (formato) | `prompts/readme.md` |
| Árvore mínima (lista única) | `scripts/validation/min-tree.txt` |

## Regra final

Conflito entre documentos: a hierarquia de `rules.md` prevalece. Se continuar irresolvido, pause.
