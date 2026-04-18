resource "databricks_disable_legacy_features_setting" "this" {
  disable_legacy_features {
    value = true
  }
}

resource "databricks_group" "dbx_account_admins" {
  display_name = var.dbx_acc_adm_grp_display_name
  external_id  = var.dbx_acc_adm_grp_object_id
}

resource "databricks_group_role" "account_admin" {
  group_id = databricks_group.dbx_account_admins.id
  role     = "account_admin"
}
