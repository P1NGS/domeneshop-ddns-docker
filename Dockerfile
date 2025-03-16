FROM alpine:latest

RUN apk add --no-cache curl jq && \
    mkdir /app

CMD ["/bin/sh", "/app/update-dns.sh"]
