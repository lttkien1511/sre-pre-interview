#!/bin/bash

set -Eeuo pipefail

SYSADMIN_USER="sysadmin"
PASSWORD_FILE="/root/bootstrap-passwords.txt"

echo "[INFO] Configuring sysadmin account"

if id "${SYSADMIN_USER}" >/dev/null 2>&1; then
echo "[INFO] User '${SYSADMIN_USER}' already exists. Skipping."
exit 0
fi

PASSWORD="$(openssl rand -base64 20)"

useradd --create-home --shell /bin/bash "${SYSADMIN_USER}"

echo "${SYSADMIN_USER}:${PASSWORD}" | chpasswd

usermod -aG sudo "${SYSADMIN_USER}"

touch "${PASSWORD_FILE}"
chmod 600 "${PASSWORD_FILE}"

{
echo "========================================"
echo "Provisioned: $(date)"
echo "Username: ${SYSADMIN_USER}"
echo "Password: ${PASSWORD}"
echo "========================================"
} >> "${PASSWORD_FILE}"

echo "[OK] User '${SYSADMIN_USER}' created"
echo "[OK] Password stored in ${PASSWORD_FILE}"
