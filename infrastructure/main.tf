provider "aws" {
  region = var.aws_region
}

# --- terraform backend ---

terraform {
  required_version = ">= 1.6.4"
  backend "s3" {
    bucket         = "terraform-state-bucket-kaledgar"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock-table"
    encrypt        = true
  }
}

# --- s3 bucket for backend ---

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-bucket-kaledgar"
  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# --- s3 dynamodb table for locks ---

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
