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

locals {
  # Use the CA ARN from var if provided, otherwise from the test CA
  certificate_authority_arn = var.certificate_authority_arn != "" ? var.certificate_authority_arn : aws_acmpca_certificate_authority.test.arn

  # Use the certificate from var if provided, otherwise from the issued certificate
  certificate = var.certificate != "" ? var.certificate : aws_acmpca_certificate.test.certificate

  # Certificate chain is optional
  certificate_chain = var.certificate_chain
}
