# 🐳 Docker Windows Setup Automático

Este script instala y configura automáticamente:

- Docker con configuración personalizada
- Un contenedor `dockurr/windows` listo para usar
- `ngrok` con authtoken incluido
- Script `subdock` accesible desde cualquier lugar
- Herramientas útiles como `inotify-tools`

---

## ⚙️ Requisitos

- Ubuntu/Debian o derivado
- Acceso como `root` o con `sudo`
- Docker y Docker Compose instalados

---

## 🚀 Instalación rápida

### 🔁 Opción 1: Clonar el repositorio y ejecutar el script

```bash
git clone https://github.com/tuusuario/docker-setup-auto.git \
  && cd docker-setup-auto \
  && chmod +x setup_total.sh \
  && sudo bash setup_total.sh

#### ⚡ Opción 2: Ejecutar sin clonar (copia y pega directo)
🔽 Usando curl

```bash
curl -sSL https://raw.githubusercontent.com/tuusuario/docker-setup-auto/main/setup_total.sh | sudo bash
##### 🔽 Usando wget
```bash
wget -qO- https://raw.githubusercontent.com/tuusuario/docker-setup-auto/main/setup_total.sh | sudo bash

###### 📦 ¿Qué hace este script?

Reemplaza el script wrapdocker en /google/scripts/

Le da permisos ejecutables con chmod +x

Instala ngrok y configura el token automáticamente

Crea y mueve subdock.sh a /usr/local/bin/

Instala inotify-tools

Ejecuta wrapdocker

Crea el archivo composer.yml

Ejecuta docker compose up -d

Muestra ✔️ o ❌ para cada paso realizado


---

✅ **Último paso:** cambia `royt` en los enlaces por tu **adrienru**
