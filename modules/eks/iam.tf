module "iam_s3_rw_context" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context    = module.this.context
  attributes = ["iam", "s3", "read-write"]
}

resource "aws_iam_role" "s3_rw_role" {
  name = module.iam_s3_rw_context.id

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "s3_rw_policy" {
  name = module.iam_s3_rw_context.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "MountpointAllowReadWriteObjects",
        Effect   = "Allow",
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:AbortMultipartUpload",
          "s3:DeleteObject"
        ],
        Resource = "${var.s3_csi_bucket_arn}/*"
      },
      {
        Sid      = "MountpointAllowListBucket",
        Effect   = "Allow",
        Action   = [
          "s3:ListBucket"
        ],
        Resource = "${var.s3_csi_bucket_arn}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_s3_rw_policy" {
  role       = aws_iam_role.s3_rw_role.name
  policy_arn = aws_iam_policy.s3_rw_policy.arn
}
