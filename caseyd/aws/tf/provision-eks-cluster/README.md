# Custom - Provision an AWS EKS Cluster


## Customize the deployment

Update `variables.tf` with the cluster prefix, region, and k8s version.

## Deploy with Terraform

Refer to [Terraform Readme](../README.md) for other Terraform commands
```
terraform init
terraform apply
```

# References

This is a fork of the [Provision an EKS Cluster tutorial](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks) containing
Terraform configuration files to provision an EKS cluster on AWS.
