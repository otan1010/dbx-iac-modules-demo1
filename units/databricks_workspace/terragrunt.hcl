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
  databricks_metastore_id = dependency.dbx_metastore_id.outputs.databricks_metastore_id
  dbx_acc_adm_grp_object_id = dependency.dbx_acc_adm_grp.outputs.entraid_group_object_id
}

### These are a cross-stack dependencies, which is currently (2026-14-14) not supported, see:
### https://docs.terragrunt.com/features/stacks/explicit/#dependencies-cannot-be-set-on-stacks
### The workaround is to create a dependency from one unit in a stack to another unit in another
### stack. Since the relative paths between them is evaluated after generation, the path needs
### to traverse all static and dynamic folders (".terragrunt-stack", etc.). This is very brittle
###and depends on a very specific folder structure in the live repository. However, in order
### to follow DRY principles this is necessary (which is the whole point of terragrunt to begin
### with).

dependency "dbx_metastore_id" {
  config_path = "../../../../../../metastore/.terragrunt-stack/databricks_metastore/.terragrunt-stack/metastore"

  mock_outputs = {
    databricks_metastore_id = 00000000-0000-0000-0000-000000000000
  }
}
