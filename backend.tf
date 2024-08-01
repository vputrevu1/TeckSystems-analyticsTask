terraform {
  required_version = ">= 1.0.0, < 3.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

data "aws_s3_bucket" "tf_state-app_s3_bucket" {
  bucket = "tf-backend-s3-state"
}
# resource "aws_s3_bucket" "terraform_s3_state" {
#   bucket = var.bucket_name
#   force_destroy = true
# }

# # Enable versioning so you can see the full revision history of your
# # state files
# resource "aws_s3_bucket_versioning" "enabled" {
#   bucket = data.aws_s3_bucket.tf_state-app_s3_bucket.state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }
# # Enable server-side encryption by default
# resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
#   bucket = aws_s3_bucket.terraform_s3_state.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# # Explicitly block all public access to the S3 bucket
# resource "aws_s3_bucket_public_access_block" "public_access" {
#   bucket                  = aws_s3_bucket.terraform_s3_state.id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

resource "aws_dynamodb_table" "tf-s3-terraform_locks1" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}