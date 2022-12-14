package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformAwsRds(t *testing.T) {
	t.Parallel()
	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../awsrds",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "arn_rdsaurora")
	assert.Equal(t, "arn:aws:rds:us-east-2:459539156751:cluster:rdsmoduleinstance1", output)
}
