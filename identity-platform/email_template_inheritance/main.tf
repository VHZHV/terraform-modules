data "google_client_config" "default" {}

locals {
  request = <<EOT
curl 'https://identitytoolkit.googleapis.com/v2/projects/${var.project_id}/tenants/${var.tenant_name}?updateMask=inheritance.emailSendingConfig' \
  -X 'PATCH' \
  -H 'authorization: Bearer BEARER_TOKEN_TO_REPLACE' \
  -H 'content-type: application/json' \
  -H 'X-Goog-User-Project: ${var.project_id}' \
  --data-raw '{
    "inheritance": {
      "emailSendingConfig": true
    }
  }'
  EOT
}

resource "null_resource" "email_template_inheritance" {
  triggers = {
    always_run = sha512(local.request)
  }

  provisioner "local-exec" {
    command = replace(local.request, "BEARER_TOKEN_TO_REPLACE", data.google_client_config.default.access_token)
  }
}
