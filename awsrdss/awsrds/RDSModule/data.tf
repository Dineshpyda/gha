data "aws_security_group" "rds_access" {
  name = "rds-access-${var.environment}"
}

data "aws_route53_zone" "shoprunner-io-private" {
  name         = "${var.environment}.shoprunner.io."
  private_zone = true
}

data "aws_route53_zone" "shoprunner-io-public" {
  name         = "${var.environment}.shoprunner.io."
  private_zone = false
}
