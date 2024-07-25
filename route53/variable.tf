# route53 variables
variable "domain_name" {
#   default = "638810e07ecf9001e8.xyz"
  description = "domain name"
  type = string
}

variable "aws_key" {
    sensitive = true
    description = "aws_key"
    type = string
}

variable "aws_secret" {
    sensitive = true
    description = "aws_secret"
    type = string
}

variable "type_of_record" {
  default = {
    "azure" = {
        "type" = "A"
        "route" = "4.191.72.249"
        "ttl" = "60"
    },
    "wrs_az" = {
        "type" = "CNAME"
        "route" = "az-ag-api-mp.haiwanr.cn"
        "ttl" = "60"
        "weighted" = "1"
    },
    "wrs_hw" = {
        "type" = "CNAME"
        "route" = "wrs-mp.haiwanr.cn"
        "ttl" = "60"
        "weighted" = "111"
    },
    "api_hw" = {
        "type" = "CNAME"
        "route" = "api-mp.haiwanr.cn"
        "ttl" = "60"
        "weighted" = "111"
    },
    "domain_name" = {
        "type" = "CNAME"
        "route" = "haiwanr.cn"
        "ttl" = "60"
    }
  }

  type = map(any)
}



variable "record_names" {
#   default = [
    # {
    #     "record_name" = "example"
    #     "route_to" = "54.160.254.187"
    #     "type" = "A"
    #     "geo" = "China"
    #     "weighted" = "111"
    #     "ttl" = "300"
    #     "set_identifier" = "live"
    # },
    # {
    #     "record_name" = "example"
    #     "route_to" = "54.160.254.187"
    #     "type" = "A"
    #     "geo" = "Default"
    #     "ttl" = "300"
    #     "set_identifier" = "dev"
    # },
    # {
    #     "record_name" = "demo-app"
    #     "route_to" = "54.160.254.187"
    #     "type" = "A"
    #     "weighted" : "1"
    #     "ttl" = "300"
    #     "set_identifier" = "dev"
    # },
    # {
    #     "record_name" = "demo-app"
    #     "route_to" = "54.160.254.187"
    #     "type" = "A"
    #     "weighted" = "111"
    #     "ttl" = "300"
    #     "set_identifier" = "live"
    # },
#     {
#         "record_name" = "demo-app"
#         "route_to" = "azure"
#         "set_identifier" = "live"
#     }
#   ]
  type = list(map(string))
  description = "all sub domain"
}

#Example
/*
export TF_VAR_aws_key=""
export TF_VAR_aws_secret=""
export TF_VAR_record_names='[{"record_name" = "demo-app" "route_to" = "azure" "set_identifier" = "live"}]'
export TF_VAR_domain_nam="638810e07ecf9001e8.xyz"

*/