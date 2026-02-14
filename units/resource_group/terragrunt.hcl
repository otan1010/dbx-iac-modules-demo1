include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  location = local.region_vars.locals.azure_region

  resource_group_vars = read_terragrunt_config(find_in_parent_folders("resource_group.hcl"))
  name = local.resource_group_vars.locals.azure_resource_group_name
}

terraform {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/resource_group?ref=main"
}

inputs = {
  name = local.name
  location = local.location
}
