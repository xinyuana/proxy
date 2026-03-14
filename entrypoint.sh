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
# Squid helpers run as the squid/proxy user; keep file non-world-readable but accessible.
if id proxy >/dev/null 2>&1; then
  chown proxy:proxy /etc/squid/passwd
else
  # Fallback for images using 'squid' user.
  chown squid:squid /etc/squid/passwd 2>/dev/null || true
fi
chmod 640 /etc/squid/passwd

exec squid -N -f /etc/squid/squid.conf
