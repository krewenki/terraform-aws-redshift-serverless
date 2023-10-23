
output "aws_redshiftserverless_namespace_arn" {
  value       = try(aws_redshiftserverless_namespace.this[0].arn, "")
  description = "Serverless redshift namespace ARN"
}

output "aws_redshiftserverless_namespace_id" {
  value       = try(aws_redshiftserverless_namespace.this[0].id, "")
  description = "Serverless redshift namespace id"
}

output "aws_redshiftserverless_namespace_name" {
  value       = try(aws_redshiftserverless_namespace.this[0].namespace_name, "")
  description = "Serverless redshift namespace name"
}

output "aws_redshiftserverless_namespace_db_name" {
  value       = try(aws_redshiftserverless_namespace.this[0].db_name, "")
  description = "Serverless redshift namespace db name"
}

output "aws_redshiftserverless_workgroup_arn" {
  value       = try(aws_redshiftserverless_workgroup.this[0].arn, "")
  description = "Serverless redshift Workgroup ARN"
}

output "aws_redshiftserverless_workgroup_id" {
  value       = try(aws_redshiftserverless_workgroup.this[0].id, "")
  description = "Serverless redshift Workgroup id"
}

output "aws_redshiftserverless_workgroup_endpoint" {
  value       = try(aws_redshiftserverless_workgroup.this[0].endpoint, "")
  description = "Serverless redshift Workgroup endpoint"
}

output "aws_redshiftserverless_default_security_group_id" {
  value       = try(aws_security_group.this[0].id, "")
  description = "The default security group id for Serverless Redshift in case `create_default_security_group` option was specified"
}

output "aws_redshiftserverless_default_security_group_arn" {
  value       = try(aws_security_group.this[0].arn, "")
  description = "The default security group ARN for Serverless Redshift in case `create_default_security_group` option was specified"
}

output "aws_redshiftserverless_default_security_group_name" {
  value       = try(aws_security_group.this[0].name, "")
  description = "The default security group name for Serverless Redshift in case `create_default_security_group` option was specified"
}
