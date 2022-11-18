resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!$#%^&*()"
}

resource "aws_rds_cluster" "rdsaurora" {
  cluster_identifier      = var.name
  engine                  = "aurora-postgresql"
  database_name           = var.db_name
  master_username         = "root"
  master_password         = random_password.db_password.result
  backup_retention_period = local.backup_retention
  vpc_security_group_ids  = [data.aws_security_group.rds_access.id]
  db_subnet_group_name    = "default-vpc-188e4473"
  tags                    = merge(local.default_tags, var.additional_tags)
  engine_version          = var.engine_version

  // Don't store snapshot if pre-prd environments
  skip_final_snapshot          = local.skip_final_snapshot
  final_snapshot_identifier    = "${var.name}-final-snapshot"
  copy_tags_to_snapshot        = true
  deletion_protection          = false
  preferred_maintenance_window = var.maintenance_window
  lifecycle {
    ignore_changes = [master_password]
  }
}

// Defines the instances of databases that are part of the cluster.
resource "aws_rds_cluster_instance" "cluster_instance" {
  count                      = var.instance_count
  identifier                 = "${var.name}-${count.index}"
  cluster_identifier         = aws_rds_cluster.rdsaurora.id
  instance_class             = var.instance_class
  engine                     = "aurora-postgresql"
  promotion_tier             = 0
  tags                       = merge(local.default_tags, var.additional_tags)
  auto_minor_version_upgrade = true
}

resource "aws_rds_cluster_instance" "cluster_readonly_replica_instance" {
  count                      = var.readonly_instance_count
  identifier                 = "${var.name}-ro-instance-${count.index}"
  cluster_identifier         = aws_rds_cluster.rdsaurora.id
  instance_class             = var.readonly_instance_class
  engine                     = "aurora-postgresql"
  promotion_tier             = 15
  tags                       = merge(local.default_tags, var.additional_tags)
  auto_minor_version_upgrade = true
}
