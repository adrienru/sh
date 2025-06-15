#!/bin/bash

GREEN="\\033[1;32m"
RED="\\033[1;31m"
RESET="\\033[0m"

check() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✔️ $1${RESET}"
    else
        echo -e "${RED}❌ $1${RESET}"
    fi
}

# 1. Reemplazar wrapdocker
cat <<'EOF' > /google/scripts/wrapdocker/wrapdocker
#!/bin/bash
export container=docker

# Matar dockerd si está corriendo
pkill -f dockerd

# Eliminar pid viejo
rm -f /var/run/docker.pid

# Montar seguridad
if [ -d /sys/kernel/security ] && ! mountpoint -q /sys/kernel/security; then
  mount -t securityfs none /sys/kernel/security || {
    echo >&2 'Could not mount /sys/kernel/security.'
    echo >&2 'AppArmor detection and --privileged mode might break.'
  }
fi

# iptables modo legacy
update-alternatives --set iptables /usr/sbin/iptables-legacy

# Cerrar descriptores innecesarios
pushd /proc/self/fd >/dev/null
for FD in *; do
  case "$FD" in
    [012]) ;;
    *) eval exec "$FD>&-";;
  esac
done
popd >/dev/null

# Crear dispositivos loopback
function ensure_loopback_device() {
  DEVICE_NUMBER="$1"
  DEVICE_NAME="/dev/loop$DEVICE_NUMBER"
  if [ -b "$DEVICE_NAME" ]; then return 0; fi
  mknod -m660 "$DEVICE_NAME" b 7 "$DEVICE_NUMBER" || {
    echo "Failed to create $DEVICE_NAME."
    return 1
  }
}

for i in {0..3}; do ensure_loopback_device $i; done

# Iniciar dockerd con ruta personalizada y MTU
echo "Starting dockerd with custom data-root"
dockerd --data-root=/home/user/docker --mtu=1460 &

DOCKER_PID=$!

# Esperar a que esté listo
(( timeout = 60 + SECONDS ))
until docker info >/dev/null 2>&1; do
  if (( SECONDS >= timeout )); then
    echo '❌ Timed out waiting for Docker daemon.' >&2
    exit 1
  fi
  sleep 1
done

echo "✅ Docker is ready (PID: $DOCKER_PID)"
EOF

# 2. Hacer ejecutable wrapdocker
chmod +x /google/scripts/wrapdocker/wrapdocker
check "wrapdocker actualizado y con permisos ejecutables"

# 8. Ejecutar wrapdocker
sudo /google/scripts/wrapdocker/wrapdocker
check "wrapdocker ejecutado correctamente"
