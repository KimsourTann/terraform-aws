output "subnet_id" {
  value = values(module.subnet)[*].subnet_id
}