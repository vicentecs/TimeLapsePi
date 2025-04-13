#!/bin/bash
# 3_gerar_video.sh - Gera vídeo a partir das imagens JPG

set -euo pipefail
IFS=$'\n\t'

: "${IMG_PATH:?IMG_PATH nao definido}"
: "${VIDEO_PATH:?VIDEO_PATH nao definido}"

# Arquivo de áudio
AUDIO="${PASTA}audio.mp3"

# Arquivo da logo
LOGO="${PASTA}logo.png"
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
if [ ! -f "$AUDIO" ]; then
  echo "Arquivo de áudio \"$AUDIO\" não encontrado!"
  exit 1
fi

# Verifica se a logo existe
if [ ! -f "$LOGO" ]; then
  echo "Arquivo da logo \"$LOGO\" não encontrado!"
  exit 1
fi

echo "Gerando vídeo..."

ffmpeg \
    -framerate 60 \
    -pattern_type glob \
    -i "${IMG_PATH}/*.jpg" \
    #-i "$AUDIO" \
    #-i "$LOGO" \
    #-filter_complex "[2:v]scale=${LOGO_LARGURA}:-1,format=rgba,colorchannelmixer=aa=${LOGO_OPACIDADE}[logo];[0:v][logo]overlay=${POSICAO_LOGO}" \
    -c:v h264_v4l2m2m \
    -b:v 6M \
    -c:a aac \
    -shortest \
    -pix_fmt yuv420p \
    "$VIDEO_PATH" -y

echo "Vídeo finalizado com sucesso: $VIDEO_PATH"
