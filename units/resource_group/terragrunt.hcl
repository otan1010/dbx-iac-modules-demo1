include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  subscription_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  resourcegroup_vars = read_terragrunt_config(find_in_parent_folders("resourcegroup.hcl"))
}

terraform {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/resource_group?ref=main"
}

inputs = {
	name = local.resourcegroup_vars.azure_resourcegroup_name
	location = local.region.azure_region
}
