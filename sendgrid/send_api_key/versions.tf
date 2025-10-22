terraform {
  required_version = ">= 0.13"

  required_providers {
    sendgrid = {
      source  = "anna-money/sendgrid"
      version = "~> 1.0"
    }
  }
}
