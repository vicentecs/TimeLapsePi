#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Verifica se a pasta de imagens existe
: "${IMG_PATH:?IMG_PATH nao definido}"

if ! command -v jpeginfo &> /dev/null; then
  echo "jpeginfo não encontrado. Instale com: sudo apt install jpeginfo"
  exit 1
fi

echo "Validando imagens em: $IMG_PATH"

find "$IMG_PATH" -type f -iname "*.jpg" | while read -r img; do
  if ! jpeginfo -c "$img" | grep -q "OK"; then
    echo "Removendo imagem corrompida: $img"
    rm -f "$img"
  fi

done

echo "Validação de imagens concluída."
