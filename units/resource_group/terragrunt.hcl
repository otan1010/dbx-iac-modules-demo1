include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region = local.region_vars.locals.region

  rgrp_vars = read_terragrunt_config(find_in_parent_folders("resource_group.hcl"))
  prefix = local.rgrp_vars.locals.resource_group_prefix
}

terraform {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/resource_group?ref=main"
}

inputs = {
  name = "${local.prefix}-staticname-${local.region}"
  location = local.region
}
