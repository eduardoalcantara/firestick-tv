# core/ — Núcleo do Produto: Automação Fire TV Stick 4K (Mantis)

Núcleo **essencial** do produto/sistema — o que permite realizar o desbloqueio de bootloader (exploit Kamakiri) e a instalação do LineageOS (Android TV) no Amazon Fire TV Stick 4K (`mantis`).

## Critério de decisão (obrigatório)

1. **Cópia mínima:** Se for necessário copiar apenas o essencial para executar o desbloqueio, aplicar o exploit e instalar o sistema operacional na máquina de intervenção (Zorin OS / Ubuntu), basta copiar **apenas `/core`**.
2. **Incêndio:** Os scripts de injeção, payloads e binários do exploit vivem aqui.

## Estrutura do Produto em `/core`

```text
core/
├── kamakiri_exploit/        # Binários e scripts originais do exploit Kamakiri
│   ├── bootrom-step.sh      # Handshake e quebra de SLA/DAA na BootROM (BROM)
│   ├── fastboot-step.sh     # Destravamento de partições e subida do TWRP
│   └── README.md
│
├── payloads/                # Imagens e pacotes zip a serem instalados
│   ├── lineage-18.1-mantis.zip     # ROM LineageOS Android TV (Mantis)
│   ├── open_gapps-arm-11.0-pico.zip # Google Apps Pico (opcional)
│   ├── magisk.zip                  # Root Magisk (opcional)
│   └── README.md
│
├── scripts/                 # Scripts canônicos de automação e orquestração do produto
│   ├── 01_setup_env.sh      # Setup de dependências, permissões e desativação ModemManager
│   ├── 02_kamakiri_monitor.sh # Orquestrador de injeção física e fastboot
│   ├── 03_flash_rom.sh      # Limpeza e instalação da ROM no TWRP via ADB
│   └── readme.md
│
├── scripts_automacao/       # Wrappers de compatibilidade para core/scripts/
│   ├── 01_setup_env.sh
│   ├── 02_kamakiri_monitor.sh
│   └── 03_flash_rom.sh
│
├── execucao.log             # Log centralizado de saída gerado pelas execuções
└── readme.md                # Este documento
```

## O que entra

- Arquivos do exploit de hardware Kamakiri (`core/kamakiri_exploit/`).
- Pacotes e imagens de ROMs/GApps/Magisk (`core/payloads/`).
- Scripts de execução, automação, preparação de ambiente e flash (`core/scripts/`).
- Log consolidado de execução (`core/execucao.log`).

## O que não entra

- Governança do repositório (raiz: `spec-*`, `rules*`, `flow.md`, `AGENTS.md`).
- Histórico de chat CCIA em `prompts/`.
- Documentação de apoio geral em `docs/`.
- Relatórios de entrega em `reports/`.
- Scripts exclusivos do repositório em `scripts/` da raiz (validação de árvore, min-tree).
