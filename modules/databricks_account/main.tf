resource "databricks_disable_legacy_features_setting" "this" {
  disable_legacy_features {
    value = true
  }
}

resource "databricks_group_role" "account_admin" {
  group_id = var.dbx_acc_adm_grp_id
  role     = "account_admin"
}
