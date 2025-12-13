# Simple Example

This example demonstrates minimal usage of the `tf-aws-module_primitive-acmpca_certificate_authority_certificate` module by creating a test Certificate Authority and installing a certificate on it.

## Features

- Creates a test Root Certificate Authority
- Issues a certificate for the Certificate Authority
- Installs the certificate on the CA using the module
- Demonstrates the complete CA setup workflow

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
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

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate"></a> [certificate](#output\_certificate) | PEM-encoded certificate for the Certificate Authority |
| <a name="output_certificate_authority_arn"></a> [certificate\_authority\_arn](#output\_certificate\_authority\_arn) | ARN of the Certificate Authority |
| <a name="output_certificate_chain"></a> [certificate\_chain](#output\_certificate\_chain) | PEM-encoded certificate chain |
| <a name="output_id"></a> [id](#output\_id) | ARN of the certificate |
<!-- END_TF_DOCS -->
