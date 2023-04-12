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
