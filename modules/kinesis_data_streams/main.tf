resource "aws_kinesis_stream" "data_stream" {
  name        = var.stream_name
  shard_count = var.shard_count

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

output "stream_name" {
  description = "El nombre del Kinesis Data Stream."
  value       = aws_kinesis_stream.data_stream.name
}

output "stream_arn" {
  description = "El ARN del Kinesis Data Stream."
  value       = aws_kinesis_stream.data_stream.arn
}
