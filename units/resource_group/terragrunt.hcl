include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  sub_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))
  environment = local.sub_vars.locals.environment_abbreviation

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region = local.region_vars.locals.region
}

terraform {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/resource_group?ref=main"
}

inputs = {
  name = "rg-staticname-${local.environment}-${local.region}"
  location = local.region
}
