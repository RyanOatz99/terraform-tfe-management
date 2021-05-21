# vim: set ft=terraform :

terraform {
  required_version = "~>0.14"
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.25.3"
    }
  }
}
