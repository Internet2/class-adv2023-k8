# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

/*Output variables are a way to extract information about the resources that Terraform 
manages so that you can use it elsewhere, like in another Terraform configuration or to display it to the user. /*
  

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}
