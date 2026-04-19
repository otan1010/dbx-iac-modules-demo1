variable "name" {
  description = "Workspace name."
  type        = string
}

variable "region" {
  description = "Azure region."
  type        = string
}

variable "rg" {
  description = "Resource group for the workspace."
  type        = string
}

variable "databricks_metastore_id" {
  description = "ID for Databricks Metastore."
  type        = string
}

variable "dbx_ws_adm_grp_object_id" {
  type        = string
  description = "The object ID of the Azure AD group to make workspace admin."
}
