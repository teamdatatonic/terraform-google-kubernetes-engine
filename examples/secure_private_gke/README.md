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
| environment\_prefix | n/a | `string` | `"dev"` | no |
| gke\_config | n/a | `any` | n/a | yes |
| gke\_network\_name | n/a | `string` | `"example-usage-vpc"` | no |
| project\_id | The ID of the project where the GKE will be created | `any` | n/a | yes |
| region | n/a | `string` | `"europe-west2"` | no |
| routing\_mode | n/a | `string` | `"REGIONAL"` | no |
| secure\_subnet | n/a | `any` | <pre>[<br>  {<br>    "enable_logs": false,<br>    "subnet_ip": "192.168.0.0/20",<br>    "subnet_name": "secure-subnet-gke",<br>    "subnet_region": "europe-west2"<br>  }<br>]</pre> | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
