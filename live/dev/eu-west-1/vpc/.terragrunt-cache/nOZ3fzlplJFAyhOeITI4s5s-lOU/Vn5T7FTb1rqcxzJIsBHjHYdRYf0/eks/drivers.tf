resource "helm_release" "s3_csi_driver" {
  name             = "s3-csi-driver"
  repository       = var.s3_csi_repository
  chart            = var.s3_csi_chart
  version          = var.s3_csi_version
  namespace        = var.s3_csi_namespace
  create_namespace = true
  wait             = true

  values = [file("${path.module}/k8s/s3-csi-driver/values.yaml")]

  depends_on = [
    helm_release.karpenter
  ]
}