# AWS Redshift Serverless Terraform module

Terraform module which creates Redshift Serverless resources on AWS.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Usage

```hcl
module "redshift-serverless" {
  source  = "krewenki/redshift-serverless"

}
```

## Examples

- [Complete Redshift Serverless example](https://github.com/krewenki/terraform-aws-redshift-serverless/tree/master/examples/complete) creates VPC with Redshift subnet, VPC security group and Redshift Serverless namespace itself.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.30.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.30.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_redshift_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_subnet_group) | resource |
| [aws_redshiftserverless_endpoint_access.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshiftserverless_endpoint_access) | resource |
| [aws_redshiftserverless_namespace.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshiftserverless_namespace) | resource |
| [aws_redshiftserverless_usage_limit.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshiftserverless_usage_limit) | resource |
| [aws_redshiftserverless_workgroup.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshiftserverless_workgroup) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_password.master_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base_capacity"></a> [base\_capacity](#input\_base\_capacity) | (Optional) The base data warehouse capacity of the workgroup in Redshift Processing Units (RPUs). | `number` | `null` | no |
| <a name="input_cluster_identifier"></a> [cluster\_identifier](#input\_cluster\_identifier) | The Cluster Identifier. Must be a lower case string | `string` | `""` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether to create Redshift cluster and resources (affects all resources) | `bool` | `true` | no |
| <a name="input_create_default_security_group"></a> [create\_default\_security\_group](#input\_create\_default\_security\_group) | Whether to create a new Security Group dedicated to Serverless Redshift Endpoint | `bool` | `false` | no |
| <a name="input_create_endpoint_access"></a> [create\_endpoint\_access](#input\_create\_endpoint\_access) | Determines whether to create an endpoint access (managed VPC endpoint) | `bool` | `false` | no |
| <a name="input_create_random_password"></a> [create\_random\_password](#input\_create\_random\_password) | Determines whether to create random password for cluster `master_password` | `bool` | `true` | no |
| <a name="input_create_subnet_group"></a> [create\_subnet\_group](#input\_create\_subnet\_group) | Determines whether to create a subnet group or use existing | `bool` | `true` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the first database to be created when the cluster is created. If you do not provide a name, Amazon Redshift will create a default database called `dev` | `string` | `null` | no |
| <a name="input_default_iam_role_arn"></a> [default\_iam\_role\_arn](#input\_default\_iam\_role\_arn) | The Amazon Resource Name (ARN) for the IAM role that was set as default for the cluster when the cluster was created | `string` | `null` | no |
| <a name="input_default_security_group_name"></a> [default\_security\_group\_name](#input\_default\_security\_group\_name) | (Optional) The name to provide to the default security group, in case `create_default_security_group` is set to true | `string` | `null` | no |
| <a name="input_default_security_group_tags"></a> [default\_security\_group\_tags](#input\_default\_security\_group\_tags) | (Optional) Tags to provide to the default security group, in case `create_default_security_group` is set to true | `object({})` | `{}` | no |
| <a name="input_default_security_group_vpc_id"></a> [default\_security\_group\_vpc\_id](#input\_default\_security\_group\_vpc\_id) | (Optional) The VPC id to provide to the default security group, in case `create_default_security_group` is set to true | `string` | `null` | no |
| <a name="input_endpoint_name"></a> [endpoint\_name](#input\_endpoint\_name) | The Redshift-managed VPC endpoint name | `string` | `""` | no |
| <a name="input_endpoint_vpc_security_group_ids"></a> [endpoint\_vpc\_security\_group\_ids](#input\_endpoint\_vpc\_security\_group\_ids) | The security group IDs to use for the endpoint access (managed VPC endpoint) | `list(string)` | `[]` | no |
| <a name="input_enhanced_vpc_routing"></a> [enhanced\_vpc\_routing](#input\_enhanced\_vpc\_routing) | If `true`, enhanced VPC routing is enabled | `bool` | `null` | no |
| <a name="input_iam_role_arns"></a> [iam\_role\_arns](#input\_iam\_role\_arns) | A list of IAM Role ARNs to associate with the cluster. A Maximum of 10 can be associated to the cluster at any time | `list(string)` | `[]` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The ARN for the KMS encryption key. When specifying `kms_key_arn`, `encrypted` needs to be set to `true` | `string` | `null` | no |
| <a name="input_log_exports"></a> [log\_exports](#input\_log\_exports) | (Optional) The types of logs the namespace can export. Available export types are userlog, connectionlog, and useractivitylog. | `list(string)` | <pre>[<br>  "userlog",<br>  "connectionlog",<br>  "useractivitylog"<br>]</pre> | no |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | Password for the master DB user. (Required unless a `snapshot_identifier` is provided). Must contain at least 8 chars, one uppercase letter, one lowercase letter, and one number | `string` | `null` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | Username for the master DB user (Required unless a `snapshot_identifier` is provided). Defaults to `awsuser` | `string` | `"awsuser"` | no |
| <a name="input_namespace_name"></a> [namespace\_name](#input\_namespace\_name) | (Required) The name of the namespace | `string` | `null` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | If true, the cluster can be accessed from a public network | `bool` | `false` | no |
| <a name="input_random_password_length"></a> [random\_password\_length](#input\_random\_password\_length) | Length of random password to create. Defaults to `16` | `number` | `16` | no |
| <a name="input_subnet_group_description"></a> [subnet\_group\_description](#input\_subnet\_group\_description) | The description of the Redshift Subnet group. Defaults to `Managed by Terraform` | `string` | `null` | no |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | The name of the Redshift subnet group, existing or to be created | `string` | `null` | no |
| <a name="input_subnet_group_tags"></a> [subnet\_group\_tags](#input\_subnet\_group\_tags) | Additional tags to add to the subnet group | `map(string)` | `{}` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | An array of VPC subnet IDs to use in the subnet group | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_usage_limits"></a> [usage\_limits](#input\_usage\_limits) | Map of usage limit definitions to create; more info see: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshiftserverless_usage_limit | <pre>list(object({<br>    usage_type    = string,<br>    amount        = number,<br>    period        = string,<br>    breach_action = string,<br>    tags          = map(string),<br>  }))</pre> | `[]` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | A list of Virtual Private Cloud (VPC) security groups to be associated with the cluster | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_redshiftserverless_default_security_group_arn"></a> [aws\_redshiftserverless\_default\_security\_group\_arn](#output\_aws\_redshiftserverless\_default\_security\_group\_arn) | The default security group ARN for Serverless Redshift in case `create_default_security_group` option was specified |
| <a name="output_aws_redshiftserverless_default_security_group_id"></a> [aws\_redshiftserverless\_default\_security\_group\_id](#output\_aws\_redshiftserverless\_default\_security\_group\_id) | The default security group id for Serverless Redshift in case `create_default_security_group` option was specified |
| <a name="output_aws_redshiftserverless_default_security_group_name"></a> [aws\_redshiftserverless\_default\_security\_group\_name](#output\_aws\_redshiftserverless\_default\_security\_group\_name) | The default security group name for Serverless Redshift in case `create_default_security_group` option was specified |
| <a name="output_aws_redshiftserverless_namespace_arn"></a> [aws\_redshiftserverless\_namespace\_arn](#output\_aws\_redshiftserverless\_namespace\_arn) | Serverless redshift namespace ARN |
| <a name="output_aws_redshiftserverless_namespace_db_name"></a> [aws\_redshiftserverless\_namespace\_db\_name](#output\_aws\_redshiftserverless\_namespace\_db\_name) | Serverless redshift namespace db name |
| <a name="output_aws_redshiftserverless_namespace_id"></a> [aws\_redshiftserverless\_namespace\_id](#output\_aws\_redshiftserverless\_namespace\_id) | Serverless redshift namespace id |
| <a name="output_aws_redshiftserverless_namespace_name"></a> [aws\_redshiftserverless\_namespace\_name](#output\_aws\_redshiftserverless\_namespace\_name) | Serverless redshift namespace name |
| <a name="output_aws_redshiftserverless_workgroup_arn"></a> [aws\_redshiftserverless\_workgroup\_arn](#output\_aws\_redshiftserverless\_workgroup\_arn) | Serverless redshift Workgroup ARN |
| <a name="output_aws_redshiftserverless_workgroup_endpoint"></a> [aws\_redshiftserverless\_workgroup\_endpoint](#output\_aws\_redshiftserverless\_workgroup\_endpoint) | Serverless redshift Workgroup endpoint |
| <a name="output_aws_redshiftserverless_workgroup_id"></a> [aws\_redshiftserverless\_workgroup\_id](#output\_aws\_redshiftserverless\_workgroup\_id) | Serverless redshift Workgroup id |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained by [Warren Krewenki](https://github.com/krewenki).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/krewenki/terraform-aws-redshift-serverless/tree/main/LICENSE) for full details.
