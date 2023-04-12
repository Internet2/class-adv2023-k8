# Provision AKS Cluster

## Creating Service Principal

This took a very long time.
```
 az ad sp create-for-rbac --skip-assignment
```

Copy `aks.auto.tfvars.example` to `aks.auto.tfvars` and update with the service
principal and secret. This file should not be added to version control.

## Configure Kubectl
```
az aks get-credentials --resource-group $(terraform output -raw resource_group_name) --name $(terraform output -raw kubernetes_cluster_name)
```

# References
This code is a fork of the [Provision an AKS Cluster tutorial](https://developer.hashicorp.com/terraform/tutorials/kubernetes/aks), containing Terraform configuration files to provision an AKS cluster on Azure.
