# [NOME DO PROJETO]

## Resumo

Fundação documental e operacional do projeto. Padroniza estrutura, governança, fluxo do agente e o núcleo do produto em `/core`.

Substitua os placeholders `[NOME DO PROJETO]`, `[RESUMO]`, `[PÚBLICO]` e demais marcações conforme a necessidade do projeto.

## Público e objetivo

- **Público:** pessoas e agentes que criam e mantêm projetos no Cursor.
- **Objetivo:** nascer com contexto suficiente para o Cursor trabalhar com consistência desde o primeiro prompt.

## Estrutura de alto nível

| Caminho | Função |
|---|---|
| `AGENTS.md` | Índice único do agente (não repete as regras) |
| `CLAUDE.md` | Claude Code: importa `AGENTS.md` |
| `.gemini/settings.json` | Gemini CLI: contexto = `AGENTS.md` |
| `spec-root.md` | Autoridade arquitetural do projeto |
| `rules.md` | Governança permanente, inclusive fronteira script de repo vs script de produto |
| `software-development-rules.md` | SOLID, DI e padrões (só se o repo for software/sistemas) |
| `flow.md` | Ordem de leitura e execução |
| `status.md` / `timeline.md` | Estado e histórico do projeto |
| `setup.md` / `tools-*.md` | Ambiente e ferramentas |
| `specs/` | Especificações formais (`to-do/`, `done/`, `optional/`) |
| `scripts/validation/min-tree.txt` | Única lista da árvore mínima |
| `core/` | Essencial do produto, inclusive scripts de produto em `core/scripts/` |
| `scripts/` | Scripts do **repositório** (não entram em `/core`) |
| `docs/`, `ideas/`, `references/`, `reports/`, `prompts/`, `resources/` | Apoio documental e operacional |

## Agentes

`AGENTS.md` é o único texto de instrução. Cursor, OpenCode e Codex leem esse arquivo. Claude Code lê `CLAUDE.md`, que só importa `AGENTS.md`. Gemini CLI usa `.gemini/settings.json` para procurar `AGENTS.md` em vez de `GEMINI.md`.

## Como iniciar

1. Personalize com `specs/optional/bootstrap-personalizar-projeto.md` e abra no Cursor.
2. Leia: `spec-root.md` → `rules.md` → `flow.md` → `setup.md` → `core/readme.md`.
3. Preencha os placeholders. Código e scripts de build/run/installer do produto vão para `/core` (`core/scripts/`). Scripts que só servem ao repositório ficam em `scripts/`.
4. Atualize `status.md` e `timeline.md` a cada entrega relevante.

Detalhes de ambiente: ver `setup.md`, `tools-linux.md` e `tools-windows.md`.

## Documentação relacionada

- Fluxo do agente: `flow.md`
- Regras permanentes: `rules.md`
- Regras de scripts: `rules-scripts.md`
- Molde de specs: `spec-template.md`

## Estado atual

`status.md` e `timeline.md` registram pendências e alterações do projeto.
