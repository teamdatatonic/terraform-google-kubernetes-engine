## Secured Google kubernetes Engine 



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| google-beta | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gke\_config | map of GKE configs. | `any` | n/a | yes |
| network\_name | (Optional) The name or self\_link of the Google Compute Engine network to which the cluster is connected. For Shared VPC, set this to the self link of the shared network. | `string` | n/a | yes |
| node\_count | (Optional) The number of nodes per instance group. | `number` | `3` | no |
| project\_id | The ID of the project where the GKE will be created | `string` | n/a | yes |
| region | Region where the cluster reside. | `string` | n/a | yes |
| subnet\_name | (Optional) The name or self\_link of the Google Compute Engine subnetwork in which the cluster's instances are launched. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | an identifier for the GKE resource with format projects/{{project}}/locations/{{zone}}/clusters/{{name}} |
| cluster\_name | n/a |
| cluster\_self\_link | The server-defined URL for the GKE resource. |
| endpoint | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
