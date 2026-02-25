include "root" {
  path = find_in_parent_folders("databricks_account_provider.hcl")
}

terraform {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/databricks_metastore?ref=${values.version}"
}

inputs = {
  name = values.name
  region = values.region
}
