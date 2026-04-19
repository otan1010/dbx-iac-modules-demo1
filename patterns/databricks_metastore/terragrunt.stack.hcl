locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region = local.region_vars.locals.name
}

unit "databricks_metastore" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/databricks_metastore?ref=main"
  path = "metastore"
  values = {
    version = "main"
    name = "metastore-${local.region}"
    region = "${local.region}"
  }
}
