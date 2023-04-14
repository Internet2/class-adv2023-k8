# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
//This block would be used if you were to use Terraform Cloud or some other remote workspace.
    /*cloud {
    workspaces {
      name = "learn-terraform-eks"
    }
  }
  */

 /* This block specifies the required providers and their versions for the Terraform configuration. It includes:
- The AWS provider (hashicorp/aws) with version constraint `~> 4.47.0`
- The Random provider (hashicorp/random) with version constraint `~> 3.4.3`
- The TLS provider (hashicorp/tls) with version constraint `~> 4.0.4`
- The CloudInit provider (hashicorp/cloudinit) with version constraint `~> 2.2.0`


This line sets the required Terraform version for the configuration. It specifies a version constraint of `~> 1.3`, meaning it requires a Terraform version that is compatible with version 1.3, but not necessarily the exact version.

In summary, this configuration file sets up the required providers and their versions and specifies the required Terraform version for the project.
*/
    
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.47.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2.0"
    }
  }

  required_version = "~> 1.3"
}

