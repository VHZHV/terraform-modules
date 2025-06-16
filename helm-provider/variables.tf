variable "project_id" {
  type        = string
  description = "The project ID to host the cluster in"
}

variable "cluster_location" {
  description = "The location of the cluster, either a region or a zone"
  type        = string
}

variable "cluster_name" {
  description = "The name of the cluster to connect to"
  type        = string
}
