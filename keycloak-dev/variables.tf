variable "keycloak_client_id" {
  description = "Client ID of the sandbox's own scoped service account (not PROD's shared admin client)"
  default     = "dasharpe-terraform-sandbox"
}

variable "keycloak_client_secret" {
  description = "Client secret for the sandbox service account"
  sensitive   = true
}

variable "keycloak_url" {
  description = "Base URL of the Keycloak DEV instance"
  default     = "https://common-logon-dev.hlth.gov.bc.ca"
}

variable "keycloak_realm" {
  description = "Realm the sandbox client authenticates against and manages"
  default     = "moh_applications"
}
