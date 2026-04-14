unit "databricks_account" {
  source = "git::https://github.com/otan1010/dbx-iac-modules-demo1.git//units/databricks_account?ref=main"
  path = "account"
  values = {
    version = "main"
  }
}
