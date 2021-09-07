default_region = "us-east-1"

team         = "Learning-Team"
owner        = "Vivek"
environment  = "qa"
isMonitoring = true
project      = "Learning-TF"
component    = "DataStorage"

bucket_config = {

  "artifactory_bucket" = {
    bucket_prefix = "artifactory"
    bucket_acl = "private"
    fore_destroy = false
    acceleration_status = "Suspended"
    sse_algorithm = "AES256"
    kms_master_key_id = ""
    enable_versioning = true

    infrequent_transition_enabled = true
    infrequent_transition_prefix = ""
    infrequent_transition_days = 60

    glacier_transition_enabled = false
    glacier_transition_prefix = ""
    glacier_transition_days = 180

    expiry_enabled = true
    expiry_prefix = ""
    expiry_days = 365
    noncurrent_expiry_days = 30
  },

  "logging_bucket" = {
    bucket_prefix = "logging"
    bucket_acl = "private"
    fore_destroy = false
    acceleration_status = "Suspended"
    sse_algorithm = "AES256"
    kms_master_key_id = ""
    enable_versioning = true

    infrequent_transition_enabled = true
    infrequent_transition_prefix = ""
    infrequent_transition_days = 60

    glacier_transition_enabled = false
    glacier_transition_prefix = ""
    glacier_transition_days = 180

    expiry_enabled = true
    expiry_prefix = ""
    expiry_days = 180
    noncurrent_expiry_days = 30
  },

  "datalake_bucket" = {
    bucket_prefix = "datalake"
    bucket_acl = "private"
    fore_destroy = false
    acceleration_status = "Suspended"
    sse_algorithm = "AES256"
    kms_master_key_id = ""
    enable_versioning = true

    infrequent_transition_enabled = true
    infrequent_transition_prefix = ""
    infrequent_transition_days = 60

    glacier_transition_enabled = true
    glacier_transition_prefix = ""
    glacier_transition_days = 180

    expiry_enabled = false
    expiry_prefix = ""
    expiry_days = 365
    noncurrent_expiry_days = 30
  }
}