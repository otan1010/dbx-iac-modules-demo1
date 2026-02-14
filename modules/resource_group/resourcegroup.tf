resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
}

output {
  pathh = "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/terraform.tfstate"
}
