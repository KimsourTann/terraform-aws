variable "region" {
  default = "us-east-2"
  description = "var use to set aws region"
}

variable "aws_key" {
  description = "AWS access key"
  default = "AKIA4MTWJACORJYXRJ4R"
  type = string
}
variable "aws_secret" {
  description = "AWS access secret"
  type = string
  default = "jIgiBZ3v1fXNCiCBBI+WrgMbS7PG88vD7vOOWWhe"
}



variable "lambda_name" {
  description = "Lambda Name"
  type = string
}


variable "s3_bucket" {
  description = "AWS access secret"
  type = string
}

variable "source_code_hash" {
  description = "source_code_hash use to froce redeploy when code change"
  type = string
}


variable "s3_key" {
  description = "AWS access secret"
  type = string
}


variable "runtime" {
  description = "AWS access secret"
  type = string
}


variable "handler" {
  description = "AWS access secret"
  type = string
}

variable "role_arn" {
  description = "AWS access secret"
  type = string
}


