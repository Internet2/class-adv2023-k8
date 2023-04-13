output "public_proxy" {
    description = "URL for the JupyterHub"
    value = data.kubernetes_namespace.jupyterhub.id
}