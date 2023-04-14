# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "random_pet" "prefix" {}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "${random_pet.prefix.id}-rg"
  location = "West US 2"

  tags = {
    environment = "Demo"
  }
}


# Provision a Public IP Address
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
resource "azurerm_public_ip" "default" {
  name                = "${random_pet.prefix.id}-public_ip1"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = "Demo"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "${random_pet.prefix.id}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${random_pet.prefix.id}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "standard_dc2s_v3"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Demo"
  }

# Experiment with applying the public ip to the AKS network - not working
#  network_profile {
#    network_plugin = "azure"
#    load_balancer_sku = "standard"
#    load_balancer_profile {
#      outbound_ip_address_ids = [azurerm_public_ip.default.id]
#   }
#  }

  # Automatically run the configure command for kubectl on cluster creation
  provisioner "local-exec" {
    command = "az aks get-credentials --resource-group ${azurerm_resource_group.default.name} --name ${azurerm_kubernetes_cluster.default.name}"
    when = create
  }
}
