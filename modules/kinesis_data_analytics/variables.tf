variable "application_name" {
  description = "Nombre de la aplicación Kinesis Data Analytics."
  type        = string
}

variable "input_stream_arn" {
  description = "ARN del Kinesis Data Stream de entrada."
  type        = string
}

variable "application_code" {
  description = "Código SQL o Flink para la aplicación Kinesis Data Analytics."
  type        = string
  default     = "CREATE OR REPLACE STREAM \"DESTINATION_SQL_STREAM\" (data VARCHAR(65536));\n\nCREATE OR REPLACE PUMP \"STREAM_PUMP\" AS INSERT INTO \"DESTINATION_SQL_STREAM\" SELECT STREAM * FROM \"SOURCE_SQL_STREAM\";"
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos."
  type        = string
}

variable "environment" {
  description = "Entorno (dev/prod) para etiquetar recursos."
  type        = string
}
