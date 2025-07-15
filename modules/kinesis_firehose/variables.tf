variable "delivery_stream_name" {
  description = "Nombre del Kinesis Firehose Delivery Stream."
  type        = string
}

variable "input_stream_arn" {
  description = "ARN del Kinesis Data Stream de entrada para Firehose."
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos."
  type        = string
}

variable "environment" {
  description = "Entorno (dev/prod) para etiquetar recursos."
  type        = string
}
