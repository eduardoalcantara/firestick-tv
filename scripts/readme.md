# scripts/

Scripts de automação, bootstrap, validação e apoio **do repositório** — não do produto em produção.

## Fronteira com `/core`

| Onde | Critério |
|---|---|
| `/core` | Essencial para alterar, compilar, rodar ou gerar instalador do **produto**. Se só restasse `/core`, a manutenção do sistema ainda seria possível. |
| `scripts/` | Apoio ao **repo** (validar estrutura do template, bootstrap documental, automação de governança). Não é o que se salvaria “no incêndio” junto com o produto. |

Scripts essenciais do produto (build/run/pack/install) vivem em `core/scripts/`, não aqui. Detalhe: `core/readme.md` e `core/scripts/readme.md`. Norma: `rules.md`.

## Categorias

| Pasta | Função |
|---|---|
| `bootstrap/` | Preparação inicial do ambiente/projeto (repo) |
| `validation/` | Checagens estruturais e auditoria (repo) |
| `automation/` | Tarefas repetíveis do repositório |
| `maintenance/` | Limpeza e reparo do repositório |

## Normas

Siga `rules-scripts.md` na raiz:

- descoberta da raiz do repositório;
- input numerado;
- `--uninstall` em scripts de instalação;
- equivalência Linux (`.sh`) / Windows (`.ps1`).
