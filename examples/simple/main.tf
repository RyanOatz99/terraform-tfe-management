# vim: set ft=terraform :

module "simple" {
  source = "../.."

  organization = {
    name                     = "tf-simple-demo-org"
    email                    = "tf-owner@your-domain"
    collaborator_auth_policy = "password"
    members = {
      "tf-owner2@your-domain" = { team = "owners" },
      "tf-owner3@your-domain" = { team = "owners" },
    }
  }

  teams = {
    "owners" = { visibility = "secret" }
  }

  workspaces = {
    "tf-simple-demo-workspace1" = {
      description        = "Simple demo workspace with latest Terraform version"
      execution_mode     = "remote"
      allow_destroy_plan = true
      auto_apply         = false
      terraform_version  = null # latest
      vcs_repo           = {}
    },

    "tf-simple-demo-workspace2" = {
      description        = "Simple demo workspace with Terraform version 0.14.11"
      execution_mode     = "local"
      allow_destroy_plan = true
      auto_apply         = false
      terraform_version  = "0.14.11"
      vcs_repo           = {}
    },
  }
}
