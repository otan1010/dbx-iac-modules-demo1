output "entraid_group_id" {
  description = "The Object ID of the created EntraID group."
  value       = azuread_group.this.id
}

output "entraid_group_display_name" {
  description = "The display name of the created Entra ID group."
  value       = azuread_group.this.display_name
}
