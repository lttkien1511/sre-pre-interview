#!/bin/bash

set -Eeuo pipefail

FAILED=0

pass() {
echo "PASS: $1"
}

fail() {
echo "FAIL: $1"
FAILED=1
}

#Swap check

if swapon --show | grep -q .; then
fail "swap is enabled"
else
pass "swap disabled"
fi

#Hostname check

if [[ -n "$(hostnamectl --static)" ]]; then
pass "hostname configured"
else
fail "hostname not configured"
fi

#DNS check

if systemctl is-active --quiet systemd-resolved; then
pass "DNS resolver active"
else
fail "DNS resolver inactive"
fi

#Kernel modules check

if lsmod | grep -q "^overlay"; then
pass "overlay module loaded"
else
fail "overlay module not loaded"
fi

if lsmod | grep -q "^br_netfilter"; then
pass "br_netfilter module loaded"
else
fail "br_netfilter module not loaded"
fi

#Sysctl check

if [[ "$(sysctl -n net.ipv4.ip_forward)" == "1" ]]; then
pass "ip_forward enabled"
else
fail "ip_forward disabled"
fi

if [[ "$(sysctl -n net.bridge.bridge-nf-call-iptables)" == "1" ]]; then
pass "bridge-nf-call-iptables enabled"
else
fail "bridge-nf-call-iptables disabled"
fi

if [[ "$(sysctl -n net.bridge.bridge-nf-call-ip6tables)" == "1" ]]; then
pass "bridge-nf-call-ip6tables enabled"
else
fail "bridge-nf-call-ip6tables disabled"
fi

#Container runtime check

if systemctl is-active --quiet containerd; then
pass "containerd active"
else
fail "containerd inactive"
fi

if grep -q "SystemdCgroup = true" /etc/containerd/config.toml; then
pass "SystemdCgroup enabled"
else
fail "SystemdCgroup not configured"
fi

#Kubernetes package check

if dpkg -s kubelet >/dev/null 2>&1; then
pass "kubelet installed"
else
fail "kubelet missing"
fi

if dpkg -s kubeadm >/dev/null 2>&1; then
pass "kubeadm installed"
else
fail "kubeadm missing"
fi

if dpkg -s kubectl >/dev/null 2>&1; then
pass "kubectl installed"
else
fail "kubectl missing"
fi

if command -v crictl >/dev/null 2>&1; then
pass "crictl installed"
else
fail "crictl missing"
fi

#Audit check

if systemctl is-active --quiet auditd; then
pass "auditd active"
else
fail "auditd inactive"
fi

#Sysadmin account check

if id sysadmin >/dev/null 2>&1; then
pass "sysadmin account exists"
else
fail "sysadmin account missing"
fi

#Summary

if [[ $FAILED -eq 0 ]]; then
echo "Validation passed"
exit 0
else
echo "Validation failed"
exit 1
fi

