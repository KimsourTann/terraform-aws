data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "s3_lambda_policy" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "s3_bucket_access" {
  name        = "TestS3BucketAccess"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${aws_s3_bucket.test_bucket.id}/*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_lambda_s3_bucket_access" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.s3_bucket_access.arn
}

data "archive_file" "lambda_s3" {
  type = "zip"

  source_dir  = "./s3"
  output_path = "./s3.zip"
}

resource "aws_s3_object" "lambda_s3" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "s3.zip"
  source = data.archive_file.lambda_s3.output_path
  
  source_hash = filemd5(data.archive_file.lambda_s3.output_path)
}

module "my-lambda-s3" {
  source      = "../../../modules/lambda"
  lambda_name = "my-lambda-s3"
  s3_bucket   = aws_s3_bucket.lambda_bucket.id
  s3_key      = aws_s3_object.lambda_s3.key
  runtime     = "python3.8"
  handler     = "lambda_handler.lambda_handler"
  role_arn    = aws_iam_role.iam_for_lambda.arn
  source_code_hash = data.archive_file.lambda_s3.output_base64sha256
}