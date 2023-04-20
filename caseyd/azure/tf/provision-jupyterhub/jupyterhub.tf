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
  # Increase the timeout to support large images/slow downloads
  timeout           = 900
  wait              = false
  recreate_pods     = true

  values = [
    templatefile("${path.module}/jupyterhub-values.yaml",
      {
      public_ip = "${data.terraform_remote_state.aks.outputs.public_ip}",
      oauth_client_id = var.oauth_client_id,
      oauth_client_secret = var.oauth_client_secret,
      fqdn = var.fqdn,
      le_contact_email = var.le_contact_email
      jupyterhub_admins = join(",",var.jupyterhub_admins),
      jupyterhub_users = join(",",var.jupyterhub_users)
      })
  ]
  # Wait for the proxy to settle and fetch the proxy IP
  provisioner "local-exec" {
    command = "sleep 30 && kubectl -n jhub get service proxy-public"
    when = create
  }
}



# Not sure this is needed for a JupyterHub chart?
#data "kubernetes_service" "jupyterhub" {
#  depends_on = [helm_release.jupyterhub]
#  metadata {
#    name = "jupyterhub"
#  }
#}
