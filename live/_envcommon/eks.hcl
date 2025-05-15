# ---------------------------------------------------------------------------------------------------------------------
# COMMON TERRAGRUNT CONFIGURATION
# This is the common component configuration for vpc. The common variables for each environment to
# deploy vpc are defined here. This configuration will be merged into the environment configuration
# via an include block.
# ---------------------------------------------------------------------------------------------------------------------
locals {
  # Automatically load environment-level variables
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  env = local.env_vars.locals.stage

  # Expose the base source URL so different versions of the module can be deployed in different environments. This will
  # be used to construct the source URL in the child terragrunt configurations.
  base_source_url = "${get_repo_root()}/modules//eks"
}

inputs = {
  # Karpenter
  karpenter_version    = "1.3.3"
  karpenter_wait       = false
  karpenter_namespace  = "karpenter"
  karpenter_repository = "oci://public.ecr.aws/karpenter"
  karpenter_chart      = "karpenter"

  # Mountpoint S3 CSI driver
  s3_csi_version    = "v1.14.1"
  s3_csi_wait       = false
  s3_csi_namespace  = "kube-system"
  s3_csi_repository = "https://awslabs.github.io/mountpoint-s3-csi-driver"
  s3_csi_chart      = "aws-mountpoint-s3-csi-driver"

  # Helm charts
  helm_charts_path = "${get_repo_root()}/helm-charts"
  helm_values_path = "${get_repo_root()}/helm-values"
}
