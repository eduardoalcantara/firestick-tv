# flow.md — fluxo operacional do agente

## Leitura condicional

Não ler a raiz inteira em todo prompt.

| Situação | Ler |
|---|---|
| Sempre | `AGENTS.md` (índice já injetado). Abrir os outros documentos só na linha que couber |
| Usuário pediu atualizar via CCIA/handoff | O(s) arquivo(s) `@` indicados em `prompts/` |
| Implementar / documentar | `spec-root.md`, `rules.md`, e trechos necessários de `flow.md` |
| Repo/entrega de software/sistemas | `software-development-rules.md` (SOLID, DI, padrões); **ignorar** se o domínio não for software |
| Scripts | `rules-scripts.md` |
| Entrega material | `status.md`, `timeline.md` |
| Spec ativa em `specs/to-do/` | A spec ativa (escopo mandatório) |

## Modos de tarefa

Um prompt → um modo: `explorar` | `implementar` | `corrigir` | `documentar` | `commit+push`.

## Fluxo de execução

Se `AGENTS.md` ainda tiver a seção "Gatilho — sair do modo template", execute esse gatilho antes dos passos abaixo. Se essa seção já não existir e existir "Gatilho — CCIA", siga essa seção antes de gravar CCIA.

1. Identificar modo e escopo.
2. Ler só o necessário (tabela acima).
3. Executar só o escopo confirmado (sem refactor espontâneo).
4. Validar ou declarar limitação.
5. No projeto derivado, atualizar `status.md` / `timeline.md` se material. No repo-fonte do template, não preencher esses arquivos com o histórico do template.
6. Gravar/append CCIA se prompt relevante (projetos derivados; não no repo-fonte do template; não em Commit+Push exclusivo). Enquanto `AGENTS.md` tiver a seção `Gatilho — CCIA`, não gravar.
7. Responder com dados mínimos + DoD.

`.prompt-status` está desativado. Não criar nem atualizar.

## CCIA / handoff

- **Gravar/append** (projetos derivados): 1 arquivo por chat; transcrição **literal** prompt↔resposta; após entrega relevante.
- CCIA **não** é resumo de entrega — isso é `timeline.md` / `status.md`.
- Repo-fonte deste template: **não** gravar CCIA de conversa.
- Handoff diário (resumo de sessão) se pedido.
- **Ler** somente sob pedido explícito do usuário (troca de máquina + `@arquivo`).
- Detalhes: `prompts/readme.md`.

## Checklist (DoD)

- [ ] Modo e escopo claros
- [ ] Leitura condicional feita
- [ ] Sem refactor fora do pedido
- [ ] Validação ou limitação declarada
- [ ] Docs atualizados se material
- [ ] CCIA gravado/append se relevante (derivados; não no repo-fonte do template)
- [ ] Próximo passo explícito

## Limite de exploração

Sem progresso após ~8 buscas/leituras → pause com opções numeradas.
