variable "create" {
  description = "Determines whether to create Redshift cluster and resources (affects all resources)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Cluster
################################################################################

variable "base_capacity" {
  description = "(Optional) The base data warehouse capacity of the workgroup in Redshift Processing Units (RPUs)."
  type        = number
  default     = null
}

variable "namespace_name" {
  description = "(Required) The name of the namespace"
  type        = string
  default     = null
}

variable "allow_version_upgrade" {
  description = "If `true`, major version upgrades can be applied during the maintenance window to the Amazon Redshift engine that is running on the cluster. Default is `true`"
  type        = bool
  default     = null
}

variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is `false`"
  type        = bool
  default     = null
}

variable "aqua_configuration_status" {
  description = "The value represents how the cluster is configured to use AQUA (Advanced Query Accelerator) after the cluster is restored. Possible values are `enabled`, `disabled`, and `auto`. Requires Cluster reboot"
  type        = string
  default     = null
}

variable "automated_snapshot_retention_period" {
  description = "The number of days that automated snapshots are retained. If the value is 0, automated snapshots are disabled. Even if automated snapshots are disabled, you can still create manual snapshots when you want with create-cluster-snapshot. Default is 1"
  type        = number
  default     = null
}

variable "availability_zone" {
  description = "The EC2 Availability Zone (AZ) in which you want Amazon Redshift to provision the cluster. Can only be changed if `availability_zone_relocation_enabled` is `true`"
  type        = string
  default     = null
}

variable "availability_zone_relocation_enabled" {
  description = "If `true`, the cluster can be relocated to another availabity zone, either automatically by AWS or when requested. Default is `false`. Available for use on clusters from the RA3 instance family"
  type        = bool
  default     = null
}

variable "cluster_identifier" {
  description = "The Cluster Identifier. Must be a lower case string"
  type        = string
  default     = ""
}

# cluster_parameter_group_name -> see parameter group section
# cluster_subnet_group_name -> see subnet group section

variable "cluster_version" {
  description = "The version of the Amazon Redshift engine software that you want to deploy on the cluster. The version selected runs on all the nodes in the cluster"
  type        = string
  default     = null
}

variable "database_name" {
  description = "The name of the first database to be created when the cluster is created. If you do not provide a name, Amazon Redshift will create a default database called `dev`"
  type        = string
  default     = null
}

# default_iam_role_arn -> see iam roles section

variable "elastic_ip" {
  description = "The Elastic IP (EIP) address for the cluster"
  type        = string
  default     = null
}

variable "encrypted" {
  description = "If `true`, the data in the cluster is encrypted at rest"
  type        = bool
  default     = true
}

variable "enhanced_vpc_routing" {
  description = "If `true`, enhanced VPC routing is enabled"
  type        = bool
  default     = null
}

variable "final_snapshot_identifier" {
  description = "The identifier of the final snapshot that is to be created immediately before deleting the cluster. If this parameter is provided, `skip_final_snapshot` must be `false`"
  type        = string
  default     = null
}

# iam_roles -> see iam roles section

variable "kms_key_arn" {
  description = "The ARN for the KMS encryption key. When specifying `kms_key_arn`, `encrypted` needs to be set to `true`"
  type        = string
  default     = null
}

variable "log_exports" {
  description = "(Optional) The types of logs the namespace can export. Available export types are userlog, connectionlog, and useractivitylog."
  type        = list(string)
  default     = ["userlog", "connectionlog", "useractivitylog"]
}

variable "master_password" {
  description = "Password for the master DB user. (Required unless a `snapshot_identifier` is provided). Must contain at least 8 chars, one uppercase letter, one lowercase letter, and one number"
  type        = string
  default     = null
  sensitive   = true
}

variable "create_random_password" {
  description = "Determines whether to create random password for cluster `master_password`"
  type        = bool
  default     = true
}

variable "random_password_length" {
  description = "Length of random password to create. Defaults to `16`"
  type        = number
  default     = 16
}

variable "master_username" {
  description = "Username for the master DB user (Required unless a `snapshot_identifier` is provided). Defaults to `awsuser`"
  type        = string
  default     = "awsuser"
}

variable "publicly_accessible" {
  description = "If true, the cluster can be accessed from a public network"
  type        = bool
  default     = false
}

variable "vpc_security_group_ids" {
  description = "A list of Virtual Private Cloud (VPC) security groups to be associated with the cluster"
  type        = list(string)
  default     = []
}

################################################################################
# IAM Roles
################################################################################

variable "iam_role_arns" {
  description = "A list of IAM Role ARNs to associate with the cluster. A Maximum of 10 can be associated to the cluster at any time"
  type        = list(string)
  default     = []
}

variable "default_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) for the IAM role that was set as default for the cluster when the cluster was created"
  type        = string
  default     = null
}

################################################################################
# Subnet Group
################################################################################

variable "create_subnet_group" {
  description = "Determines whether to create a subnet group or use existing"
  type        = bool
  default     = true
}

variable "subnet_group_name" {
  description = "The name of the Redshift subnet group, existing or to be created"
  type        = string
  default     = null
}

variable "subnet_group_description" {
  description = "The description of the Redshift Subnet group. Defaults to `Managed by Terraform`"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "An array of VPC subnet IDs to use in the subnet group"
  type        = list(string)
  default     = []
}

variable "subnet_group_tags" {
  description = "Additional tags to add to the subnet group"
  type        = map(string)
  default     = {}
}

################################################################################
# Endpoint Access
################################################################################

variable "create_endpoint_access" {
  description = "Determines whether to create an endpoint access (managed VPC endpoint)"
  type        = bool
  default     = false
}

variable "endpoint_name" {
  description = "The Redshift-managed VPC endpoint name"
  type        = string
  default     = ""
}

variable "endpoint_vpc_security_group_ids" {
  description = "The security group IDs to use for the endpoint access (managed VPC endpoint)"
  type        = list(string)
  default     = []
}

################################################################################
# Usage Limit
################################################################################

variable "usage_limits" {
  description = "Map of usage limit definitions to create; more info see: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshiftserverless_usage_limit"
  type = list(object({
    usage_type    = string,
    amount        = number,
    period        = string,
    breach_action = string,
    tags          = map(string),
  }))
  default = []
}
