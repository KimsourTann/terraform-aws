variable "key_pair_id" {
  description = "Keys use for SSH"
}

variable "region" {
  default = "us-east-2"
  description = "var use to set aws region"
}

variable "env" {
  default = "dev"
}