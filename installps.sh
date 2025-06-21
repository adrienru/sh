#!/bin/bash
set -e

# 🔧 Instalación opcional de rclone (se puede quitar si no se necesita)
echo "🔧 Instalando rclone..."
sudo -v
curl https://rclone.org/install.sh | sudo bash

# 📥 Descargar y mover script principal "5"
echo "📥 Descargando script principal..."
curl -fsSL https://raw.githubusercontent.com/adrienru/sh/refs/heads/main/5 -o /tmp/5

echo "🔐 Dando permisos de ejecución..."
sudo mv /tmp/5 /usr/local/bin/5
sudo chmod +x /usr/local/bin/5

echo "✔️ Todo listo. Puedes usar el comando: 5"

# ▶️ Ejecutar script adicional de configuración
curl -fsSL https://raw.githubusercontent.com/adrienru/sh/refs/heads/main/install.sh | bash
