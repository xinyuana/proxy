#!/usr/bin/env bash
set -euo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo "Please run as root (or: sudo bash scripts/setup-ubuntu24.sh)"
  exit 1
fi

export DEBIAN_FRONTEND=noninteractive

echo "[setup] updating apt..."
apt-get update -y
apt-get install -y ca-certificates curl gnupg lsb-release ufw

echo "[setup] installing docker..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

ARCH="$(dpkg --print-architecture)"
CODENAME="$(. /etc/os-release && echo "${VERSION_CODENAME}")"
echo "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu ${CODENAME} stable" \
  > /etc/apt/sources.list.d/docker.list

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl enable --now docker

echo "[setup] configuring ufw..."
ufw --force enable
ufw allow 22/tcp
ufw allow 3128/tcp
ufw status

echo "[setup] done"
