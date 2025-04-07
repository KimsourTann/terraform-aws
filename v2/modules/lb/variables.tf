variable "region" {
  default = "us-east-2"
  description = "var use to set aws region"
}

variable "env" {
  default = "dev"
}

variable "type" {
  default = "application"
}
variable "name" {
  default = "load-balancer-application"
}
variable "security_groups" {
  type = list(string)
}
variable "subnets" {
  type = list(string)
}
variable "depends" {
  type = list(string)
  default = []
}
variable "vpc_id" {
}