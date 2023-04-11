# class-adv2023-k8

Infrastructure as code: This project will deploy a Jupyterhub with scalable compute nodes (for distributed computing)  on 3 cloud platforms using AWS EKS, Azure Kubernetes Service (AKS) and Google Kubernetes Engine (GKE).


AKS TF template for UO's deployment - UO_aks_TFtemplate\main.tf. This sets up the networking, AKS, and Azure AD app for authentication but all the variables that make it work are left out since we keep those in a vault till runtime (there are keys in there and whatnot). There is additional custimization to the containers and helm config we do that is class specific but at the very least this should give an idea what our core deployment looks like. 
