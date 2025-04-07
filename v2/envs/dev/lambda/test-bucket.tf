resource "random_pet" "test_bucket_name" {
  prefix = "lambda"
  length = 2
}

resource "aws_s3_bucket" "test_bucket" {
  bucket        = random_pet.test_bucket_name.id
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "test_bucket" {
  bucket = aws_s3_bucket.test_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "test_bucket" {
  bucket = aws_s3_bucket.test_bucket.id

  key     = "hello.json"
  content = jsonencode({ name = "Kimsour-S3" })
}

output "test_s3_bucket" {
  value = random_pet.test_bucket_name.id
}