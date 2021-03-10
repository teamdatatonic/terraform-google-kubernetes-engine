## Sandbox GKE Cluster - Example Usage 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment\_prefix | The GCP envioment where the cluster will be created. | `string` | `"dev"` | no |
| gke\_config | Maps of GKE configurations. | `any` | n/a | yes |
| gke\_network\_name | The name of the network being created. | `string` | n/a | yes |
| project\_id | The ID of the project where the GKE will be created. | `string` | n/a | yes |
| region | (Optional) The region in  which the resources will be created. | `string` | `"europe-west2"` | no |
| routing\_mode | The network routing mode (default 'REGIONAL'). | `string` | `"REGIONAL"` | no |
| subnets | The list of subnets to be created. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | an identifier for the GKE resource with format projects/{{project}}/locations/{{zone}}/clusters/{{name}}. |
| cluster\_name | The name of the cluster, unique within the project and location. |
| cluster\_self\_link | The server-defined URL for the GKE resource. |
| endpoint | The IP address of this cluster's Kubernetes master. |
| node\_pool\_sa\_email | The node pool service account email. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
