resource "helm_release" "jupyterhub" {
    name = "jupyterhub"
    repository  = "https://jupyterhub.github.io/helm-chart/"
    chart = "jupyterhub"

    values = [
        file("${path.module}/jupyterhub-config.yaml")
    ]   
}