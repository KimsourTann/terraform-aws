variable "region" {
  default     = "us-east-2"
  description = "var use to set aws region"
}
variable "aws_secret" {
  default = "/VOmMnXb+YUM+5tTOWaBUQD1kRmMSkh7tVvNk/4/"
}

variable "aws_key" {
  default = "AKIA4MTWJACO545TUNXG"
}

variable "env" {
  default = "dev"
}

variable "ingressess" {
  type = map(any)
  default = {
    80  = ["0.0.0.0/0"]
    443 = ["0.0.0.0/0"]
    22  = ["0.0.0.0/0"]
  }
}

variable "egressess" {
  type = map(any)
  default = {
    0 = ["0.0.0.0/0"]
  }
}
