# --- lambda assets ---

resource "aws_s3_bucket" "lambda-assets-bucket" {
  bucket = "${local.project_prefix}-lambda-asssets-bucket"
}

resource "aws_s3_object" "lambda_source_code_upload" {
  bucket      = aws_s3_bucket.lambda-assets-bucket.id
  key         = "lambda/lambda.zip"
  source      = data.archive_file.source.output_path
  source_hash = filemd5(data.archive_file.source.output_path)
}
