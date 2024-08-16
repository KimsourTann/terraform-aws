variable "key_pair_id" {
  description = "Keys use for SSH"
}

variable "region" {
  default = "us-east-2"
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

variable "security_group_ids" {
  type = list(string)
  description = "Security Group Ids"
}

variable "subnet_id" {
  description = "Subnet for EC2"
}

variable "user_data" {
  description = "Script run after lunch instance"
  default = ""
}