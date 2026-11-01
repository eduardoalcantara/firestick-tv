# status.md — snapshot do estado atual

Pendências e estado do repositório.

## Última atualização
2026-11-01

## Resumo do estado atual
Produto organizado em `/core` conforme governança (`core/kamakiri_exploit/`, `core/payloads/`, `core/scripts/` e `core/scripts_automacao/`), contendo os scripts bash de automação com validação de root, logging centralizado em `core/execucao.log` e manual de uso em `docs/manual-de-uso-scripts.md`. CCIA ativado para continuidade operacional.

## Tarefas concluídas
- Ativação do mecanismo de CCIA e remoção do gatilho transitório em `AGENTS.md`.
- Migração de todo o sub-conteúdo de `firetv_unlock` para `/core` (respeitando a fronteira produto vs repositório).
- Adaptação dos caminhos nos scripts `core/scripts/01_setup_env.sh`, `core/scripts/02_kamakiri_monitor.sh` e `core/scripts/03_flash_rom.sh`.
- Criação de wrappers de compatibilidade em `core/scripts_automacao/`.
- Remoção do diretório legado `firetv_unlock/`.
- Documentação do produto em `core/readme.md` e tabela de scripts em `core/scripts/readme.md`.
- Criação do manual completo em `docs/manual-de-uso-scripts.md`.
- Normalização de quebras de linha para LF (`\n`) em todos os scripts do `core/`.
- Validação estrutural do repositório via `validate-structure.ps1` com êxito.

## Tarefas pendentes
- Transferência da pasta `core/` (ou do repositório) para o computador com Zorin OS 18 Pro.
- Download dos arquivos originais do exploit Kamakiri em `core/kamakiri_exploit/`.
- Download dos pacotes da ROM (`lineage-18.1-mantis.zip`), OpenGApps e Magisk em `core/payloads/`.
- Execução física do processo em ambiente bare metal.

## Riscos
- Mau contato ou curto aplicado no ponto incorreto na placa.
- Demora em remover o curto DAT0 após o handshake BROM, impedindo a inicialização da eMMC no fastboot.
- Cabo micro-USB com defeito ou sem linhas de dados.

## Próximos passos
- Conectar o dispositivo no Zorin OS e iniciar pelo passo 1: `sudo core/scripts/01_setup_env.sh`.

## Mudanças recentes
- Migrado sub-conteúdo para `/core` e criado manual de uso em `docs/manual-de-uso-scripts.md`.
