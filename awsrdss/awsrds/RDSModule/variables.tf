variable "name" {
  description = "The name of the rds, this name must be unique for each rds created."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.name))
    error_message = "ERROR: Name can include only [a-z0-9-]."
  }
}

variable "additional_tags" {
  description = "Additional tags that you can assign to the resource."
  type        = map(string)
  default     = {}
}

variable "maintainer" {
  description = "The maintainer of the service or application utilizing this resource. This MUST be the same for all resources you create."
  type        = string
}

variable "product" {
  description = "The name of the product that is utilizing this resource."
  type        = string
}

variable "environment" {
  description = "The environment in which this resource needs to be created. This should be 'terraform.workspace'. Accepted values [lab, wip, stg, prd, pci, devops, sandbox]."
  type        = string
  validation {
    # `default` is only for ci to run terraform validate
    condition     = can(regex("default|lab|wip|stg|prd|pci|devops|sandbox", var.environment))
    error_message = "ERROR: Environment value must be one of [lab, wip, stg, prd, pci, devops, sandbox]."
  }
}

variable "data_classification" {
  description = "The sensitivity level (data_classification) for information assets based on the appropriate audience for the information. MUST be one of: restricted, confidential, internal_use, public."
  type        = string
  validation {
    condition     = can(regex("restricted|confidential|internal_use|public", var.data_classification))
    error_message = "ERROR: Data Classification must be restricted or confidential or internal_use or public."
  }
}

variable "db_name" {
  description = "The name of the database."
  type        = string
  validation {
    condition     = can(regex("^[a-z]+$", var.db_name))
    error_message = "ERROR: DBName can contain only lowercase letters."
  }
}

variable "engine_version" {
  description = "The engine version to use."
  type        = string
  validation {
    condition     = var.engine_version > 12
    error_message = "ERROR: postgres version should be greater than 12."
  }
}

variable "instance_class" {
  description = "The instance type of the writer RDS instance in the cluster."
  type        = string
}

variable "maintenance_window" {
  description = "The window to perform maintenance. Time is in UTC, should be in this pattern Mon:07:00-Mon:10:00."
}

variable "readonly_instance_count" {
  description = "The number of read-only instances of the database to spin up. Note that if primary fails, this may still be promoted to writer. Increase the instance_count variable to prevent this. Default 0."
  type        = number
  default     = 0
}

variable "instance_count" {
  description = "The number of instances of the database to spin up. Default 1."
  type        = number
  default     = 1
}

variable "readonly_instance_class" {
  description = "The instance class for the RDS database for read-only instances. Allowed aurora instance types: https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.DBInstanceClass.html"
  type        = string
}
