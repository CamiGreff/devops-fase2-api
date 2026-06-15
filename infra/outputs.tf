output "bucket_name" {
  description = "Nome do bucket criado."
  value       = aws_s3_bucket.site.bucket
}

output "website_endpoint" {
  description = "Endpoint de hospedagem estatica do S3."
  value       = aws_s3_bucket_website_configuration.site.website_endpoint
}
