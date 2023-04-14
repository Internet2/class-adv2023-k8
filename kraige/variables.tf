# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Use this document to set variables.  The region for example, can be set by changing the default variable.

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}
