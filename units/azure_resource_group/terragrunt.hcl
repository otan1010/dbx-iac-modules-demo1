include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/azure_resource_group?ref=${values.version}"
}

inputs = {
  name = values.name
  region = values.region
}
