output "entraid_group_id" {
  description = "The Object ID of the created EntraID group."
  value       = azuread_group.this.id
}
