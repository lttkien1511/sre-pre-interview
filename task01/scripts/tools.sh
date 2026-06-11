#!/bin/bash

set -Eeuo pipefail

echo "[INFO] Installing common CLI tools"

apt-get update

apt-get install -y \
curl \
wget \
git \
jq \
htop \
net-tools \
tcpdump \
dnsutils \
unzip

echo "[OK] CLI tools installed"
