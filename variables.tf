# vim: set ft=terraform :

variable "organization" {
  description = "Manage organization & add or remove a user from an organization."
  type = object({
    name                     = string
    email                    = string
    collaborator_auth_policy = string
    members = map(object({
      # key = name
      team = string
    }))
  })
}

variable "teams" {
  description = "Manage teams."
  type = map(object({
    # key = name
    visibility = string
  }))
  default = {}
}

variable "oauth_clients" {
  description = "Manage OAuth Client connection between an organization and a VCS provider."
  type = map(object({
    api_url          = string
    http_url         = string
    oauth_token      = string
    service_provider = string
  }))
  default = {}
}

variable "registry_modules" {
  description = "Manage private module registry."
  type = map(object({
    # key = display_identifier
    identifier         = string
    oauth_token_client = string
    oauth_token_id     = string
  }))
  default = {}
}

variable "workspaces" {
  description = "Manage workspace resources."
  type = map(object({
    # key = name
    description        = string
    allow_destroy_plan = bool
    auto_apply         = bool
    execution_mode     = string
    terraform_version  = string
    vcs_repo = map(object({
      # key = identifier
      branch             = string
      ingress_submodules = bool
      oauth_token_client = string
      oauth_token_id     = string
    }))
  }))
}
