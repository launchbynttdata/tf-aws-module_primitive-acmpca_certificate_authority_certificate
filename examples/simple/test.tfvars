# Certificate Authority Configuration
certificate_authority_type = "ROOT"
key_algorithm              = "RSA_4096"
signing_algorithm          = "SHA512WITHRSA"
subject_common_name        = "example.com"

# Certificate Configuration
template_arn   = "arn:aws:acm-pca:::template/RootCACertificate/V1"
validity_type  = "YEARS"
validity_value = 10

# Optional: Use existing CA and certificate instead of test resources
# If these are provided, the module will use them instead of the test CA resources
# Note: The test CA resources will still be created but won't be used by the module
# certificate_authority_arn = "arn:aws:acm-pca:us-east-1:123456789012:certificate-authority/12345678-1234-1234-1234-123456789012"
# certificate = "-----BEGIN CERTIFICATE-----\n...\n-----END CERTIFICATE-----"
# certificate_chain = "-----BEGIN CERTIFICATE-----\n...\n-----END CERTIFICATE-----"
