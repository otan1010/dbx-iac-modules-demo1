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

### This is a cross-stack dependency, which is currently (2026-14-14) not supported, see:
### https://docs.terragrunt.com/features/stacks/explicit/#dependencies-cannot-be-set-on-stacks
### The workaround is to create a dependency from one unit in a stack to another unit in another
### stack. Since the relative paths between them is evaluated after generation, the path needs
### to traverse all static and dynamic folders (".terragrunt-stack"). This is very brittle and
### depends on a very specific folder structure in the live repository. However, in order
### to follow DRY principles this is necessary (which is the whole point of terragrunt to begin
### with), since metastores have a one-to-many relationship with workspaces.

dependency "metastore" {
  config_path = "../../../../../../metastore/.terragrunt-stack/databricks_metastore/.terragrunt-stack/metastore"

  mock_outputs = {
    databricks_metastore_id = 00000000-0000-0000-0000-000000000000
  }
}

dependency "dbx-account-admins" {
  config_path = "../../../../../../../databricks_account/.terragrunt-stack/databricks_account/.terragrunt-stack/dbx_acc_adm_grp"

  mock_outputs = {
    entraid_group_id = 00000000-0000-0000-0000-000000000000
  }
}
