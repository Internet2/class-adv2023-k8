# Configure the azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.4.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.22.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = local.azure_subscription_id
}
data "azurerm_client_config" "current" {}

provider "azuread" {
  tenant_id = data.azurerm_client_config.current.tenant_id
}
data "azuread_client_config" "current" {}

# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = local.location
}


#Networking
resource "azurerm_virtual_network" "vnet" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = local.vnet_name
  address_space       = local.vnet_address_space
}
resource "azurerm_subnet" "subnet" {
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  name                 = local.subnet_name
  address_prefixes     = local.subnet_address_prefixes
}


# Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "cruo${local.service_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Premium"
  admin_enabled       = false
}


# Azure Kubernetes Service
resource "azurerm_kubernetes_cluster" "aks" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = local.aks_name
  dns_prefix          = local.aks_name

  default_node_pool {
    vnet_subnet_id        = azurerm_subnet.subnet.id
    enable_auto_scaling   = true
    enable_node_public_ip = true
    name                  = local.aks_default_node_pool_name
    node_count            = local.aks_default_node_pool_init_count
    max_count             = local.aks_default_node_pool_max_count
    min_count             = local.aks_default_node_pool_min_count
    vm_size               = local.aks_default_node_pool_vm_size

  }

  depends_on = [ azurerm_subnet.subnet ]

  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }

  identity {
    type = "SystemAssigned"
  }

  linux_profile {
    admin_username = local.aks_linux_profile_admin_username

    ssh_key {
      key_data = local.aks_linux_profile_ssh_key
    }
  }

  network_profile {
    network_policy     = local.aks_network_profile_network_policy
    network_plugin     = local.aks_network_profile_network_plugin
    dns_service_ip     = local.aks_network_profile_dns_service_ip
    docker_bridge_cidr = local.aks_network_profile_docker_bridge_cidr
    service_cidr       = local.aks_network_profile_service_cidr
    load_balancer_sku  = "standard"
  }

  timeouts {
    create = "60m"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "userpods" {
  name                  = local.aks_userpods_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = local.aks_userpods_vm_size
  enable_auto_scaling   = true
  node_count            = local.aks_userpods_init_count
  max_count             = local.aks_userpods_max_count
  min_count             = local.aks_userpods_min_count
  node_labels           = local.aks_userpods_node_labels
  node_taints           = local.aks_userpods_node_taints
  vnet_subnet_id        = azurerm_subnet.subnet.id
  max_pods              = 71 # 64 users (max disks limit) + 7 kube pods

  lifecycle {
    ignore_changes = [node_count]
  }
}

# Public IP inside the AKS cluster
resource "azurerm_public_ip" "public_ip" {
  name                = local.aks_name
  resource_group_name = azurerm_kubernetes_cluster.aks.node_resource_group
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = local.public_ip_domain_name_label
  tags                = { "kubernetes-dns-label-service" = "jupyterhub/proxy-public" }
}

# Security
resource "azurerm_network_security_group" "nsg" {
  name                = local.nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
resource "azurerm_network_security_rule" "nsg_allow_80" {
  name                        = "http"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = azurerm_public_ip.public_ip.ip_address
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}
resource "azurerm_network_security_rule" "nsg_allow_443" {
  name                        = "https"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = azurerm_public_ip.public_ip.ip_address
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}
resource "azurerm_network_security_rule" "nsg_inter_network" {
  name                        = "inter-network"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.240.0.0/16"
  destination_address_prefix  = "10.240.0.0/16"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}


# Attach the container registry to AKS
resource "azurerm_role_assignment" "aks_to_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

# Allow AKS to read the public IP
resource "azurerm_role_assignment" "aks_ident_to_public_ip" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}
resource "azurerm_role_assignment" "aks_kube_to_public_ip" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

# this is the enterprise application used to control access
resource "azuread_application" "azure_ad_app" {
  display_name     = local.app_name
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"

  optional_claims {
    access_token {
      name = "preferred_username"
    }
    id_token {
      name = "preferred_username"
    }
  }

  web {
    # CHANGE THIS TO HTTPS WHEN SSL IS WORKING
    redirect_uris = ["https://${local.service_name}.uoregon.edu/hub/oauth_callback"]

    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }
}

# This generates the client secret for the enterprise app
resource "azuread_application_password" "azure_ad_app_password" {
  application_object_id = azuread_application.azure_ad_app.object_id
}

data "azuread_user" "apijupyterhub" {
  user_principal_name = "apijupyterhub@uoregon.edu"
}

resource "azuread_service_principal" "sp" {
  application_id               = azuread_application.azure_ad_app.application_id
  # app_role_assignment_required = true
  owners                       = [
    data.azuread_client_config.current.object_id,
    data.azuread_user.apijupyterhub.object_id
  ]
}

# add users this way
# resource "azuread_app_role_assignment" "ra" {
  # app_role_id         = local.default_access_role_id
  # principal_object_id = data.azuread_user.apijupyterhub.object_id
  # resource_object_id  = azuread_service_principal.sp.object_id
# }


# Azure Functions for scheduling scale events

# resource "azurerm_storage_account" "funcstorage" {
  # name                     = "sajhfunc${local.service_name}"
  # resource_group_name      = azurerm_resource_group.rg.name
  # location                 = azurerm_resource_group.rg.location
  # account_tier             = "Standard"
  # account_replication_type = "LRS"
# }
#
# resource "azurerm_service_plan" "funcsp" {
  # name                = "svcp-jh-func-${local.service_name}"
  # resource_group_name = azurerm_resource_group.rg.name
  # location            = azurerm_resource_group.rg.location
  # os_type             = "Linux"
  # sku_name            = "Y1"
# }
#
# resource "azurerm_key_vault" "kv" {
  # name                       = "kvjhfunc${local.service_name}"
  # location                   = azurerm_resource_group.rg.location
  # resource_group_name        = azurerm_resource_group.rg.name
  # tenant_id                  = data.azurerm_client_config.current.tenant_id
  # soft_delete_retention_days = 7
  # sku_name                   = "standard"
# }
#
# resource "azurerm_key_vault_secret" "tenant_id" {
  # name         = "tenantId"
  # value        = "success!"
  # key_vault_id = azurerm_key_vault.kv.id
# }
#
# resource "azurerm_linux_function_app" "funcapp" {
  # name                = "af-jh-func-${local.service_name}"
  # resource_group_name = azurerm_resource_group.rg.name
  # location            = azurerm_resource_group.rg.location
#
  # storage_account_name = azurerm_storage_account.funcstorage.name
  # service_plan_id      = azurerm_service_plan.funcsp.id
#
  # identity {
    # type = "SystemAssigned"
  # }
#
  # application_stack {
    # python_version = "3.9"
  # }
#
  # app_settings = {
    # tenantId = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.tenant_id.id})"
  # }
#
  # site_config {}
#
  # depends_on = [azurerm_key_vault.kv]
#
# }
#
# resource "azurerm_key_vault_access_policy" "kvap" {
  # key_vault_id       = azurerm_key_vault.kv.id
  # tenant_id          = data.azurerm_client_config.current.tenant_id
  # object_id          = azurerm_linux_function_app.funcapp.identity[0].principal_id
  # secret_permissions = ["Get", "List", "Set"]
# }












# output "function_app_principal_id" {
  # value = azurerm_linux_function_app.funcapp.identity[0].principal_id
# }

output "resource_group_name" {
  value = local.resource_group_name
}

output "aks_cluster_name" {
  value = local.aks_name
}

output "aks_public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "aks_resource_group_name" {
  value = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "container_registry_name" {
  value = azurerm_container_registry.acr.name
}

output "app_registration_id" {
  value = azuread_application.azure_ad_app.application_id
}

output "app_registration_value" {
  value = azuread_application_password.azure_ad_app_password.value
  sensitive = true
}

output "app_registration_redirect_url" {
  value = tolist(azuread_application.azure_ad_app.web[0].redirect_uris)[0]
}
