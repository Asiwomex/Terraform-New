# logging.tf

resource "aws_s3_bucket_logging" "this" {
  count  = var.logging_enabled ? 1 : 0
  bucket = aws_s3_bucket.this.id

  target_bucket = var.logging_bucket
  target_prefix = "log/${var.bucket_name}/"
}