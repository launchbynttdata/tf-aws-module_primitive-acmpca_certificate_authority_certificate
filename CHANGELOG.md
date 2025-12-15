# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial implementation of `aws_acmpca_certificate_authority_certificate` primitive module
- Added all required variables: `certificate`, `certificate_authority_arn`
- Added optional variable: `certificate_chain`
- Added outputs: `certificate`, `certificate_authority_arn`, `certificate_chain`, `id`
  - Outputs normalize empty strings to `null` for idempotency
- Created simple example demonstrating minimal usage with test Certificate Authority
  - Example includes configurable test CA parameters: `certificate_authority_type`, `key_algorithm`, `signing_algorithm`, `subject_common_name`
  - Example includes configurable certificate parameters: `template_arn`, `validity_type`, `validity_value`
  - All parameters exposed via `test.tfvars` for easy testing of different configurations
- Implemented comprehensive test coverage using AWS ACM PCA SDK
  - Tests verify certificate installation, CA status, and resource properties
  - Tests handle optional `certificate_chain` output gracefully
  - Tests validate actual AWS resource state matches Terraform configuration

### Changed

- Updated from template placeholder to actual ACM PCA certificate authority certificate resource
- Configured module to follow primitive module conventions per copilot-instructions.md
