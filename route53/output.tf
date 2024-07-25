output "sub_domain" {
  description = "Sub domain after created successfully"
  value = var.record_names[*]
}