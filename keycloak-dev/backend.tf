terraform {
  required_version = ">= 1.9"
  required_providers {
    keycloak = {
      source  = "keycloak/keycloak"
      version = "5.6.0"
    }
  }

  backend "s3" {
    bucket       = "tfstate-918084097805-ca-central-1"
    key          = "keycloak-dev/terraform.tfstate"
    region       = "ca-central-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "keycloak" {
  client_id     = var.keycloak_client_id
  client_secret = var.keycloak_client_secret
  url           = var.keycloak_url
  realm         = var.keycloak_realm
  base_path     = "/auth"
}
