module "security_policy" {
  source  = "GoogleCloudPlatform/cloud-armor/google"
  version = "8.1.0"

  count = var.cloud_armor_id == "" ? 0 : 1

  project_id                           = var.project_id
  name                                 = var.cloud_armor_id
  default_rule_action                  = "allow"
  type                                 = "CLOUD_ARMOR"
  layer_7_ddos_defense_enable          = true
  layer_7_ddos_defense_rule_visibility = "STANDARD"

  pre_configured_rules = {
    "sqli" = {
      priority          = 1
      action            = "deny(502)"
      target_rule_set   = "sqli-v422-stable"
      sensitivity_level = 4
      preview           = true
    }
    "xss" = {
      priority          = 2
      action            = "deny(502)"
      target_rule_set   = "xss-v422-stable"
      sensitivity_level = 2
      preview           = true
    }
    "lfi" = {
      priority          = 3
      action            = "deny(502)"
      target_rule_set   = "lfi-v422-stable"
      sensitivity_level = 2
      preview           = true
    }
    "rfi" = {
      priority          = 4
      action            = "deny(502)"
      target_rule_set   = "rfi-v422-stable"
      sensitivity_level = 2
      preview           = true
    }
    "rce" = {
      priority          = 5
      action            = "deny(502)"
      target_rule_set   = "rce-v422-stable"
      sensitivity_level = 3
      preview           = true
    }
    "methodenforcement" = {
      priority          = 6
      action            = "deny(502)"
      target_rule_set   = "methodenforcement-v422-stable"
      sensitivity_level = 1
      preview           = true
    }
    "scannerdetection" = {
      priority          = 7
      action            = "deny(502)"
      target_rule_set   = "scannerdetection-v422-stable"
      sensitivity_level = 2
    }
    "protocolattack" = {
      priority          = 8
      action            = "deny(502)"
      target_rule_set   = "protocolattack-v422-stable"
      sensitivity_level = 4
      preview           = true
    }
    "sessionfixation" = {
      action            = "deny(502)"
      priority          = 9
      target_rule_set   = "sessionfixation-v422-stable"
      sensitivity_level = 1
      preview           = true
    }
    "java" = {
      action            = "deny(502)"
      priority          = 10
      target_rule_set   = "java-v422-stable"
      sensitivity_level = 4
      preview           = true
    }
    "generic" = {
      action            = "deny(502)"
      priority          = 11
      target_rule_set   = "generic-v422-stable"
      sensitivity_level = 2
      preview           = true
    }
  }
}
