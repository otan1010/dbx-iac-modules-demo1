#Workspace level configuration should be done here

locals {
  metastore_vars = read_terragrunt_config(find_in_parent_folders("metastore.hcl"))
  metastore = local.metastore_vars.locals.name

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region = local.region_vars.locals.name

  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  environment = local.environment_vars.locals.name

  rg_name = "rg-dbx-${local.environment}-${local.region}"
  ws_name = "ws-dbx-${local.environment}-${local.region}"
}

unit "core_databricks_resource_group" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/azure_resource_group?ref=main"
  path = "${local.rg_name}"
  values = {
    version = "main"
    name = "${local.rg_name}"
    region = "${local.region}"
  }
}

unit "core_databricks_workspace" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/databricks_workspace?ref=main"
  path = "${local.ws_name}"
  values = {
    version = "main"
    name = "${local.ws_name}"
    region = "${local.region}"
    rg = "${local.rg_name}"
  }
}
