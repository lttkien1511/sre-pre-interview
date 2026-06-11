#!/bin/bash

set -Eeuo pipefail

NODE_HOSTNAME="${NODE_HOSTNAME:-k8s-node}"

echo "[INFO] Configuring hostname"

hostnamectl set-hostname "${NODE_HOSTNAME}"

echo "[OK] Hostname set to ${NODE_HOSTNAME}"
