#!/usr/bin/env bash
set -euo pipefail

# Atualiza sistema e instala pacotes oficiais
echo "🔄 Atualizando mirrors e sistema..."
sudo pacman -Syyu --noconfirm

echo "📦 Instalando pacotes oficiais de packages.txt..."
sudo pacman -S --noconfirm $(< packages.txt)

# Garante que o helper AUR esteja instalado
if ! command -v paru &>/dev/null; then
  echo "🔧 Instalando paru (AUR helper)..."
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  pushd /tmp/paru
    makepkg -si --noconfirm
  popd
  rm -rf /tmp/paru
fi

echo "🎯 Instalando pacotes do AUR de aur-list.txt..."
paru -S --noconfirm $(< aur-list.txt)

echo "✅ Tudo instalado!"

