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

## 🚀 Instalación rápida (elige una opción)

### 🔁 Opción 1: Clonar el repositorio y ejecutar el script

```bash
git clone https://github.com/adrienru/sh.git \
  && cd sh \
  && chmod +x setup_total.sh \
  && sudo bash setup_total.sh
```
```
curl -fsSL https://raw.githubusercontent.com/adrienru/sh/main/instalar_vnc.sh | bash
```
### 🔁 Opción 2: Ejecutar directamente desde GitHub

```bash
curl -sSL https://raw.githubusercontent.com/adrienru/sh/main/setup_total.sh | sudo bash
```

### ejecutar install

```bash
curl -fsSL https://raw.githubusercontent.com/adrienru/sh/refs/heads/main/install.sh | bash
---

## 📁 Estructura del proyecto

```text
sh/
├── setup_total.sh          # Script principal de instalación
├── subdock                 # Script auxiliar para gestionar el contenedor
├── README.md               # Este archivo
```

---

## 📌 Notas

- Se recomienda tener el `ngrok authtoken` listo antes de iniciar.  
- El contenedor de Windows se ejecutará automáticamente tras la instalación.  
- El script `subdock` te permite iniciar/detener Windows fácilmente desde cualquier terminal.

---

## 🧪 Verificación

Puedes verificar que todo esté funcionando con:

```bash
docker ps
subdock status
```

---

## 🧑‍💻 Autor

**Adrien Ruiz** – [github.com/adrienru](https://github.com/adrienru)

---

## 📝 Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo `LICENSE` para más detalles.
