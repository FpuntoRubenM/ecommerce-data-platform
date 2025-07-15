
variable "aws_region" {
  description = "La región de AWS donde se desplegarán los recursos."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos."
  type        = string
  default     = "ecommerce-data-platform"
}

variable "environment" {
  description = "Entorno (dev/staging/prod) para el despliegue."
  type        = string
}
