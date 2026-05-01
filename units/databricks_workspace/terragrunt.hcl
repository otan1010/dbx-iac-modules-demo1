include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "azure_provider" {
  path = find_in_parent_folders("provider_azure.hcl")
}

include "databricks_account_provider" {
  path = find_in_parent_folders("provider_dbx_account.hcl")
}

include "databricks_workspace_provider" {
  path = find_in_parent_folders("provider_dbx_workspace.hcl")
}

terraform {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/databricks_workspace?ref=${values.version}"
}

inputs = {
  name  = values.name
  region = values.region
  rg     = values.rg

  databricks_metastore_id        = dependency.dbx_metastore.outputs.databricks_metastore_id
  dbx_ws_adm_grp_object_id       = dependency.dbx_ws_adm_grp.outputs.entraid_group_object_id
  dbx_ws_adm_grp_display_name    = dependency.dbx_ws_adm_grp.outputs.entraid_group_display_name
}

dependency "dbx_ws_adm_grp" {
  config_path = "../dbx_ws_adm_grp"

  mock_outputs = {
    entraid_group_object_id     = "00000000-0000-0000-0000-000000000000"
    entraid_group_display_name  = "mock_dbx_ws_adm_grp"
  }
}

dependency "dbx_metastore" {
  config_path = "../../../metastore"

  mock_outputs = {
    databricks_metastore_id = "00000000-0000-0000-0000-000000000000"
  }
}
