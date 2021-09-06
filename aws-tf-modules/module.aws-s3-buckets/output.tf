output "artifactory_s3_arn" {
  value = aws_s3_bucket.s3_artifactory_bucket.arn
}

output "logging_s3_arn" {
  value = aws_s3_bucket.s3_logging_bucket.arn
}

output "datalake_s3_arn" {
  value = aws_s3_bucket.s3_dataLake_bucket.arn
}

output "artifactory_s3_name" {
  value = aws_s3_bucket.s3_artifactory_bucket.id
}

output "logging_s3_name" {
  value = aws_s3_bucket.s3_logging_bucket.id
}

output "datalake_s3_name" {
  value = aws_s3_bucket.s3_dataLake_bucket.id
}
