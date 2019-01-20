#!/usr/bin/env bash

DROPLET_IP=$(terraform output droplet_ip_address)

ssh root@$DROPLET_IP <<'ENDSSH'
    sudo certbot --nginx --webroot-path=/home/hackerlite/sslcerts -d hackerlite.xyz -d www.hackerlite.xyz && cd /home/hackerlite && cp /etc/letsencrypt/live/hackerlite.xyz/fullchain.pem sslcerts/ && cp /etc/letsencrypt/live/hackerlite.xyz/privkey.pem sslcerts/ && sudo openssl dhparam -out /home/hackerlite/sslcerts/dhparam.pem 2048 && sudo systemctl stop nginx && docker-compose up -d
ENDSSH
