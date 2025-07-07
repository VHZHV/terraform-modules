output "ip_names" {
  value = {
    for index, name in var.dns_names : name => module.ip_addresses.names[index]
  }
}
