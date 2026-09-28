terraform {
  required_version = ">= 1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "> 6"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }
  }
}
