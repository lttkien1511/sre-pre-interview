#!/bin/bash

set -Eeuo pipefail

echo "[INFO] Disabling swap"

swapoff -a

cp /etc/fstab /etc/fstab.bak.$(date +%s)

sed -ri '/\sswap\s/s/^/#/' /etc/fstab

echo "[OK] Swap disabled"
#
