resource "sendgrid_api_key" "design_library_api_key" {
  name = var.name
  scopes = [
    "design_library.read",
    "design_library.create",
    "design_library.update",
    "design_library.delete",
    "sender_verification_eligible",
    "sender_verification_legacy",
    "2fa_required"
  ]
}
