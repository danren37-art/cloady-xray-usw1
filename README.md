# cloady-xray-usw1
Minimal Xray (VLESS + WebSocket + TLS) for Cloady US West (USW1).
Multi-stage Dockerfile: the official ghcr.io/xtls/xray-core image has no shell, so the binary (/usr/local/bin/xray) is copied into Alpine, which provides the shell for the entrypoint.
The container listens on 3000 internally; Cloady exposes it on 443 with TLS.
Required env vars (set as secrets in Cloady): UUID, WS_PATH.
