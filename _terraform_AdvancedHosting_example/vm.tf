resource "ah_cloud_server" "example" {
  count      = 3
  name       = "node${count.index}"
  datacenter = var.ah_datacenter
  image      = var.ah_image_type
  product    = var.ah_machine_type
  ssh_keys   = ["02:84:8c:29:4d:16:10:12:3e:7e:48:fc:d4:46:d8:81"]
}


resource "ah_private_network" "example" {
  ip_range = "192.168.1.0/24"
  name = "LAN"
  depends_on = [
    ah_cloud_server.example,
  ]
}

resource "ah_private_network_connection" "example" {
  count = 3
  cloud_server_id = ah_cloud_server.example[count.index].id
  private_network_id = ah_private_network.example.id
  ip_address = "192.168.1.${count.index+1}"
  depends_on = [
    ah_cloud_server.example,
    ah_private_network.example
  ]
}
