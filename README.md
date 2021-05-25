# Terraform Cloud Management

<!-- TF_DOCS_BEGIN -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement_terraform) (~>0.14)

- <a name="requirement_tfe"></a> [tfe](#requirement_tfe) (0.25.3)

## Providers

The following providers are used by this module:

- <a name="provider_tfe"></a> [tfe](#provider_tfe) (0.25.3)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [tfe_oauth_client.this](https://registry.terraform.io/providers/hashicorp/tfe/0.25.3/docs/resources/oauth_client) (resource)
- [tfe_organization.this](https://registry.terraform.io/providers/hashicorp/tfe/0.25.3/docs/resources/organization) (resource)
- [tfe_organization_membership.this](https://registry.terraform.io/providers/hashicorp/tfe/0.25.3/docs/resources/organization_membership) (resource)
- [tfe_registry_module.this](https://registry.terraform.io/providers/hashicorp/tfe/0.25.3/docs/resources/registry_module) (resource)
- [tfe_team.this](https://registry.terraform.io/providers/hashicorp/tfe/0.25.3/docs/resources/team) (resource)
- [tfe_team_organization_member.this](https://registry.terraform.io/providers/hashicorp/tfe/0.25.3/docs/resources/team_organization_member) (resource)
- [tfe_variable.this](https://registry.terraform.io/providers/hashicorp/tfe/0.25.3/docs/resources/variable) (resource)
- [tfe_workspace.this](https://registry.terraform.io/providers/hashicorp/tfe/0.25.3/docs/resources/workspace) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_organization"></a> [organization](#input_organization)

Description: Manage organization & add or remove a user from an organization.

Type:

```hcl
object({
    name  = string
    email = string
    #session_timeout_minutes  = number
    #session_remember_minutes = number
    collaborator_auth_policy = string
    members = map(object({
      # key = name
      team = string
    }))
  })
```

### <a name="input_workspaces"></a> [workspaces](#input_workspaces)

Description: Manage workspace resources.

Type:

```hcl
map(object({
    # key = name
    description        = string
    allow_destroy_plan = bool
    auto_apply         = bool
    execution_mode     = string
    terraform_version  = string
    working_directory  = string
    vcs_repo = map(object({
      # key = identifier
      branch             = string
      ingress_submodules = bool
      oauth_token_client = string
      oauth_token_id     = string
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
    identifier         = string
    oauth_token_client = string
    oauth_token_id     = string
  }))
```

Default: `{}`

### <a name="input_teams"></a> [teams](#input_teams)

Description: Manage teams.

Type:

```hcl
map(object({
    # key = name
    visibility = string
  }))
```

Default: `{}`

### <a name="input_variables"></a> [variables](#input_variables)

Description: Manage workspace variables.

Type:

```hcl
map(object({
    # key = workspace/key
    value       = string
    category    = string # terraform or env
    description = string
    hcl         = bool
    sensitive   = bool
  }))
```

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_org_id"></a> [org_id](#output_org_id)

Description: The ID/name of the organization.
<!-- TF_DOCS_END -->

## Author

Module is maintained by [Chris Frage](https://github.com/sh0shin)

## License

MIT Licensed. See [LICENSE](LICENSE.txt) for full details.
