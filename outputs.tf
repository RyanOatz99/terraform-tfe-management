# vim: set ft=terraform :

output "org_id" {
  description = "The ID/name of the organization."
  value       = tfe_organization.this.id
}
