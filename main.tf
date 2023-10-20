
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
  namespace_name       = var.namespace_name
  admin_user_password  = local.master_password
  admin_username       = var.master_username
  db_name              = var.database_name
  default_iam_role_arn = var.default_iam_role_arn
  iam_roles            = var.iam_role_arns
  kms_key_id           = var.kms_key_arn
  log_exports          = var.log_exports
  tags                 = var.tags
}

resource "aws_redshiftserverless_workgroup" "this" {
  count          = var.create ? 1 : 0
  namespace_name = aws_redshiftserverless_namespace.this[0].namespace_name
  workgroup_name = aws_redshiftserverless_namespace.this[0].namespace_name

  base_capacity        = var.base_capacity
  enhanced_vpc_routing = var.enhanced_vpc_routing
  publicly_accessible  = var.publicly_accessible
  security_group_ids   = var.vpc_security_group_ids
  subnet_ids           = var.subnet_ids
  tags                 = merge(var.tags, try(each.value.tags, {}))
}

resource "aws_redshiftserverless_endpoint_access" "this" {
  count                  = var.create && var.create_endpoint_access ? 1 : 0
  endpoint_name          = var.endpoint_name
  workgroup_name         = aws_redshiftserverless_workgroup.this.workgroup_name
  security_group_ids     = var.vpc_security_group_ids
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

resource "aws_redshiftserverless_usage_limit" "this" {
  for_each      = var.create ? toset(var.usage_limits) : []
  resource_arn  = aws_redshiftserverless_workgroup.this[0].arn
  usage_type    = try(each.key.usage_type, null)
  amount        = try(each.key.amount, null)
  period        = try(each.key.period, null)
  breach_action = try(each.key.breach_action, null)
  tags          = try(each.key.tags, {})
}
