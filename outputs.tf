output "kinesis_stream_name" {
  description = "Nombre del Kinesis Data Stream."
  value       = module.kinesis_data_stream.stream_name
}

output "kinesis_stream_arn" {
  description = "ARN del Kinesis Data Stream."
  value       = module.kinesis_data_stream.stream_arn
}

output "kinesis_analytics_app_name" {
  description = "Nombre de la aplicación Kinesis Data Analytics."
  value       = module.kinesis_data_analytics.application_name
}

output "kinesis_analytics_app_arn" {
  description = "ARN de la aplicación Kinesis Data Analytics."
  value       = module.kinesis_data_analytics.application_arn
}

output "firehose_delivery_stream_name" {
  description = "Nombre del Kinesis Firehose Delivery Stream."
  value       = module.kinesis_firehose.delivery_stream_name
}

output "firehose_delivery_stream_arn" {
  description = "ARN del Kinesis Firehose Delivery Stream."
  value       = module.kinesis_firehose.delivery_stream_arn
}

output "firehose_s3_bucket_name" {
  description = "Nombre del bucket S3 de destino de Firehose."
  value       = module.kinesis_firehose.firehose_bucket_name
}

output "redshift_cluster_endpoint" {
  description = "Endpoint del clúster de Redshift."
  value       = module.redshift_cluster.cluster_endpoint
}

output "redshift_cluster_arn" {
  description = "ARN del clúster de Redshift."
  value       = module.redshift_cluster.cluster_arn
}
