# Provision your Kubernetes clusters with the Terraform Helm provider



## Customize the deployment

Update `variables.tf` with the k8s namespace, and JupyterHelm chart version.

Add custom configuration values to `jupyterhub-values.yaml`

## Deploy with Terraform

Refer to [Terraform Readme](../README.md) for other Terraform commands
```
terraform init
terraform apply
```


# References
This is a supplemental repository for the Hashicorp [Helm provider tutorial](https://developer.hashicorp.com/terraform/tutorials/kubernetes/helm-provider).
