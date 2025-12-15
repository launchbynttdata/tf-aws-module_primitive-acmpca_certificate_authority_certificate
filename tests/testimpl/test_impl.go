package testimpl

import (
	"context"
	"regexp"
	"testing"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/acmpca"
	"github.com/gruntwork-io/terratest/modules/terraform"
	testTypes "github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestComposableComplete(t *testing.T, ctx testTypes.TestContext) {
	// Get AWS ACM PCA client to verify certificate authority certificate
	acmpcaClient := GetAWSACMPCAClient(t)

	// Get outputs from Terraform
	certificateAuthorityArn := terraform.Output(t, ctx.TerratestTerraformOptions(), "certificate_authority_arn")
	certificate := terraform.Output(t, ctx.TerratestTerraformOptions(), "certificate")
	id := terraform.Output(t, ctx.TerratestTerraformOptions(), "id")

	// Certificate chain is optional - use OutputMap to safely retrieve it
	outputs := terraform.OutputAll(t, ctx.TerratestTerraformOptions())
	certificateChain := ""
	if val, ok := outputs["certificate_chain"]; ok && val != nil {
		if strVal, isString := val.(string); isString {
			certificateChain = strVal
		}
	}

	t.Run("TestCertificateAuthorityArnValid", func(t *testing.T) {
		testCertificateAuthorityArnValid(t, certificateAuthorityArn)
	})

	t.Run("TestCertificateValid", func(t *testing.T) {
		testCertificateValid(t, certificate)
	})

	t.Run("TestIdMatchesCertificateAuthorityArn", func(t *testing.T) {
		testIdMatchesCertificateAuthorityArn(t, id, certificateAuthorityArn)
	})

	t.Run("TestCertificateAuthorityStatus", func(t *testing.T) {
		testCertificateAuthorityStatus(t, acmpcaClient, certificateAuthorityArn)
	})

	t.Run("TestCertificateMatchesAWS", func(t *testing.T) {
		testCertificateMatchesAWS(t, acmpcaClient, certificateAuthorityArn, certificate, certificateChain)
	})
}

func testCertificateAuthorityArnValid(t *testing.T, arn string) {
	assert.NotEmpty(t, arn, "Certificate Authority ARN should not be empty")

	// Verify it's a valid ACM PCA ARN format
	matched, _ := regexp.MatchString(`^arn:aws:acm-pca:[a-z0-9-]+:\d{12}:certificate-authority/[a-f0-9-]+$`, arn)
	assert.True(t, matched, "Certificate Authority ARN should match expected format")
}

func testCertificateValid(t *testing.T, certificate string) {
	assert.NotEmpty(t, certificate, "Certificate should not be empty")

	// Verify it's a PEM-encoded certificate
	assert.Contains(t, certificate, "-----BEGIN CERTIFICATE-----", "Certificate should be PEM-encoded")
	assert.Contains(t, certificate, "-----END CERTIFICATE-----", "Certificate should be PEM-encoded")
}

func testIdMatchesCertificateAuthorityArn(t *testing.T, id string, arn string) {
	// For aws_acmpca_certificate_authority_certificate, the ID is the same as the certificate_authority_arn
	assert.Equal(t, arn, id, "ID should match the Certificate Authority ARN")
}

func testCertificateAuthorityStatus(t *testing.T, client *acmpca.Client, arn string) {
	// Get the Certificate Authority details from AWS
	describeCaOutput, err := client.DescribeCertificateAuthority(context.TODO(), &acmpca.DescribeCertificateAuthorityInput{
		CertificateAuthorityArn: aws.String(arn),
	})
	require.NoError(t, err, "Failed to describe Certificate Authority")

	// Verify the CA exists and has a certificate installed
	assert.NotNil(t, describeCaOutput.CertificateAuthority, "Certificate Authority should exist")
	assert.NotNil(t, describeCaOutput.CertificateAuthority.Status, "Certificate Authority should have a status")

	// The CA should be ACTIVE if the certificate is properly installed
	assert.Equal(t, "ACTIVE", string(describeCaOutput.CertificateAuthority.Status), "Certificate Authority should be ACTIVE after certificate installation")
}

func testCertificateMatchesAWS(t *testing.T, client *acmpca.Client, arn string, certificate string, certificateChain string) {
	// Get the Certificate Authority certificate from AWS
	getCaCertOutput, err := client.GetCertificateAuthorityCertificate(context.TODO(), &acmpca.GetCertificateAuthorityCertificateInput{
		CertificateAuthorityArn: aws.String(arn),
	})
	require.NoError(t, err, "Failed to get Certificate Authority certificate from AWS")

	// Verify the certificate from Terraform matches what's in AWS
	assert.NotNil(t, getCaCertOutput.Certificate, "Certificate should exist in AWS")
	assert.Equal(t, certificate, *getCaCertOutput.Certificate, "Certificate from Terraform should match AWS")

	// Handle certificate chain validation
	if certificateChain != "" {
		// Certificate chain was provided in Terraform - verify it exists and matches in AWS
		assert.NotNil(t, getCaCertOutput.CertificateChain, "Certificate chain should exist in AWS when provided")
		assert.Equal(t, certificateChain, *getCaCertOutput.CertificateChain, "Certificate chain from Terraform should match AWS")
	} else {
		// Certificate chain was not provided - verify it doesn't exist in AWS or is empty
		if getCaCertOutput.CertificateChain != nil {
			assert.Empty(t, *getCaCertOutput.CertificateChain, "Certificate chain should be empty in AWS when not provided")
		}
	}
}

func GetAWSACMPCAClient(t *testing.T) *acmpca.Client {
	awsACMPCAClient := acmpca.NewFromConfig(GetAWSConfig(t))
	return awsACMPCAClient
}

func GetAWSConfig(t *testing.T) (cfg aws.Config) {
	cfg, err := config.LoadDefaultConfig(context.TODO())
	require.NoErrorf(t, err, "unable to load SDK config, %v", err)
	return cfg
}
