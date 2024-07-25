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
  for_each = {for r in var.record_names : r.record_name => r if lookup(var.type_of_record,r.route_to,null) != null }
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = each.key
  type    = var.type_of_record[each.value.route_to].type

  ttl = var.type_of_record[each.value.route_to].ttl

  set_identifier = lookup(var.type_of_record[each.value.route_to], "geo", null) != null || lookup(var.type_of_record[each.value.route_to], "weighted", null) != null ? each.value.set_identifier:"" 

 

  dynamic "geolocation_routing_policy" {
    for_each = lookup(var.type_of_record[each.value.route_to], "geo", null) == null ? []:[1]
    content {
      country = var.type_of_record[each.value.route_to].geo
    }
  }

  dynamic "weighted_routing_policy" {
    for_each = lookup(var.type_of_record[each.value.route_to], "weighted", null) == null ? []:[1]
    content {
      weight = var.type_of_record[each.value.route_to].weighted
    }
  }

  records = [var.type_of_record[each.value.route_to].route]
}

# #Create S3 bucket to store backend terraform
# resource "aws_s3_bucket" "terraform_state" {
#   bucket = "sour-terraform-state"

#   lifecycle {
#     prevent_destroy = true
#   }
# }

# resource "aws_s3_bucket_versioning" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id
#     lifecycle {
#         prevent_destroy = false
#     }
#   versioning_configuration {
#     status = "Enabled"
#   }
# }


# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id
#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# resource "aws_s3_bucket_public_access_block" "terraform_state" {
#   bucket                  = aws_s3_bucket.terraform_state.id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# # Create Dynamodb table to store LockId
# resource "aws_dynamodb_table" "terraform_state" {
#   name         = "terraform-state"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

# # Configuration backend
# terraform {
#   backend "s3" {
#     key = "global/s3/terraform.tfstate"
#     bucket = "sour-terraform-state"
#     dynamodb_table = "terraform-state"
#     region = "us-east-1"
#     encrypt = true
#   }
# }