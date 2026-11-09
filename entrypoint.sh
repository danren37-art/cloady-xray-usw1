#!/bin/sh
set -e
# Container always listens on 3000 internally; Cloady maps it to 443 externally.
PORT=3000
WS_PATH=${WS_PATH:-/xray}
if [ -z "$UUID" ]; then echo "UUID env var is required" >&2; exit 1; fi
mkdir -p /etc/xray
cat > /etc/xray/config.json <<EOJSON
{
  "log": {"loglevel": "warning"},
  "inbounds": [
    {
      "port": $PORT,
      "protocol": "vless",
      "settings": {
        "clients": [{"id": "$UUID"}],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {"path": "$WS_PATH"}
      }
    }
  ],
  "outbounds": [{"protocol": "freedom"}]
}
EOJSON
exec /usr/local/bin/xray run -config /etc/xray/config.json
