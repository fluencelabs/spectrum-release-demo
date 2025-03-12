resource "helm_release" "cilium" {
  name       = "cilium"
  chart      = "cilium"
  repository = "https://helm.cilium.io/"
  namespace  = "kube-system"
  version    = "1.16.5"
  wait       = true

  values = [
    templatefile("${path.module}/templates/cilium.yml", {
      hubble_enabled = var.cilium_hubble_enabled
      cluster_flavour = var.cluster_flavour
    })
  ]
}
