resource "aws_lambda_function" "this" {
  function_name = var.lambda_name
  s3_bucket     = var.s3_bucket
  s3_key        = var.s3_key
  runtime       = var.runtime
  handler       = var.handler
  role          = var.role_arn
  source_code_hash = var.source_code_hash
}