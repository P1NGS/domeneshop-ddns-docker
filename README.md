# domeneshop-ddns-docker
Docker Compose build for DDNS to Domeneshop.

# Requirements
First, you need to create an API token.

Go to https://domene.shop/admin?view=api

The docker and docker-compose packages are needed.

# Configure API token
In the ./docker-compose.yml, update the your_client_token and your_client_secret with the API key you received earlier.
```
    environment:
      - DOMENESHOP_CLIENT_TOKEN=**your_client_token**
      - DOMENESHOP_CLIENT_SECRET=**your_client_secret**
```

## Add Your Domains in /data/domains.txt
In the /data/domains.txt add yours domains like this 
(Domain) (@ for root) or (subdomain)
```
example.com @
example.com test
example.net test2
```

# Install
## Download
```curl
curl -L https://github.com/P1NGS/domeneshop-ddns-docker/archive/refs/heads/main.tar.gz -o domeneshop-ddns-docker.tar.gz
tar -xvzf domeneshop-ddns-docker.tar.gz
```
or
```git 
git clone https://github.com/P1NGS/domeneshop-ddns-docker.git
```
## Configure Domains and API
```sh
nano docker-compose.yml
nano data/domains.txt
```
## Build docker image
```sh
docker-compose up -d --build
```

