# modules/s3/variables.tf

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "The environment this bucket is for (e.g., dev, staging, prod)"
  type        = string
}

variable "acl" {
  description = "The canned ACL to apply"
  type        = string
  default     = "private"
}

variable "versioning_enabled" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = false
}
variable "logging_enabled" {
  description = "Enable logging for the bucket"
  type        = bool
  default     = false
}

variable "logging_bucket" {
  description = "The bucket to store logs in (if logging is enabled)"
  type        = string
  default     = ""
}

variable "prevent_destroy" {
  description = "Prevents the bucket from being destroyed"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}

