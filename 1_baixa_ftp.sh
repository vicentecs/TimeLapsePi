#!/bin/bash
# 1_baixa_ftp.sh - Baixa imagens via FTP

set -euo pipefail
IFS=$'\n\t'

: "${WORK_PATH:?WORK_PATH nao definido}"
: "${IMG_PATH:?IMG_PATH nao definido}"

mkdir -p "$IMG_PATH"

source "$WORK_PATH/.env"

# Verificação das variáveis
: "${FTP_USER:?FTP_USER nao definido no .env}"
: "${FTP_PASSWD:?FTP_PASSWD nao definido no .env}"
: "${FTP_HOST:?FTP_HOST nao definido no .env}"
: "${FTP_PATH:?FTP_PATH nao definido no .env}"

#lftp ftp://${FTP_USER}:${FTP_PASSWD}@${FTP_HOST}${FTP_PATH} -e "mirror -I *.jpg "${FTP_PATH}" "${IMG_PATH}" --parallel=3 --Remove-source-files; bye"

# Baixa as imagens via lftp
lftp -u "$FTP_USER","$FTP_PASSWD" "$FTP_HOST" <<EOF
mirror -I *.jpg "$FTP_PATH" "$IMG_PATH" --parallel=3 --Remove-source-files
bye
EOF

echo "Download concluído em $IMG_PATH"
