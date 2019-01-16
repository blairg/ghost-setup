
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
      "sudo ufw enable",
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
  #     "sudo certbot certonly -a webroot --webroot-path=/var/www/letsencrypt --register-unsafely-without-email --agree-tos -d hackerlite.xyz -d www.hackerlite.xyz"
     ]
  }

  # Copies the nginx.conf file to /etc/myapp.conf
  provisioner "file" {
    source      = "resources/nginx.conf"
    destination = "/etc/nginx/sites-available/default" // copy to different location then overwrite
  }

  # Clone my Repo from Github

  # Unpack Google cloud backup for ghost data

  # Restart NGINX
}

resource "digitalocean_floating_ip_assignment" "hackerlite-droplet" {
  ip_address = "${var.digitalocean_floating_ip}"
  droplet_id = "${digitalocean_droplet.hackerlite-droplet.id}"
}