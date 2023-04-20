# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.66.0"
    }
  }

  required_version = ">= 0.14"
}


# From https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli
# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
#terraform {
#  required_providers {
#    azurerm = {
#      source  = "hashicorp/azurerm"
#      version = "=3.0.0"
#    }
#  }
#}

# Configure the Microsoft Azure Provider
#provider "azurerm" {
#  features {}
#}
