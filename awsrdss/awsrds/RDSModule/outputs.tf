output "cluster_address" {
  description = "The hostname of the RDS cluster."
  value       = aws_rds_cluster.rdsaurora.endpoint
}

output "cluster_arn" {
  description = "The ARN of the RDS cluster."
  value       = aws_rds_cluster.rdsaurora.arn
}

output "cluster_cname" {
  description = "The CNAME of the RDS cluster."
  value       = aws_route53_record.rds-public.name
}

output "cluster_ro_address" {
  description = "The hostname of the read only cluster endpoint."
  value       = aws_rds_cluster.rdsaurora.reader_endpoint
}

output "cluster_ro_cname" {
  description = "The CNAME of the read only cluster."
  value       = aws_route53_record.rds-ro-public.name
}
