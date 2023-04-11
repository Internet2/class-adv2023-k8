
# Terraform EKS Example
https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks


## Terraform Commands

### Install TF Requirements
```
 terraform init
```

### Validate Terraform file syntax
```
terraform validate
```

### Preview Changes
```
 terraform plan
```

### Apply Terraform files
```
  terraform apply
```

When the provisioning is complete, details will be provided about the cluster.

```
  cluster_endpoint = "https://E44319CC44678D8EE100B7C42A46AE5D.gr7.us-west-2.eks.amazonaws.com"
  cluster_name = "education-eks-pAGhwfz9"
  cluster_security_group_id = "sg-01f527e90fdbf2f6d"
  region = "us-west-2"
```

### Show the current terraform state
```
  terraform show
```

This will also show the cluster output information


## Configure kube for the new cluster

```
aws eks update-kubeconfig --name education-eks-pAGhwfz9
```

Update kubectl from Terraform output (from the EKS terraform directory)
```
aws eks update-kubeconfig --name $(terraform output -raw cluster_name)
```

## Updating a Cluster

Edit variables.tf and replace cluster_version 1.24 with version 1.25
```
 terraform apply
```

AWS will step through and upgrade the cluster to version 1.25

## Deleting a cluster
```
 terraform destroy
```


## Terraform Helm Example

https://developer.hashicorp.com/terraform/tutorials/kubernetes/helm-provider
