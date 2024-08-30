provider "aws" {
  region = var.region
  access_key = var.aws_key
  secret_key = var.aws_secret
}


# Use to create s3 bucket
resource "aws_s3_bucket" "terraform_state" {
    bucket = "kimsour-terraform-state"

    # Use to prevet accident delete s3 bucket (this s3 can be destroy only if you command attridute lifecycle)
    # lifecycle {
    #   prevent_destroy = true
    # }
}

# Use to enable s3 bucket version to backup previous version
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}


# Use to encrypt data on s3 bucket to prevent leak data
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


# Use to block from public access
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


# Use to create table dynamoDB table to lock the state of terrafrom state
resource "aws_dynamodb_table" "terraform_state" {
  name         = "terraform-state"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

