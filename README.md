<h1>Multi-cloud Jupyterhub Deployments with Infrastructure as Code</h1>

<h2>Overview</h2>

This project will deploy a Jupyterhub with scalable compute nodes (for distributed computing) on 3 cloud platforms using AWS EKS, Azure Kubernetes Service (AKS) and Google Kubernetes Engine (GKE). There are several learning objectives for this project:

1. Learn how create replicable and reusable templates for deployment of cloud services using Infrastructure-as-Code (IaC), namely Terraform
2. Understand how to use Kubernetes for container orchestration and scaling of microservices
3. Understand how to deploy scalable Jupyterhubs (i.e. Jupyterhubs as a service, Jupyterhub for Classroom)
4. Understand best practices on Jupyterhub deployments including steps on SSO/OAuth, cost optimization, security, networking, and other node scaling mechanisms


<h2>Contents</h2>

[AKS TF template for UO's deployment](https://github.com/Internet2/class-adv2023-k8/tree/main/UO_aks_TFtemplate/main.tf)

This sets up the networking, AKS, and Azure AD app for authentication but all the variables that make it work are left out since we keep those in a vault till runtime (there are keys in there and whatnot). There is additional custimization to the containers and helm config we do that is class specific but at the very least this should give an idea what our core deployment looks like. 

<h2>Project Contributors (Aplhabetically by Last Name)</h2>

Chris Blanton;
Matthew Brookover; 
John Cox;
Casey Dinsmore;
Kraig Eisenman;
Jacob Fosso Tande;
Sarah Knickerbocker;
David Luong;
Amanda Tan

<h2>Acknowledgements</h2>

This project was created as part of the Internet2 CLASS Advanced program and supported with credits from AWS, GCP, and Azure. 


