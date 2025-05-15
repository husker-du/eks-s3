module "s3_csi_context" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context    = module.this.context
  attributes = ["s3-csi", "images"]
}

module "s3_csi_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "4.8.0"

  bucket        = module.s3_csi_context.id
  acl           = var.acl
  force_destroy = true

  control_object_ownership = true

  versioning = {
    enabled = var.versioning_enabled
  }
}