# vim: set ft=terraform :

module "complete" {
  source = "../.."

  organization = {
    name                     = "tf-complete-demo-org"
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

  oauth_clients = {
    "github" = {
      api_url          = "https://api.github.com"
      http_url         = "https://github.com"
      oauth_token      = "ghp_token"
      service_provider = "github"
    },
  }

  registry_modules = {
    "tf-complete-demo/terraform-tfe-management" = {
      identifier         = "tf-complete-demo/terraform-tfe-management"
      oauth_token_client = "github"
      oauth_token_id     = null
    },
  }

  workspaces = {
    "tf-complete-demo-workspace1" = {
      description        = "Complete demo workspace with latest Terraform version"
      execution_mode     = "remote"
      allow_destroy_plan = true
      auto_apply         = false
      terraform_version  = null # latest
      working_directory  = "demo1"
      vcs_repo = {
        "tf-complete-demo/tf-complete-demo-workspace1" = {
          branch             = "main"
          ingress_submodules = false
          oauth_token_client = "github"
          oauth_token_id     = null
        }
      }
    },

    "tf-complete-demo-workspace2" = {
      description        = "Complete demo workspace with Terraform version 0.14.11"
      execution_mode     = "local"
      allow_destroy_plan = true
      auto_apply         = false
      terraform_version  = "0.14.11"
      working_directory  = null
      vcs_repo           = {}
    },

  }
}
