# Provision JupyterHub in a AKS cluster with the Terraform Helm provider


## Customize the deployment

Update `variables.tf` with the k8s namespace, and JupyterHelm chart version.

Copy `jupyterhub.auto.tfvars.example` to `jupyterhub.auto.tfvars` and customize as needed.

Add custom configuration values to `jupyterhub-values.yaml`

## Deploy with Terraform

Deploy AKS via terraform using [Provision AKS Cluster](../provision-aks-cluster/README.md)


Refer to [Terraform Readme](../README.md) for other Terraform commands
```
terraform init
terraform apply
```


# References
This is a modified version of the Hashicorp [Helm provider tutorial](https://developer.hashicorp.com/terraform/tutorials/kubernetes/helm-provider) modified for AKS.
