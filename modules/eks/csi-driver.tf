resource "helm_release" "s3_csi_driver" {
  name             = "s3-csi-driver"
  repository       = var.s3_csi_repository
  chart            = var.s3_csi_chart
  version          = var.s3_csi_version
  namespace        = var.s3_csi_namespace
  create_namespace = true
  wait             = true

  values = [templatefile("${var.helm_values_path}/s3-csi-driver/values.yaml.tftpl", {
    csi_driver_role_arn = aws_iam_role.s3_rw_role.arn
  })]

  depends_on = [
    helm_release.karpenter
  ]
}

resource "kubernetes_secret" "aws_secret_csi_driver" {
  metadata {
    name      = var.s3_csi_secret_name
    namespace = var.s3_csi_namespace
  }

  data = {
    "key_id"     = var.aws_key_id
    "access_key" = var.aws_access_key
  }

  depends_on = [
    helm_release.s3_csi_driver
  ]
}

# resource "helm_release" "external_secrets" {
#   name             = "external-secrets"
#   repository       = "https://charts.external-secrets.io"
#   chart            = "external-secrets"
#   version          = "0.17.0"
#   namespace        = "external-secrets"
#   create_namespace = true
#   wait             = true

#   depends_on = [
#     helm_release.karpenter
#   ]
# }

# resource "helm_release" "hello_kubernetes" {
#   name             = "hello-kubernetes"
#   repository       = "${var.helm_charts_path}/hello-kubernetes/deploy/helm/"
#   chart            = "hello-kubernetes"
#   namespace        = "hello-kubernetes"
#   create_namespace = true
#   wait             = true

#   values = [file("${var.helm_values_path}/k8s/hello-kubernetes/values.yaml")]

#   depends_on = [
#     helm_release.karpenter
#   ]
# }
