output "external_ip_addresses_of_created_nodes" {
  value = ah_cloud_server.example.*.ips.0.ip_address
}
