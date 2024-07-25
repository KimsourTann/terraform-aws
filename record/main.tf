provider "aws" {
  region = "us-east-1"
  access_key = var.aws_key
  secret_key = var.aws_secret
}

# get hosted zone details
# terraform aws data hosted zone
data "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
}

# create a record set in route 53
# terraform aws route 53 record
resource "aws_route53_record" "site_domain" {
  for_each = {for idx,r in local.record_names : idx => r }
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = each.value.record_name
  type    = each.value.type

  ttl = each.value.ttl

  set_identifier = lookup(each.value, "geolocation", null) != null || lookup(each.value, "weighted", null) != null ? each.key:"" 


  dynamic "geolocation_routing_policy" {
    for_each = lookup(each.value, "geolocation", null) == null ? []:[1]
    content {
      country = each.value.geolocation
    }
  }


  dynamic "weighted_routing_policy" {
    for_each = lookup(each.value, "weighted", null) == null ? []:[1]
    content {
      weight = each.value.weighted
    }
  }

  records = [each.value.route_to]
}