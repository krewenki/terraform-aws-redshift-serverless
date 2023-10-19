
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
