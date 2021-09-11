data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

############################################################
#                     S3 Resources                         #
############################################################
resource "aws_s3_bucket" "s3_bucket" {
  for_each = var.bucket_config

  bucket = "${var.environment}-${each.value.bucket_prefix}-${local.account_id}-${var.default_region}"
  acl    = each.value.bucket_acl

  force_destroy       = each.value.fore_destroy
  acceleration_status = each.value.acceleration_status

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = each.value.sse_algorithm
        kms_master_key_id = each.value.kms_master_key_id
      }
    }
  }

  versioning {
    enabled = each.value.enable_versioning
  }

  lifecycle_rule {
    id      = "transition-infrequent"
    enabled = each.value.infrequent_transition_enabled
    prefix  = each.value.infrequent_transition_prefix

    transition {
      days          = each.value.infrequent_transition_days
      storage_class = "STANDARD_IA"
    }
  }

  lifecycle_rule {
    id      = "transition-to-glacier"
    enabled = each.value.glacier_transition_enabled
    prefix  = each.value.glacier_transition_prefix

    transition {
      days          = each.value.glacier_transition_days
      storage_class = "GLACIER"
    }
  }

  lifecycle_rule {
    id      = "expiry"
    enabled = each.value.expiry_enabled
    prefix  = each.value.expiry_prefix

    noncurrent_version_expiration {
      days = each.value.noncurrent_expiry_days
    }
    expiration {
      days = each.value.expiry_days
    }
  }

  tags = merge(local.common_tags, tomap("Name", "${var.environment}-${each.value.bucket_prefix}-bucket"))
}
