# trivy:ignore:avd-gcp-0056 - Require this to be able to get artifacts from the registry
# trivy:ignore:avd-gcp-0057 - This is a false positive, as this does end up using GKE_METADATA
# trivy:ignore:avd-gcp-0059 - We want this cluster to have services that can be accessed from the internet
# trivy:ignore:avd-gcp-0061 - We want this in case someone on support needs to access the cluster
# trivy:ignore:avd-gcp-0050 - False positive, as we do generate a minimal service account for the nodes
module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "42.0.0"

  project_id = var.project_id
  name       = var.cluster_name

  regional = var.cluster_regional
  region   = var.region
  zones    = var.cluster_zones

  network           = var.network_name
  subnetwork        = var.subnet_name
  ip_range_pods     = var.ip_range_pods_name
  ip_range_services = var.ip_range_services_name

  enable_cost_allocation   = true
  deletion_protection      = var.deletion_protection
  remove_default_node_pool = true

  grant_registry_access = true
  release_channel       = "RAPID"
  registry_project_ids  = ["hozah-artifacts"]

  node_pools = [
    {
      name            = "default-node-pool"
      disk_size_gb    = 20
      strategy        = "SURGE"
      max_surge       = 0
      max_unavailable = 1
      min_count       = 0
      max_count       = 100
      autoscaling     = var.cluster_autoscaling_enabled
    }
  ]

  enable_vertical_pod_autoscaling = true
  horizontal_pod_autoscaling      = true
  gateway_api_channel             = "CHANNEL_STANDARD"
  cluster_autoscaling = {
    enabled             = var.cluster_autoscaling_enabled
    autoscaling_profile = var.cluster_autoscaling_profile
    min_cpu_cores       = 0
    max_cpu_cores       = var.cluster_max_cpu_cores
    min_memory_gb       = 0
    max_memory_gb       = var.cluster_max_memory_gb
    auto_repair         = true
    auto_upgrade        = true
    strategy            = "SURGE"
    max_surge           = 0
    max_unavailable     = 1

    gpu_resources = []
  }

  cluster_resource_labels = {
    type : var.label,
    env : split("-", var.project_id)[1],
  }
}
