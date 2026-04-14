resource "databricks_disable_legacy_features_setting" "this" {
  disable_legacy_features {
    value = true
  }
}
