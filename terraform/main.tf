terraform {
  backend "gcs" {
    bucket  = "hackerlite"
    prefix  = "terraform/state"
    credentials = "gcsauth.json"
  }
}

module "droplet" {
  source = "./droplet"
  do_token="${var.do_token}"
  pub_key="${var.pub_key}"
  pvt_key="${var.pvt_key}"
  ssh_fingerprint="${var.ssh_fingerprint}"
  digitalocean_floating_ip="${var.digitalocean_floating_ip}"
}