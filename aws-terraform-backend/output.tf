output "tf_backend_s3_bucket_arn" {
  value = aws_s3_bucket.tf_state_backend_bucket.arn
}

output "tf_backend_s3_bucket_name" {
  value = aws_s3_bucket.tf_state_backend_bucket.id
}

output "tf_backend_dynamoDB_arn" {
  value = aws_dynamodb_table.dynamodb-terraform-state-lock.arn
}

output "tf_backend_dynamoDB_name" {
  value = aws_dynamodb_table.dynamodb-terraform-state-lock.name
}

