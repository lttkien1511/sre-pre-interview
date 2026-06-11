#!/bin/bash

set -Eeuo pipefail

PRIMARY_DNS="${PRIMARY_DNS:-1.1.1.1}"
SECONDARY_DNS="${SECONDARY_DNS:-8.8.8.8}"

echo "[INFO] Configuring DNS"

cat >/etc/systemd/resolved.conf <<EOF
[Resolve]
DNS=${PRIMARY_DNS} ${SECONDARY_DNS}
EOF

systemctl restart systemd-resolved

echo "[OK] DNS configured"
echo "[INFO] Primary DNS: ${PRIMARY_DNS}"
echo "[INFO] Secondary DNS: ${SECONDARY_DNS}"
