#!/bin/sh
#This file is part of [domeneshop-ddns-docker].
#It is licensed under the GNU GPL v3. See the LICENSE file for details.

# Load env vars
TOKEN="${DOMENESHOP_CLIENT_TOKEN}"
SECRET="${DOMENESHOP_CLIENT_SECRET}"
TTL="${UPDATE_TTL}"
DOMAINS_FILE="/app/domains.txt"
LAST_IP_FILE="/app/last_known_ip.txt"

# Get current public IP (change the URL if needed)
PUBLIC_IP=$(curl -s ifconfig.me)

# Check if the public IP has changed compared to the last known IP
if [ -f "$LAST_IP_FILE" ]; then
    OLD_IP=$(cat "$LAST_IP_FILE")
else
    OLD_IP=""
fi

if [ "$PUBLIC_IP" = "$OLD_IP" ]; then
    echo "Public IP has not changed ($PUBLIC_IP). No update needed."
else
    echo "Public IP changed to $PUBLIC_IP. Updating DNS records..."

    # Loop through each domain and hostname in the domains file
    while read -r DOMAIN HOSTNAME; do
        if [ -z "$DOMAIN" ] || [ -z "$HOSTNAME" ]; then
            continue
        fi

        # Get domain ID from Domeneshop API
        DOMAIN_ID=$(curl -s -u "$TOKEN:$SECRET" "https://api.domeneshop.no/v0/domains" | jq -r --arg domain "$DOMAIN" '.[] | select(.domain==$domain) | .id')


        if [ ! -n "$DOMAIN_ID" ]; then
            echo "Error: Could not find domain ID for $DOMAIN"
            continue 
        else
            # Get current IP for the DNS record for this hostname
            CURRENT_IP=$(curl -s -u "$TOKEN:$SECRET" "https://api.domeneshop.no/v0/domains/$DOMAIN_ID/dns" | jq -r --arg host "$HOSTNAME" '.[] | select(.host==$host) | .data')
        fi
        
        
        if [ ! "$CURRENT_IP" != "$PUBLIC_IP" ]; then
            echo "No update needed for $HOSTNAME.$DOMAIN (IP is already $CURRENT_IP)"
            continue 
        else
            # Get the DNS record ID
            RECORD_ID=$(curl -s -u "$TOKEN:$SECRET" "https://api.domeneshop.no/v0/domains/$DOMAIN_ID/dns" | jq -r --arg host "$HOSTNAME" '.[] | select(.host==$host) | .id')
        fi

        if [ -n "$RECORD_ID" ]; then
            # Perform the update with the new public IP
            curl -X PUT "https://api.domeneshop.no/v0/domains/$DOMAIN_ID/dns/$RECORD_ID" \
                -u "$TOKEN:$SECRET" \
                -H "Content-Type: application/json" \
                -d "{\"type\": \"A\", \"host\": \"$HOSTNAME\", \"data\": \"$PUBLIC_IP\", \"ttl\": $TTL}"
            echo "Updated $HOSTNAME.$DOMAIN to $PUBLIC_IP"
        else
            echo "Error: Could not find DNS record for $HOSTNAME.$DOMAIN"
        fi
    done < "$DOMAINS_FILE"

    # Save the new public IP to the last-known IP file
    echo "$PUBLIC_IP" > "$LAST_IP_FILE"
fi

# Sleep and repeat
sleep "${UPDATE_INTERVAL}"
exec "$0"
