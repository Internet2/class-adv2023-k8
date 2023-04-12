# Custom - Provision an AWS EKS Cluster


## Customize the deployment

Update `variables.tf` with the cluster prefix, region, and k8s version.

## Deploy with Terraform

Refer to [Terraform Readme](../README.md) for other Terraform commands
```
terraform init
terraform apply
```

## Updating a Cluster

Edit `variables.tf` and replace cluster_version 1.24 with version 1.25
```
 terraform apply
```

AWS will step through and upgrade the cluster to version 1.25

# References

This is a fork of the [Provision an EKS Cluster tutorial](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks) containing
Terraform configuration files to provision an EKS cluster on AWS.
