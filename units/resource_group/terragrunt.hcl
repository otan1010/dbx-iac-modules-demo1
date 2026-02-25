#include "root" {
#  path = find_in_parent_folders("root.hcl")
#}
#
#locals {
#  sub_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))
#  env = local.sub_vars.locals.environment_abbreviation
#
#  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
#  region = local.region_vars.locals.region
#
#  rg_vars = read_terragrunt_config(find_in_parent_folders("resource_group.hcl"))
#  rg_name = local.rg_vars.locals.resource_group_name
#}
#
#terraform {
#  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/resource_group?ref=main"
#}
#
#inputs = {
#  name = "rg-${local.rg_name}-${local.env}-${local.region}"
#  region = local.region
#}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/resource_group?ref=main"
}

locals {
  # Explicit unit interface:
  # - environment_abbreviation and region come from root.hcl inputs
  # - rg_name comes from stack values/inputs
  env    = try(var.environment_abbreviation, null)
  region = try(var.region, null)
  rg     = try(var.rg_name, null)
}

inputs = {
  name   = "rg-${local.rg}-${local.env}-${local.region}"
  region = local.region
}
