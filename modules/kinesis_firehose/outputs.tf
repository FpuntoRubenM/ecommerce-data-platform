output "delivery_stream_name" {
  description = "El nombre del Kinesis Firehose Delivery Stream."
  value       = aws_kinesis_firehose_delivery_stream.firehose_stream.name
}

output "delivery_stream_arn" {
  description = "El ARN del Kinesis Firehose Delivery Stream."
  value       = aws_kinesis_firehose_delivery_stream.firehose_stream.arn
}

output "firehose_bucket_name" {
  description = "El nombre del bucket S3 de destino de Firehose."
  value       = aws_s3_bucket.firehose_bucket.id
}
