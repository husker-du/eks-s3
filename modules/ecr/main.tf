module "ecr_context" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context    = module.this.context
  attributes = ["ecr", "image-viewer"]
}

resource "aws_ecr_repository" "my_app" {
  name                 = module.ecr_context.id
  image_tag_mutability = var.tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = module.ecr_context.tags
}
