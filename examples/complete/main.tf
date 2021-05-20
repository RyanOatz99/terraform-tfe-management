# vim: set ft=terraform :

module "complete" {
  source = "../.."

  organization = {
    name                     = "tf-complete-demo-org"
    email                    = "tf-owner@your-domain"
    collaborator_auth_policy = "password"
    members = [
      "tf-owner2@your-domain",
      "tf-owner3@your-domain",
    ]
  }

  workspaces = {
    "tf-complete-demo-workspace1" = {
      description       = "Complete demo workspace with latest Terraform version"
      execution_mode    = "remote"
      terraform_version = null # latest
      vcs_repo          = {}
    },

    "tf-complete-demo-workspace2" = {
      description       = "Complete demo workspace with Terraform version 0.14.11"
      execution_mode    = "local"
      terraform_version = "0.14.11"
      vcs_repo          = {}
    },

  }
}
