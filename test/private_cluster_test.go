package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/gcp"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

type GkeConfig struct {
	NameSuffix            string         `json:"name_suffix"`
	ReleaseChannel        string         `json:"release_channel"`
	EnablePrivateNodes    bool           `json:"enable_private_nodes"`
	EnablePrivateEndpoint bool           `json:"enable_private_endpoint"`
	DataBaseEncryption    bool           `json:"db_encrypt"`
	Gke_labels            Gke_labels     `json:"gke_labels"`
	NodePoolConfig        NodePoolConfig `json:"node_pool_config"`
}

type Gke_labels struct {
	GkeEnv string `json:"gke-env"`
}

type NodePoolConfig struct {
	StandardPool StandardPool `json:"standard-pool"`
}
type StandardPool struct {
	MachineType  string `json:"machine_type"`
	Location     string `json:"location"`
	Autoscaling  bool   `json:"autoscaling"`
	MinNodeCount int    `json:"min_node_count"`
	MaxNodeCount int    `json:"max_node_count"`
	Preemptible  bool   `json:"preemptible"`
}

func TestSecurePrivateCluster(t *testing.T) {
	t.Parallel()

	project_id := gcp.GetGoogleProjectIDFromEnvVar(t)
	gke_network_name := "testing-secure-cluster"
	terraformDir := "../examples/secure_private_gke"

	//var config, _ = json.Marshal(init_config)

	terraformOptions := &terraform.Options{

		TerraformDir: terraformDir,

		Vars: map[string]interface{}{
			"project_id":       project_id,
			"gke_network_name": gke_network_name,
			"gke_config": map[string]interface{}{
				"name_suffix":     "name",
				"release_channel": "release",
				"db_encrypt":      false,
				"gke_labels": map[string]string{
					"gke-env": "dev",
				},
				"enable_private_nodes":    true,
				"enable_private_endpoint": false,
				"node_pool_config": map[string]interface{}{
					"standard-pool": map[string]interface{}{
						"machine_type":   "e2-medium",
						"location":       "europe-west2-b",
						"autoscaling":    true,
						"min_node_count": 1,
						"max_node_count": 3,
						"preemptible":    true,
					},
				},
			},
		},
		EnvVars: map[string]string{
			"GOOGLE_CLOUD_PROJECT": project_id,
		},
	}
	//defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndPlan(t, terraformOptions)
	//gke_output_name := terraform.Output(t, terraformOptions, "cluster_name")
	//	gke_output_name_expected := "gke-secure-example"
	//assert.Equal(t, gke_output_name_expected, gke_output_name)
}
