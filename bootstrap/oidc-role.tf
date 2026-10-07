# This file must only ever be applied by a human running Terraform locally
# with an elevated AWS SSO session (never by the GitHub Actions pipeline).
# The role below intentionally has no IAM permissions, so even if CI ran
# `apply`, it could not grant itself broader access, including changes to
# this file's own resources.
data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_role" "github_actions_hello_world" {
  name = "dasharpe-terraform-hello-world-gha"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = data.aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:bcgov@916280/dasharpe-terraform-hello-world@1398856883:*"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "github_actions_s3_backend" {
  name = "terraform-s3-backend-access"
  role = aws_iam_role.github_actions_hello_world.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:ListBucket"
        Resource = "arn:aws:s3:::tfstate-918084097805-ca-central-1"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
        ]
        Resource = "arn:aws:s3:::tfstate-918084097805-ca-central-1/hello-world/*"
      }
    ]
  })
}

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions_hello_world.arn
}
