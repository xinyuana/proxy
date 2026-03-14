# proxy (public)

Public repo for deploying an authenticated Squid forward proxy using Docker Compose.

## Deploy (Ubuntu 24.04)

```bash
sudo bash scripts/setup-ubuntu24.sh
```

Then:

```bash
git clone https://github.com/xinyuana/proxy.git
cd proxy
cp .env.example .env
```

Edit `.env` and set `PROXY_PASSWORD` (kept blank in git by design), then start:

```bash
docker compose up -d --build
docker compose ps
```

## Test

```bash
curl -v -x http://<server-ip>:3128 --proxy-user "mediacrawler:<your-password>" https://www.baidu.com -I
```

If your password contains `!`, prefer single quotes:

```bash
curl -v -x http://<server-ip>:3128 --proxy-user 'mediacrawler:MediaCrawler2025!' https://www.baidu.com -I
```

## Ops

```bash
docker logs --tail 200 mediacrawler_squid
docker compose restart
```

## Notes

- Open port `3128/tcp` in both UFW and your cloud security group.
- To restrict access by IP range, edit `squid.conf` ACL rules.
