include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/resource_group?ref=main"
}

inputs = {
	#name = values.name
	#location = values.location
	name = local.azure_resourcegroup_name
	location = local.region
}
