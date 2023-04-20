
# References
# Terraform State Hints
# https://developer.hashicorp.com/terraform/tutorials/kubernetes/helm-provider
#
# Helm & Kubernetes provider configuration hints
# https://schnerring.net/blog/use-terraform-to-deploy-an-azure-kubernetes-service-aks-cluster-traefik-2-cert-manager-and-lets-encrypt-certificates/
#
# Zoom chat - Azure Office Hours
# vishalkalal:
#
# data "azurerm_kubernetes_cluster" "this" {
#   name                = "myakscluster"
#   resource_group_name = "my-example-resource-group"
# }
# provider "kubernetes" {
#   alias                  = "aks"
#   host                   = data.azurerm_kubernetes_cluster.this.kube_config.host
#   client_certificate     = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.client_certificate)
#   client_key             = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.client_key)
#   cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.cluster_ca_certificate)
# }
# This is the example can be used to authenticate to aks using terraform. If aks is
# created by terraform, then you can output kubeconfig rather using data block
#
# -- CD
# In our case we modify terraform_remote_state.path/outputs.tf to export the
# following keys and re-run terraform apply:
# - host
# - client_certificate
# - client_key
# - cluster_ca_certificate
#
# These fields will now be available in terraform_remote_state.aks.outputs as defined below:

data "terraform_remote_state" "aks" {
  backend = "local"
  config = {
    path = "../provision-aks-cluster/terraform.tfstate"
  }
}

provider "helm" {
  kubernetes {
    host = data.terraform_remote_state.aks.outputs.host

    client_certificate     = base64decode(data.terraform_remote_state.aks.outputs.client_certificate)
    client_key             = base64decode(data.terraform_remote_state.aks.outputs.client_key)
    cluster_ca_certificate = base64decode(data.terraform_remote_state.aks.outputs.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host = data.terraform_remote_state.aks.outputs.host

  client_certificate     = base64decode(data.terraform_remote_state.aks.outputs.client_certificate)
  client_key             = base64decode(data.terraform_remote_state.aks.outputs.client_key)
  cluster_ca_certificate = base64decode(data.terraform_remote_state.aks.outputs.cluster_ca_certificate)
}
