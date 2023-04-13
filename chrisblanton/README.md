# JuptyerHub Kubernetes

# AWS EKS Setup

The code to create the AWS Elastic Kubernetes Service is found within the directory `aws_eks`

# Secrets

The Access secrets are stored in a file named `secrets.tf` in each directory. The file is not included in the repository. The file should be created with the following format:

```terraform
variable "tf_key" {
  description = "AWS TF access key"
  type = string
  default = "<put_key_here>"
}

variable "tf_secret" {
  description = "AWS Secret key for Route53"
  type = string
  default = "<put_secret_here>"
}
```

# AWS JupyterHub deployment

The code to deploy and manage the Kubernetes deployment of JupyterHub is within the directory `aws_control`



  

# Tips and Tricks

- To import the access keys via `csv` file use `aws configure import --csv <path/to/csv>

# References and Resources

- [Getting started with Amazon EKS – AWS Management Console and AWS CLI - Amazon EKS](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html): This gives the needed steps to create a K8 cluster on AWS.
- [Provision an EKS Cluster (AWS) | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks): This tutorial gives the details to create a K8 cluster using Terraform.
-  [Manage Kubernetes Resources via Terraform | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/tutorials/kubernetes/kubernetes-provider): This provides information on how to manage a K8 cluster using Terraform.
- [Deploy Applications with the Helm Provider | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/tutorials/kubernetes/helm-provider): This provides information on how to use Helm within Terraform.
