
# Terraform EKS Example
https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks


## Install TF Requirements
```
 terraform init
```

## Preview Changes
```
 terraform plan
```

## Apply Terraform and build the cluster
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

## Configure kube for the new cluster

```
aws eks update-kubeconfig --name education-eks-pAGhwfz9
```


## Updating a Cluster

Edit main.tf and replace version 1.24 with version 1.25
```
 terraform apply
```

AWS will step through and upgrade the cluster to version 1.25




## Terraform Helm Example

https://developer.hashicorp.com/terraform/tutorials/kubernetes/helm-provider
