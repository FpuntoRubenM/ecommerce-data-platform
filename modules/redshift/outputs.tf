output "cluster_endpoint" {
  description = "El endpoint del clúster de Redshift."
  value       = aws_redshift_cluster.redshift_cluster.endpoint
}

output "cluster_arn" {
  description = "El ARN del clúster de Redshift."
  value       = aws_redshift_cluster.redshift_cluster.arn
}
