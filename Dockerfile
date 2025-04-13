# Dockerfile para pipeline de geração de vídeo

FROM debian:bookworm

# Instala dependências essenciais
RUN apt-get update && apt-get install -y \
    ffmpeg \
    curl \
    lftp \
    jq \
    jpeginfo \
    bash \
    ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Define diretório de trabalho
WORKDIR /app

# Copia todos os scripts para o container
COPY . /app

# Define permissões de execução
RUN chmod +x ./*.sh

# Comando padrão
CMD ["bash", "_start.sh", "tudo"]
