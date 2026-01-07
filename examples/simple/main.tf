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

# Create a Certificate Authority for testing
resource "aws_acmpca_certificate_authority" "test" {
  type = var.certificate_authority_type

  certificate_authority_configuration {
    key_algorithm     = var.key_algorithm
    signing_algorithm = var.signing_algorithm

    subject {
      common_name = var.subject_common_name
    }
  }
}

# Issue a certificate for the CA
resource "aws_acmpca_certificate" "test" {
  certificate_authority_arn   = aws_acmpca_certificate_authority.test.arn
  certificate_signing_request = aws_acmpca_certificate_authority.test.certificate_signing_request
  signing_algorithm           = var.signing_algorithm

  template_arn = var.template_arn

  validity {
    type  = var.validity_type
    value = var.validity_value
  }
}

# Use the module to install the certificate on the Certificate Authority
module "certificate_authority_certificate" {
  source = "../../"

  certificate_authority_arn = local.certificate_authority_arn
  certificate               = local.certificate
  certificate_chain         = local.certificate_chain
}
