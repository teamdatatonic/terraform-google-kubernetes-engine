# Terraform Private Google Kubernetes Engine (GKE) Resource Module

This repo contains Terraform resource modules for running a Hardened Kuberenetes cluster on Google Cloud Platform built in accordance to [Hardening your cluster's security docs by Google](https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster).

 
## Prerequisites 
- Terraform 0.14+ ([tfswitch](https://warrensbox.github.io/terraform-switcher/) is the best way to install/manage)
- [Pre-commit](https://pre-commit.com/) 
- [commitizen](https://github.com/commitizen/cz-cli)

### Local Setup 
- install pre-commit: `brew install pre-commit`.
- install the git hook scripts: `pre-commit install`.

## Usage
You can go to the examples folder for module usage, the usage of the resource modules could be like this in your own main.tf file:

```hcl
module "secure_private_cluster" {
    source  = "teamdatatonic/terraform-google-kubernetes-engine"
    version = "1.0.0"

    project_id = "<PROJECT ID>"
    region     = "europe-west1"
    environment_prefix = "dev"
    gke_config         = {
        name_suffix = "example-gke-name"
        release_channel = "STABLE"
        enable_private_nodes = true
        enable_private_endpoint = false 
        node_pool_config = {
            standard-pool-name-as-key = {
                machine_type = e2-medium
                autoscaling  = true
                min_node_count = 1
                max_node_count = 3
                preemptible    = true
            },
            second-node-pool-name-as-key = {
            standard-pool-name-as-key = {
                machine_type = e2-medium
                autoscaling  = false
            }
        }

    }
    gke_network_name   = "example-vpc-name"
    secure_subnet      = [
    {
      subnet_name   = "secure-subnet-gke",
      subnet_ip     = "192.168.0.0/20",
      subnet_region = "europe-west2",
      enable_logs   = false
    }
    ]
}
```

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
| environment\_prefix | The GCP envioment where the cluster will be created. | `string` | n/a | yes |
| gke\_config | Maps of GKE configurations. | `any` | n/a | yes |
| gke\_network\_name | The name of the network being created. | `string` | n/a | yes |
| project\_id | The ID of the project where the GKE will be created. | `string` | n/a | yes |
| region | (Optional) The region in  which the cluster master will be created, as well as the node pool location. | `string` | n/a | yes |
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

### Contributing 
This repository enforces using [commitizen](https://github.com/commitizen/cz-cli) to structure the git commit messages  
- `git add`
- `git cz`
