# Digital Ocean VM

## Backup Ghost Data

* ssh onto machine
* navigate to the directory cd /home/hackerlite
* zip -r hackerlite.zip ./
* scp -rp <USER>@<IP_ADDRESS>:/home/hackerlite/hackerlite.zip ./Downloads
* Upload manually to a Google bucket

## Migration New VMls

 
* 
* scp -rp ./Downloads/hackerlite.zip <USER>@<IP_ADDRESS>:/home/hackerlite
* unzip hackerlite.zip -d hackerlite
* cd hackerlite/hackerlite
* sudo certbot --nginx --webroot-path=/home/hackerlite/hackerlite/sslcerts -d hackerlite.xyz -d www.hackerlite.xyz
* sudo systemctl stop nginx 
* docker-compose up -d



## Plan 

cd terraform

terraform plan -out=tfplan -input=false \
  -var "do_token=${DO_PAT}" \
  -var "pub_key=$HOME/.ssh/id_rsa.pub" \
  -var "pvt_key=$HOME/.ssh/id_rsa" \
  -var "ssh_fingerprint=${SSH_FINGERPRINT}" \
  -var "digitalocean_floating_ip=$FLOATING_IP"


## Create

terraform apply tfplan

## Destroy

terraform destroy \
  -var "do_token=${DO_PAT}" \
  -var "pub_key=$HOME/.ssh/id_rsa.pub" \
  -var "pvt_key=$HOME/.ssh/id_rsa" \
  -var "ssh_fingerprint=$SSH_FINGERPRINT" \
  -var "digitalocean_floating_ip=$FLOATING_IP"
