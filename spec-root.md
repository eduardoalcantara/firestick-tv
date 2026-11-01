# spec-root.md — autoridade arquitetural

## Propósito do projeto

[NOME DO PROJETO] existe para [PROPÓSITO EM UMA FRASE].

Este repositório é o template. A espinha dorsal já está nos arquivos de regra da raiz (`AGENTS.md` aponta para eles). Novos repositórios nascem pelo GitHub (**Use this template**), não por um gerador à parte.

## Visão geral

- O projeto é governado pelos documentos da raiz.
- O agente opera segundo `flow.md`, `rules.md` e `AGENTS.md`.
- O essencial do produto/sistema vive em `/core` (código e scripts necessários para manter, compilar, rodar e instalar).
- O progresso do projeto derivado é rastreado em `status.md` e `timeline.md`. No repositório-fonte do template esses arquivos ficam sem histórico do template.

## Princípios fundacionais

1. **Repositório nasce documentado** — contexto mínimo antes de código solto.
2. **A raiz orienta** — cada arquivo da raiz tem função operacional.
3. **Contexto explícito para o agente** — regras, fluxo, estado e histórico visíveis.
4. **Formato universal, conteúdo adaptável** — espinha dorsal fixa; interior muda por domínio.
5. **`/core` é o essencial do produto** — o que bastaria copiar sozinho para continuar a manutenção (alterar, compilar, rodar, gerar instalador), inclusive scripts de produto em `core/scripts/`; e o que se salvaria “no incêndio” se não desse tempo de salvar tudo. Script de repositório fica em `scripts/` na raiz e **não** entra em `/core`.
6. **Nomenclatura com hífen** — arquivos Markdown de governança na raiz usam `-`, nunca `_`.
7. **CCIA** — nos projetos derivados: 1 arquivo por chat, transcrição literal prompt↔resposta (append após relevante); não é resumo de entrega (`timeline.md` / `status.md`); ler só sob pedido explícito. No repo-fonte deste template: não gravar CCIA de conversa. Enquanto `AGENTS.md` tiver a seção `Gatilho — CCIA`, não gravar: a seção pergunta uma vez e mantém ou retira as regras. `.prompt-status` está desativado.

## Escopo

- Manter a estrutura documental e operacional do template.
- Permitir adaptação por domínio (software, hardware, SO, impressão 3D, híbridos).
- Garantir que o Cursor consiga operar sem ambiguidade sobre regras, validação e documentação.

## Fora de escopo

- Implementação de domínio específico antes de specs em `specs/to-do/`.
- Ferramentas, serviços ou integrações não documentadas.
- Alterações que violem a hierarquia normativa sem atualização explícita de `spec-root.md` e `rules.md`.

## Arquitetura de alto nível

```text
raiz documental (governança)
├── fluxo e regras do agente
├── estado e histórico
├── specs / docs / prompts
├── scripts / reports / resources
└── core/  ← essencial do produto (cópia mínima / “incêndio”)
```

## Contratos centrais

| Contrato | Documento |
|---|---|
| O que o projeto é | `spec-root.md`, `readme.md` |
| Como o agente age | `flow.md`, `AGENTS.md` |
| O que é permitido | `rules.md` |
| Como scripts funcionam | `rules-scripts.md` |
| Onde está o essencial do produto | `/core` (`core/readme.md`) |
| Árvore mínima | `scripts/validation/min-tree.txt` |

## Regras permanentes

- Não implementar fora do escopo confirmado.
- Não usar `.prompt-status` (desativado).
- Não ler CCIA/handoff sem pedido explícito do usuário.
- Em pedido exclusivo de Commit + Push, não gravar/append CCIA.
- CCIA não substitui `timeline.md` / `status.md`; no repo-fonte do template não gravar CCIA de conversa.
- Não colocar o essencial do produto fora de `/core` sem justificativa normativa; scripts essenciais de build/run/installer do produto ficam em `/core`, não em `scripts/` da raiz.
- `/core` ≠ pasta genérica de “código”: é o mínimo operacional do produto (critérios em `core/readme.md`).
- Não renomear arquivos de governança da raiz para underscore; manter hífen.
- No projeto derivado, mudanças relevantes atualizam `status.md` e `timeline.md`. No repositório-fonte do template, não usar esses arquivos para o histórico do template.

## Critérios de sucesso

O repositório está pronto quando o Cursor responde sem ambiguidade:

- o que o projeto é;
- quais são as regras;
- como operar e validar;
- como documentar progresso;
- onde fica o essencial do produto em `/core` (cópia mínima / critério do “incêndio”);
- como o agente se comporta;
- como distinguir script de repositório (`scripts/`) de script de produto (`core/scripts/`);
- como usar CCIA (transcrição literal por chat nos derivados; ler só sob pedido explícito).

## Conclusão normativa

Este arquivo é a autoridade arquitetural máxima. Specs em `specs/` detalham entregas; se houver conflito, `spec-root.md` prevalece até ser atualizado formalmente.
