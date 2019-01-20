# Digital Ocean VM

<!-- ## Backup Ghost Data

* ssh onto machine
* navigate to the directory cd /home/hackerlite
* zip -r hackerlite.zip ./
* scp -rp <USER>@<IP_ADDRESS>:/home/hackerlite/hackerlite.zip ./Downloads
* Upload manually to a Google bucket -->

## Migration New VMs
 
<!-- * docker run -ti -e CLOUDSDK_CONFIG=/config/mygcloud -v `pwd`/mygcloud:/config/mygcloud -v `pwd`:/certs google/cloud-sdk:latest /bin/bash
* * gcloud init  --console-only
* * gsutil cp gs://hackerlite/hackerlite.zip /config/mygcloud
* * exit
* unzip $PWD/mygcloud/hackerlite.zip -d /home/hackerlite  -->


* DROPLET_IP=$(terraform output droplet_ip_address)
* ssh root@$DROPLET_IP
* sudo certbot --nginx --webroot-path=/home/hackerlite/sslcerts -d hackerlite.xyz -d www.hackerlite.xyz && cd /home/hackerlite && cp /etc/letsencrypt/live/hackerlite.xyz/fullchain.pem sslcerts/ && cp /etc/letsencrypt/live/hackerlite.xyz/privkey.pem sslcerts/ && sudo openssl dhparam -out /home/hackerlite/sslcerts/dhparam.pem 2048 && sudo systemctl stop nginx && docker-compose up -d

<!-- sudo certbot --nginx --webroot-path=/home/hackerlite/sslcerts -d hackerlite.xyz -d www.hackerlite.xyz && cd /home/hackerlite && cp /etc/letsencrypt/live/hackerlite.xyz/fullchain.pem sslcerts/ && cp /etc/letsencrypt/live/hackerlite.xyz/privkey.pem sslcerts/ && sudo openssl dhparam -out /home/hackerlite/sslcerts/dhparam.pem 2048 && sudo systemctl stop nginx && docker-compose up -d -->



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
