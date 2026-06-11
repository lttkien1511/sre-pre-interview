#!/bin/bash

set -Eeuo pipefail

LOG_FILE="/var/log/k8s-node-provision.log"

log() {
echo "[$(date '+%F %T')] $1" | tee -a "$LOG_FILE"
}

require_root() {
if [[ $EUID -ne 0 ]]; then
echo "Please run as root"
exit 1
fi
}

require_root

