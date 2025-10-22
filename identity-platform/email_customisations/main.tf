data "google_client_config" "default" {}

locals {
  request = <<EOT
curl 'https://identitytoolkit.googleapis.com/v2/projects/${var.project_id}/config?updateMask=notification.sendEmail.resetPasswordTemplate,notification.sendEmail.callbackUri' \
  -X 'PATCH' \
  -H 'authorization: Bearer BEARER_TOKEN_TO_REPLACE' \
  -H 'content-type: application/json' \
  -H 'X-Goog-User-Project: ${var.project_id}' \
  --data-raw '{
    "notification": {
      "sendEmail": {
        "resetPasswordTemplate": {
          "senderLocalPart": "${var.send_email.resetPasswordTemplate.senderLocalPart}",
          "senderDisplayName": "${var.send_email.resetPasswordTemplate.senderDisplayName}",
          "subject": "${var.send_email.resetPasswordTemplate.subject}",
          "body": "${var.send_email.resetPasswordTemplate.body}"
        },
        "callbackUri": "${var.send_email.callbackUri}"
      }
    }
  }'
  EOT
}

resource "null_resource" "reset_password_email_template" {
  triggers = {
    always_run = sha512(local.request)
  }

  provisioner "local-exec" {
    command = replace(local.request, "BEARER_TOKEN_TO_REPLACE", data.google_client_config.default.access_token)
  }
}
