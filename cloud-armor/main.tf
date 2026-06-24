locals {
  waf_rules = [
    { target_rule_set = "xss-v422-stable", sensitivity_level = 1 },
    { target_rule_set = "lfi-v422-stable", sensitivity_level = 4 },
    { target_rule_set = "rfi-v422-stable", sensitivity_level = 4 },
    { target_rule_set = "rce-v422-stable", sensitivity_level = 1 },
    { target_rule_set = "scannerdetection-v422-stable", sensitivity_level = 4 },
    { target_rule_set = "protocolattack-v422-stable", sensitivity_level = 2 },
    { target_rule_set = "sessionfixation-v422-stable", sensitivity_level = 4 },
    { target_rule_set = "java-v422-stable", sensitivity_level = 4 },
    { target_rule_set = "generic-v422-stable", sensitivity_level = 4 },
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
    for idx, rule in local.waf_rules : split(",", rule.target_rule_set)[0] => {
      target_rule_set         = rule.target_rule_set
      priority                = idx
      action                  = "deny(502)"
      sensitivity_level       = rule.sensitivity_level
      preview                 = true
      exclude_target_rule_ids = compact([for ignored in var.ignored_rules : (endswith(ignored, split(",", rule.target_rule_set)[0]) ? ignored : "")])
    }
  }
}
