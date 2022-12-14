terraform {
  required_version = ">= 0.12"
  #experiments      = [variable_validation]
}

# Please add the provider configuration in application root directory when using the module.
# provider "aws" {
#   version = "~> 3.0"
#   region  = "us-east-1"
# }

module "rds" {

  source = "./RDSModule"

  name                    = var.rds_name
  additional_tags         = var.add_tags
  maintainer              = var.maintainer_service
  product                 = var.product_name
  environment             = var.env_workspace
  data_classification     = var.data_class
  db_name                 = var.database_name
  engine_version          = var.eng_version
  instance_class          = var.inst_class
  maintenance_window      = var.maint_window
  readonly_instance_count = var.ro_instance_count
  instance_count          = var.instance_ct
  readonly_instance_class = var.ro_instance_class

}