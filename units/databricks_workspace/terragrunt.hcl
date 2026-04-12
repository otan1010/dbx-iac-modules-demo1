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
}

dependency "metastore" {
  config_path = "C:/Users/40724616/aaa/dbx-iac-live-demo1/_tenant_name/_subscription_dbx-demo-development/_region_northeurope/metastore/.terragrunt-stack/databricks_metastore/.terragrunt-stack/metastore-northeurope"

  mock_outputs = {
    id = 0000
  }
}
