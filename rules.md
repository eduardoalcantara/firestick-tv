# rules.md — regras permanentes de governança

## Hierarquia normativa

1. `spec-root.md` — autoridade arquitetural máxima
2. `rules.md` — este arquivo (governança permanente)
3. `AGENTS.md` — comportamento do agente (canônico neste template)
4. `flow.md` — sequência operacional
5. `rules-scripts.md` — governança de scripts
6. `software-development-rules.md` — engenharia de software (SOLID, DI, padrões); **só** se o repo/entrega for software/sistemas
7. Specs em `specs/` — entregas formais
8. Docs, ideas e references — apoio (não normativo por padrão)

Em conflito: nível superior prevalece. Se irresolvido → pause e peça esclarecimento.

**Nota:** `AGENTS.md` é só o índice (não repete estas regras). Este template não depende de `.cursor/rules/`.

## Regras gerais permanentes

- Não inventar requisitos. Não extrapolar escopo.
- Ser honesto sobre limites, dúvidas e validações.
- Manter a raiz documental viva e coerente.
- Conteúdo específico do projeto vive em `/core` sempre que aplicável.
- Preferir mudanças pequenas; não reescrever o que o pedido não pediu.

## Regras de escopo

- Implementar somente o confirmado em `spec-root.md` ou em specs ativas em `specs/to-do/`.
- Spec ativa tem prioridade; não abrir escopo paralelo sem autorização.
- Não misturar grupos/temas sem autorização.

## Regras de qualidade e performance no Cursor

- Leitura **condicional** (ver `flow.md` / `AGENTS.md`).
- Orçamento de contexto: `@arquivo` pontual; evitar pastas grandes e CCIAs antigos.
- Um prompt = um modo de tarefa.
- Limite de exploração: pause com opções se não houver progresso.
- `.cursorignore` deve excluir binários, downloads, logs e segredos da indexação.
- Qualidade de **código de software**: quando aplicável, `software-development-rules.md` (referência de padrões: [Refactoring.Guru — Design Patterns](https://refactoring.guru/design-patterns/catalog)).

## Regras de documentação

- `status.md` e `timeline.md` registram pendências e alterações do repositório.
- Entregas materiais geram relatório em `reports/`.
- Specs novas usam `spec-template.md`; concluídas vão para `specs/done/`.

## Regras de validação

- Validar o possível; não afirmar sucesso sem evidência; registrar o não validado.

## Regras de bloqueio

Pause quando: faltar contexto; houver contradição; escopo indefinido; ação destrutiva sem confirmação.

## Scripts de repositório e scripts de produto

São coisas diferentes. Não misturar.

| Tipo | Onde | O que é |
|---|---|---|
| Script de **repositório** | `scripts/` na raiz | Apoio ao repo (validar árvore, manutenção documental). Não entra em `/core`. |
| Script de **produto** | `core/scripts/` | Essencial para alterar, compilar, rodar ou instalar o produto. Não fica em `scripts/` da raiz. |

Detalhe: `scripts/readme.md`, `core/readme.md`, `core/scripts/readme.md`. UX comum (input, uninstall): `rules-scripts.md`.

## Regras de atualização e rastreio

- Alterar `spec-root.md` só com intenção explícita de mudar a arquitetura.
- `.prompt-status` está **desativado**. Não criar, não ler, não atualizar e não versionar.
- CCIA: **1 arquivo por chat**, transcrição **literal** prompt↔resposta (append); **não** é resumo de entrega (`timeline.md` / `status.md`). Formato em `prompts/readme.md`.
- CCIA: **gravar/append** após prompt relevante; **ler** só se o usuário pedir explicitamente.
- Em Commit+Push exclusivo: não gravar/append CCIA.

## Regras de scripts (resumo)

Detalhes em `rules-scripts.md`:

- instalação com `--uninstall` reversível;
- identificação em texto puro, sem cor e sem bordas;
- menus numerados: `0` = não, `1` = sim, Enter = default;
- modos `--quiet`, `--ssh`, `--force`, `--log` quando aplicável.
