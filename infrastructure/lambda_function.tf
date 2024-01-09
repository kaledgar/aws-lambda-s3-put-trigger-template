resource "aws_lambda_function" "trigger" {
  function_name = "${local.project_prefix}-lambda"
  description   = "I get triggered by file from s3"
  runtime       = "python3.9"
  handler       = "lambda.lambda_handler"
  role          = aws_iam_role.lambda_role.arn


  source_code_hash = base64sha256(data.archive_file.source.output_path)
  s3_bucket        = aws_s3_bucket.lambda-assets-bucket.id
  s3_key           = aws_s3_object.lambda_source_code_upload.key

  environment {
    variables = {
      AWS_REGION     = var.aws_region
      PROJECT_PREFIX = local.project_prefix
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "${local.project_prefix}-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}
