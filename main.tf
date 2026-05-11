resource "random_string" "random" {
  for_each = toset([for i in range(var.how_many_secrets) : tostring(i)])

  length           = var.string_length
  special          = var.include_special
  override_special = var.override_special
}
