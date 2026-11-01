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

## Gatilho — sair do modo template

No início do turno, antes do pedido, olhe só o nome da pasta que contém este arquivo (a raiz do repo, não o caminho inteiro).

- Se esse nome contiver `template`, sem diferenciar maiúsculas: pare. Não converta. Esta seção fica.
- Se não contiver: este repositório é um projeto normal. Neste turno, antes do pedido, faça a conversão e apague esta seção inteira. `status.md` e `timeline.md` passam a valer. Não grave CCIA neste turno: a seção `Gatilho — CCIA` pergunta antes.

Conversão — só o que trata este repo como fonte do template, ou que proíbe histórico por isso:

- Apague esta seção de `AGENTS.md`. Não apague a seção `Gatilho — CCIA`.
- Em `spec-root.md`, `rules.md`, `flow.md`, `prompts/readme.md`, `readme.md` e `setup.md`: apague as isenções de repo-fonte e as frases de que este repositório é o template ou de que o próximo passo é **Use this template**. `status.md` e `timeline.md` passam a registrar este repositório. Não ative CCIA aqui.
- Em `status.md` e `timeline.md`: apague a frase de que ficam vazios por serem o template. Uma entrada na timeline, com a data do turno: saiu do modo template porque o nome da pasta raiz não contém `template`. Não invente outras tarefas.
- Não invente nome, propósito ou domínio. Placeholders `[NOME DO PROJETO]` ficam até o usuário pedir para preencher.
- Não renomeie arquivos. `spec-template.md` continua sendo o molde de specs.
- Não substitua a palavra `template` no resto do repositório. Não apague `specs/optional/`.
- Não apague `CLAUDE.md` nem `.gemini/settings.json`. Eles só apontam para este arquivo.

## Gatilho — CCIA

Se a seção `Gatilho — sair do modo template` ainda existir, ignore esta seção. Não pergunte.

Se ela já não existir, esta seção manda. Não grave CCIA nem handoff enquanto ela estiver aqui. Atenda o pedido do usuário mesmo assim.

- Se a mensagem já responder sim ou não ao uso de CCIA, aplique abaixo neste turno. Não pergunte de novo.
- Se não responder, pergunte uma vez, na resposta: "Quer usar CCIA neste repositório? Sim mantém a transcrição do chat e o handoff. Não remove essas regras. Não pergunto de novo."

Sim:

- Apague só esta seção.
- Deixe as regras de CCIA e handoff valendo neste repositório. Se ainda disserem "só projetos derivados" ou "não gravar no repo-fonte", apague essa restrição.

Não:

- Apague esta seção.
- Retire as regras que mandam gravar, ler ou formatar CCIA e handoff em `AGENTS.md`, `spec-root.md`, `rules.md`, `flow.md`, `prompts/readme.md`, `setup.md`, `specs/optional/bootstrap-personalizar-projeto.md` e `specs/optional/software-multi-produto.md`.
- Em `prompts/readme.md`, deixe a pasta como colas reutilizáveis, sem transcrição de chat nem handoff. Não apague `prompts/` nem o arquivo: ele está na árvore mínima.
- Não invente outro mecanismo de conversa no lugar.
