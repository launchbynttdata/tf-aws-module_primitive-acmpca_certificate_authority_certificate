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
- Created simple example demonstrating minimal usage with test Certificate Authority
- Implemented comprehensive test coverage using AWS ACM PCA SDK
- Tests verify certificate installation, CA status, and resource properties

### Changed

- Updated from template placeholder to actual ACM PCA certificate authority certificate resource
- Configured module to follow primitive module conventions per copilot-instructions.md
