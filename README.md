# domeneshop-ddns-docker
Docker Compose build for ddns to domeneshop
This updates only A records, and uses curl -s ipconfig.me to get publick IP.



# Requirements
First you need to create a API token.
Go to https://domene.shop/admin?view=api

# Configure API token
In the ./docker-compose.yml update the your_client_token and your_client_secret with the API key you got earlier.
```
    environment:
      - DOMENESHOP_CLIENT_TOKEN=**your_client_token**
      - DOMENESHOP_CLIENT_SECRET=**your_client_secret**
```

## Add your domains in /data/domains.txt
In the /data/domains.txt add yours domains like this 
(Domain) (@ for root) or (subdomain)
```
example.com @
example.com test
example.net test2
```
