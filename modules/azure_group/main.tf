resource "azuread_group" "this" {
  display_name     = var.name
  description      = var.desc

  security_enabled = true
  mail_enabled     = false
  prevent_duplicate_names = true
}
