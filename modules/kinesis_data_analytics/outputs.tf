output "application_name" {
  description = "El nombre de la aplicación Kinesis Data Analytics."
  value       = aws_kinesis_analytics_application.analytics_app.name
}

output "application_arn" {
  description = "El ARN de la aplicación Kinesis Data Analytics."
  value       = aws_kinesis_analytics_application.analytics_app.arn
}

output "analytics_role_arn" {
  description = "El ARN del rol de IAM para la aplicación Kinesis Data Analytics."
  value       = aws_iam_role.analytics_role.arn
}
