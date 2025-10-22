resource "sendgrid_api_key" "validate_api_key" {
  name = var.name
  scopes = [
    "validations.email.create",
    "sender_verification_eligible",
    "sender_verification_legacy",
    "2fa_required"
  ]
}
