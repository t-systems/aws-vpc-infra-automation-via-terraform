#####==================Logging Bucket for Test Environment=====================#####
resource "aws_s3_bucket" "s3_logging_bucket" {
  bucket = "${var.logging_bucket_prefix}-${var.environment}-${var.default_region}"
  acl    = "private"

  force_destroy = true

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true
    id      = "log"
    prefix  = "log-data/"

    noncurrent_version_expiration {
      days = 1
    }
  }

  tags = merge(local.common_tags, map("Name", "${var.environment}-logging-bucket"))
}


#####==================Artifactory Bucket for Dev Environment=====================#####
resource "aws_s3_bucket" "s3_artifactory_bucket" {
  bucket = "${var.artifactory_bucket_prefix}-${var.environment}-${var.default_region}"
  acl    = "private"

  force_destroy = true

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true
    id      = "deploy"
    prefix  = "deploy/"

    noncurrent_version_expiration {
      days = 30
    }
  }

  tags = merge(local.common_tags, map("Name", "${var.environment}-aritifactory-bucket"))
}


#####==================DataLake S3 Bucket for Dev Environment=====================#####
resource "aws_s3_bucket" "s3_dataLake_bucket" {
  bucket = "${var.dataLake_bucket_prefix}-${var.environment}-${var.default_region}"
  acl    = "private"

  force_destroy = true


  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true
    id      = "data"
    prefix  = "data/"

    transition {
      days          = 30
      storage_class = "ONEZONE_IA"            #"STANDARD_IA"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 180
    }

    noncurrent_version_expiration {
      days = 1
    }
  }

  tags = merge(local.common_tags, map("Name", "${var.environment}-datalake-bucket"))
}