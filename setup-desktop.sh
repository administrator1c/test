#!/usr/bin/env bash
set -euo pipefail
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends xfce4 xfce4-terminal tigervnc-standalone-server novnc websockify dbus-x11
printf '\nInstallation complete. Run: bash start-desktop.sh\n'
