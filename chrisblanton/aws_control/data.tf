data "terraform_remote_state" "eks" {
    backend = "local"
    config = {
      path = "../aws_eks/terraform.tfstate"
     }
}

data "aws_eks_cluster" "cluster" {
    name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "kubernetes_namespace" "jupyterhub" {
    metadata {
      name = "default"
    }   
}