package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/gcp"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"gotest.tools/assert"
)

func TestSecurePrivateCluster(t *testing.T) {
	t.Parallel()

	project_id := gcp.GetGoogleProjectIDFromEnvVar(t)
	terraformDir := "../examples/secure_private_gke"

	tf_vars := []string{"variables.auto.tfvars.json"}

	terraformOptions := &terraform.Options{
		VarFiles:     tf_vars,
		TerraformDir: terraformDir,
		Vars: map[string]interface{}{
			"project_id": project_id,
		},
		EnvVars: map[string]string{
			"GOOGLE_CLOUD_PROJECT": project_id,
		},
	}
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
	gke_output_name := terraform.Output(t, terraformOptions, "cluster_name")
	gke_output_name_expected := "datatonic-devops-play-gke-example"
	assert.Equal(t, gke_output_name_expected, gke_output_name)
}
