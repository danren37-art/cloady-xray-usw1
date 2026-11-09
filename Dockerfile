# Stage 1: official Xray image (distroless, no shell). Binary lives at /usr/local/bin/xray.
FROM ghcr.io/xtls/xray-core:latest AS xray
# Stage 2: Alpine provides the shell for the entrypoint.
FROM alpine:3.21
RUN apk add --no-cache ca-certificates
COPY --from=xray /usr/local/bin/xray /usr/local/bin/xray
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 3000
ENTRYPOINT ["/entrypoint.sh"]
