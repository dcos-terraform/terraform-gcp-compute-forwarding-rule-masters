/**
 * GCP Forwarding Rule - Masters
 * ============
 * This module creates an GCP forwarding rule for DC/OS masters. The default ports are `80` and `443`. Also a default healthcheck is applied.
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "dcos-forwarding-rule-masters" {
 *   source  = "dcos-terraform/compute-forwarding-rule-masters/gcp"
 *   version = "~> 0.2.0"
 *
 *   cluster_name = "production"
 *
 *   masters_self_link = [${"module.masters.instances_self_link"}]
 * }
 *```
 */

provider "google" {}

locals {
  // 443 and 80 are automatically enabled in `dcos-terraform/compute-forwarding-rule/gcp` module
  default_rules = [
    {
      port_range            = "${var.adminrouter_grpc_proxy_port}"
      load_balancing_scheme = "EXTERNAL"
      ip_protocol           = "TCP"
    },
  ]

  concat_rules = ["${concat(local.default_rules,var.additional_rules)}"]
}

module "dcos-forwarding-rule-masters" {
  source  = "dcos-terraform/compute-forwarding-rule/gcp"
  version = "~> 0.2.0"

  cluster_name = "${var.cluster_name}"

  instances_self_link = ["${var.masters_self_link}"]
  name_format         = "${var.name_format}"
  disable             = "${var.disable}"
  name_prefix         = "${var.name_prefix}"

  additional_rules = ["${local.concat_rules}"]

  health_check {
    target = "/"
    port   = "5050"
  }

  labels = "${var.labels}"

  providers = {
    google = "google"
  }
}
