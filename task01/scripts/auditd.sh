#!/bin/bash

set -Eeuo pipefail

echo "[INFO] Installing auditd"

apt-get update
apt-get install -y auditd audispd-plugins

cat >/etc/audit/rules.d/user-commands.rules <<EOF
-a always,exit -F arch=b64 -S execve -k user_commands
-a always,exit -F arch=b32 -S execve -k user_commands
EOF

augenrules --load

systemctl enable auditd
systemctl restart auditd

echo "[OK] auditd configured"
