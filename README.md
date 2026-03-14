# MediaCrawler Squid Proxy (Docker)

Public repo for deploying a simple authenticated Squid forward proxy.

## Quick Start

1. Set `PROXY_PASSWORD` in `docker-compose.yml` (blank by default).
2. Start the proxy:

```bash
docker compose up -d --build
```

## Test

```bash
curl -v -x http://<server-ip>:3128 --proxy-user "mediacrawler:<your-password>" https://www.baidu.com -I
```

## Files

- `docker-compose.yml`: run proxy
- `squid.conf`: squid config
- `entrypoint.sh`: generates `/etc/squid/passwd` at container start
