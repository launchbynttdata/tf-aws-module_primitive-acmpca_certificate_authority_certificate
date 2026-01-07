// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

variable "certificate" {
  description = "PEM-encoded certificate for the Certificate Authority"
  type        = string
  default     = ""
}

variable "certificate_authority_arn" {
  description = "ARN of the Certificate Authority"
  type        = string
  default     = ""
}

variable "certificate_chain" {
  description = "PEM-encoded certificate chain"
  type        = string
  default     = null
}

variable "certificate_authority_type" {
  description = "Type of the Certificate Authority"
  type        = string
  default     = "ROOT"
}

variable "key_algorithm" {
  description = "Key algorithm for the Certificate Authority"
  type        = string
  default     = "RSA_4096"
}

variable "signing_algorithm" {
  description = "Signing algorithm for the Certificate Authority"
  type        = string
  default     = "SHA512WITHRSA"
}

variable "subject_common_name" {
  description = "Common name for the Certificate Authority subject"
  type        = string
  default     = "example.com"
}

variable "template_arn" {
  description = "ARN of the template to use for issuing the certificate"
  type        = string
  default     = "arn:aws:acm-pca:::template/RootCACertificate/V1"
}

variable "validity_type" {
  description = "Type of validity period for the certificate"
  type        = string
  default     = "YEARS"
}

variable "validity_value" {
  description = "Value of validity period for the certificate"
  type        = number
  default     = 10
}
