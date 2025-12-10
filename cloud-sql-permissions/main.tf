terraform {
  required_version = ">=1.7.2"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

locals {
  script_path = "${path.module}/scripts/grant_sql_access"
  code_hash = sha1(
    join("",
      [for f in fileset(local.script_path, "*") : filesha1("${local.script_path}/${f}")],
      [
        var.instance_connection_name,
        var.user_name,
        var.user_password,
        var.database_name,
      ],
      var.extra_commands,
    )
  )
}

resource "null_resource" "run_grant_sql_access" {
  triggers = {
    always_run = "${local.code_hash}-${var.user_name}"
  }

  provisioner "local-exec" {
    working_dir = local.script_path
    command     = "npm install && npm run exec"
    environment = {
      INSTANCE_CONNECTION_NAME = var.instance_connection_name
      USER_NAME                = var.user_name
      USER_PASSWORD            = var.user_password
      DATABASE_NAME            = var.database_name
      APP_USERNAME             = var.user_name
      EXTRA_COMMANDS           = join("", var.extra_commands)
    }
  }
}
