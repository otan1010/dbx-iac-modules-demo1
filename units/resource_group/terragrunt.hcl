include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  location = local.region_vars.locals.azure_region

  resourcegroup_vars = read_terragrunt_config(find_in_parent_folders("resourcegroup.hcl"))
  name = local.resourcegroup_vars.locals.azure_resourcegroup_name
}

terraform {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/resource_group?ref=main"
}

inputs = {
  name = "testname1"
  #name = local.name
  location = local.location
}

output {
  pathh = "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/terraform.tfstate"
}
