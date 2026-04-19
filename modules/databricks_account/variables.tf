variable "dbx_acc_adm_grp_object_id" {
  type        = string
  description = "The object ID of the Azure AD group to make account admin."
}

variable "dbx_acc_adm_grp_display_name" {
  type        = string
  description = "The display name of the Azure AD group to make account admin."
}

variable "dbx_mstore_adm_grp_object_id" {
  type        = string
  description = "The object ID of the Azure AD group for global metastore admin."
}

variable "dbx_mstore_adm_grp_display_name" {
  type        = string
  description = "The display name of the Azure AD group for global metastore admin."
}
