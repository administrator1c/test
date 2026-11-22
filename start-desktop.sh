#!/usr/bin/env bash
set -euo pipefail
read -rsp 'Set VNC password (at least 6 characters): ' VNC_PASSWORD
echo
if [ "${#VNC_PASSWORD}" -lt 6 ]; then echo 'Password too short'; exit 1; fi
mkdir -p "$HOME/.vnc"
printf '%s\n' "$VNC_PASSWORD" | vncpasswd -f > "$HOME/.vnc/passwd"
chmod 600 "$HOME/.vnc/passwd"
unset VNC_PASSWORD
cat > "$HOME/.vnc/xstartup" <<'XSTART'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec dbus-launch --exit-with-session startxfce4
XSTART
chmod +x "$HOME/.vnc/xstartup"
vncserver -kill :1 >/dev/null 2>&1 || true
vncserver :1 -localhost yes -geometry 1280x720 -depth 24
exec websockify --web=/usr/share/novnc/ 0.0.0.0:6080 localhost:5901
