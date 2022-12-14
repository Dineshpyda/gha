# Basic Use

``` hcl
module "aurorapostgres" {
  source                  = "github.com/ShopRunner/terraform-aws-rds-aurora-postgres?ref=v1" # please use the latest version
  name                    = "module-example-${terraform.workspace}"
  maintainer              = "TEAM_NAME"
  product                 = "Spinnaker"
  data_classification     = "internal_use"
  environment             = terraform.workspace
  db_name                 = "moduleexample"
  engine_version          = "12.4"
  instance_class          = "db.t3.small"
  maintenance_window      = "Mon:07:00-Mon:07:30"
  readonly_instance_class = "db.t3.small"
  readonly_instance_count = 1
  instance_count          = 1
}
```
Please check the [documentation](#inputs) below for description and all available inputs.

### Example to create RDS with DD monitors

``` hcl
module "aurorapostgres" {
  source                  = "github.com/ShopRunner/terraform-aws-rds-aurora-postgres?ref=v1" # please use the latest version
  name                    = "module-example-${terraform.workspace}"
  maintainer              = "TEAM_NAME"
  product                 = "Spinnaker"
  data_classification     = "internal_use"
  environment             = terraform.workspace
  db_name                 = "moduleexample"
  engine_version          = "12.4"
  instance_class          = "db.t3.small"
  maintenance_window      = "Mon:07:00-Mon:07:30"
  readonly_instance_class = "db.t3.small"
  readonly_instance_count = 1
  instance_count          = 1
  create_monitors         = true
  datadog_api_key         = var.datadog_api_key
  datadog_app_key         = var.datadog_app_key
  # Notification channel have to be created manually in Datadog. Please make sure that it's valid value, otherwise Datadog won't be able to send notifications correctly  
  datadog_warning_notification_channel = "@slack-test-notification-channel"
  datadog_alert_notification_channel   = "@pagerduty-test-notification-channel"
}
```
To create datadog monitors for RDS you will need to define the 2 variables for it - `datadog_api_key` and `datadog_app_key`. Values for the variables will be injected by the pipeline.

``` hcl
variable "datadog_api_key" {
  description = "Datadog api key secret"
}

variable "datadog_app_key" {
  description = "Datadog app key secret"
}
```

# Versioning

All versions can be found in [releases tab](https://github.com/ShopRunner/terraform-aws-rds-aurora-postgres/releases) in this repository

It is recommended you use `?ref=<LATEST-VERSION>` to keep up to date with bug fixes, but being confident that the resources will not change from under you.

The versions of this module are [semantically versioned](https://semver.org/).
1. Major versions will have API changes, such as required variables or outputs.
2. Minor version will add, remove, or change the resources produced and optional variables my be added, but no optional variables will be removed and no required variables will be changed.
3. Patch versions fix bug and refine meaning of provided values without changing the resources created with a given set of values.
4. Along with the semantic version (`vX.Y.Z`), there will be one more version released for the module as `vX`. This version will always point to the latest changes for the semantic version series `vX.Y.Z`.

## Releasing a new version

1. Merge your changes to the `main` branch
1. From Github UI navigate to the repository:
    1. Click on [releases](https://github.com/ShopRunner/terraform-aws-rds-aurora-postgres/releases) tab
    1. Draft a new release
    1. Provide next tag version `vX.Y.Z` according to [semantic versioning](https://semver.org/) described in [section above](#versioning)
    1. Provide release title and description what checked in new version
    1. Verify the github [workflow](https://github.com/ShopRunner/terraform-aws-rds-aurora-postgres/actions/workflows/tag.yml) run is completed and the major version tag [`vX`](https://github.com/ShopRunner/terraform-aws-rds-aurora-postgres/tags) points to the same commit as `vX.Y.Z`  

# Module documentation

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_datadog_rds_core_monitors"></a> [datadog\_rds\_core\_monitors](#module\_datadog\_rds\_core\_monitors) | github.com/ShopRunner/terraform-datadog-aws-rds | v1 |

## Resources

| Name | Type |
|------|------|
| [aws_rds_cluster.rdsaurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.cluster_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_instance.cluster_readonly_replica_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_route53_record.rds-private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.rds-public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.rds-ro-private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.rds-ro-public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [random_password.db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_route53_zone.shoprunner-io-private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_route53_zone.shoprunner-io-public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_security_group.rds_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Additional tags that you can assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_create_monitors"></a> [create\_monitors](#input\_create\_monitors) | Whether to create datadog monitors along with the RDS or not | `bool` | `false` | no |
| <a name="input_data_classification"></a> [data\_classification](#input\_data\_classification) | The sensitivity level (data\_classification) for information assets based on the appropriate audience for the information. MUST be one of: restricted, confidential, internal\_use, public. | `string` | n/a | yes |
| <a name="input_datadog_alert_notification_channel"></a> [datadog\_alert\_notification\_channel](#input\_datadog\_alert\_notification\_channel) | Notification channel to receive alerts. Please use Datadog's format ex. '@pagerduty-channel\_name'. You can provide multiple channels by splitting them with spaces. This need to be created manually in the Datadog otherwise the notification won't be send correctly. | `string` | `""` | no |
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | Datadog api key secret | `string` | `""` | no |
| <a name="input_datadog_app_key"></a> [datadog\_app\_key](#input\_datadog\_app\_key) | Datadog app key secret | `string` | `""` | no |
| <a name="input_datadog_warning_notification_channel"></a> [datadog\_warning\_notification\_channel](#input\_datadog\_warning\_notification\_channel) | Notification channel to receive warnings. Please use Datadog's format ex. @slack-channel\_name. You can provide multiple channels by splitting them with spaces. This need to be created manually in the Datadog otherwise the notification won't be send correctly. | `string` | `""` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The name of the database. | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version to use. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which this resource needs to be created. This should be 'terraform.workspace'. Accepted values [lab, wip, stg, prd, pci, devops, sandbox]. | `string` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance type of the writer RDS instance in the cluster. | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | The number of instances of the database to spin up. Default 1. | `number` | `1` | no |
| <a name="input_maintainer"></a> [maintainer](#input\_maintainer) | The maintainer of the service or application utilizing this resource. This MUST be the same for all resources you create. | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The window to perform maintenance. Time is in UTC, should be in this pattern Mon:07:00-Mon:10:00. | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the rds, this name must be unique for each rds created. | `string` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | The name of the product that is utilizing this resource. | `string` | n/a | yes |
| <a name="input_readonly_instance_class"></a> [readonly\_instance\_class](#input\_readonly\_instance\_class) | The instance class for the RDS database for read-only instances. Allowed aurora instance types: https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.DBInstanceClass.html | `string` | n/a | yes |
| <a name="input_readonly_instance_count"></a> [readonly\_instance\_count](#input\_readonly\_instance\_count) | The number of read-only instances of the database to spin up. Note that if primary fails, this may still be promoted to writer. Increase the instance\_count variable to prevent this. Default 0. | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_address"></a> [cluster\_address](#output\_cluster\_address) | The hostname of the RDS cluster. |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The ARN of the RDS cluster. |
| <a name="output_cluster_cname"></a> [cluster\_cname](#output\_cluster\_cname) | The CNAME of the RDS cluster. |
| <a name="output_cluster_ro_address"></a> [cluster\_ro\_address](#output\_cluster\_ro\_address) | The hostname of the read only cluster endpoint. |
| <a name="output_cluster_ro_cname"></a> [cluster\_ro\_cname](#output\_cluster\_ro\_cname) | The CNAME of the read only cluster. |

<!--- END_TF_DOCS --->

