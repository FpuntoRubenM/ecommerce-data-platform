output "stream_name" {
  description = "El nombre del Kinesis Data Stream."
  value       = aws_kinesis_stream.data_stream.name
}

output "stream_arn" {
  description = "El ARN del Kinesis Data Stream."
  value       = aws_kinesis_stream.data_stream.arn
}
