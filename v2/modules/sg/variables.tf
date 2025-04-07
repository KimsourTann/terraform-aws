variable "region" {
  default = "us-east-2"
  description = "var use to set aws region"
}

variable "env" {
  default = "dev"
}

variable "vpc_id" {
  description = "VPC id"
}

variable "ingressess" {
  type = map(any)
  default = {
    80 = [ "0.0.0.0/0" ]
  }
}

variable "egressess" {
  type = map(any)
  default = {

        0 = [ "0.0.0.0/0" ]
    }
}