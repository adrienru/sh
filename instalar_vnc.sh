#!/bin/bash

# --- VARIABLES ---
VNC_PASS="tu_clave_vnc"

echo "[1/7] Actualizando sistema..."
sudo apt update && sudo apt upgrade -y

echo "[2/7] Instalando XFCE4 y TigerVNC..."
sudo apt install xfce4 xfce4-goodies tigervnc-standalone-server -y

echo "[3/7] Configurando contraseña VNC..."
mkdir -p ~/.vnc
echo "$VNC_PASS" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

echo "[4/7] Configurando archivo xstartup..."
cat > ~/.vnc/xstartup <<EOF
#!/bin/bash
xrdb \$HOME/.Xresources
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

echo "[5/7] Deteniendo VNC por si está en ejecución..."
vncserver -kill :1 2>/dev/null

echo "[6/7] Iniciando servidor VNC en :1 (puerto 5901)..."
vncserver :1

echo "[7/7] ¡Listo! Puedes conectarte vía VNC a esta IP:"
ip a | grep inet | grep -v 127 | awk '{print $2}' | cut -d/ -f1

echo "Usa el puerto 5901 o la IP Tailscale + :5901 si tienes Tailscale."
