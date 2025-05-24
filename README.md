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
```
```
tar -xvzf domeneshop-ddns-docker.tar.gz
```
or
```git 
git clone https://github.com/P1NGS/domeneshop-ddns-docker.git
```
## Configure Domains and API
```sh
nano docker-compose.yml
```
```
nano data/domains.txt
```
## Build docker image
```sh
docker-compose up -d --build
```



# CopyRight
```
Copyright (C) 2025 Andreas Skjei Dahl

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.
```
