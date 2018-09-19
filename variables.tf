variable "name_prefix" {
  description = "Cluster Name"
}

variable "name_format" {
  description = "printf style format for naming the ELB. Gets truncated to 32 characters. (input cluster_name)"
  default     = "%s-master-forwarding-rule"
}

variable "masters_self_link" {
  description = "List of master instances self links"
  type        = "list"
  default     = []
}

variable "additional_rules" {
  description = "Additional list of rules. These Rules are an additon to the default rules."
  default     = []
}
