
provider "digitalocean" {
  token = "${var.do_token}"
}
resource "digitalocean_droplet" "hackerlite-droplet" {
  image = "${var.digitalocean_image}"
  name = "${var.digitalocean_droplet_name}"
  region = "${var.digitalocean_droplet_region}"
  size = "${var.digitalocean_droplet_size}"
  private_networking = true
  tags = ["hackerlite", "ghost", "ubuntu"]
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]

  connection {
    user = "root"
    type = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }

  # Enable DO Monitoring
  provisioner "remote-exec" {
    inline = [
      "curl -sSL https://agent.digitalocean.com/install.sh | sh"
    ]
  }

	# Install Docker and download and run Hackerlite blog
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
    # Install NGINX
      "sudo apt install -y nginx unzip zip",
      "sudo ufw allow 'Nginx Full'",
      "sudo ufw enable -y",
    # install Docker
      "snap install docker",
      "sudo curl -L \"https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose",
      "docker-compose version",
    # Install Certbot - Let's Encrypt
      "sudo mkdir -p /var/www/letsencrypt",
      "sudo apt-get update",
      "sudo apt-get install -y -q software-properties-common",
      "sudo add-apt-repository -y universe",
      "sudo add-apt-repository -y ppa:certbot/certbot",
      "sudo apt-get update",
      "sudo apt-get install -y python-certbot-nginx"
     ]
  }

  # Copies the nginx.conf file to /etc/myapp.conf
  provisioner "file" {
    source      = "resources/nginx.conf"
    destination = "/etc/nginx/sites-available/default" // copy to different location then overwrite
  }

  # Restart NGINX
  provisioner "remote-exec" {
    inline = [
      "sudo /etc/init.d/nginx restart"
    ]
  }

  # Clone my Repo from Github
  provisioner "remote-exec" {
    inline = [
      "cd /home", 
      "git clone https://github.com/blairg/ghost-setup.git",
      "cd ghost-setup",
      "git checkout hackerlite-blog",
      "cp -r /home/ghost-setup/hackerlite /home/hackerlite"
    ]
  }

  # Gcloud Auth File
  provisioner "file" {
    source      = "gcsauth.json"
    destination = "/home/gcsauth.json" 
  }

  # Install Google Cloud SDK and rsync blog data
  provisioner "remote-exec" {
    inline = [
      "cd /home",
      "mkdir mygcloud",
      "export CLOUD_SDK_REPO=\"cloud-sdk-$(lsb_release -c -s)\"",
      "echo \"deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main\" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list",
      "curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -",
      "sudo apt-get update && sudo apt-get install -y google-cloud-sdk",
      "gcloud auth activate-service-account --key-file gcsauth.json",
      "mkdir -p /home/hackerlite/data",
      "mkdir -p /home/hackerlite/sslcerts",
      "gsutil -m cp -r gs://hackerlite/v2/data /home/hackerlite/",
      "gsutil -m cp -r gs://hackerlite/v2/sslcerts /home/hackerlite/",
      "sudo openssl dhparam -out /home/hackerlite/sslcerts/dhparam.pem 2048",
      "sudo systemctl stop nginx",
      "cd /home/hackerlite",
      "docker-compose up -d"
    ]
  }

  # Cronjob to hourly rsync the blog data
  provisioner "remote-exec" {
    inline = [
      "cd /home",
      "gsutil cp gs://hackerlite/cronjobs.txt cronjobs.txt",
      "(crontab -l ; cat cronjobs.txt 2>&1) | grep -v \"no crontab\" | sort | uniq | crontab -"
    ]
  }

  # # Create SSL certificate folder
  # provisioner "remote-exec" {
  #   inline = [
  #     "mkdir -p /home/hackerlite/sslcerts"
  #   ]
  # }

}

resource "digitalocean_floating_ip_assignment" "hackerlite-droplet" {
  ip_address = "${var.digitalocean_floating_ip}"
  droplet_id = "${digitalocean_droplet.hackerlite-droplet.id}"
}