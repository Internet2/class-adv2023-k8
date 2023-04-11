# class-adv2023-k8

**Overview**

This project will deploy a Jupyterhub with scalable compute nodes (for distributed computing) on 3 cloud platforms using AWS EKS, Azure Kubernetes Service (AKS) and Google Kubernetes Engine (GKE). The goals are to (1) Create a replicable, reusable template for deployment of Jupyterhubs on campuses using Terraform and/or other automation scripts (2) Create documentation around best practices for deploying Jupyterhubs including steps on SSO/OAuth, cost optimization, and other node scaling mechanisms. 

**Contents**
[AKS TF template for UO's deployment](https://github.com/Internet2/class-adv2023-k8/tree/main/UO_aks_TFtemplate/main.tf)

This sets up the networking, AKS, and Azure AD app for authentication but all the variables that make it work are left out since we keep those in a vault till runtime (there are keys in there and whatnot). There is additional custimization to the containers and helm config we do that is class specific but at the very least this should give an idea what our core deployment looks like. 

**Project Contributors (Aplhabetically by Last Name)**
Chris Blanton
Matthew Brookover 
John Cox
Casey Dinsmore
Kraig Eisenman
Jacob Fosso Tande
Sarah Knickerbocker
David Luong
Amanda Tan

**Acknowledgements**
This project was created as part of the Internet2 CLASS Advanced program and supported with credits from AWS, GCP, and Azure. 


