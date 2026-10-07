resource "keycloak_role" "sandbox_test" {
  realm_id    = var.keycloak_realm
  name        = "dasharpe-terraform-sandbox-test"
  description = "Harmless test role created by the Terraform sandbox. Safe to delete."
}

output "role_id" {
  value = keycloak_role.sandbox_test.id
}
