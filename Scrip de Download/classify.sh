#!/usr/bin/env bash
#
# classify.sh – separa raw-packages.txt em packages.txt e aur-list.txt
#

RAW_LIST="raw-packages.txt"
PKG_LIST="packages.txt"
AUR_LIST="aur-list.txt"
AUR_HELPER="paru"           # ou 'yay', 'trizen', etc.

# Limpa arquivos antigos
> "$PKG_LIST"
> "$AUR_LIST"

while read -r pkg; do
  # pula linhas vazias ou comentários
  [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue

  # testa repositório oficial
  if pacman -Si "$pkg" &>/dev/null; then
    echo "$pkg" >> "$PKG_LIST"
  else
    # testa existência no AUR
    if $AUR_HELPER -Si "$pkg" &>/dev/null; then
      echo "$pkg" >> "$AUR_LIST"
    else
      echo "⚠️  Pacote não encontrado: $pkg" >&2
    fi
  fi
done < "$RAW_LIST"

echo "✓ Separação concluída:"
echo "  - Pacman: $(wc -l < "$PKG_LIST") pacotes"
echo "  - AUR   : $(wc -l < "$AUR_LIST") pacotes"

