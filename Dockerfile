FROM alpine:latest

RUN apk add --no-cache curl jq

# Create app directory
RUN mkdir /app

# Copy your update-dns.sh script into the container
COPY data/update-dns.sh /app/update-dns.sh

# Make sure the script is executable
RUN chmod +x /app/update-dns.sh

# Default command to run the script
CMD ["/bin/sh", "/app/update-dns.sh"]
