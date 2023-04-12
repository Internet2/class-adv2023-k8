# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "cluster_prefix" {
  description = "Name Prefix of the AWS EKS Cluster"
  type        = string
  default     = "tftest1"
}

variable "cluster_version" {
  description = "EKS Cluster Version"
  type        = string
  default     = "1.24"
}
