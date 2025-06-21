#!/bin/bash

echo "📥 Descargando script '5' desde GitHub..."
curl -fsSL https://raw.githubusercontent.com/adrienru/sh/refs/heads/main/5 -o /tmp/5

if [ ! -s /tmp/5 ]; then
    echo "❌ Error: No se pudo descargar el archivo o está vacío."
    exit 1
fi

echo "📦 Moviendo a /usr/local/bin..."
sudo mv /tmp/5 /usr/local/bin/5

echo "🔐 Dando permisos de ejecución..."
sudo chmod +x /usr/local/bin/5

if command -v 5 >/dev/null 2>&1; then
    echo "✅ Instalación completa. Ahora puedes ejecutar: 5"
else
    echo "⚠️ Algo falló. Asegúrate de tener permisos suficientes."
fi
