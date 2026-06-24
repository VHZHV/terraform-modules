locals {
  waf_rules = [
    "sqli-v422-stable",
    "xss-v422-stable",
    "lfi-v422-stable",
    "rfi-v422-stable",
    "rce-v422-stable",
    "methodenforcement-v422-stable",
    "scannerdetection-v422-stable",
    "protocolattack-v422-stable",
    "sessionfixation-v422-stable",
    "java-v422-stable",
    "generic-v422-stable",
  ]
}

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
  json_parsing                         = "STANDARD"

  pre_configured_rules = {
    for idx, rule in local.waf_rules : split(",", rule)[0] => {
      target_rule_set         = rule
      priority                = idx
      action                  = "deny(502)"
      sensitivity_level       = 4
      preview                 = true
      exclude_target_rule_ids = compact([for ignored in var.ignored_rules : (endswith(ignored, split(",", rule)[0]) ? ignored : "")])
    }
  }
}
