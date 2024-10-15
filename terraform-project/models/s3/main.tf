# modules/s3/main.tf

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = var.acl

  # Optional settings
  versioning {
    enabled = var.versioning_enabled
  }

  lifecycle {
    prevent_destroy = var.prevent_destroy
  }

  tags = var.tags
}
