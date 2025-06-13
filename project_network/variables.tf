variable "project_id" {
  type        = string
  description = "Project id tier will be setup."
}

variable "regions" {
  description = "Regions that should have a network available, can be used to disaster recovery."
  type        = list(string)
}

variable "network_name" {
  description = "Name of the network to be created."
  type        = string
}

variable "ip_range_services_name" {
  description = "Name of the IP range for services. This will end up being used for the GKE cluster services."
  type        = string
}

variable "ip_range_pods_name" {
  description = "Name of the IP range for pods. This will end up being used for the GKE cluster pods."
  type        = string
}

variable "subnet_name_suffix" {
  description = "Suffix for the subnet names. This will be appended to the region name to create unique subnet names."
  type        = string
}
