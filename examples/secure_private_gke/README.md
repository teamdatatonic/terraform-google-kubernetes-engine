<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.5 |
| google | ~> 3.55 |
| google-beta | ~> 3.55 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment\_prefix | The GCP envioment where the cluster will be created. | `string` | `"dev"` | no |
| gke\_config | Maps of GKE configurations. | `any` | n/a | yes |
| gke\_network\_name | The name of the network being created. | `string` | `"example-usage-vpc"` | no |
| project\_id | The ID of the project where the GKE will be created | `string` | n/a | yes |
| region | (Optional) The region in  which the cluster master will be created, as well as the node pool location. | `string` | `"europe-west2"` | no |
| routing\_mode | The network routing mode (default 'REGIONAL'). | `string` | `"REGIONAL"` | no |
| secure\_subnet | The list of subnets to be created. | `any` | <pre>[<br>  {<br>    "enable_logs": false,<br>    "subnet_ip": "192.168.0.0/20",<br>    "subnet_name": "secure-subnet-gke",<br>    "subnet_region": "europe-west2"<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | an identifier for the GKE resource with format projects/{{project}}/locations/{{zone}}/clusters/{{name}}. |
| cluster\_name | The name of the cluster, unique within the project and location. |
| cluster\_self\_link | The server-defined URL for the GKE resource. |
| endpoint | The IP address of this cluster's Kubernetes master. |
| node\_pool\_sa\_email | The node pool service account email. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
