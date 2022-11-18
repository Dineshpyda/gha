###
# Locals
# @link https://www.terraform.io/docs/configuration/locals.html
###

locals {
  default_tags = {
    "Owner"               = var.maintainer
    "Product"             = var.product
    "Team"                = var.maintainer
    "Environment"         = var.environment
    "data_classification" = var.data_classification
    "tf_module"           = "ShopRunner/terraform-aws-rds-aurora-postgres"
  }

  backup_retention_map = {
    "prd"    = 30
    "pci"    = 30
    "stg"    = 14
    "devops" = 30
  }

  // defaults to 3 days
  backup_retention = lookup(local.backup_retention_map, var.environment, 3)

  skip_final_snapshot_map = {
    "prd"    = false
    "pci"    = false
    "devops" = false
  }

  // defaults to true
  skip_final_snapshot = lookup(local.skip_final_snapshot_map, var.environment, true)

  multi_az_map = {
    "prd"    = true
    "pci"    = true
    "devops" = true
  }

  // defaults to false
  multi_az = lookup(local.multi_az_map, var.environment, false)

}

