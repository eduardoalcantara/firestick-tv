# core/scripts/

Scripts **essenciais do produto** — preparação do ambiente, orquestração da injeção do exploit Kamakiri, monitoramento de hardware e flash de ROM no Fire TV Stick 4K (Mantis).

## Por que aqui (não em `scripts/` na raiz)

Critérios de `/core` (ver `core/readme.md`):

1. **Cópia mínima** — copiar só `/core` basta para rodar a preparação de ambiente, o exploit e a instalação da ROM no dispositivo.
2. **Incêndio** — os scripts de intervenção no dispositivo residem aqui.

Scripts que servem só ao **repositório** (como `scripts/validation/validate-structure.*`) ficam em `scripts/` na raiz.

## Scripts do Produto

| Script | Função | Privilégios |
|---|---|---|
| `01_setup_env.sh` | Atualiza repositórios, instala dependências apt (`python3`, `serial`, `usb`, `adb`, `fastboot`, `dos2unix`), desativa `ModemManager` e normaliza quebras de linha com `dos2unix`. | `root` (`sudo`) |
| `02_kamakiri_monitor.sh` | Orquestra a injeção do exploit Kamakiri: instruções ANSI (amarelo/vermelho) para o curto DAT0, chamada de `bootrom-step.sh`, alerta crítico para soltura do curto, execução de `fastboot-step.sh` e detecção do TWRP via ADB. | `root` (`sudo`) |
| `03_flash_rom.sh` | Limpa as partições originais do Fire OS (`wipe system`, `data`, `cache`), transfere e instala `lineage-18.1-mantis.zip`, instala pacotes opcionais (`OpenGApps`, `Magisk`) e reinicia o dispositivo via ADB. | `root` (`sudo`) |

## Convenções de Execução

- Todos os scripts exigem execução como superusuário (`sudo ./script.sh`), validando o `EUID` no início.
- Erros não tratados interrompem o fluxo com `set -e`.
- Todas as saídas são exibidas no terminal e espelhadas simultaneamente para `core/execucao.log`.
- Se os scripts forem invocados a partir de `core/scripts_automacao/`, wrappers transparentes encaminham a execução para estes scripts em `core/scripts/`.
