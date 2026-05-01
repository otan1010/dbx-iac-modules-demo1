unit "databricks_account" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/databricks_account?ref=main"
  path = "account"
  values = {
    version = "main"
  }
}

unit "dbx_acc_adm_grp" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/azure_group?ref=main"
  path = "dbx_acc_adm_grp"
  values = {
    version = "main"
    name = "admins-acc-dbx"
    desc = "Databricks Administrator group for Account-level access."
  }
}
