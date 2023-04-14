# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "jupyterhub_namespace" {
  description = "JupyterHub Namespace"
  type        = string
  default     = "jhub"
}

variable "jupyterhub_helm_version" {
  description = "JupyterHub Helm Version"
  type        = string
  default     = "2.0.0"
}

variable "oauth_client_id" {
  description = "Oauth2 Client ID"
  type = string
}

variable "oauth_client_secret" {
  description = "OAuth2 Client Secret"
  type = string
}

variable "fqdn" {
  description = "FQDN for JupyterHub"
  type = string
}

variable "le_contact_email" {
  description = "LetsEncrypt Contact E-mail Address"
  type = string
}

variable "jupyterhub_admins" {
  description = "Jupyterhub Admin Users"
  type = list
}

variable "jupyterhub_users" {
  description = "Jupyterhub Allowed Users"
  type = list
}
