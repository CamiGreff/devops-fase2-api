variable "aws_region" {
  description = "Regiao AWS onde os recursos serao provisionados."
  type        = string
  default     = "sa-east-1"
}

variable "bucket_name" {
  description = "Nome globalmente unico do bucket S3."
  type        = string
}

variable "environment" {
  description = "Ambiente de execucao."
  type        = string
  default     = "dev"
}
