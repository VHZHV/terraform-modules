output "ip_names" {
  value = {
    for index, name in var.domains : name => module.ip_addresses.names[index]
  }
}
