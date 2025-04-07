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