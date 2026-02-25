resource "databricks_metastore" "this" {
  name = var.name
  region = var.region
  delta_sharing_scope = "INTERNAL"
  delta_sharing_recipient_token_lifetime_in_seconds = 1
}
