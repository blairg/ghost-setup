
variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}
variable "digitalocean_floating_ip" {}

variable "digitalocean_image" {
  description = "The DigitalOcean image to use as the base for this digitalocean-droplet."
  default = "ubuntu-18-10-x64"
}

variable "digitalocean_droplet_name" {
  description = "The name of the digitalocean-droplet."
  default = "hackerlite-ubuntu-18-10-64-1gb-lon1"
}

variable "digitalocean_droplet_region" {
  description = "The region of the digitalocean-droplet."
  default = "LON1"
}

variable "digitalocean_droplet_size" {
  description = "The RAM size of the digitalocean-droplet."
  default = "s-1vcpu-1gb"
}