output "ip_address" {
  description = "IP Address of master load balancer"
  value       = "${module.dcos-forwarding-rule-masters.ip_address}"
}
