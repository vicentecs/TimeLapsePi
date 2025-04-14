#!/bin/bash
# _start.sh - Orquestrador principal do pipeline

# Configura o modo estrito para segurança e debugs
set -euo pipefail
IFS=$'\n\t'

export WORK_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$WORK_PATH/.env"
export DIA="${2:-$(date +"%Y-%m-%d")}"
export IMG_PATH="${WORK_PATH}/img_${DIA}"
export NOME_VIDEO="Replay_${DIA}.mp4"
export VIDEO_PATH="${WORK_PATH}/videos/${NOME_VIDEO}"
export AUDIO_PATH="${WORK_PATH}/audio.mp3"
export LOGO_PATH="${WORK_PATH}/logo.png"

function usage() {
  echo "Uso: $0 [baixar|validar|gerar|subir|tudo] [DIA opcional no formato AAAA-MM-DD]"
  exit 1
}

source ${WORK_PATH}/notificacao_telegram.sh || true
trap 'enviar_telegram "\ud83d\udca5 *Erro no script na linha $LINENO*"' ERR

case "${1:-}" in
  baixar) bash "$WORK_PATH/1_baixa_ftp.sh" ;;
  validar) bash "$WORK_PATH/2_validar_fotos.sh" ;;
  gerar) bash "$WORK_PATH/3_gerar_video.sh" ;;
  subir) bash "$WORK_PATH/4_subir_video.sh" ;;
  tudo)
    if [ -z "${2:-}" ]; then
      bash "$WORK_PATH/1_baixa_ftp.sh"
    else
      echo "🔁 DIA fornecido: ${DIA}, ignorando etapa de download."
    fi
    bash "$WORK_PATH/2_validar_fotos.sh"
    bash "$WORK_PATH/3_gerar_video.sh"
    bash "$WORK_PATH/4_subir_video.sh"
    ;;
  *) usage ;;
esac
