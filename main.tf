
resource "random_password" "master_password" {
  count = var.create && var.create_random_password ? 1 : 0

  length      = var.random_password_length
  min_lower   = 1
  min_numeric = 1
  min_special = 1
  min_upper   = 1
  special     = false
}

################################################################################
# Cluster
################################################################################

locals {

  master_password = var.create && var.create_random_password ? random_password.master_password[0].result : var.master_password
}

resource "aws_redshiftserverless_namespace" "this" {
  count                = var.create ? 1 : 0
  namespace_name       = "concurrency-scaling"
  admin_user_password  = local.master_password
  admin_user           = var.master_username
  db_name              = var.database_name
  default_iam_role_arn = null
  iam_roles            = null
  kms_key_id           = null
  log_exports          = null
  tags                 = merge(var.tags, try(each.value.tags, {}))
}

resource "aws_redshiftserverless_workgroup" "this" {
  count          = var.create ? 1 : 0
  namespace_name = aws_redshiftserverless_namespace.this[0].namespace_name
  workgroup_name = aws_redshiftserverless_namespace.this[0].namespace_name

  base_capacity        = null
  enhanced_vpc_routing = null
  publicly_accessible  = null
  security_group_ids   = null
  subnet_ids           = var.subnet_ids
  tags                 = merge(var.tags, try(each.value.tags, {}))
}

resource "aws_redshiftserverless_usage_limit" "this" {
  count         = var.create ? 1 : 0
  resource_arn  = aws_redshiftserverless_workgroup.this.arn
  usage_type    = "serverless-compute"
  amount        = 60
  period        = "daily"
  breach_action = "deactivate"
}

resource "aws_redshiftserverless_endpoint_access" "this" {
  count                  = var.create && var.create_endpoint_access ? 1 : 0
  endpoint_name          = var.endpoint_name
  workgroup_name         = aws_redshiftserverless_workgroup.this.workgroup_name
  security_group_ids     = null
  subnet_ids             = var.subnet_ids
  vpc_security_group_ids = var.endpoint_vpc_security_group_ids
}


################################################################################
# Subnet Group
################################################################################

resource "aws_redshift_subnet_group" "this" {
  count = var.create && var.create_subnet_group ? 1 : 0

  name        = coalesce(var.subnet_group_name, var.cluster_identifier)
  description = var.subnet_group_description
  subnet_ids  = var.subnet_ids

  tags = merge(var.tags, var.subnet_group_tags)
}


################################################################################
# Usage Limit
################################################################################

# resource "aws_redshift_usage_limit" "this" {
#   for_each = { for k, v in var.usage_limits : k => v if var.create }

#   cluster_identifier = aws_redshift_cluster.this[0].id

#   amount        = each.value.amount
#   breach_action = try(each.value.breach_action, null)
#   feature_type  = each.value.feature_type
#   limit_type    = each.value.limit_type
#   period        = try(each.value.period, null)

#   tags = merge(var.tags, try(each.value.tags, {}))
# }
