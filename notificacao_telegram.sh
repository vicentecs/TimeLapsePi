#!/bin/bash

# Caminho absoluto do .env (mesmo diretório do script)
ENV_FILE="${WORK_PATH}/.env"

# Verifica se o arquivo .env existe
if [ ! -f "$ENV_FILE" ]; then
  echo "Erro: Arquivo .env não encontrado em ${ENV_FILE}" >&2
  exit 1
fi

# Carrega o .env
source "$ENV_FILE"

# Verifica se as variáveis necessárias estão definidas
if [ -z "${TELEGRAM_BOT_TOKEN:-}" ]; then
  echo "Erro: TELEGRAM_BOT_TOKEN não está definido no .env" >&2
  exit 1
fi

if [ -z "${TELEGRAM_CHAT_ID:-}" ]; then
  echo "Erro: TELEGRAM_CHAT_ID não está definido no .env" >&2
  exit 1
fi

# Função para enviar mensagem para o Telegram
enviar_telegram() {
  local MENSAGEM="$1"

  echo "enviar_telegram = ${MENSAGEM}"

  curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
    -d "chat_id=${TELEGRAM_CHAT_ID}" \
    -d "text=${MENSAGEM}" \
    -d "parse_mode=Markdown"
}
