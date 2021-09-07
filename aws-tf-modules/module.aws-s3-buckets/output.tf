output "artifactory_s3_arn" {
  value = aws_s3_bucket.s3_bucket["artifactory"].arn
}

output "logging_s3_arn" {
  value = aws_s3_bucket.s3_bucket["logging"].arn
}

output "datalake_s3_arn" {
  value = aws_s3_bucket.s3_bucket["datalake"].arn
}

output "artifactory_s3_name" {
  value = aws_s3_bucket.s3_bucket["artifactory"].id
}

output "logging_s3_name" {
  value = aws_s3_bucket.s3_bucket["logging"].id
}

output "datalake_s3_name" {
  value = aws_s3_bucket.s3_bucket["datalake"].id
}
