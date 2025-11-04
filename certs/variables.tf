variable "map" {
  type        = string
  description = "Name of the certificate map."
}

variable "domains" {
  type        = list(string)
  description = "List of domain names to be used for the certificates."
}

variable "prefix" {
  type        = string
  description = "Prefix to be used for naming the certificates."
}
