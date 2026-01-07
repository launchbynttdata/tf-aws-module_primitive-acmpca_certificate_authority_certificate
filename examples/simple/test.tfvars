# Certificate Authority Configuration
certificate_authority_type = "ROOT"
key_algorithm              = "RSA_4096"
signing_algorithm          = "SHA512WITHRSA"
subject_common_name        = "example.com"

# Certificate Configuration
template_arn   = "arn:aws:acm-pca:::template/RootCACertificate/V1"
validity_type  = "YEARS"
validity_value = 10

# Optional: Provide existing CA and certificate values to override use of test resources.
# IMPORTANT: The test CA and certificate resources are always created, regardless of whether you provide these variables.
# If you provide these variables, the module will use them instead of the test resources, but the test resources will still be created (just not used).
# certificate_authority_arn = "arn:aws:acm-pca:us-east-1:123456789012:certificate-authority/12345678-1234-1234-1234-123456789012"
# certificate = "-----BEGIN CERTIFICATE-----\n...\n-----END CERTIFICATE-----"
# certificate_chain = "-----BEGIN CERTIFICATE-----\n...\n-----END CERTIFICATE-----"
