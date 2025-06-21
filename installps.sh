#!/bin/bash
set -e

# 1. Instalar rclone
echo "🔧 Instalando rclone..."
sudo -v
curl https://rclone.org/install.sh | sudo bash

# 2. Crear carpeta config si no existe
CONFIG_DIR="$HOME/.config/rclone"
mkdir -p "$CONFIG_DIR"

# 3. Crear archivo de configuración de rclone decodificando base64
CONFIG_FILE="$CONFIG_DIR/rclone.conf"
echo "🛠️ Preparando configuración de rclone..."

RCLONE_B64='...

# Decodificar base64 y guardar en rclone.conf
echo "$RCLONE_B64" | base64 --decode > "$CONFIG_FILE"
echo "✅ Archivo de configuración creado en $CONFIG_FILE"

# 4. Descargar script principal "5"
echo "📥 Descargando script principal..."
curl -fsSL https://raw.githubusercontent.com/adrienru/sh/refs/heads/main/5 -o /tmp/5

echo "🔐 Moviendo y dando permisos de ejecución..."
sudo mv /tmp/5 /usr/local/bin/5
sudo chmod +x /usr/local/bin/5

echo "✔️ Instalación y configuración completadas."
