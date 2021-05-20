# Terraform Cloud Management

<!-- TF_DOCS_BEGIN -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement_terraform) (~>0.14)

- <a name="requirement_tfe"></a> [tfe](#requirement_tfe) (0.25.2)

## Providers

The following providers are used by this module:

- <a name="provider_tfe"></a> [tfe](#provider_tfe) (0.25.2)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [tfe_oauth_client.this](https://registry.terraform.io/providers/hashicorp/tfe/0.25.2/docs/resources/oauth_client) (resource)
- [tfe_organization.this](https://registry.terraform.io/providers/hashicorp/tfe/0.25.2/docs/resources/organization) (resource)
- [tfe_organization_membership.this](https://registry.terraform.io/providers/hashicorp/tfe/0.25.2/docs/resources/organization_membership) (resource)
- [tfe_registry_module.this](https://registry.terraform.io/providers/hashicorp/tfe/0.25.2/docs/resources/registry_module) (resource)
- [tfe_workspace.this](https://registry.terraform.io/providers/hashicorp/tfe/0.25.2/docs/resources/workspace) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_organization"></a> [organization](#input_organization)

Description: Manage organization & add or remove a user from an organization.

Type:

```hcl
object({
    name                     = string
    email                    = string
    collaborator_auth_policy = string
    members                  = list(string)
  })
```

### <a name="input_workspaces"></a> [workspaces](#input_workspaces)

Description: Manage workspace resources.

Type:

```hcl
map(object({
    # key = name
    description       = string
    execution_mode    = string
    terraform_version = string
    vcs_repo = map(object({
      # key = oauth_client
      identifier         = string
      branch             = string
      ingress_submodules = bool
    }))
  }))
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_oauth_clients"></a> [oauth_clients](#input_oauth_clients)

Description: Manage OAuth Client connection between an organization and a VCS provider.

Type:

```hcl
map(object({
    api_url          = string
    http_url         = string
    oauth_token      = string
    service_provider = string
  }))
```

Default: `{}`

### <a name="input_registry_modules"></a> [registry_modules](#input_registry_modules)

Description: Manage private module registry.

Type:

```hcl
map(object({
    # key = display_identifier
    identifier     = string
    oauth_token_id = string
  }))
```

Default: `{}`

## Outputs

No outputs.
<!-- TF_DOCS_END -->

## Author

Module is maintained by [Chris Frage](https://github.com/sh0shin)

## License

MIT Licensed. See [LICENSE](LICENSE.txt) for full details.
