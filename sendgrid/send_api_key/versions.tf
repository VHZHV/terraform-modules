terraform {
  required_version = ">= 1"
  required_providers {
    sendgrid = {
      source  = "anna-money/sendgrid"
      version = "~> 1.0"
    }
  }
}
