resource "random_string" "random" {
  for_each = toset([for i in range(var.how_many_secrets) : tostring(i)])

  length           = var.string_length
  special          = var.include_special
  override_special = var.override_special
}

resource "random_string" "random_from_map" {
  for_each = var.random_string_configs

  length           = each.value.length
  special          = each.value.include_special
  override_special = each.value.override_special
}
