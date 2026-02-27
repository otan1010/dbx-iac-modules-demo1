resource "azurerm_virtual_network" "this" {
  name                = "demo-databricks-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.region
  resource_group_name = var.resource_group
}

resource "azurerm_subnet" "public" {
  name                 = "demo-public-subnet"
  resource_group_name  = var.resource_group
  virtual_network_name = "vnet-public"
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "demo-databricks-del"

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_subnet" "private" {
  name                 = "demo-private-subnet"
  resource_group_name  = var.resource_group
  virtual_network_name = "vnet-private"
  address_prefixes     = ["10.0.2.0/24"]

  delegation {
    name = "demo-databricks-del"

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_network_security_group" "this" {
  name                = "demo-databricks-nsg"
  location            = var.region
  resource_group_name = var.resource_group
}

resource "azurerm_databricks_workspace" "this" {
  name                = var.workspace_name
  location            = var.region
  resource_group_name = var.resource_group
  sku                         = "premium"
  managed_resource_group_name = "${var.resource_group}-dbxmanaged"

	  custom_parameters {
      no_public_ip        = true
      public_subnet_name  = azurerm_subnet.public.name
      private_subnet_name = azurerm_subnet.private.name
      virtual_network_id  = azurerm_virtual_network.this.id

      public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.public.id
      private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.private.id
  }
}
