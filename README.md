# Meu CachyOS Config

Este repositório contém um conjunto de scripts para automatizar a instalação de aplicativos e a configuração do meu ambiente no CachyOS (base Arch Linux) com GNOME. Com apenas dois scripts (`classify.sh` e `install.sh`) e uma lista mestra (`raw-packages.txt`), podendo rapidamente configurar qualquer máquina nova de forma reprodutível.

---

## Estrutura do repositório

```
├── classify.sh         # Script para separar pacotes oficiais (pacman) e AUR
├── install.sh          # Script para instalar pacotes via pacman e AUR helper
├── raw-packages.txt    # Lista mestra de todos os pacotes desejados (edite você mesmo)
├── packages.txt        # Gerado pelo classify.sh: pacotes oficiais
├── aur-list.txt        # Gerado pelo classify.sh: pacotes AUR
└── README.md           # Este arquivo de documentação
```

---

## Como funciona

### 1. raw-packages.txt

* Este arquivo contém o nome de **todos** os aplicativos que você deseja instalar, um por linha.
* Exemplo de conteúdo:

  ```txt
  steam
  discord
  microsoft-edge-stable-bin
  visual-studio-code-bin
  spotify
  ```
* Qualquer modificação aqui será refletida na próxima execução..

### 2. classify.sh

* Lê cada linha de `raw-packages.txt` e determina onde cada pacote existe:

  * **Pacman** (`pacman -Si <pacote>`): se existir, grava em `packages.txt`.
  * **AUR** (`paru -Si <pacote>`): se não estiver nos oficiais mas existir na AUR, grava em `aur-list.txt`.
  * Se não for encontrado em nenhum, emite um alerta no terminal.
* Gera (ou sobrescreve) automaticamente `packages.txt` e `aur-list.txt`.

#### Como executar

1. Dê permissão de execução:

   ```bash
   chmod +x classify.sh
   ```
2. Execute:

   ```bash
   ./classify.sh
   ```

3.Confira `packages.txt` e `aur-list.txt` gerados.

### 3. install.sh

* Atualiza os mirrors e o sistema (`pacman -Syyu`).
* Instala todos os pacotes listados em `packages.txt` via `pacman`.
* Verifica se o helper AUR (`paru`) está instalado; se não, clona e compila automaticamente.
* Instala todos os pacotes listados em `aur-list.txt` via `paru`.

#### Como executar

1. Certifique-se de que `install.sh` também tenha permissão de execução:

   ```bash
   chmod +x install.sh
   ```
2. Execute:

   ```bash
   ./install.sh
   ```
3. Aguarde até a conclusão; o script exibirá mensagens de progresso.

---

## Fluxo completo de uso

1. **Clone** este repositório em sua máquina ou dispositivo novo:

   ```bash
   git clone https://github.com/Sllvalitz/meu-cachy-config.git
   cd meu-cachy-config
   ```
2. **Edite** `raw-packages.txt`, adicionando ou removendo pacotes conforme sua necessidade.
3. **Execute** `classify.sh` para gerar as listas de pacotes:

   ```bash
   ./classify.sh
   ```
4. **Execute** `install.sh` para instalar tudo de forma automática:

   ```bash
   ./install.sh
   ```
5. **Pronto!** Seu ambiente está configurado com todos os aplicativos listados.

---

## Dicas e Solução de Problemas

* Se `classify.sh` reclamar de `raw-packages.txt` inexistente, verifique se o arquivo está no mesmo diretório (use `ls`).
* Se `install.sh` falhar ao baixar algum recurso (ex: VS Code), verifique se o nome do pacote em `raw-packages.txt` coincide com o nome do AUR ou considere usar outra versão/variante disponível.
* Para atualizar a lista, basta editar `raw-packages.txt` e reexecutar `classify.sh` + `install.sh`.

---

## Contribuições

Pull requests são bem-vindos! Sinta-se à vontade para:

* Sugerir novos pacotes padrão.
* Melhorar os scripts (adição de backup de dotfiles, configuração do GNOME, flatpaks, etc.).

---

> 💡 **Nota**: Este processo foi testado em CachyOS 2025 com GNOME. Em outras distros Arch-based, ajustes mínimos podem ser necessários.

