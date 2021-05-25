# vim: set ft=terraform :

resource "tfe_organization" "this" {
  name  = var.organization.name
  email = var.organization.email
  #session_timeout_minutes  = var.organization.session_timeout_minutes
  #session_remember_minutes = var.organization.session_remember_minutes
  collaborator_auth_policy = var.organization.collaborator_auth_policy
}

resource "tfe_organization_membership" "this" {
  for_each     = var.organization.members
  organization = tfe_organization.this.id
  email        = each.key
}

resource "tfe_team" "this" {
  for_each     = var.teams
  name         = each.key
  organization = tfe_organization.this.id
  visibility   = each.value.visibility
  #organization_access {}
}

resource "tfe_team_organization_member" "this" {
  for_each                   = var.organization.members
  team_id                    = tfe_team.this[each.value.team].id
  organization_membership_id = tfe_organization_membership.this[each.key].id
}

resource "tfe_oauth_client" "this" {
  for_each         = var.oauth_clients
  organization     = tfe_organization.this.id
  api_url          = each.value.api_url
  http_url         = each.value.http_url
  oauth_token      = each.value.oauth_token
  service_provider = each.value.service_provider
}

resource "tfe_registry_module" "this" {
  for_each = var.registry_modules
  vcs_repo {
    display_identifier = each.key
    identifier         = each.value.identifier
    oauth_token_id     = each.value.oauth_token_client != null ? tfe_oauth_client.this[each.value.oauth_token_client].oauth_token_id : each.value.oauth_token_id
  }
}

resource "tfe_workspace" "this" {
  for_each           = var.workspaces
  name               = each.key
  organization       = tfe_organization.this.id
  description        = each.value.description
  allow_destroy_plan = each.value.allow_destroy_plan
  auto_apply         = each.value.auto_apply
  execution_mode     = each.value.execution_mode
  terraform_version  = each.value.terraform_version
  #agent_pool_id
  #global_remote_state
  #remote_state_consumer_ids
  #queue_all_runs
  #speculative_enabled
  #ssh_key_id
  #file_triggers_enabled
  #trigger_prefixes
  working_directory = each.value.working_directory
  dynamic "vcs_repo" {
    for_each = each.value.vcs_repo
    content {
      identifier         = vcs_repo.key
      branch             = vcs_repo.value.branch
      ingress_submodules = vcs_repo.value.ingress_submodules
      oauth_token_id     = vcs_repo.value.oauth_token_client != null ? tfe_oauth_client.this[vcs_repo.value.oauth_token_client].oauth_token_id : vcs_repo.value.oauth_token_id
    }
  }
}

resource "tfe_variable" "this" {
  for_each     = var.variables
  key          = split("/", each.key)[1]
  value        = each.value.value
  category     = each.value.category
  description  = each.value.description
  hcl          = each.value.hcl
  sensitive    = each.value.sensitive
  workspace_id = tfe_workspace.this[split("/", each.key)[0]].id
}
