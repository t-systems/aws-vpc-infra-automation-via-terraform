output "artifactory_s3_arn" {
  value = aws_s3_bucket.s3_bucket["artifactory_bucket"].arn
}

output "logging_s3_arn" {
  value = aws_s3_bucket.s3_bucket["logging_bucket"].arn
}

output "datalake_s3_arn" {
  value = aws_s3_bucket.s3_bucket["datalake_bucket"].arn
}

output "artifactory_s3_name" {
  value = aws_s3_bucket.s3_bucket["artifactory_bucket"].id
}

output "logging_s3_name" {
  value = aws_s3_bucket.s3_bucket["logging_bucket"].id
}

output "datalake_s3_name" {
  value = aws_s3_bucket.s3_bucket["datalake_bucket"].id
}
