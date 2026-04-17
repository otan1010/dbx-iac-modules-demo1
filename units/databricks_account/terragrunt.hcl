include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "databricks_account_provider" {
  path = find_in_parent_folders("provider_dbx_account.hcl")
}

terraform {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/databricks_account?ref=${values.version}"
}

dependency "dbx_acc_adm_grp" {
  config_path = "../dbx_acc_adm_grp" 

  mock_outputs = {
    entraid_group_id = 00000000-0000-0000-0000-000000000000
  }
}

inputs = {
  dbx_acc_adm_grp_id = dependency.dbx_acc_adm_grp.outputs.entraid_group_id
}
