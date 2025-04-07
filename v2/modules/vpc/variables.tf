variable "region" {
  default = "us-east-2"
  description = "var use to set aws region"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "env" {
  default = "dev"
}