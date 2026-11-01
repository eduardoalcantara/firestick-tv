# Manual de Uso: Scripts de Automação do Exploit Kamakiri
**Dispositivo:** Amazon Fire TV Stick 4K (Codinome: `mantis`)  
**Ambiente:** Zorin OS 18 Pro / Ubuntu (Bare Metal)  
**Localização do Produto:** Diretório `/core`

---

## 1. Visão Geral

Este manual orienta o uso dos scripts de automação criados para executar com segurança o desbloqueio de bootloader via exploit de hardware **Kamakiri** e a instalação do sistema operacional customizado **LineageOS (Android TV)** no **Amazon Fire TV Stick 4K (Mantis)**.

O processo é dividido em três fases orquestradas por scripts em `core/scripts/`:
1. **Preparação (`01_setup_env.sh`):** Instala ferramentas de baixo nível, desativa o `ModemManager` para liberar portas seriais USB e normaliza os scripts com `dos2unix`.
2. **Injeção do Exploit (`02_kamakiri_monitor.sh`):** Guia a intervenção física no ponto **DAT0**, dispara o handshake da BootROM (BROM), sinaliza o momento crítico de desfeita do curto e aciona o Fastboot para iniciar o TWRP Recovery.
3. **Instalação do Sistema (`03_flash_rom.sh`):** Formata as partições do Fire OS original (`system`, `data`, `cache`), transfere e instala a ROM LineageOS, instala pacotes adicionais (OpenGApps e Magisk, se presentes) e reinicia o stick.

---

## 2. Pré-requisitos

### Hardware Necessário
- **Amazon Fire TV Stick 4K (Mantis):** Carcaça aberta com a blindagem metálica recortada ou exposta sobre o ponto de teste DAT0 e a malha de terra (GND).
- **Ferramenta condutiva de curto:** Uma pinça de ponta fina, clipe de papel metálico desdobrado ou cabo jumper de precisão.
- **Cabo Micro-USB confiável:** Deve possuir linhas de dados funcionais (não use cabos exclusivos de carregamento).
- **Computador com Zorin OS 18 Pro (ou Ubuntu/Debian recente):** Executado diretamente em máquina física (*bare metal*), não em máquina virtual, para evitar latência no barramento USB.

### Arquivos Requeridos
Coloque os arquivos nas respectivas pastas dentro de `core/`:
- Em `core/kamakiri_exploit/`:
  - `bootrom-step.sh`
  - `fastboot-step.sh`
  - Pastas `modules/`, `bin/` e demais arquivos do pacote Kamakiri Mantis (ex.: projeto *amonet* de k4y0z/xyz).
- Em `core/payloads/`:
  - `lineage-18.1-mantis.zip` (Obrigatório)
  - `open_gapps-arm-11.0-pico.zip` (Opcional)
  - `magisk.zip` (Opcional)

---

## 3. Estrutura Operacional

```text
core/
├── kamakiri_exploit/        # Binários e scripts oficiais do exploit
├── payloads/                # Arquivos ZIP da ROM, GApps e Magisk
├── scripts/                 # Scripts de automação (canônicos)
│   ├── 01_setup_env.sh
│   ├── 02_kamakiri_monitor.sh
│   └── 03_flash_rom.sh
├── scripts_automacao/       # Wrappers para compatibilidade de chamada
├── execucao.log             # Registro centralizado de logs
└── readme.md
```

---

## 4. Guia Passo a Passo de Execução

### Passo 1: Preparar o Ambiente

Abra o terminal no diretório do projeto e execute com privilégios de `root`:

```bash
cd core/scripts
sudo ./01_setup_env.sh
```

**Comportamento esperado:**
- Valida se o comando foi disparado como `root` (`EUID == 0`).
- Atualiza o `apt` e instala: `python3`, `python3-serial`, `python3-usb`, `adb`, `fastboot` e `dos2unix`.
- Encerra e desativa o serviço `ModemManager`, garantindo que o sistema operacional não tente interpretar a porta serial USB do chipset MediaTek como um modem 3G/4G.
- Converte todos os scripts `.sh` para quebras de linha padrão Unix (LF) e concede permissão de execução (`chmod +x`).

---

### Passo 2: Injeção do Exploit Kamakiri

Com o Fire TV Stick totalmente **desconectado do cabo USB**:

```bash
sudo ./02_kamakiri_monitor.sh
```

**Procedimento de Intervenção Física:**
1. O terminal exibirá um quadro de atenção com alertas destacados em **amarelo** e **vermelho**.
2. **Localização:** Posicione a placa de modo visível. Localize o ponto de teste **DAT0** (eMMC CLK/DAT) e qualquer ponto metálico da blindagem ou trilha externa de **GND**.
3. **Aplicação do Curto:** Encoste a pinça ou jumper firmemente interligando o ponto **DAT0** ao **GND**.
4. **Conexão USB:** Mantendo o curto firme, conecte o cabo USB ao computador.
5. O script acionará `./bootrom-step.sh`. O processo aguardará o handshake USB sem timeouts agressivos.
6. Assim que a tela confirmar o envio do microloader com status de sucesso (`SUCESSO` em verde):
   - **SOLTE O CURTO IMEDIATAMENTE!**
   - O terminal exibirá um aviso crítico em **vermelho**: `AÇÃO CRÍTICA IMEDIATA: REMOVA O CURTO`.
   - Solte a pinça/jumper da placa.
   - Pressione `[ENTER]` no terminal para confirmar que o curto foi desfeito.
7. O script executará `./fastboot-step.sh`.
8. O stick reinicializará e entrará automaticamente no **TWRP Recovery**. O script aguarda a detecção pelo ADB (`adb wait-for-device`) e exibe o dispositivo conectado.

---

### Passo 3: Limpeza e Instalação da ROM

Com o Fire TV Stick iniciado no TWRP Recovery e conectado via USB:

```bash
sudo ./03_flash_rom.sh
```

**Comportamento do script:**
1. Confirma a integridade e existência do arquivo da ROM (`core/payloads/lineage-18.1-mantis.zip`). Se ausente, aborta antes de qualquer limpeza.
2. Aguarda conexão ativa com o TWRP via ADB.
3. Executa a formatação completa do sistema antigo:
   ```bash
   adb shell twrp wipe system
   adb shell twrp wipe data
   adb shell twrp wipe cache
   ```
4. Envia a ROM para a memória do stick (`adb push`) e aciona a instalação (`adb shell twrp install /sdcard/lineage-18.1-mantis.zip`).
5. Se detectar pacotes de **OpenGApps** ou **Magisk** em `core/payloads/`, realiza o push e a instalação sequencial de cada um.
6. Dispara `adb reboot` para inicializar o sistema Android TV.

> **Nota:** O primeiro boot do LineageOS após a instalação pode levar de 3 a 5 minutos. Conecte o dispositivo à TV com o cabo HDMI para acompanhar a tela de boas-vindas do LineageOS.

---

## 5. Auditoria e Logs

Todas as saídas de terminal geradas pelos três scripts são espelhadas simultaneamente na tela e no arquivo:

```text
core/execucao.log
```

Para monitorar a saída em tempo real a partir de outro terminal:

```bash
tail -f core/execucao.log
```

---

## 6. Diagnóstico e Resolução de Problemas

| Sintoma / Erro | Causa Provável | Solução |
|---|---|---|
| `ERRO: Este script precisa ser executado como root` | Script executado sem permissões de superusuário. | Execute com `sudo ./<nome_do_script>.sh`. |
| `Waiting for device` permanece travado sem resposta no Passo 2 | Curto no pino DAT0 não fez contato adequado ou o cabo USB não tem linhas de dados. | Desconecte o USB, realinhe a pinça garantindo bom contato entre DAT0 e GND, e reconecte o cabo USB ao computador. Teste outro cabo USB de qualidade. |
| `Device or resource busy` ao conectar o USB | O `ModemManager` do Linux interceptou a porta `/dev/ttyACM0`. | Execute `sudo ./01_setup_env.sh` para garantir que o ModemManager foi desativado. |
| `fastboot-step.sh` falha ou não detecta dispositivo | O curto DAT0 não foi desfeito após o handshake da BROM. | Desconecte o cabo USB, retire qualquer curto físico, reinicie o processo a partir de `02_kamakiri_monitor.sh`. |
| `\r: command not found` | Quebras de linha estilo Windows (CRLF) no script bash. | Execute `dos2unix core/scripts/*.sh`. |
| `Arquivo 'lineage-18.1-mantis.zip' não encontrado` | A imagem da ROM não foi colocada na pasta de payloads. | Baixe a ROM do LineageOS para Mantis e coloque em `core/payloads/`. |
