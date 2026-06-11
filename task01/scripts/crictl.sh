#!/bin/bash

set -Eeuo pipefail

VERSION="v1.36.0"

cd /tmp

wget -q \
https://github.com/kubernetes-sigs/cri-tools/releases/download/${VERSION}/crictl-${VERSION}-linux-amd64.tar.gz

tar -xzf crictl-${VERSION}-linux-amd64.tar.gz

install -m 755 crictl /usr/local/bin/crictl

cat >/etc/crictl.yaml <<EOF
runtime-endpoint: unix:///run/containerd/containerd.sock
image-endpoint: unix:///run/containerd/containerd.sock
timeout: 10
debug: false
EOF

echo "[OK] crictl installed"

