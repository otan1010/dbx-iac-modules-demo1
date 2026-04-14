locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region_name = local.region_vars.locals.region # e.g., "northeurope"
}

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
  #config_path = "C:/Users/40724616/aaa/dbx-iac-live-demo1/_tenant_name/_subscription_dbx-demo-development/_region_northeurope/metastore/.terragrunt-stack/databricks_metastore/.terragrunt-stack/metastore-northeurope"
  #config_path = "${get_repo_root()}/_tenant_default/_region_${local.region_name}/metastore/.terragrunt-stack/databricks_metastore/.terragrunt-stack/metastore-${local.region_name}"
  config_path = "../../../../../metastore/.terragrunt-stack/databricks_metastore/.terragrunt-stack/metastore"

  mock_outputs = {
    databricks_metastore_id = 00000000-0000-0000-0000-000000000000
  }
}
