include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "azure_provider" {
  path = find_in_parent_folders("provider_entraid.hcl")
}

terraform {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/azure_group?ref=${values.version}"
}

inputs = {
  name = values.name
  desc = values.desc
}
