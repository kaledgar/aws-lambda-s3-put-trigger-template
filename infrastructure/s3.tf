resource "aws_s3_bucket" "lambda-assets-bucket" {
  bucket = "${local.project_prefix}-lambda-asssets-bucket"
}
