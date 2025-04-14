#!/bin/bash

: "${WORK_PATH:?WORK_PATH nao definido}"
: "${DIA:?DIA nao definido}"
: "${IMG_PATH:?IMG_PATH nao definido}"
: "${NOME_VIDEO:?NOME_VIDEO nao definido}"
: "${VIDEO_PATH:?VIDEO_PATH nao definido}"

# Verifica se a pasta de imagens existe
if [ ! -d "$IMG_PATH" ]; then
  echo "Erro: Pasta ${IMG_PATH} não encontrada."
  exit 1
fi

# Primeira foto para a capa
first_jpg=$(find "${IMG_PATH}" -maxdepth 1 -iname '*.jpg' | sort | head -n 1)

if [ -z "$first_jpg" ]; then
  echo "Erro: Nenhuma imagem encontrada em ${IMG_PATH}."
  exit 1
fi

# Verifica se o vídeo existe
if [ ! -f "$VIDEO_PATH" ]; then
  echo "Erro: Arquivo de vídeo não encontrado: ${VIDEO_PATH}"
  exit 1
fi

source "$WORK_PATH/.env"

echo "Enviando capa ${first_jpg}..."

url_capa=$(curl -s --location "${URL_UPLOAD}/upload" \
  --form "file=@${first_jpg}" | jq -r '.filename')

if [ -z "${url_capa:-}" ]; then
  echo "Erro: ao buscar url da capa."
  exit 1
fi

echo "Enviando vídeo ${VIDEO_PATH}..."
url_video=$(curl -s --location "${URL_UPLOAD}/upload" \
  --form "file=@${VIDEO_PATH}" | jq -r '.filename')

# Verifica se o vídeo existe
if [ -z "${url_video:-}" ]; then
  echo "Erro: ao buscar url do vídeo"
  exit 1
fi

echo "Registrando capa(${url_capa}) e vídeo (${url_video}) na API..."
curl -s --location "${URL_API}/videos" \
  --header "Content-Type: application/json" \
  --data "{\"nome\":\"${NOME_VIDEO}\",\"dthr\":\"${DIA}T23:59:59.000Z\",\"url\":\"${url_video}\",\"poster\":\"${url_capa}\",\"idQuadra\":1}"

echo "Registro finalizado com sucesso: ${NOME_VIDEO}"
