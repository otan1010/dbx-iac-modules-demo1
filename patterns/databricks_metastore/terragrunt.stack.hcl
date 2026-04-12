#Databricks Metastore-level resources should be created here

locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region = local.region_vars.locals.name

  metastore_name_primary = "metastore-${local.region}"
}

unit "databricks_metastore_primary" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/databricks_metastore?ref=main"
  path = "${local.metastore_name_primary}"
  values = {
    version = "main"
    name = "${local.metastore_name_primary}"
    region = "${local.region}"
  }
}
