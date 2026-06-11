#!/bin/bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/scripts/common.sh"

log "Starting Kubernetes node provisioning"

bash "$SCRIPT_DIR/scripts/users.sh"
bash "$SCRIPT_DIR/scripts/hostname.sh"
bash "$SCRIPT_DIR/scripts/dns.sh"
bash "$SCRIPT_DIR/scripts/tools.sh"
bash "$SCRIPT_DIR/scripts/disable_swap.sh"
bash "$SCRIPT_DIR/scripts/kernel.sh"
bash "$SCRIPT_DIR/scripts/kubernetes.sh"
bash "$SCRIPT_DIR/scripts/containerd.sh"
bash "$SCRIPT_DIR/scripts/crictl.sh"
bash "$SCRIPT_DIR/scripts/auditd.sh"

log "Provisioning completed successfully"
