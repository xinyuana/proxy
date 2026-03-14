FROM ubuntu/squid:latest

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends apache2-utils ca-certificates; \
  rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
