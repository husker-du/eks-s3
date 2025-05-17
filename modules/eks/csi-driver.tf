resource "helm_release" "s3_csi_driver" {
  name             = "s3-csi-driver"
  repository       = var.s3_csi_repository
  chart            = var.s3_csi_chart
  version          = var.s3_csi_version
  namespace        = var.s3_csi_namespace
  create_namespace = true
  wait             = true

  values = [templatefile("${var.helm_values_path}/s3-csi-driver/values.yaml.tftpl", {
    csi_driver_role_arn    = aws_iam_role.s3_rw_role.arn
  })]

  depends_on = [
    helm_release.karpenter
  ]
}
