# route53 variables
variable "domain_name" {
#   default = "638810e07ecf9001e8.xyz"
  description = "domain name"
  type = string
}

variable "az_app_gw_ip" {
  description = "Azure application gateway IP"
  type = string
}

variable "wrs_az_front_door" {
  description = "WRS url of Azure frontdoor"
  type = string
}

variable "api_huawei_cdn" {
  description = "API url of Huawei CDN"
  type = string
}


variable "wrs_huawei_cdn" {
  description = "WRS url of Huawei CDN"
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

locals  {
  record_names = [ 
    {
        "record_name" = "api-mp.${var.domain_name}"
        "type" = "CNAME"
        "ttl" = "60"
        "geolocation" = "CN"
        "route_to" = "wd-api-mp.${var.domain_name}"
    },
    {
        "record_name" = "api-mp.${var.domain_name}"
        "type" = "CNAME"
        "ttl" = "60"
        "geolocation" = "*"
        "route_to" = "az-ag-api-mp.${var.domain_name}"
    },
    {
        "record_name" = "wrs-mp.${var.domain_name}"
        "type" = "CNAME"
        "ttl" = "60"
        "geolocation" = "CN"
        "route_to" = "wd-wrs-mp.${var.domain_name}"
    },
    {
        "record_name" = "wrs-mp.${var.domain_name}"
        "type" = "CNAME"
        "ttl" = "60"
        "geolocation" = "*"
        "route_to" = "${var.wrs_az_front_door}"
    },
    {
        "record_name" = "az-ag-api-mp.${var.domain_name}"
        "type" = "A"
        "ttl" = "60"
        "route_to" = "${var.az_app_gw_ip}"
    },
    {
        "record_name" = "wd-api-mp.${var.domain_name}"
        "type" = "CNAME"
        "ttl" = "60"
        "weighted" = "111"
        "route_to" = "${var.api_huawei_cdn}"
    },
    {
        "record_name" = "wd-api-mp.${var.domain_name}"
        "type" = "CNAME"
        "ttl" = "60"
        "weighted" = "1"
        "route_to" = "az-ag-api-mp.${var.domain_name}"
    },
    {
        "record_name" = "wd-wrs-mp.${var.domain_name}"
        "type" = "CNAME"
        "ttl" = "60"
        "weighted" = "111"
        "route_to" = "${var.wrs_huawei_cdn}"
    },
    {
        "record_name" = "wd-wrs-mp.${var.domain_name}"
        "type" = "CNAME"
        "ttl" = "60"
        "weighted" = "1"
        "route_to" = "${var.wrs_az_front_door}"
    },
     {
        "record_name" = "www.${var.domain_name}"
        "type" = "CNAME"
        "ttl" = "60"
        "route_to" = "${var.domain_name}"
    }
    

  ]
  description = "all sub domain"
}

#Example
/*



export TF_VAR_domain_name=638810e07ecf9001e8.xyz
export TF_VAR_az_app_gw_ip=4.191.72.249
export TF_VAR_wrs_az_front_door=wrd_az_front_door
export TF_VAR_api_huawei_cdn=api-mp-haiwanr.cn
export TF_VAR_wrs_huawei_cdn=wrs-mp-haiwanr.cn




export TF_VAR_aws_key=""
export TF_VAR_aws_secret=""
export TF_VAR_record_names='[{"record_name" = "demo-app" "route_to" = "azure" "set_identifier" = "live"}]'
export TF_VAR_domain_nam="638810e07ecf9001e8.xyz"

*/