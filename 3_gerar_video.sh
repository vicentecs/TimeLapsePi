#!/bin/bash
# 3_gerar_video.sh - Gera vídeo a partir das imagens JPG

set -euo pipefail
IFS=$'\n\t'

: "${WORK_PATH:?WORK_PATH nao definido}"
: "${IMG_PATH:?IMG_PATH nao definido}"
: "${VIDEO_PATH:?VIDEO_PATH nao definido}"

# Arquivo de áudio
AUDIO="${WORK_PATH}/audio.mp3"

# Arquivo da logo
LOGO="" # "${WORK_PATH}/logo.png"

# Largura desejada da logo (mantém proporção)
LOGO_LARGURA=100

# Transparência da logo (0.0 a 1.0)
LOGO_OPACIDADE=0.7

# Posição da logo: canto superior direito (10px de margem)
POSICAO_LOGO="W-w-10:10"

# Verifica se ffmpeg está instalado
if ! command -v ffmpeg &> /dev/null; then
  echo "FFmpeg não está instalado. Instale com: sudo apt install ffmpeg"
  exit 1
fi

# Verifica se o áudio existe
if [ -z "$AUDIO" ] || [ -f "$AUDIO" ]; then
  echo "FFmpeg não está instalado. Instale com: sudo apt install ffmpeg"
  exit 1
fi

echo "Gerando vídeo ($VIDEO_PATH) ..."

#ffmpeg \
#    -framerate 60 \
#    -pattern_type glob \
#    -i '${IMG_PATH}/*.jpg' \
#    -i 'audio.mp3' -c:a aac -shortest
#    -c:v libx264
#    -pix_fmt yuv420p \
#    -b:v 4M \
#    -s 1920x1080 \
#    "${VIDEO_PATH}" -y

ffmpeg -framerate 60 -pattern_type glob -i "${IMG_PATH}/*.jpg" -i "$AUDIO" -c:a aac -shortest -c:v libx264 -pix_fmt yuv420p -s 1920x1080 -b:v 4M "${VIDEO_PATH}" -y

echo "Vídeo finalizado com sucesso: $VIDEO_PATH"
