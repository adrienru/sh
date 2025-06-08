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
