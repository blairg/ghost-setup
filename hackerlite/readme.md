App folder on VM -> /home/project-overview-mono/hackerlite




echo "" > docker-compose.yml &&  nano docker-compose.yml
  568  echo "" > nginx.conf &&  nano nginx.conf
  569  docker-compose build && docker-compose up
  570  nano docker-compose.yml
  571  nano Dockerfile
  572  docker-compose build && docker-compose up
  573  cp certs/dhparam.pem dhparam.pem
  574  cp certs/fullchain.pem fullchain.pem
  575  cp -r certs/fullchain.pem fullchain.pem
  576  cp -r certs/privkey.pem privkey.pem
  577  docker-compose build && docker-compose up
  578  nano Dockerfile
  579  chmod 777 privkey.pem
  580  sudo cp -a certs/privkey.pem privkey.pem
  581  ls
  582  ls -la
  583  cat privkey.pem > privkey.pem1
  584  cat privkey.pem | pbcopy
  585  cat privkey.pem
  586  nano ../../archive/hackerlite.xyz/privkey1.pem
  587  /etc/letsencrypt/live/hackerlite.xyz/
  588  cd /etc/letsencrypt/live/hackerlite.xyz/
  589  ls
  590  ls -al
  591  cp fullchain.pem /home/project-overview-mono/hackerlite/
  592  mv fullchain.pem /home/project-overview-mono/hackerlite/
  593  mv privkey.pem /home/project-overview-mono/hackerlite/
  594  ls -al
  595  cd /home/project-overview-mono/hackerlite/
  596  ls
  597  ls -la
  598  mv /etc/letsencrypt/live/hackerlite.xyz/privkey.pem /home/project-overview-mono/hackerlite/
  599  ls
  600  unlink fullchain.pem
  601  ls
  602  history
  603  sudo systemctl start nginx
  604  sudo certbot certonly -a webroot --webroot-path=/usr/share/nginx/html -d hackerlite.xyz -d www.hackerlite.xyz
  605  cd /etc/letsencrypt/live/hackerlite.xyz/
  606  ls
  607  /etc/letsencrypt/live/hackerlite.xyz-0001
  608  cd /etc/letsencrypt/live/hackerlite.xyz-0001
  609  ls
  610  ls -la
  611  pw
  612  pwd
  613  cp -r /etc/letsencrypt/live/hackerlite.xyz-0001/* /home/project-overview-mono/hackerlite/certs/
  614  cd /home/project-overview-mono/hackerlite/certs/
  615  ls
  616  cd ..
  617  nano docker-compose.yml
  618  nano Dockerfile
  619  ls -la
  620  cd certs/
  621  ls
  622  lsl
  623  ls -lah
  624  echo "" > docker-compose.yml &&  nano docker-compose.yml
  625  cd ..
  626  echo "" > docker-compose.yml &&  nano docker-compose.yml
  627  nano Dockerfile
  628  docker-compose build && docker-compose up
  629  nano Dockerfile
  630  nano docker-compose.yml
  631  docker-compose build && docker-compose up
  632  sudo systemctl stop nginx.service
  633  docker-compose build && docker-compose up
  634  cd /etc/letsencrypt/live/hackerlite.xyz
  635  ls
  636  cd ..
  637  ls
  638  cd hackerlite.xyz-0001/
  639  ls
  640  ls -la
  641  cat fullchain.pem
  642  nano /home/project-overview-mono/hackerlite/certs/fullchain.pem
  643  cat privkey.pem
  644  cd /home/
  645  ls
  646  cd project-overview-mono/
  647  ls
  648  cd hackert
  649  cd hackerlite/
  650  ls
  651  mkdir sslcerts
  652  cp certs/dhparam.pem sslcerts/
  653  nano sslcerts/fullchain.pem
  654  nano sslcerts/privkey.pem
  655  ls
  656  ls
  657  cd ..
  658  nano Dockerfile
  659  echo "" > docker-compose.yml &&  nano docker-compose.yml
  660  docker-compose build && docker-compose up
  661  yum remove nginx
  662  docker-compose build && docker-compose up -d
  663  curl -l http://localhost
  664  docker-compose down
  665  echo "" > docker-compose.yml &&  nano docker-compose.yml
  666  docker-compose build && docker-compose up -d
  667  docker-compose down
  668  docker-compose build && docker-compose up -d
  669  docker-compose down