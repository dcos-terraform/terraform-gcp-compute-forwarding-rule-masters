GCP Forwarding Rule - Masters
============
This module creates an GCP forwarding rule for DC/OS masters. The default ports are `80` and `443`. Also a default healthcheck is applied.

EXAMPLE
-------

```hcl
module "dcos-forwarding-rule-masters" {
  source  = "dcos-terraform/compute-forwarding-rule-masters/gcp"
  version = "~> 0.2.0"

  cluster_name = "production"

  masters_self_link = [${"module.masters.instances_self_link"}]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster\_name | Name of the DC/OS cluster | string | n/a | yes |
| additional\_rules | List of additional rules | list | `<list>` | no |
| labels | Add custom labels to all resources | map | `<map>` | no |
| masters\_self\_link | List of master instances self links | list | `<list>` | no |
| name\_format | printf style format for naming the ELB. Gets truncated to 32 characters. (input cluster_name) | string | `"m-%s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| ip\_address | Load balancer ip address |

