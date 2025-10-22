resource "sendgrid_api_key" "send_api_key" {
  name = var.name
  scopes = [
    "mail.send",
    "sender_verification_eligible",
    "sender_verification_legacy",
    "2fa_required"
  ]
}
