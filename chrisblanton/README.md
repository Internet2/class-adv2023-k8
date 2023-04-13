# JuptyerHub Kubernetes

# Developer environment 

The work has been done using the following:

```json
// For format details, see https://aka.ms/devcontainer.json. For config options, see the
// README at: https://github.com/devcontainers/templates/tree/main/src/ubuntu
{
	"name": "Ubuntu",
	// Or use a Dockerfile or Docker Compose file. More info: https://containers.dev/guide/dockerfile
	"image": "mcr.microsoft.com/devcontainers/base:jammy",
	"features": {
		"ghcr.io/devcontainers/features/docker-outside-of-docker:1": {
			"moby": true,
			"installDockerBuildx": true,
			"version": "latest",
			"dockerDashComposeVersion": "v1"
		},
		"ghcr.io/devcontainers/features/terraform:1": {
			"installSentinel": true,
			"installTFsec": true,
			"installTerraformDocs": true,
			"version": "latest",
			"tflint": "latest",
			"terragrunt": "latest"
		},
		"ghcr.io/devcontainers-contrib/features/mkdocs:2": {
			"version": "latest",
			"plugins": "mkdocs-material pymdown-extensions mkdocstrings[crystal,python] mkdocs-monorepo-plugin mkdocs-pdf-export-plugin mkdocs-awesome-pages-plugin"
		},
		"ghcr.io/devcontainers-contrib/features/poetry:2": {
			"version": "latest"
		},
		"ghcr.io/devcontainers-contrib/features/ansible:2": {
			"version": "latest"
		},
		"ghcr.io/devcontainers/features/aws-cli:1": {
			"version": "latest"
		},
		"ghcr.io/devcontainers/features/kubectl-helm-minikube:1" : {
			"version": "latest"
		},
		"ghcr.io/dhoeric/features/google-cloud-cli:1" {
			"version": "latest"
		}
	}

	// Features to add to the dev container. More info: https://containers.dev/features.
	// "features": {},

	// Use 'forwardPorts' to make a list of ports inside the container available locally.
	// "forwardPorts": [],

	// Use 'postCreateCommand' to run commands after the container is created.
	// "postCreateCommand": "uname -a",

	// Configure tool-specific properties.
	// "customizations": {},

	// Uncomment to connect as root instead. More info: https://aka.ms/dev-containers-non-root.
	// "remoteUser": "root"
}

```

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
