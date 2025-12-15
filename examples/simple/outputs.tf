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

output "certificate" {
  description = "PEM-encoded certificate for the Certificate Authority"
  value       = module.certificate_authority_certificate.certificate
}

output "certificate_authority_arn" {
  description = "ARN of the Certificate Authority"
  value       = module.certificate_authority_certificate.certificate_authority_arn
}

output "certificate_chain" {
  description = "PEM-encoded certificate chain"
  value       = module.certificate_authority_certificate.certificate_chain
}

output "id" {
  description = "Certificate Authority ARN (same as certificate_authority_arn)"
  value       = module.certificate_authority_certificate.id
}
