# rules-scripts.md — governança de scripts

## Propósito

Definir como scripts deste repositório são criados, organizados, executados e desfeitos, com UX previsível no Linux e no Windows.

## Escopo

Dois lugares, dois papéis:

- `scripts/` na raiz — script de **repositório** (validar árvore, manutenção do repo). Não vai para `/core`.
- `core/scripts/` — script de **produto** (build, run, empacote, instalador). Não fica em `scripts/` da raiz.

A UX abaixo vale para os dois. O lugar do arquivo segue a fronteira de `rules.md`.

## Limpeza inicial da tela

No início da execução interativa, o script pode limpar a tela (`clear` no bash/ps1). `--quiet` não limpa.

## Identificação

No início, texto puro, sem cor e sem bordas: nome do script e propósito. Sem tabela, sem ciano e sem linhas de desenho.

## Organização por categoria macro

```text
scripts/
├── bootstrap/     # preparação inicial
├── validation/    # checagens e auditoria
├── automation/    # tarefas repetíveis
└── maintenance/   # limpeza, reparo, housekeeping
```

Espelhar comportamento entre variantes `.sh` (Linux) e `.ps1` (Windows) sempre que ambos existirem.

## Descoberta da raiz do repositório

- Script de repositório: autodetectar a raiz por `spec-root.md` + `rules.md` (ou `.git`).
- Script de produto: autodetectar a raiz do produto por marcador do domínio em `/core` (ex.: `package.json`, `.sln`), não por `spec-root.md`.
- Falhar com mensagem clara se a raiz não for encontrada.
- Usar caminhos relativos à raiz; evitar hardcodes absolutos.

## Parâmetros mínimos e input interativo

- Aceitar flags documentadas (`--uninstall`, `--help`, etc.).
- Quando o usuário precisar escolher: lista numerada + digitar o número.
- Convenção obrigatória de valores binários:
  - `0` = não / false / no / abortar
  - `1` = sim / true / yes / continuar
  - Enter sem digitar = default documentado
- Validar entrada; se inválida, repetir o prompt.
- NUNCA solicitar digitação manual de `s/n`, `yes/no`.

## Modos Não-Interativo e Remoto (Automação/Agente)

Scripts interativos que alteram estado devem obrigatoriamente aceitar as seguintes flags de automação:
- `--quiet` (ou `-q`): Não pede input. Assume a opção padrão para menus. Silencia a limpeza de tela (`clear`) obrigatória para evitar quebrar pipes.
- `--force` (ou `-f`): Obrigatório junto com `--quiet` ou `--ssh` para autorizar ações **destrutivas** (como formatar/apagar dados).
- `--ssh`: Modo remoto/agente sem TTY. Ignora defaults de leitura e exige a passagem explícita de parâmetros essenciais no terminal.
- `--log <caminho>`: Obrigatório quando usando `--ssh`. Espelha todo `stdout`/`stderr` para o arquivo indicado. Opcional no modo interativo.

## Uso de caminhos internos

- Preferir paths internos ao repositório.
- Não escrever fora do repo sem aviso explícito e confirmação.
- Não apagar conteúdo que o script não criou.

## Mensagens e UX operacional

- Mensagens curtas, com status (`OK`, `FAIL`, `SKIP`, `WARN`).
- Separar stdout informativo de erros em stderr quando possível.
- Ao terminar: resumo do que foi feito / desfeito.

## Equivalência comportamental entre Linux e Windows

- Mesmas flags semânticas.
- Mesmos defaults.
- Mesmos efeitos colaterais documentados.
- Diferenças de plataforma devem ser apenas de implementação, não de contrato.

## Scripts de instalação e desinstalação

- Todo script de instalação deve oferecer `--uninstall` (ou equivalente documentado).
- O modo uninstall desfaz **somente** o que o script instalou/configurou/copiou.
- Preservar conteúdo não criado pelo script.
- Falhar de forma segura se não puder reverter integralmente.
- Reversão previsível, explícita e segura.

## Atualização documental

Ao criar ou alterar scripts relevantes:
- atualizar este arquivo se a norma mudar;
- atualizar `setup.md` / `tools-*.md` com comandos de uso;
- registrar em `status.md` / `timeline.md` quando o impacto for material.

## Regra final

Script sem contrato claro de execução, sem modos não interativos bem definidos e sem reversão não deve ser considerado pronto para uso em produção do template.