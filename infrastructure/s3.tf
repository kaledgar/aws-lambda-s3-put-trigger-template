resource "aws_s3_bucket" "lambda_assets_bucket" {
  bucket = "${var.prefix}-lambda-asssets-bucket"
}
