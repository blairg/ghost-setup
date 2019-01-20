output "droplet_id" {
  value = "${digitalocean_droplet.hackerlite-droplet.id}"
}

output "droplet_ip_address" {
  value = "${digitalocean_droplet.hackerlite-droplet.ipv4_address}"
}