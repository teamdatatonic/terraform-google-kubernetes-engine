## Private Google kubernetes Engine 


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.5 |
| google | ~> 3.55 |
| google-beta | ~> 3.55 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.55 |
| google-beta | ~> 3.55 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gke\_config | Maps of GKE configurations. | `any` | n/a | yes |
| gke\_project\_iam | The list of roles to assign to the gke service account. | `list(string)` | `null` | no |
| network\_name | The name of the network being created. | `string` | n/a | yes |
| project\_id | The ID of the project where the GKE will be created. | `string` | n/a | yes |
| region | Region where the resources will be created. | `string` | n/a | yes |
| subnet\_name | The list of subnets to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | an identifier for the GKE resource with format projects/{{project}}/locations/{{zone}}/clusters/{{name}}. |
| cluster\_name | The name of the cluster, unique within the project and location. |
| cluster\_self\_link | The server-defined URL for the GKE resource. |
| endpoint | The IP address of this cluster's Kubernetes master. |
| node\_pool\_sa\_email | The node pool service account email. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
