#!/bin/bash
set -e

# 📁 Ruta del archivo de configuración
CONFIG_DIR="$HOME/.config/rclone"
CONFIG_FILE="$CONFIG_DIR/rclone.conf"

echo "🛠️ Preparando configuración de rclone..."

# 🔧 Crear carpeta si no existe
mkdir -p "$CONFIG_DIR"

# 🧬 Base64 del rclone.conf (reemplaza todo por tu base64 completo)
RCLONE_B64='PEGA_AQUI_TODO_TU_BASE64_LARGO'

# 📄 Decodificar y guardar el archivo
echo "$RCLONE_B64" | base64 --decode > "$CONFIG_FILE"

echo "✅ Configuración rclone escrita en: $CONFIG_FILE"
