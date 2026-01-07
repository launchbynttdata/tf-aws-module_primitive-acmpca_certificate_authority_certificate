# Simple Example

This example demonstrates minimal usage of the `tf-aws-module_primitive-acmpca_certificate_authority_certificate` module by creating a test Certificate Authority and installing a certificate on it.

## Features

- Creates a configurable test Root Certificate Authority
- Issues a certificate for the Certificate Authority
- Installs the certificate on the CA using the module
- Demonstrates the complete CA setup workflow
- All CA and certificate parameters configurable via `test.tfvars`

## Configuration

The example includes variables for configuring the test Certificate Authority:

- **CA Configuration**: `certificate_authority_type`, `key_algorithm`, `signing_algorithm`, `subject_common_name`
- **Certificate Configuration**: `template_arn`, `validity_type`, `validity_value`
- **Module Inputs**: `certificate_authority_arn`, `certificate`, `certificate_chain` (optional)

All values can be customized in `test.tfvars` to test different CA configurations and validity periods.

## Usage

```bash
terraform init
terraform plan -var-file=test.tfvars
terraform apply -var-file=test.tfvars
terraform destroy -var-file=test.tfvars
```

## Resources Created

- 1 ACM Private Certificate Authority (test CA)
- 1 ACM PCA Certificate (for the CA)
- 1 ACM PCA Certificate Authority Certificate (installed via module)

## Notes

This example creates its own test resources for demonstration purposes. In production, you would typically:

1. Have an existing Certificate Authority
2. Issue a certificate for it using `aws_acmpca_certificate`
3. Use this module to install the certificate on the CA

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.100 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_certificate_authority_certificate"></a> [certificate\_authority\_certificate](#module\_certificate\_authority\_certificate) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_acmpca_certificate.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acmpca_certificate) | resource |
| [aws_acmpca_certificate_authority.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acmpca_certificate_authority) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate"></a> [certificate](#input\_certificate) | PEM-encoded certificate for the Certificate Authority | `string` | `""` | no |
| <a name="input_certificate_authority_arn"></a> [certificate\_authority\_arn](#input\_certificate\_authority\_arn) | ARN of the Certificate Authority | `string` | `""` | no |
| <a name="input_certificate_chain"></a> [certificate\_chain](#input\_certificate\_chain) | PEM-encoded certificate chain | `string` | `null` | no |
| <a name="input_certificate_authority_type"></a> [certificate\_authority\_type](#input\_certificate\_authority\_type) | Type of the Certificate Authority | `string` | `"ROOT"` | no |
| <a name="input_key_algorithm"></a> [key\_algorithm](#input\_key\_algorithm) | Key algorithm for the Certificate Authority | `string` | `"RSA_4096"` | no |
| <a name="input_signing_algorithm"></a> [signing\_algorithm](#input\_signing\_algorithm) | Signing algorithm for the Certificate Authority | `string` | `"SHA512WITHRSA"` | no |
| <a name="input_subject_common_name"></a> [subject\_common\_name](#input\_subject\_common\_name) | Common name for the Certificate Authority subject | `string` | `"example.com"` | no |
| <a name="input_template_arn"></a> [template\_arn](#input\_template\_arn) | ARN of the template to use for issuing the certificate | `string` | `"arn:aws:acm-pca:::template/RootCACertificate/V1"` | no |
| <a name="input_validity_type"></a> [validity\_type](#input\_validity\_type) | Type of validity period for the certificate | `string` | `"YEARS"` | no |
| <a name="input_validity_value"></a> [validity\_value](#input\_validity\_value) | Value of validity period for the certificate | `number` | `10` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate"></a> [certificate](#output\_certificate) | PEM-encoded certificate for the Certificate Authority |
| <a name="output_certificate_authority_arn"></a> [certificate\_authority\_arn](#output\_certificate\_authority\_arn) | ARN of the Certificate Authority |
| <a name="output_certificate_chain"></a> [certificate\_chain](#output\_certificate\_chain) | PEM-encoded certificate chain |
| <a name="output_id"></a> [id](#output\_id) | Certificate Authority ARN (same as certificate\_authority\_arn) |
<!-- END_TF_DOCS -->
