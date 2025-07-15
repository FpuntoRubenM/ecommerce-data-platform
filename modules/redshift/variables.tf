variable "cluster_identifier" {
  description = "Identificador único para el clúster de Redshift."
  type        = string
}

variable "node_type" {
  description = "Tipo de nodo para el clúster de Redshift."
  type        = string
  default     = "dc2.large"
}

variable "cluster_type" {
  description = "Tipo de clúster de Redshift (single-node o multi-node)."
  type        = string
  default     = "single-node"
}

variable "master_username" {
  description = "Nombre de usuario maestro para el clúster de Redshift."
  type        = string
}

variable "master_password" {
  description = "Contraseña maestra para el clúster de Redshift."
  type        = string
  sensitive   = true
}

variable "skip_final_snapshot" {
  description = "Determina si se debe omitir la instantánea final al eliminar el clúster."
  type        = bool
  default     = true
}

variable "publicly_accessible" {
  description = "Determina si el clúster es accesible públicamente."
  type        = bool
  default     = false
}

variable "db_name" {
  description = "Nombre de la base de datos inicial en el clúster de Redshift."
  type        = string
  default     = "dev"
}

variable "s3_bucket_arn" {
  description = "ARN del bucket S3 donde Firehose deposita los datos."
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
