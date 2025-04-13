# TimeLapsePi
Scripts Tools for TimeLapse in Raspberry Pi

Este projeto automatiza o processo de:
- Baixar imagens via FTP
- Validar JPGs
- Gerar vídeo com `ffmpeg`
- Subir vídeo e capa para uma API

Tudo empacotado num container Docker com suporte a CI via GitHub Actions 🚀

---

## 🛠 Requisitos
- Docker
- Docker Compose

---

## 📦 Estrutura
```
📁 video-pipeline/
├── .env                # Variáveis de ambiente (NÃO versionar)
├── audio.mp3           # Trilha sonora
├── logo.png            # Logo
├── output/             # Arquivos gerados
├── _start.sh           # Script principal
├── [1-4]_*.sh          # Scripts auxiliares
├── Dockerfile
└── docker-compose.yml
```

---

## ⚙️ .env de exemplo
```env
TELEGRAM_BOT_TOKEN=seu_token
TELEGRAM_CHAT_ID=123456
FTP_USER=usuario
FTP_PASSWD=senha
FTP_HOST=ftp.dominio.com
FTP_PATH=/fotos
URL_UPLOAD=https://localhost/api
URL_API=https://localhost/api
```

---

## ▶️ Executando
```bash
docker-compose up --build
```

## ✅ Resultado
- Vídeos renderizados no container
- Upload automático para API
- Notificação via Telegram em caso de erro (opcional)

---

## 📬 Contato
Contribuições, sugestões e melhorias são bem-vindas!
