resource "databricks_mws_permission_assignment" "workspace_admin_setup" {
  provider     = databricks.account
  workspace_id = var.workspace_id
  principal_id = var.dbx_acc_adm_grp_object_id
  permissions  = ["ADMIN"]
}
