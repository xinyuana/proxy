#!/bin/sh
set -eu

PROXY_PORT="${PROXY_PORT:-3128}"
PROXY_USER="${PROXY_USER:-mediacrawler}"
PROXY_PASSWORD="${PROXY_PASSWORD:-}"

if [ -z "$PROXY_PASSWORD" ]; then
  echo "[squid-proxy] ERROR: PROXY_PASSWORD is empty. Set it in docker-compose.yml (or via env var) and restart." >&2
  exit 2
fi

htpasswd -bc /etc/squid/passwd "$PROXY_USER" "$PROXY_PASSWORD" >/dev/null
chmod 600 /etc/squid/passwd

exec squid -N -f /etc/squid/squid.conf
