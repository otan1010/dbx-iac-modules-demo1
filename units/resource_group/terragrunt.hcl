terraform {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//modules/resource_group?ref=main"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
	name = "the_name_input_in_the_unit"
	region = "northeurope"
}
