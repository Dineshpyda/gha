
output "arn_rdsaurora" {
  description = "ARN from rds.tf aws_rds_cluster.rdsaurora"
  value = module.rds.cluster_arn
}