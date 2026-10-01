terraform {
  required_version = ">= 1.9"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket       = "tfstate-918084097805-ca-central-1"
    key          = "hello-world/terraform.tfstate"
    region       = "ca-central-1"
    profile      = "bcgov-tools"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region  = "ca-central-1"
  profile = "bcgov-tools"

  default_tags {
    tags = {
      Environment = "tools"
      Project     = "terraform-state"
      Owner       = "david.a.sharpe@cgi.com"
      ManagedBy   = "Terraform"
    }
  }
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}
