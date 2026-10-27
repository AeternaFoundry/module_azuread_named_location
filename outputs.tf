output "named_locations_id" {
  description = "Map of id values across all named_locations, keyed the same as var.named_locations"
  value       = { for k, v in azuread_named_location.named_locations : k => v.id }
}
output "named_locations_country" {
  description = "Map of country values across all named_locations, keyed the same as var.named_locations"
  value       = { for k, v in azuread_named_location.named_locations : k => one(v.country) }
}
output "named_locations_display_name" {
  description = "Map of display_name values across all named_locations, keyed the same as var.named_locations"
  value       = { for k, v in azuread_named_location.named_locations : k => v.display_name }
}
output "named_locations_ip" {
  description = "Map of ip values across all named_locations, keyed the same as var.named_locations"
  value       = { for k, v in azuread_named_location.named_locations : k => one(v.ip) }
}
output "named_locations_object_id" {
  description = "Map of object_id values across all named_locations, keyed the same as var.named_locations"
  value       = { for k, v in azuread_named_location.named_locations : k => v.object_id }
}

