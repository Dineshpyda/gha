resource "aws_route53_record" "rds-private" {
  zone_id = data.aws_route53_zone.shoprunner-io-private.id
  name    = "rds-${replace(var.name, "-${var.environment}", "")}.${var.environment}.shoprunner.io"
  type    = "CNAME"
  ttl     = "3600"
  records = [aws_rds_cluster.rdsaurora.endpoint]
}

resource "aws_route53_record" "rds-public" {
  zone_id = data.aws_route53_zone.shoprunner-io-public.id
  name    = "rds-${replace(var.name, "-${var.environment}", "")}.${var.environment}.shoprunner.io"
  type    = "CNAME"
  ttl     = "3600"
  records = [aws_rds_cluster.rdsaurora.endpoint]
}

resource "aws_route53_record" "rds-ro-private" {
  zone_id = data.aws_route53_zone.shoprunner-io-private.id
  name    = "rds-${replace(var.name, "-${var.environment}", "")}-ro.${var.environment}.shoprunner.io"
  type    = "CNAME"
  ttl     = "3600"
  records = [aws_rds_cluster.rdsaurora.reader_endpoint]
}

resource "aws_route53_record" "rds-ro-public" {
  zone_id = data.aws_route53_zone.shoprunner-io-public.id
  name    = "rds-${replace(var.name, "-${var.environment}", "")}-ro.${var.environment}.shoprunner.io"
  type    = "CNAME"
  ttl     = "3600"
  records = [aws_rds_cluster.rdsaurora.reader_endpoint]
}
