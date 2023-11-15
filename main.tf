provider "aws" {
  region = "your_aws_region"
  # Add any other necessary configuration for your AWS provider
}

resource "aws_lambda_function" "s3_trigger_lambda" {
  function_name = "s3-trigger-lambda-function"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "lambda.handler"
  runtime       = "python3.8"               # Adjust the runtime based on your Lambda function code
  filename      = "path/to/your/lambda.zip" # Update with the correct path to your Lambda code package

  source_code_hash = filebase64("path/to/your/lambda.zip") # Update with the correct path to your Lambda code package

  environment {
    variables = {
      # Add any environment variables your Lambda function might need
    }
  }

  depends_on = [aws_iam_role_policy.lambda]
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "s3-trigger-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_iam_role_policy" "lambda" {
  name = "s3-trigger-lambda-policy"
  role = aws_iam_role.lambda_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        Effect   = "Allow",
        Resource = "*",
      },
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
        ],
        Effect   = "Allow",
        Resource = "arn:aws:s3:::your_bucket_name/*", # Update with your S3 bucket name
      },
    ],
  })
}
