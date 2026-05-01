# --- NETWORK RESOURCES (VNET & SUBNETS) ---
resource "azurerm_virtual_network" "this" {
  name                = "demo-databricks-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.region
  resource_group_name = var.rg
}

resource "azurerm_subnet" "public" {
  name                 = "demo-public-subnet"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "demo-databricks-del"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
    }
  }
}

resource "azurerm_subnet" "private" {
  name                 = "demo-private-subnet"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.2.0/24"]

  delegation {
    name = "demo-databricks-del"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
    }
  }
}

# --- NETWORK SECURITY ---
resource "azurerm_network_security_group" "this" {
  name                = "demo-databricks-nsg"
  location            = var.region
  resource_group_name = var.rg
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.this.id
}

# --- DATABRICKS WORKSPACE ---
resource "azurerm_databricks_workspace" "this" {
  name                        = var.name
  location                    = var.region
  resource_group_name         = var.rg
  sku                         = "premium" # UC requirement
  managed_resource_group_name = "${var.rg}-dbxmanaged"

  custom_parameters {
    no_public_ip        = true
    public_subnet_name  = azurerm_subnet.public.name
    private_subnet_name = azurerm_subnet.private.name
    virtual_network_id  = azurerm_virtual_network.this.id

    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.public.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.private.id
  }
}

resource "databricks_metastore_assignment" "this" {
  provider = databricks.account_level
  metastore_id = var.databricks_metastore_id
  workspace_id = azurerm_databricks_workspace.this.workspace_id
}

resource "databricks_group" "dbx_ws_adm_grp" {
  provider     = databricks.account_level
  display_name = var.dbx_ws_adm_grp_display_name
  external_id  = var.dbx_ws_adm_grp_object_id
}

resource "databricks_mws_permission_assignment" "dbx_ws_adm_grp" {
  provider = databricks.account_level
  workspace_id = azurerm_databricks_workspace.this.workspace_id
  principal_id = databricks_group.dbx_ws_adm_grp.id
  permissions  = ["ADMIN"]
}

resource "databricks_default_namespace_setting" "this" {
  provider = databricks.workspace_level
  namespace {
    value = "main" 
  }
  
  # Ensure the workspace is ready and assigned to UC first
  depends_on = [databricks_metastore_assignment.this]
}

resource "databricks_disable_legacy_access_setting" "this" {
  provider = databricks.workspace_level
  disable_legacy_access {
    value = true
  }

  # This must happen AFTER the default namespace is changed to avoid "locking out" users from any catalog
  depends_on = [databricks_default_namespace_setting.this]
}
