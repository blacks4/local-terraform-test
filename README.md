# Terraform Random String Generator

This Terraform configuration generates multiple random strings using the `random_string` resource with configurable parameters.

## Overview

The configuration uses `for_each` to create multiple random string resources based on the `how_many_secrets` variable, making it easy to generate any number of random strings in a single Terraform apply.

## Features

- **Dynamic Resource Creation**: Generate multiple random strings using `for_each`
- **Configurable Count**: Control the number of secrets via `how_many_secrets` variable
- **Customizable String Properties**: Configure length, special characters, and character overrides
- **Map Output**: All generated strings are output as a map for easy reference

## Files

- `main.tf` - Main resource definition with `for_each` loop
- `variables.tf` - Variable declarations
- `terraform.tfvars` - Variable values (customize here)
- `outputs.tf` - Output definitions
- `terraform.tf` - Terraform and provider configuration

## Variables

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `how_many_secrets` | number | 1 | Number of random strings to generate |
| `string_length` | string | - | Length of each random string |
| `include_special` | bool | - | Whether to include special characters |
| `override_special` | string | - | Custom set of special characters to use |

## Usage

### 1. Configure Variables

Edit `terraform.tfvars` to set your desired values:

```hcl
how_many_secrets = 5
string_length    = 20
include_special  = true
override_special = "!@#$%^&*()-_"
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Preview Changes

```bash
terraform plan
```

This will show that 5 `random_string.random` resources will be created (based on `how_many_secrets = 5`).

### 4. Apply Configuration

```bash
terraform apply
```

### 5. View Outputs

After applying, you'll see output like:

```hcl
strings = {
  "0" = "abc123xyz!@#$%^&*()-_"
  "1" = "def456uvw!@#$%^&*()-_"
  "2" = "ghi789rst!@#$%^&*()-_"
  "3" = "jkl012opq!@#$%^&*()-_"
  "4" = "mno345lmn!@#$%^&*()-_"
}
```

## Output Format

The `strings` output is a map where:
- **Keys**: String indices ("0", "1", "2", etc.)
- **Values**: The generated random strings

### Accessing Individual Strings

In other Terraform configurations, you can reference individual strings:

```hcl
# Reference a specific string
value = module.random_strings.strings["0"]

# Loop through all strings
for_each = module.random_strings.strings
```

## How It Works

### Resource Creation with `for_each`

The `main.tf` file uses `for_each` to create multiple resources:

```hcl
resource "random_string" "random" {
  for_each = toset([for i in range(var.how_many_secrets) : tostring(i)])
  
  length           = var.string_length
  special          = var.include_special
  override_special = var.override_special
}
```

**Breakdown:**
1. `range(var.how_many_secrets)` creates a list: `[0, 1, 2, 3, 4]` (for `how_many_secrets = 5`)
2. `tostring(i)` converts each number to a string: `["0", "1", "2", "3", "4"]`
3. `toset()` converts the list to a set (required by `for_each`)
4. Each iteration creates a separate resource instance

### Output Generation

The `outputs.tf` file uses a `for` expression to create a map:

```hcl
output "strings" {
  description = "Map of all generated random strings"
  value       = { for k, v in random_string.random : k => v.result }
}
```

This iterates over all `random_string.random` instances and creates a map of their results.

## Examples

### Generate 10 Secrets

```hcl
how_many_secrets = 10
string_length    = 32
include_special  = true
override_special = "!@#$%^&*()-_=+[]{}|;:,.<>?"
```

### Generate Simple Alphanumeric Strings

```hcl
how_many_secrets = 3
string_length    = 16
include_special  = false
override_special = ""
```

## Validation

To validate the configuration without applying:

```bash
terraform validate
```

## Clean Up

To destroy all created resources:

```bash
terraform destroy
```

## Requirements

- Terraform >= 0.13
- `random` provider

## Notes

- The `random_string` resource generates cryptographically secure random strings
- Each string is unique and stored in Terraform state
- Changing `how_many_secrets` will create/destroy resources to match the new count
- The resource keys ("0", "1", "2", etc.) are stable and won't change unless you modify the `for_each` expression

## License

This configuration is provided as-is for demonstration and testing purposes.