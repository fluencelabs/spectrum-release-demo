resource "helm_release" "flux" {
  depends_on       = [helm_release.cilium]
  name             = "flux"
  chart            = "flux2"
  repository       = "https://fluxcd-community.github.io/helm-charts/"
  namespace        = "flux-system"
  create_namespace = true
  wait             = true

  set {
    name  = "notificationController.create"
    value = "false"
  }

  set {
    name  = "imageReflectionController.create"
    value = "false"
  }

  set {
    name  = "imageAutomationController.create"
    value = "false"
  }
  set {
    name  = "helmController.priorityClassName"
    value = "system-cluster-critical"
  }
  set {
    name  = "kustomizeController.priorityClassName"
    value = "system-cluster-critical"
  }
  set {
    name  = "notificationController.priorityClassName"
    value = "system-cluster-critical"
  }
  set {
    name  = "sourceController.priorityClassName"
    value = "system-cluster-critical"
  }
}

resource "helm_release" "flux-sync" {
  depends_on = [helm_release.flux]
  name       = "spectrum"
  chart      = "flux2-sync"
  repository = "https://fluxcd-community.github.io/helm-charts/"
  namespace  = "flux-system"
  wait       = true

  values = [
    templatefile("${path.module}/templates/flux-sync.yml", {
      network    = var.network
      cluster    = var.cluster
      variables  = var.flux_variables
    })
  ]
}
