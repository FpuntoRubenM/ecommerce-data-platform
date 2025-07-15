variable "stream_name" {
  description = "Nombre del Kinesis Data Stream."
  type        = string
}

variable "shard_count" {
  description = "Número de shards para el Kinesis Data Stream."
  type        = number
  default     = 1
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos."
  type        = string
}

variable "environment" {
  description = "Entorno (dev/prod) para etiquetar recursos."
  type        = string
}
