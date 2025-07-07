output "details" {
  value = {
    for index, name in var.dns_names : name => {
      domain = module.ip_addresses.dns_fqdns[index]
      ipName = module.ip_addresses.names[index]
    }
  }
}
