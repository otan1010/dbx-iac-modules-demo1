terraform {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/resource_group?ref=main"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
	name = values.azure_resourcegroup_name
	region = values.region
}
