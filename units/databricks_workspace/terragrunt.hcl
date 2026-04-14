include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "azure_provider" {
  path = find_in_parent_folders("provider_azure.hcl")
}

include "databricks_account_provider" {
  path = find_in_parent_folders("provider_dbx_account.hcl")
}

terraform {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/databricks_workspace?ref=${values.version}"
}

inputs = {
  name = values.name
  region = values.region
  rg = values.rg
  databricks_metastore_id = dependency.metastore.outputs.databricks_metastore_id
}

dependency "metastore" {
  config_path = "../../../../../../../metastore/.terragrunt-stack/databricks_metastore/.terragrunt-stack/metastore"

  mock_outputs = {
    databricks_metastore_id = 00000000-0000-0000-0000-000000000000
  }
}
