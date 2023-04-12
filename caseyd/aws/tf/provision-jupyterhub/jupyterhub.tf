# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0



resource "helm_release" "jupyterhub" {
  name              = "jupyterhub"
  repository        = "https://jupyterhub.github.io/helm-chart/"
  chart             = "jupyterhub"
  version           = var.jupyterhub_helm_version
  cleanup_on_fail   = true
  create_namespace  = true
  namespace         = var.jupyterhub_namespace

  values = [
    file("${path.module}/jupyterhub-values.yaml")
  ]

}

# Not sure this is needed for a JupyterHub chart?
#data "kubernetes_service" "jupyterhub" {
#  depends_on = [helm_release.jupyterhub]
#  metadata {
#    name = "jupyterhub"
#  }
#}
