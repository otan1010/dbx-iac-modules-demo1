resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
}

output "relative_paths" {
  description = "the relative path terragrunt hopefully outputs"
  value = "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/terraform.tfstate"
}
