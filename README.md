# Digital Ocean VM

## Backup Ghost Data

* Check rsyncing is working properly with Google cloud
* Export settings in Ghost admin page

## Migration New VMs

* DROPLET_IP=$(terraform output droplet_ip_address)
* ssh root@$DROPLET_IP
* sudo certbot --nginx --webroot-path=/home/hackerlite/sslcerts -d hackerlite.xyz -d www.hackerlite.xyz && cd /home/hackerlite && cp /etc/letsencrypt/live/hackerlite.xyz/fullchain.pem sslcerts/ && cp /etc/letsencrypt/live/hackerlite.xyz/privkey.pem sslcerts/ && sudo openssl dhparam -out /home/hackerlite/sslcerts/dhparam.pem 2048 && sudo systemctl stop nginx && docker-compose up -d



## Terraform Deployment

### Plan

cd terraform

terraform plan -out=tfplan -input=false \
  -var "do_token=${DO_PAT}" \
  -var "pub_key=$HOME/.ssh/id_rsa.pub" \
  -var "pvt_key=$HOME/.ssh/id_rsa" \
  -var "ssh_fingerprint=${SSH_FINGERPRINT}" \
  -var "digitalocean_floating_ip=$FLOATING_IP"


### Create

terraform apply tfplan

### Destroy

terraform destroy \
  -var "do_token=${DO_PAT}" \
  -var "pub_key=$HOME/.ssh/id_rsa.pub" \
  -var "pvt_key=$HOME/.ssh/id_rsa" \
  -var "ssh_fingerprint=$SSH_FINGERPRINT" \
  -var "digitalocean_floating_ip=$FLOATING_IP"
