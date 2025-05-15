resource "helm_release" "s3_csi_driver" {
  name             = "s3-csi-driver"
  repository       = var.s3_csi_repository
  chart            = var.s3_csi_chart
  version          = var.s3_csi_version
  namespace        = var.s3_csi_namespace
  create_namespace = true
  wait             = true

  values = [templatefile("${var.helm_values_path}/s3-csi-driver/values.yaml.tftpl", {
    accountId = data.aws_caller_identity.current.account_id
  })]

  depends_on = [
    helm_release.karpenter
  ]
}

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
